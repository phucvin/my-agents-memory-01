# ECS Compiler Prototype
A prototype compiler for a simple statically typed language (EcsLang), implemented using **Entity Component System (ECS)** and **Data-Oriented Design (DOD)** principles in C++. The compiler targets C.

## Architecture
Instead of a traditional object-oriented AST (where each node is an object with pointers), this compiler uses a struct-of-arrays approach.
- **Entities**: Integers representing Tokens or AST Nodes.
- **Components**: `std::vector`s storing data for each entity (e.g., `node_types`, `names`, `int_values`, `children`).
- **Systems**: Functions or classes that process these arrays (Lexer, Parser, TypeChecker, CodeGen).

## Language Features
- Types: `int`, `void`. (Booleans are `int`).
- Functions: `fn name(arg: type) -> type { ... }`
- Variables: `var name: type = expr;`
- Control Flow: `if`, `else`, `while`.
- I/O: `print(expr)`.

## Usage

### 1. Build the Compiler
```bash
g++ -std=c++17 src/main.cpp -o ecsc
```

### 2. Compile a Program
Create a file (e.g., `test.el`):
```rust
fn main() -> int {
    var x: int = 10;
    print(x * 2);
    return 0;
}
```

Run the compiler:
```bash
./ecsc test.el > test.c
```

### 3. Compile the C Output
```bash
gcc test.c -o test
./test
# Output: 20
```

## Running Tests
A test runner script is included:
```bash
./test_runner.sh
```
This compiles the compiler and runs it against sample programs in `tests/`.
