# MoonBit Examples

This project demonstrates 10 examples of MoonBit language features.

## Prerequisites

- MoonBit CLI (`moon`)

## Build and Run

```bash
moon run cmd/main
```

## Examples Included

1.  **Hello World**: Basic printing.
2.  **Fibonacci**: Recursive function.
3.  **Factorial**: Loop-based implementation.
4.  **Array Operations**: Creation, iteration, and mapping.
5.  **Structs & Methods**: Defining types and methods.
6.  **Enums & Pattern Matching**: Algebraic data types.
7.  **Higher Order Functions**: Functions as arguments.
8.  **Option Type**: Handling optional values safely.
9.  **Generics**: Generic types (Box).
10. **Traits**: Interface-like behavior (Speak trait).

## Example Output

```
Running 10 MoonBit Examples

--- 1. Hello World ---
Hello, MoonBit!

--- 2. Fibonacci (Recursion) ---
Fibonacci of 10 is 55

--- 3. Factorial (Loop) ---
Factorial of 5 is 120

--- 4. Array Operations ---
Original array: [1, 2, 3, 4, 5]
Sum of array elements: 15
Doubled array: [2, 4, 6, 8, 10]

--- 5. Structs & Methods ---
User(id=1, name=Alice, email=alice@example.com)

--- 6. Enums & Pattern Matching ---
Area of circle: 78.53975
Area of rectangle: 24

--- 7. Higher Order Functions ---
Apply double to 5: 10
Apply square to 5: 25

--- 8. Option Type ---
10 / 2 = 5
Cannot divide by zero

--- 9. Generics (Box) ---
Int box contains: 42
String box contains: Hello Generics

--- 10. Traits (Speak) ---
Woof! I am Buddy
Meow! I am Whiskers
```
