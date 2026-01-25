# WebCC Canvas2D Example

This project demonstrates a simple Canvas2D application (a bouncing ball) using the [WebCC](https://github.com/io-eric/webcc) library.

## Project Structure

- `main.cpp`: The source code for the bouncing ball animation.
- `vendor/webcc`: A local clone of the WebCC library, built from source.
- `dist/`: The output directory containing the generated HTML and JavaScript glue code.

## Prerequisites

- C++20 capable compiler (GCC or Clang).
- `wasm-ld` (WebAssembly Linker) is required to generate the final `.wasm` file.

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

2.  **Build the Example**:
    ```bash
    # From vendor/webcc directory
    ./webcc ../../main.cpp --out ../../dist
    ```

## Known Issues

In the current environment, `wasm-ld` (specifically `wasm-ld-18` expected by Clang) is missing. As a result, the `app.wasm` file cannot be linked. However, `app.js` and `index.html` are successfully generated in the `dist/` folder.

If you have `wasm-ld` installed, the build command above should produce `dist/app.wasm`, allowing the demo to run in a browser.

## Running the Demo

Once `app.wasm` is generated (requires `wasm-ld`), you can serve the `dist` directory:

```bash
cd dist
python3 -m http.server
```

Then open `http://localhost:8000` in your browser.
