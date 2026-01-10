import sys
import os

# Ensure we can import modules from current directory
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from ssa_converters.test_cases import create_test_program
from ssa_converters.standard_ssa import to_standard_ssa
from ssa_converters.functional_ssa import to_functional_ssa
from ssa_converters.pizlo_ssa import to_pizlo_ssa

def main():
    prog = create_test_program()

    print("=== Original Program ===")
    print(prog)
    print("\n")

    print("=== Standard SSA ===")
    std_ssa = to_standard_ssa(prog)
    print(std_ssa)
    print("\n")

    print("=== Functional SSA ===")
    func_ssa = to_functional_ssa(prog)
    print(func_ssa)
    print("\n")

    print("=== Pizlo SSA ===")
    pizlo_ssa = to_pizlo_ssa(prog)
    print(pizlo_ssa)
    print("\n")

    # Write outputs to files
    with open("codes/ssa_converters/output_original.txt", "w") as f:
        f.write(str(prog))
    with open("codes/ssa_converters/output_standard.txt", "w") as f:
        f.write(str(std_ssa))
    with open("codes/ssa_converters/output_functional.txt", "w") as f:
        f.write(str(func_ssa))
    with open("codes/ssa_converters/output_pizlo.txt", "w") as f:
        f.write(str(pizlo_ssa))

if __name__ == "__main__":
    main()
