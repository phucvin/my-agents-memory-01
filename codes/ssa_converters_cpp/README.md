# SSA Converters & Register Allocator Prototype

This directory contains C++ prototypes for:
1.  **SSA Conversion**: Converting a simple IR to Standard SSA, Functional SSA, and Pizlo SSA.
2.  **Register Allocation**: A Linear Scan Register Allocator for Standard SSA.

## Files

*   `ir.h`, `ir.cpp`: Defines the IR (Instructions, Basic Blocks, Functions) and a test program builder.
*   `ssa.h`, `ssa.cpp`: Implements SSA construction (Dominance, Renaming) and conversion to different SSA forms.
*   `regalloc.h`, `regalloc.cpp`: Implements a Linear Scan Register Allocator.
*   `main.cpp`: Driver program that builds a test case, converts it, and runs register allocation.

## Register Allocation

The register allocator (`regalloc.cpp`) implements a **Linear Scan** algorithm on the Standard SSA form.

### Algorithm Steps:
1.  **Linearization**: Blocks are ordered in Reverse Post Order (RPO).
2.  **Numbering**: Instructions are assigned linear indices.
3.  **Liveness Analysis**: Computes `LiveIn` and `LiveOut` sets for each block to handle control flow accurately.
4.  **Interval Construction**: Builds a single live interval `[start, end]` for each SSA value, covering all its uses and live ranges across blocks.
5.  **Allocation**: Iterates through intervals sorted by start position, maintaining an `active` set of intervals.
    *   If a free register is available, it is assigned.
    *   If all registers are full, the algorithm spills the interval (current or active) that ends the furthest in the future.

### Output
The program outputs `regalloc.txt` mapping each SSA value ID to a physical register (e.g., `R0`, `R1`) or `SPILLED`.

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
*   `regalloc.txt`: Register allocation results.
