"""Native/AOT differential checks and rejection controls for SHL, SHR and SAR flags in cpu_switch_aot.py."""

import ctypes
from pathlib import Path
import random
import sys

from iced_x86 import Decoder

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "tools"))
from cpu_switch_aot import Lifter, translate
from direct_check import GUARDS, MASK, SENTINELS, input_pairs, observe, register_probe

ALL = "o no b ae e ne be a s ns p np l ge le g".split()
DEFINED = "b ae e ne be a s ns p np".split()

# name -> (operation, operand bits, masked count, destination register or None for [r8+16])
ONE = {
    "shl1_8": ("shl", 8, 1, "rax"), "shr1_8": ("shr", 8, 1, "rax"), "sar1_8": ("sar", 8, 1, "rax"),
    "shl1_16": ("shl", 16, 1, "r9"), "shr1_16": ("shr", 16, 1, "r9"), "sar1_16": ("sar", 16, 1, "r9"),
    "shl1_32": ("shl", 32, 1, "rax"), "shr1_32": ("shr", 32, 1, "rax"), "sar1_32": ("sar", 32, 1, "rax"),
    "shl1_64": ("shl", 64, 1, "r10"), "shr1_64": ("shr", 64, 1, "r10"), "sar1_64": ("sar", 64, 1, "r10"),
}
MANY = {
    "shln_8": ("shl", 8, 3, "rax"), "shrn_8": ("shr", 8, 7, "rax"), "sarn_8": ("sar", 8, 5, "rax"),
    "shln_16": ("shl", 16, 9, None), "shrn_16": ("shr", 16, 15, None), "sarn_16": ("sar", 16, 4, None),
    "shln_32": ("shl", 32, 31, "rax"), "shrn_32": ("shr", 32, 5, "rax"), "sarn_32": ("sar", 32, 5, "rax"),
    "shln_64": ("shl", 64, 13, None), "shrn_64": ("shr", 64, 63, None), "sarn_64": ("sar", 64, 32, None),
    "shlw_16": ("shl", 16, 15, "r9"), "sarw_8": ("sar", 8, 7, "rax"), "shlw_64": ("shl", 64, 63, "r10"),
    "shln_32m": ("shl", 32, 3, None),
}
# name -> (initial RAX from "x" or "y", 32-bit initial move, operation, bits, count, condition)
JUMPS = {
    "jcc_shl64_o": ("x", False, "shl", 64, 1, "o"),
    "jcc_shr32_b": ("x", True, "shr", 32, 1, "b"),
    "jcc_sar16_s": ("y", False, "sar", 16, 5, "s"),
    "jcc_shl8_be": ("y", False, "shl", 8, 3, "be"),
    "jcc_sar64_g": ("x", False, "sar", 64, 1, "g"),
    "jcc_shr8_ge": ("x", False, "shr", 8, 1, "ge"),
    "jcc_shrn_np": ("y", True, "shr", 32, 9, "np"),
}
WIDTHS = {name: 8 for name in (*ONE, *MANY, *JUMPS, "cmov_shift")}

REJECTIONS = (
    ("neg_shl_cl_setcc", "a shift by CL may leave the flags unchanged"),
    ("neg_cmp_shl_cl_setcc", "a shift by CL may leave the flags unchanged"),
    ("neg_sar_cl_cmov", "a shift by CL may leave the flags unchanged"),
    ("neg_shl_zero_setcc", "a zero-count shift leaves the flags unchanged"),
    ("neg_shr_zero_cmov", "a zero-count shift leaves the flags unchanged"),
    ("neg_shl8_wide_setcc", "a shift by the operand width or more"),
    ("neg_shr16_wide_setcc", "a shift by the operand width or more"),
    ("neg_sar8_wide_setcc", "a shift by the operand width or more"),
    ("neg_shrn_seto", "OF is undefined after a shift by more than 1"),
    ("neg_shln_cmovg", "OF is undefined after a shift by more than 1"),
    ("neg_sarn_jl", "OF is undefined after a shift by more than 1"),
    ("neg_shl_ah_setcc", "unsupported register"),
    ("neg_rol_after_cmp", "unsupported flag producer"),
)


