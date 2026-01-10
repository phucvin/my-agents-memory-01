# Linear Scan Register Allocation Prototype

This project implements a **Linear Scan Register Allocator** for a simple SSA IR, based on the concepts described in [Bernstein Bear's blog post](https://bernsteinbear.com/blog/linear-scan/).

## Features
- **SSA Parser**: Parses a text-based SSA format (compatible with `standard_ssa.txt` from `ssa_converters_cpp`).
- **Liveness Analysis**: Computes live intervals for virtual registers, handling control flow and loops via iterative dataflow analysis.
- **Linear Scan**: Implements the core linear scan algorithm with spilling.
  - Sorts intervals by start position.
  - Maintains an active list of intervals.
  - Spills the interval with the furthest end point when registers are exhausted.
- **Assembly-like Output**: Generates pseudo-assembly code with virtual registers replaced by physical registers (`R0`, `R1`...) or stack slots (`Stack[N]`).

## Usage

1. **Build**:
   ```bash
   make
   ```

2. **Run**:
   ```bash
   ./regalloc [input_file] [output_file]
   ```
   - `input_file`: Path to input SSA text file (defaults to `input.txt`).
   - `output_file`: Path to save output (defaults to `assembly.txt`).

## Example Output

Given the input SSA:
```
Block 1:
  %3 = Phi(%1, %9)
  %4 = Phi(%2, %10)
  %5 = Lt(%4, 10)
  Branch(%5, 2, 6)
...
```

The allocator (with 3 registers) produces (in `assembly.txt`):

```
Allocating with 3 registers...
Allocation:
%1 -> R0
%2 -> R1
%4 -> R2
%5 -> R0
%6 -> R0
%7 -> R0
%8 -> R0
%10 -> R0
%3 -> Stack[1]
%9 -> Stack[0]

Rewritten Code (Pseudo-Assembly):
...
Block 1:
  R0 = Lt R2, 10
  Branch R0, 2, 6
...
```

## Implementation Details

- **IR**: defined in `ir.h`. Blocks contain linear sequences of instructions.
- **Parser**: `parser.cpp` reads the text format.
- **Liveness**: `liveness.cpp` computes `LiveIn`/`LiveOut` sets and builds `Interval`s. It conservatively assumes one continuous range per interval (covering potential holes), which is a simplification mentioned in the blog post.
- **Allocator**: `regalloc.cpp` performs the linear scan pass.

## Limitations
- **Phi Resolution**: Phi nodes are currently ignored in the output generation (assumed to be handled by move insertion which is not fully implemented in the "Rewritten Code" view, although the allocation logic respects their liveness).
- **Move Insertion**: Spills and reloads are not explicitly inserted into the instruction stream in the output, though the allocation reflects their necessity.
