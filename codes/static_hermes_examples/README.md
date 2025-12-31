# Static Hermes Examples

This directory contains examples of compiling JavaScript to C using [Static Hermes](https://github.com/facebook/hermes/tree/static_h).

## How it was built

1.  Hermes was built from the `static_h` branch (or compatible source) with `HERMES_UNICODE_LITE=ON` to avoid ICU dependency issues in the environment.
2.  `shermes` was used to compile JS to C.

## Examples

The following examples demonstrate various JavaScript features supported by Static Hermes. All examples are compiled to C using the `shermes` compiler.

### 1. Hello World
**Input (`hello.js`):** Basic print statement.

### 2. Math
**Input (`math.js`):** Basic arithmetic function.

### 3. Arrays (`arrays.js`)
Demonstrates array iteration, filtering, and mapping.

### 4. Objects (`objects.js`)
Demonstrates object property access, modification, and nested objects.

### 5. Objects - Add Field (`objects_add_field.js`)
Demonstrates adding a new field to an object after initialization, contrasting with the static shape optimization in `objects.js`.

### 6. Closures (`closures.js`)
Demonstrates function closures and state retention.

### 7. Recursion (`recursion.js`)
Demonstrates recursive function calls (Fibonacci sequence).

### 8. String Manipulation (`strings.js`)
Demonstrates string methods like `substring`, `indexOf`, `split`, and `toUpperCase`.

### 9. Control Flow (`control_flow.js`)
Demonstrates `if-else`, `while`, and `do-while` loops.

### 10. Math Operations (`math_ops.js`)
Demonstrates `Math` library functions.

### 11. Exception Handling (`try_catch.js`)
Demonstrates `try-catch-finally` blocks.

### 12. Bitwise Operations (`bitwise.js`)
Demonstrates bitwise AND, OR, XOR, NOT, and shifts.

### 13. Matrix Multiplication (`matrix.js`)
Demonstrates nested loops and 2D arrays.

## Compilation

The `compile_all.sh` script compiles all `.js` files in this directory to `.c` files using `shermes`.

```bash
./compile_all.sh
```

## Generated Files

For each `.js` file, a corresponding `.c` file exists (e.g., `arrays.c` from `arrays.js`). These C files contain the compiled bytecode and runtime calls necessary to execute the JavaScript logic within the Hermes VM environment.
