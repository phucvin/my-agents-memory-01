# LLM Compiler Examples

This directory contains manually crafted examples of WebAssembly Text (WAT) and their JavaScript equivalents. These examples demonstrate various programming concepts and Wasm GC features.

## Verification

To verify that the JS and WAT implementations produce the same output, you can use the `verify.js` script.

### Prerequisites

You need `binaryen` installed to run the verification script.

```bash
npm install
```

### Running the verification

```bash
node verify.js
```

This script will:
1. Scan for `.js` and `.wat` pairs in this directory.
2. Run the JS file using a `print` shim.
3. Convert the WAT file to Wasm using `binaryen.js`.
4. Run the Wasm module with a mocked environment.
5. Compare the standard output of both.

## Examples

- `hello`: Basic Hello World.
- `add`: Function definition and calling.
- `factorial`: Recursion.
- `fib`: Recursion.
- `loop`: Loops.
- `array`: Wasm GC Arrays.
- `object`: Wasm GC Structs.
- `string`: String manipulation.
- `closure`: Closures.
- `even_odd`: Mutual recursion.
