# Linear Scan Register Allocator (Python)

This directory contains a Python prototype of a Linear Scan Register Allocator for SSA input.

## Features

*   Parses text-based SSA format (similar to `codes/ssa_converters_cpp/standard_ssa.txt`).
*   Computes Liveness Intervals (handling Phi nodes correctly).
*   Performs Linear Scan Register Allocation.
*   Handles spilling when registers are exhausted.

## Usage

```bash
python3 linear_scan.py <input_file> [--regs N]
```

*   `<input_file>`: Path to the SSA text file.
*   `--regs N`: Number of physical registers to allocate (default: 4).

## Example

```bash
python3 linear_scan.py ../ssa_converters_cpp/standard_ssa.txt --regs 4
```

Output:

```
Register Allocation Results:
%1: R0 	(Interval: [0, 2])
%2: R1 	(Interval: [0, 2])
%3: R0 	(Interval: [3, 16])
...
```
