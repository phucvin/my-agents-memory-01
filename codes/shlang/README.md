# Shlang

Shlang is a self-interpreting, strongly typed language with C/JS-like syntax and Go-like interfaces.

## Features

*   **Syntax**: C-like (braces, semicolons).
*   **Typing**: Structural typing (Interfaces), Type Inference.
*   **Self-Hosted**: Includes an interpreter written in itself (`self/`).
*   **Host Interpreter**: Written in C++ (`src/`).

## Directory Structure

*   `src/`: Host interpreter (C++).
*   `lib/`: Standard library (written in Shlang).
*   `self/`: Self-interpreter (written in Shlang).

## Building

```bash
g++ -std=c++17 codes/shlang/src/lexer.cpp codes/shlang/src/parser.cpp codes/shlang/src/interpreter.cpp codes/shlang/src/main.cpp -o codes/shlang/shlang
```

## Running the Self-Interpreter

To run the self-interpreter interpreting a "Hello World" (or "42") example:

```bash
# Combine the self-interpreter files
cat codes/shlang/lib/map.sh codes/shlang/self/ast.sh codes/shlang/self/lexer.sh codes/shlang/self/parser.sh codes/shlang/self/interpreter.sh > codes/shlang/self/full.sh

# Run with Host Interpreter
./codes/shlang/shlang codes/shlang/self/full.sh
```

### Example Output

```
Starting Self-Interpreter...
Parsed Program.
Running main...
42
```

The example script interpreted by the self-interpreter is embedded in `codes/shlang/self/interpreter.sh`:
```go
func main() { var x = 42; print(x); }
```
