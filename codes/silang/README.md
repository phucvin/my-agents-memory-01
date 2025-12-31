# Silang

Silang is an interpreted, statically typed language with C/JS-like syntax.
The host interpreter is written in C++.
A key goal of Silang is to be capable of self-hosting (writing a Silang interpreter in Silang).

## Features

-   **Statically Typed**: Types are checked at compile/parse time (or runtime if simplified for now, but goal is static).
-   **C/JS Syntax**: Familiar curly brace syntax.
-   **Data Structures**:
    -   `int`, `bool`, `string` primitive types.
    -   `struct` for user-defined records.
    -   `Array<T>` for lists.
    -   `Map<K, V>` for key-value stores.
-   **Memory Management**: No manual memory management required (handled by the host).

## Syntax Example

```silang
struct Token {
  string type;
  string value;
}

int add(int a, int b) {
  return a + b;
}

void main() {
  print("Hello, Silang!");

  int result = add(10, 20);
  print(result);

  Array<int> numbers = [1, 2, 3];
  numbers.push(4);

  Map<string, int> ages;
  ages.set("Alice", 30);
  print(ages.get("Alice"));

  Token t;
  t.type = "IDENTIFIER";
  t.value = "x";
}
```

## Running

The host interpreter is built in C++.

```bash
make
./silang examples/hello.si
```

## Self-Hosting

The file `examples/self.si` contains a Silang interpreter written in Silang.
It implements a Lexer, Parser (recursive descent), and Interpreter (AST walker).
Due to complexity and current host parser limitations, full self-hosting verification is a work in progress, but the structure is complete.
