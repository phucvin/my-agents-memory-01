# MoonBit Examples

This directory contains 10 independent examples of MoonBit language, demonstrating various features like recursion, structs, enums, higher-order functions, and generics.

## Prerequisites

- [MoonBit CLI](https://www.moonbitlang.com/download) installed.
- `moon` command available in your PATH.

## Project Structure

Each example is located in its own directory under `cmd/`:

- `cmd/hello`: Hello World
- `cmd/fib`: Fibonacci Sequence (Recursion)
- `cmd/fact`: Factorial (Loop)
- `cmd/array`: Array Operations
- `cmd/struct`: Structs & Methods
- `cmd/enum`: Enums & Pattern Matching
- `cmd/hof`: Higher Order Functions
- `cmd/option`: Option Type
- `cmd/generics`: Generics (Box)
- `cmd/traits`: Traits (Speak)

## How to Run

To run any example, use the `moon run` command with the path to the example package:

```bash
# Run Hello World
moon run cmd/hello

# Run Fibonacci
moon run cmd/fib

# Run Generics
moon run cmd/generics
```

## Build Artifacts

We maintain generated C and WebAssembly (WAT) files for reference.

- **C Output**: Located in `c_output/`. Generated using `moon build --target native`.
- **WAT Output**: Located in `wat_output/`. Generated using `moon build --target wasm --output-wat`.

## Example Output

### 1. Hello World
```bash
$ moon run cmd/hello
Hello, MoonBit!
```

### 2. Fibonacci
```bash
$ moon run cmd/fib
Fibonacci of 10 is 55
```

### 10. Traits
```bash
$ moon run cmd/traits
Woof! I am Buddy
Meow! I am Whiskers
```
