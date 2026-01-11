# Simple Tracing JIT Prototype

This project demonstrates a minimal tracing Just-In-Time (JIT) compiler implemented in C++. It parses and interprets a simple dynamically typed language and JIT-compiles hot loops into x86_64 machine code at runtime.

## Overview

The system consists of:
1.  **Lexer & Parser**: Converts source code into an internal bytecode representation.
2.  **Bytecode Interpreter**: Executes the bytecode.
3.  **Profiler**: Counts loop back-edges to identify "hot" code paths.
4.  **Tracer**: Records the sequence of operations in a hot loop.
5.  **JIT Compiler**: Emits raw x86_64 machine code for the recorded trace.
6.  **Execution Manager**: Switches between interpreting and executing JIT-compiled code.

## Language Syntax

The language supports integer variables, `while` loops, and printing.

```javascript
var sum = 0;
var x = 200000000;
while (x > 0) {
  sum = sum + x;
  x = x - 1;
}
print(sum);
```

## Internal Instruction Set

The compiler translates the source into the following bytecode instructions:

*   `MOVI dest, val`: Move immediate value to register.
*   `MOV dest, src`: Move value from one register to another.
*   `ADD dest, src`: Add `src` to `dest`.
*   `SUB dest, src`: Subtract `src` from `dest`.
*   `SUBI dest, val`: Subtract immediate value from `dest`.
*   `CMP reg, val`: Compare register with immediate value.
*   `JNE target`: Jump if not equal (based on last comparison).
*   `PRINT reg`: Print register value (host call).
*   `EXIT`: Terminate execution.

## Building and Running

```bash
make
./tracing_jit benchmark.js
```

To run without JIT (interpreter only) for comparison:
```bash
./tracing_jit --no-jit benchmark.js
```

## Example Output

The benchmark calculates the sum of integers from 1 to 200,000,000. The implementation uses 64-bit integers.

**With JIT:**
```
Running with JIT...
20000000100000000
Time: 0.7018s
```

**Interpreter Only:**
```
Running with Interpreter...
20000000100000000
Time: 3.0914s
```

**Performance:** The Tracing JIT is approximately **4.4x faster** than the interpreter for this workload.
