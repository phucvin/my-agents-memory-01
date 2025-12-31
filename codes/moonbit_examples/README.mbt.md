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

The project includes a `target_artifacts/` directory containing the generated code for C and WebAssembly (Text Format).

- `*.c`: Generated C code (from `native` target).
- `*.wat`: Generated WebAssembly Text Format (from `wasm` target).
- `*.gc.wat`: Generated WebAssembly Text Format (from `wasm-gc` target). Note: Generating WAT for GC might fail if the installed `wasm2wat` version does not support the specific GC features used.

To rebuild these artifacts:

1.  Install `wabt` (for `wasm2wat`).
2.  Run the build script (conceptually):
    ```bash
    moon build --target c
    moon build --target wasm
    moon build --target wasm-gc
    # Copy artifacts from target/ to target_artifacts/
    ```

## Example Output (Hello World)

```bash
$ moon run cmd/hello
Hello, MoonBit!
```