def even_parity(value):
    return bin(value & 0xff).count("1") % 2 == 0


def shift(operation, bits, count, value):
    """The result and the 16 condition values that the Intel SDM and AMD APM define for a masked count
    of 1 to bits - 1. OF is defined only for a count of 1; it is None otherwise."""
    mask = (1 << bits) - 1
    value &= mask
    msb = bits - 1
    if operation == "shl":
        result = (value << count) & mask
        carry = (value >> (bits - count)) & 1
        overflow = ((result >> msb) & 1) ^ carry
    elif operation == "shr":
        result = value >> count
        carry = (value >> (count - 1)) & 1
        overflow = (value >> msb) & 1
    else:
        signed = value - (1 << bits) if value >> msb else value
        result = (signed >> count) & mask
        carry = (value >> (count - 1)) & 1
        overflow = 0
    if count != 1:
        overflow = None
    zero, sign = result == 0, bool((result >> msb) & 1)
    conditions = {"b": bool(carry), "e": zero, "be": bool(carry) or zero, "s": sign, "p": even_parity(result)}
    if overflow is not None:
        conditions.update({"o": bool(overflow), "l": sign != bool(overflow),
                           "le": zero or sign != bool(overflow)})
    for negated, base in (("no", "o"), ("ae", "b"), ("ne", "e"), ("a", "be"), ("ns", "s"), ("np", "p"),
                          ("ge", "l"), ("g", "le")):
        if base in conditions:
            conditions[negated] = not conditions[base]
    return result, conditions


def merge(register, value, bits):
    if bits >= 32:
        return value & ((1 << bits) - 1)  # a 32-bit write zero-extends
    low = (1 << bits) - 1
    return (register & ~low | value & low) & MASK


def flag_bytes(conditions, names):
    data = bytearray(b"\xff" * 16)
    for number, name in enumerate(names):
        data[number] = int(conditions[name])
    return int.from_bytes(data[:8], "little"), int.from_bytes(data[8:], "little")


def reference(name, x, y):
    if name in ONE or name in MANY:
        operation, bits, count, register = (ONE.get(name) or MANY[name])
        result, conditions = shift(operation, bits, count, y)
        low, high = flag_bytes(conditions, ALL if name in ONE else DEFINED)
        # A memory destination keeps the other bytes of the QWORD at [r8+16].
        stored = merge(y, result, bits) if register else (y & ~((1 << bits) - 1) | result) & MASK
        rax = stored if register else x
        return rax, (GUARDS[0], low, high, stored, GUARDS[1])
    if name in JUMPS:
        source, narrow, operation, bits, count, condition = JUMPS[name]
        initial = x if source == "x" else y
        if narrow:
            initial &= (1 << 32) - 1
        result, conditions = shift(operation, bits, count, initial)
        rax = merge(initial, result, bits)
        if conditions[condition]:
            rax ^= MASK
        return rax, (GUARDS[0], MASK, MASK, MASK, GUARDS[1])
    if name == "cmov_shift":
        result, conditions = shift("shr", 32, 7, x)
        first = y if conditions["a"] else result
        result, conditions = shift("sar", 32, 1, y)
        second = x & 0xffffffff if conditions["l"] else result
        stored = (y << 13) & MASK
        _, conditions = shift("shl", 64, 13, y)
        rax = stored if conditions["np"] else x
        return rax, (GUARDS[0], first, second, stored, GUARDS[1])
    raise AssertionError(f"unknown export {name}")


