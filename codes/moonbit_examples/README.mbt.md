# MoonBit Examples

This project demonstrates 10 examples of MoonBit language features, now split into independent runnable commands.

## Prerequisites

- **MoonBit CLI (`moon`)**: Required to build and run the examples.
  - Install via: `curl -fsSL https://cli.moonbitlang.com/install/unix.sh | bash`
  - Ensure `~/.moon/bin` is in your PATH.

## Structure

The examples are located in `cmd/` as separate packages:

- `cmd/hello`: Hello World
- `cmd/fibonacci`: Fibonacci sequence (Recursion)
- `cmd/factorial`: Factorial calculation (Loop)
- `cmd/arrays`: Array operations
- `cmd/structs`: Structs and methods
- `cmd/enums`: Enums and pattern matching
- `cmd/hof`: Higher-order functions
- `cmd/option`: Option type handling
- `cmd/generics`: Generics
- `cmd/traits`: Traits

## Build and Run

To run a specific example, use `moon run cmd/<example_name>`.

For example:

```bash
moon run cmd/hello
moon run cmd/fibonacci
```

## Generated Artifacts

The project includes a `target_artifacts/` directory containing the generated code for C, WebAssembly (Text Format), JavaScript, and LLVM IR.

- `*.c`: Generated C code (from `native` target).
- `*.wat`: Generated WebAssembly Text Format (from `wasm` target).
- `*.gc.wat`: Generated WebAssembly Text Format (from `wasm-gc` target).
- `*.js`: Generated JavaScript code (from `js` target).
- `*.ll`: Generated LLVM IR (from `native` target).

To rebuild these artifacts:

1.  Ensure you have `moon` installed.
2.  Run the build script:
    ```bash
    python3 scripts/build_artifacts.py
    ```

    This script builds all targets (`native`, `wasm`, `wasm-gc`, `js`) with `--output-wat` and copies the relevant output files to `target_artifacts/`.

## Example Output (Hello World)

```bash
$ moon run cmd/hello
Hello, MoonBit!
```
