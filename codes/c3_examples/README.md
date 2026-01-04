# C3 Language Examples

This directory contains 10 examples of C3 programming language usage.
C3 is an evolution of C, providing better usability and safety while maintaining C's simplicity.

## Examples

1.  **01_hello.c3**: Basic Hello World program.
2.  **02_variables.c3**: Demonstrates variables and basic types.
3.  **03_control_flow.c3**: Loops and conditional statements.
4.  **04_functions.c3**: Function definitions and calls.
5.  **05_structs.c3**: Struct usage.
6.  **06_arrays.c3**: Arrays and slices.
7.  **07_pointers.c3**: Pointer manipulation.
8.  **08_defer.c3**: Resource management with `defer`.
9.  **09_macros.c3**: Generic-like behavior using macros and compile-time checks (`$if`).
10. **10_enums.c3**: Enumerations and basic matching.

## Example Output

### 01_hello
```
Hello, World!
```

### 02_variables
```
Int: 10
Float: 3.140000
Char: A
Bool: 1
String: String literal
```

### 03_control_flow
```
x is positive
Counting to 5:
1
2
3
4
5
While loop:
0
1
2
```

### 04_functions
```
Sum: 8
Hello, User!
```

### 05_structs
```
Point: (10, 20)
Updated Point: (30, 20)
```

### 06_arrays
```
Array elements:
1
2
3
4
5
Slice elements (1..3):
2
3
```

### 07_pointers
```
Value: 42
Pointer Address: 0x...
Dereferenced: 42
New Value: 100
```

### 08_defer
```
Start
Middle
Inner Scope
Inner Scope Deferred
End (Deferred)
```

### 09_macros
```
Int: 10
Other type
```

### 10_enums
```
Green
It's Green
```

## Running

The `run_all.sh` script compiles and runs all examples using the installed `c3c` compiler (assumed to be available).
Output is saved to the `output/` directory.