def shift_inputs():
    values = {0, 1, 2, 3, 0x40, 0x7f, 0x80, 0x81, 0xc0, 0xfe, 0xff, 0x100, 0x3fff, 0x4000, 0x7fff, 0x8000,
              0x8001, 0xc000, 0xfffe, 0xffff, 0x10000, 0x3fffffff, 0x40000000, 0x7fffffff, 0x80000000,
              0x80000001, 0xc0000000, 0xfffffffe, 0xffffffff, 0x100000000, 0x4000000000000000,
              0x7fffffffffffffff, 0x8000000000000000, 0x8000000000000001, 0xc000000000000000,
              0xfffffffffffffffe, MASK, 0x123456789abcdef0, 0xdeadbeefcafebabe, 0x0000000100000080}
    highs = (0, 0xdeadbeef00000000)
    pairs = [(x, (v | high) & MASK) for v in sorted(values) for high in highs for x in (0, 0x5555aaaa33cc0ff0)]
    rng = random.Random(0x53484654)
    pairs.extend((rng.getrandbits(64), rng.getrandbits(64)) for _ in range(256))
    # Single-bit values reach the carry position of every count and width.
    pairs.extend((1 << bit, 1 << bit) for bit in range(64))
    pairs.extend((MASK ^ (1 << bit), MASK ^ (1 << bit)) for bit in range(64))
    return pairs + input_pairs()


def check_generated(original_path):
    source, functions = translate(original_path, list(WIDTHS))
    widths = {name: fn.return_width for name, fn in zip(WIDTHS, functions)}
    if widths != WIDTHS:
        raise AssertionError(f"return widths {widths} != {WIDTHS}")
    for name in ("shln_16", "shrn_64", "cmov_shift"):
        body = source.split(f"lifted_{name}(", 1)[1].split("\n}", 1)[0]
        # One volatile read of each guest memory operand: the shift destination, and CMOVNP's source.
        expected = 2 if name == "cmov_shift" else 1
        if body.count("load_always<") != expected:
            raise AssertionError(f"unexpected load count in {name}:\n{body}")


def check_rejections(original_path):
    for name, reason in REJECTIONS:
        try:
            translate(original_path, [name])
        except ValueError as exc:
            if reason not in str(exc):
                raise AssertionError(f"{name}: expected {reason!r}, got {exc}") from exc
            print(f"rejected {name}: {exc}")
        else:
            raise AssertionError(f"accepted negative control {name}")

    # Lowering a shift by CL or a rotate as a flag producer fails in Lifter itself.
    for text, raw, reason in (("shl eax, cl", "d3 e0", "a shift by CL may leave the flags unchanged"),
                              ("rol eax, 1", "d1 c0", "unsupported flag producer"),
                              ("shr eax, 32", "c1 e8 20", "a zero-count shift leaves the flags unchanged")):
        ins = next(Decoder(64, bytes.fromhex(raw), ip=0x1000))
        try:
            Lifter().lower(ins, sets_flags=True)
        except ValueError as exc:
            if reason not in str(exc):
                raise AssertionError(f"{text} sets_flags: {exc}") from exc
        else:
            raise AssertionError(f"accepted {text} with sets_flags=True")
    print(f"{len(REJECTIONS) + 3} rejection controls passed")


def check(probe_path, original_path, lifted_path):
    check_generated(original_path)
    probe = register_probe(probe_path)
    native, lifted = ctypes.CDLL(original_path), ctypes.CDLL(lifted_path)
    pairs = shift_inputs()
    total = 0
    for name in WIDTHS:
        source, translation = getattr(native, name), getattr(lifted, "lifted_" + name)
        for x, y in pairs:
            want, trace = reference(name, x, y)
            original, actual = observe(probe, source, x, y), observe(probe, translation, x, y)
            if original != (want, trace, SENTINELS):
                raise AssertionError(f"original {name}({x:#x}, {y:#x}): {original} != {want:#x} {trace}")
            if actual != original:
                raise AssertionError(f"lifted_{name}({x:#x}, {y:#x}): {actual} != {original}")
            total += 1
        print(f"{name}: {len(pairs)} inputs match native and reference")
    print(f"{total} differential comparisons passed for SHL, SHR and SAR flags at 8/16/32/64 bits")
    check_rejections(original_path)


if __name__ == "__main__":
    check(*sys.argv[1:])
