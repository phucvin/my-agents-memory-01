# Regex VM

A simple Regex Virtual Machine implementation in C++ using Pike VM architecture for efficient matching and submatch extraction.

## Features

- **Pike VM Architecture**: Avoids exponential backtracking (O(n) complexity).
- **Submatch Extraction**: Supports capturing groups `(...)`.
- **Supported Syntax**:
    - Concatenation: `ab`
    - Alternation: `a|b`
    - Kleene Star: `a*`
    - Groups: `(a)`

## Structure

- `vm.h/cpp`: The Virtual Machine that executes bytecode.
- `compiler.h/cpp`: Compiles regex pattern to bytecode (AST based).
- `main.cpp`: Unit tests and usage example.

## Usage

```cpp
#include "compiler.h"
#include "vm.h"

// Compile
RegexVM::Compiler compiler("a(b|c)*");
auto prog = compiler.compile();

// Execute
RegexVM::VM vm(prog);
std::vector<std::string> groups;
bool match = vm.match("abbc", groups);

if (match) {
    std::cout << "Full match: " << groups[0] << std::endl;
}
```

## Example Output

```
Testing /abc/ on "abc"... PASSED
Testing /abc/ on "abd"... PASSED
Testing /a*b/ on "aaab"... PASSED
Testing /a*b/ on "b"... PASSED
Testing /a|b/ on "a"... PASSED
Testing /a|b/ on "b"... PASSED
Testing /a(b|c)d/ on "abd"... PASSED
Testing /a(b|c)d/ on "acd"... PASSED
Testing /(a*)b/ on "aaab"... PASSED
Testing /((a*)b)/ on "aaab"... PASSED
Testing /(a*)* / on "aaa"... PASSED
Testing /(a)(b)/ on "ab"... PASSED
Done.
```
