# SSA Converters & Register Allocator Prototype

This directory contains C++ prototypes for:
1.  **SSA Conversion**: Converting a simple IR to Standard SSA, Functional SSA, and Pizlo SSA.
2.  **Register Allocation**: A Linear Scan Register Allocator for Standard SSA.
3.  **Assembly Generation**: A mock assembly generator that handles spilled values and Phi resolution.

## Files

*   `ir.h`, `ir.cpp`: Defines the IR (Instructions, Basic Blocks, Functions) and a test program builder.
*   `ssa.h`, `ssa.cpp`: Implements SSA construction (Dominance, Renaming) and conversion to different SSA forms.
*   `regalloc.h`, `regalloc.cpp`: Implements a Linear Scan Register Allocator.
*   `codegen.h`, `codegen.cpp`: Implements a mock assembly generator.
*   `main.cpp`: Driver program that builds a test case, converts it, runs register allocation, and generates assembly.

## Register Allocation & Assembly Generation

The register allocator (`regalloc.cpp`) implements a **Linear Scan** algorithm on the Standard SSA form.

### Algorithm Steps:
1.  **Linearization**: Blocks are ordered in Reverse Post Order (RPO).
2.  **Liveness Analysis**: Computes `LiveIn` and `LiveOut` sets for each block.
3.  **Interval Construction**: Builds a single live interval `[start, end]` for each SSA value.
4.  **Allocation**: Assigns registers or spills based on interval end points.

### Assembly Output
The program outputs `assembly.txt`, simulating a load/store architecture:
*   **Registers**: `R0`, `R1`, `R2`...
*   **Spills**: Spilled values are assigned stack slots (`[SP+0]`, `[SP+4]`...).
*   **Reloads**: Instructions using spilled values load them into temporary registers (`TMP1`, `TMP2`) before use.
*   **Spills**: Instructions defining spilled values compute into a temporary register and store to stack.
*   **Phi Resolution**: Phi nodes are eliminated by inserting `MOV` (or `LOAD`/`STORE`) instructions at the end of predecessor blocks (before jumps) or at the start of blocks with single predecessors.

## Building and Running

```bash
make
./ssa_converter
```

Outputs:
*   `original.txt`: Original non-SSA IR.
*   `standard_ssa.txt`: IR in Standard SSA form.
*   `functional_ssa.txt`: IR in Functional SSA form.
*   `pizlo_ssa.txt`: IR in Pizlo SSA form.
*   `regalloc.txt`: Register allocation results (Value -> Reg/Spill).
*   `assembly.txt`: Generated assembly code with spill handling and Phi resolution.
