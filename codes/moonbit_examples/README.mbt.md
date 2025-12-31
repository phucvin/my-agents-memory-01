# MoonBit Examples

This directory contains examples of MoonBit code.

## Prerequisites

1.  **MoonBit CLI**: Install MoonBit following the instructions at [moonbitlang.com](https://www.moonbitlang.com/download).
    *   Ensure `moon` is in your PATH.

## Structure

The examples are organized into separate packages under `cmd/`:

*   `hello`: Basic Hello World.
*   `fibonacci`: Fibonacci sequence calculation.
*   `factorial`: Factorial calculation.
*   `arrays`: Array manipulation.
*   `structs`: Struct definition and usage.
*   `enums`: Enum definition and pattern matching.
*   `hof`: Higher-order functions.
*   `option`: usage of Option type.
*   `generics`: Generic functions and types.
*   `traits`: Trait definitions and implementations.

## Running Examples

To run an example, use the `moon run` command from the `codes/moonbit_examples` directory:

```bash
moon run cmd/hello
```

You can also specify targets:

```bash
moon run cmd/hello --target wasm
moon run cmd/hello --target wasm-gc
moon run cmd/hello --target native
```

## Build Artifacts

We provide a script to generate build artifacts (C source, WAT, JS, LLVM IR) for inspection.

### Generating Artifacts

Run the build script:

```bash
python3 scripts/build_artifacts.py
```

This will create a `target_artifacts/` directory containing:

*   `.c`: C source code generated from the `native` target.
*   `.ll`: LLVM IR generated from the `native` target (if supported by `moon build`).
*   `.wat`: WebAssembly Text format generated from the `wasm` target.
*   `.gc.wat`: WebAssembly Text format generated from the `wasm-gc` target.
*   `.js`: JavaScript code generated from the `js` target.

*Note: The script cleans the `target_artifacts/` directory before building.*

## Example Output

### Hello World

```bash
$ time moon run cmd/hello --target native
Hello, MoonBit!
real    0m1.972s

$ time moon run cmd/hello --target wasm
Hello, MoonBit!
real    0m0.115s

$ time moon run cmd/hello --target wasm-gc
Hello, MoonBit!
real    0m0.111s
```

### Fibonacci

```bash
$ time moon run cmd/fibonacci --target native
Fibonacci of 10 is 55
real    0m0.879s

$ time moon run cmd/fibonacci --target wasm
Fibonacci of 10 is 55
real    0m0.133s

$ time moon run cmd/fibonacci --target wasm-gc
Fibonacci of 10 is 55
real    0m0.119s
```

### Factorial

```bash
$ time moon run cmd/factorial --target native
Factorial of 5 is 120
real    0m0.812s

$ time moon run cmd/factorial --target wasm
Factorial of 5 is 120
real    0m0.132s

$ time moon run cmd/factorial --target wasm-gc
Factorial of 5 is 120
real    0m0.121s
```

### Arrays

```bash
$ time moon run cmd/arrays --target native
Original array: [1, 2, 3, 4, 5]
Sum of array elements: 15
Doubled array: [2, 4, 6, 8, 10]
real    0m0.956s

$ time moon run cmd/arrays --target wasm
Original array: [1, 2, 3, 4, 5]
Sum of array elements: 15
Doubled array: [2, 4, 6, 8, 10]
real    0m0.147s

$ time moon run cmd/arrays --target wasm-gc
Original array: [1, 2, 3, 4, 5]
Sum of array elements: 15
Doubled array: [2, 4, 6, 8, 10]
real    0m0.125s
```
