# WebCC Canvas2D Example

This project demonstrates a simple Canvas2D application (a bouncing ball) using the [WebCC](https://github.com/io-eric/webcc) library.

## Project Structure

- `main.cpp`: The source code for the bouncing ball animation.
- `vendor/webcc`: A local clone of the WebCC library, built from source.
- `dist/`: The output directory containing the generated `app.wasm`, `app.js`, and `index.html`.

## Prerequisites

To rebuild the project, you need:
- C++20 capable compiler (GCC or Clang).
- `wasm-ld` (WebAssembly Linker).

## Build Instructions

The project includes the source for the `webcc` tool in `vendor/webcc`. You need to build it first.

1.  **Build WebCC**:
    ```bash
    cd vendor/webcc
    mkdir -p build/bootstrap build/final
    rm -f src/cli/webcc_schema.h
    rm -f build/bootstrap/*.o
    ninja
    ```
    *Note: You may need to edit `vendor/webcc/build.ninja` if your environment has specific compiler requirements (e.g., using `g++` instead of `clang++`).*

2.  **Build the Example**:
    ```bash
    # From vendor/webcc directory
    ./webcc ../../main.cpp --out ../../dist
    ```
    *Note: Ensure `wasm-ld` is in your PATH. If your Clang version expects a specific linker name (e.g., `wasm-ld-18`), you may need to symlink it.*

## Running the Demo

Serve the `dist` directory:

```bash
cd dist
python3 -m http.server
```

Then open `http://localhost:8000` in your browser.
