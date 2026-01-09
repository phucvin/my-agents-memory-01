# Simple Language Interpreter with RPython

This project implements an interpreter for a simple Lisp-like language using RPython. It demonstrates how to build a JIT-enabled interpreter.

## Language

The language supports:
-   Integers and Strings
-   Functions (`def`)
-   Conditionals (`if`)
-   Basic arithmetic (`+`, `-`, `<`)
-   Printing (`print`)

Example `fib.sl`:
```lisp
(def fib (n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(print (fib 20))
```

## Build Instructions

1.  **Prerequisites**:
    -   Python 2.7 (PyPy 2.7 recommended)
    -   RPython toolchain (from PyPy source)

2.  **Compile without JIT**:
    ```bash
    PYTHONPATH=/path/to/pypy_src /path/to/pypy /path/to/pypy_src/rpython/bin/rpython --opt=2 --output=simple_no_jit simple_lang.py
    ```

3.  **Compile with JIT**:
    ```bash
    PYTHONPATH=/path/to/pypy_src /path/to/pypy /path/to/pypy_src/rpython/bin/rpython --opt=jit --output=simple_jit simple_lang.py
    ```

## Benchmarks

We benchmarked the calculation of `fib(40)` using both interpreters.
*Note: We used `fib(40)` instead of `fib(20)` as requested because `fib(20)` executes too quickly (< 0.01s) to measure meaningful performance differences.*

| Interpreter | Time (fib 40) |
| :--- | :--- |
| **No JIT** | 63.024s |
| **JIT** | 44.590s |

The JIT-enabled interpreter is approximately **1.4x faster** for this recursive workload. Greater speedups are expected for loop-heavy code where JIT tracing is most effective.

## Files

-   `simple_lang.py`: The interpreter implementation (AST, Parser, Compiler, VM).
-   `fib.sl`: Fibonacci benchmark script.
