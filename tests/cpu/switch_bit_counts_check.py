"""Native/AOT differential checks and rejection controls for POPCNT, LZCNT and TZCNT in cpu_switch_aot.py."""

import ctypes
from pathlib import Path
import random
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "tools"))
from cpu_switch_aot import translate
from direct_check import GUARDS, MASK, SENTINELS, input_pairs, observe, register_probe

ALL = "o no b ae e ne be a s ns p np l ge le g".split()
CARRY_ZERO = "b ae e ne be a".split()
OPERATIONS = ("popcnt", "lzcnt", "tzcnt")
NAMES = ([f"{op}{bits}_{form}" for op in OPERATIONS for bits in (16, 32, 64) for form in ("reg", "mem")]
         + ["jcc_tzcnt_b", "jcc_lzcnt_e", "jcc_popcnt_ne", "cmov_counts"])
WIDTHS = {name: 8 for name in NAMES}
# CPUID bits that host_bit_counts reports: POPCNT, BMI1 (TZCNT) and ABM (LZCNT).
HOST_FEATURES = 0b111

REJECTIONS = (
    ("neg_tzcnt_seto", "OF, SF and PF are undefined after TZCNT"),
    ("neg_lzcnt_cmovs", "OF, SF and PF are undefined after LZCNT"),
    ("neg_lzcnt_setp", "OF, SF and PF are undefined after LZCNT"),
    ("neg_tzcnt_setl", "OF, SF and PF are undefined after TZCNT"),
    ("neg_popcnt_undef", "undefined register r10"),
    ("neg_tzcnt_setg", "OF, SF and PF are undefined after TZCNT"),
    ("neg_lzcnt_cmovns", "OF, SF and PF are undefined after LZCNT"),
    ("neg_bsr", "unsupported instruction"),
    ("neg_bsf", "unsupported instruction"),
)


def count(operation, bits, value):
    """The result and the conditions the Intel SDM defines for POPCNT, LZCNT and TZCNT."""
    value &= (1 << bits) - 1
    if operation == "popcnt":
        result = bin(value).count("1")
        zero = value == 0
        # ZF is set for a zero source; OF, SF, AF, CF and PF are cleared.
        conditions = {"o": False, "b": False, "e": zero, "be": zero, "s": False, "p": False, "l": False,
                      "le": zero}
    else:
        if value == 0:
            result = bits
        elif operation == "lzcnt":
            result = bits - value.bit_length()
        else:
            result = (value & -value).bit_length() - 1
        carry, zero = value == 0, result == 0
        conditions = {"b": carry, "e": zero, "be": carry or zero}
    for negated, base in (("no", "o"), ("ae", "b"), ("ne", "e"), ("a", "be"), ("ns", "s"), ("np", "p"),
                          ("ge", "l"), ("g", "le")):
        if base in conditions:
            conditions[negated] = not conditions[base]
    return result, conditions


def merge(register, value, bits):
    if bits >= 32:
        return value
    return (register & ~0xffff | value) & MASK


def flag_bytes(conditions, names):
    data = bytearray(b"\xff" * 16)
    for number, name in enumerate(names):
        data[number] = int(conditions[name])
    return int.from_bytes(data[:8], "little"), int.from_bytes(data[8:], "little")


def reference(name, x, y):
    if name == "jcc_tzcnt_b":
        result, conditions = count("tzcnt", 64, x)
        return result ^ MASK if conditions["b"] else result, (GUARDS[0], MASK, MASK, MASK, GUARDS[1])
    if name == "jcc_lzcnt_e":
        result, conditions = count("lzcnt", 32, x)
        return result ^ MASK if conditions["e"] else result, (GUARDS[0], MASK, MASK, MASK, GUARDS[1])
    if name == "jcc_popcnt_ne":
        result, conditions = count("popcnt", 64, y)
        return result ^ MASK if conditions["ne"] else result, (GUARDS[0], MASK, MASK, MASK, GUARDS[1])
    if name == "cmov_counts":
        leading, conditions = count("lzcnt", 64, y)
        first = y if conditions["a"] else x
        ones, conditions = count("popcnt", 32, x)
        second = y & 0xffffffff if conditions["le"] else ones
        return y, (GUARDS[0], first, second, leading, GUARDS[1])
    operation, form = name.split("_")
    bits = int(operation[len(operation.rstrip("0123456789")):])
    operation = operation.rstrip("0123456789")
    result, conditions = count(operation, bits, y)
    low, high = flag_bytes(conditions, ALL if operation == "popcnt" else CARRY_ZERO)
    if form == "reg":
        register = merge(x, result, bits)
        return register, (GUARDS[0], low, high, register, GUARDS[1])
    return merge(x, result, bits), (GUARDS[0], low, high, y, GUARDS[1])


def count_inputs():
    values = {0, 1, 2, 3, 0x8000, 0x7fff, 0xffff, 0x10000, 0x7fffffff, 0x80000000, 0xffffffff,
              0x100000000, 0x8000000000000000, 0x7fffffffffffffff, MASK, 0x123456789abcdef0,
              0xdeadbeefcafebabe, 0xffff0000, 0xffff00000000, 0x0001000000010000}
    values |= {1 << bit for bit in range(64)} | {MASK ^ (1 << bit) for bit in range(64)}
    values |= {(1 << bit) - 1 for bit in range(1, 65)}
    pairs = [(x, v) for v in sorted(values) for x in (0, 0xa5a5a5a5a5a5a5a5)]
    rng = random.Random(0x434e5453)
    pairs.extend((rng.getrandbits(64), rng.getrandbits(64)) for _ in range(256))
    return pairs + input_pairs()


def check_generated(original_path):
    source, functions = translate(original_path, NAMES)
    widths = {name: fn.return_width for name, fn in zip(NAMES, functions)}
    if widths != WIDTHS:
        raise AssertionError(f"return widths {widths} != {WIDTHS}")
    for name in (f"{op}{bits}_mem" for op in OPERATIONS for bits in (16, 32, 64)):
        body = source.split(f"lifted_{name}(", 1)[1].split("\n}", 1)[0]
        if body.count("load_always<") != 1:
            raise AssertionError(f"expected one volatile read of the source in {name}:\n{body}")


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
    print(f"{len(REJECTIONS)} rejection controls passed")


def check(probe_path, original_path, lifted_path):
    check_generated(original_path)
    check_rejections(original_path)
    probe = register_probe(probe_path)
    native, lifted = ctypes.CDLL(original_path), ctypes.CDLL(lifted_path)
    features = observe(probe, native.host_bit_counts, 0, 0)[0] & HOST_FEATURES
    if features != HOST_FEATURES:
        # Without these features the host runs LZCNT and TZCNT as BSR and BSF, or faults on POPCNT.
        print(f"capability skip: host CPUID reports POPCNT/TZCNT/LZCNT bits {features:03b}, not 111")
        sys.exit(77)
    pairs = count_inputs()
    total = 0
    for name in NAMES:
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
    print(f"{total} differential comparisons passed for POPCNT, LZCNT and TZCNT at 16/32/64 bits")


if __name__ == "__main__":
    check(*sys.argv[1:])
