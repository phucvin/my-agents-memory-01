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
moon run cmd/fibonacci
```

You can also specify targets:

```bash
moon run cmd/hello --target js
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
*   `.ll`: LLVM IR generated from the `native` target (via clang).
*   `.wat`: WebAssembly Text format generated from the `wasm` target.
*   `.gc.wat`: WebAssembly Text format generated from the `wasm-gc` target.
*   `.js`: JavaScript code generated from the `js` target.

## Example Output

### Hello World (Default and JS Target)

```bash
$ moon run cmd/hello
Hello, World!

$ moon run cmd/hello --target js
Hello, World!
```

### Fibonacci

```bash
$ moon run cmd/fibonacci
Fibonacci(10) = 55
```

### Factorial

```bash
$ moon run cmd/factorial
Factorial(5) = 120
```

### Arrays

```bash
$ moon run cmd/arrays
Array: [1, 2, 3, 4, 5]
Sum: 15
```
