"""Temporary fork-only driver: run the new recursion and stack-argument checks against main's translator.

usage: before_main_check.py PROBE RECURSION_DLL STACK_ARGS_DLL

The source-built originals must match their Python references (the fixtures are valid). The translator on
main must then fail each check: the exports are refused, so the structure checks and the refusal controls fail.
Exits 1 if a fixture is invalid or if any check unexpectedly passes on main.
"""

import ctypes
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
from direct_check import register_probe  # noqa: E402
import recursion_check  # noqa: E402
import stack_args_check  # noqa: E402


def main(probe_path, recursion_dll, stack_dll):
    probe = register_probe(probe_path)
    unexpected = 0
    for module, dll in ((recursion_check, recursion_dll), (stack_args_check, stack_dll)):
        name = module.__name__
        observed = module.run(probe, ctypes.CDLL(str(dll)))
        module.verify_reference(observed, "source fixture")
        print(f"{name}: PASS native original matches the reference for {len(module.EXPORTS)} exports "
              f"x {len(module.inputs())} inputs")
        _, _, aot = module.tools()
        for export in module.EXPORTS:
            try:
                aot.translate(dll, [export])
            except ValueError as error:
                print(f"{name}: EXPECTED FAIL on main: {export} refused: {error}")
            else:
                print(f"{name}: UNEXPECTED PASS on main: {export} translated")
                unexpected += 1
        for phase in (module.check_structure, module.check_refusals):
            try:
                phase(dll)
            except (AssertionError, ValueError, KeyError, AttributeError) as error:
                print(f"{name}: EXPECTED FAIL on main: {phase.__name__}: {type(error).__name__}: {error}")
            else:
                print(f"{name}: UNEXPECTED PASS on main: {phase.__name__}")
                unexpected += 1
    return 1 if unexpected else 0


if __name__ == "__main__":
    if len(sys.argv) != 4:
        raise SystemExit(__doc__)
    sys.exit(main(*sys.argv[1:]))
