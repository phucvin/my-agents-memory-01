# Linear Scan Register Allocator (Python)

This directory contains a Python prototype of a Linear Scan Register Allocator for SSA input.

## Features

*   Parses text-based SSA format (similar to `codes/ssa_converters_cpp/standard_ssa.txt`).
*   Computes Liveness Intervals (handling Phi nodes correctly).
*   Performs Linear Scan Register Allocation.
*   Handles spilling when registers are exhausted.
*   Generates pseudo-assembly with `LOAD`/`STORE` for spilled variables and Phi resolution.

## Usage

```bash
python3 linear_scan.py <input_file> [--regs N] [--output <output_file>]
```

*   `<input_file>`: Path to the SSA text file.
*   `--regs N`: Number of physical registers to allocate (default: 4).
*   `--output <file>`: Path to save the output (default: stdout).

## Example

```bash
python3 linear_scan.py ../ssa_converters_cpp/standard_ssa.txt --regs 2 --output output.txt
```
