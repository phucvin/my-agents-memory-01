# Static Hermes Examples

This directory contains examples of compiling JavaScript to C using [Static Hermes](https://github.com/facebook/hermes/tree/static_h).

## How it was built

1.  Hermes was built from the `static_h` branch (or compatible source) with `HERMES_UNICODE_LITE=ON` to avoid ICU dependency issues in the environment.
2.  `shermes` was used to compile JS to C.

## Examples

### Hello World

**Input (`hello.js`):**
```javascript
print("Hello from Static Hermes!");
```

**Command:**
```bash
shermes -O -emit-c -exported-unit=hello hello.js -o hello.c
```

### Math

**Input (`math.js`):**
```javascript
function add(a, b) { return a + b; } print(add(10, 20));
```

**Command:**
```bash
shermes -O -emit-c -exported-unit=math math.js -o math.c
```

## Generated Files

*   `hello.c`: The C source code generated from `hello.js`.
*   `math.c`: The C source code generated from `math.js`.
