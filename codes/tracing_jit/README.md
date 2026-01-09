# Simple Tracing JIT Prototype

This project demonstrates a minimal tracing Just-In-Time (JIT) compiler implemented in C++. It interprets a simple bytecode language and JIT-compiles hot loops into x86_64 machine code at runtime.

## Overview

The system consists of:
1.  **Bytecode Interpreter**: Executes a custom instruction set.
2.  **Profiler**: Counts loop back-edges to identify "hot" code paths.
3.  **Tracer**: Records the sequence of operations in a hot loop.
4.  **JIT Compiler**: Emits raw x86_64 machine code for the recorded trace.
5.  **Execution Manager**: Switches between interpreting and executing JIT-compiled code.

## Instruction Set

*   `MOVI reg, val`: Move immediate value to register.
*   `ADD reg_dest, reg_src`: Add `reg_src` to `reg_dest`.
*   `SUBI reg, val`: Subtract immediate value from register.
*   `CMP reg, val`: Compare register with immediate value.
*   `JNE target`: Jump if not equal (based on last comparison).
*   `PRINT reg`: Print register value (host call).
*   `EXIT`: Terminate execution.

## Building and Running

```bash
make
./tracing_jit
```

To run without JIT (interpreter only) for comparison:
```bash
./tracing_jit --no-jit
```

## Example Output

The program calculates the sum of integers from 1 to 200,000,000.

**With JIT:**
```
Running with JIT...
-445128448
Time: 0.1530s
```
*(Note: The negative result is due to expected 32-bit integer overflow)*

**Interpreter Only:**
```
Running with Interpreter...
-445128448
Time: 3.3970s
```

**Performance:** The Tracing JIT is approximately **22x faster** than the interpreter for this workload.
