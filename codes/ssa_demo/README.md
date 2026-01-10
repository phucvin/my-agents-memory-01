# SSA Conversion Prototype (Pizlo SSA Form)

This project demonstrates a prototype for converting code to **Pizlo SSA Form**, as described in [Pizlo SSA Form (short version)](https://gist.github.com/pizlonator/79b0aa601912ff1a0eb1cb9253f5e98d).

It supports integers, variables, `if` statements, and `while` loops.

## Features

- **IR**: Simple AST and CFG-based Intermediate Representation.
- **CFG Construction**: Converts linear/structured code into Basic Blocks.
- **SSA Conversion**:
  - Dominance Frontier calculation and Standard SSA construction.
  - **Pizlo Form Conversion**: Transforms Standard Phis into `Upsilon` stores and implicit `Phi` loads using shadow variables.

## Pizlo SSA Form

In this form:
- Every Phi node `x = phi(...)` is replaced by `x = phi()` which implicitly reads a **shadow variable** (e.g., `^x`).
- Incoming values from predecessors are handled by `upsilon(val, ^x)` instructions inserted in the predecessor blocks.
- This decouples SSA data flow from the CFG structure (no block arguments).

## Usage

Run the demo script:

```bash
python3 ssa.py
```

Run tests:

```bash
python3 test_ssa.py
```

## Example Output

Input Code:
```python
x = 1
y = 1
if x:
  y = 2
# else y stays 1
print y
```

Initial CFG:
```
L0_entry:
  x = 1
  y = 1
  br x, L1_then, L2_else

L1_then:
  y = 2
  jmp L3_join

L2_else:
  jmp L3_join

L3_join:
  print y
  => (end)
```

Pizlo SSA Form CFG:
```
L0_entry:
  x_0 = 1
  y_0 = 1
  br x_0, L1_then, L2_else

L1_then:
  y_1 = 2
  upsilon(y_1, ^y_2)
  jmp L3_join

L2_else:
  upsilon(y_0, ^y_2)
  jmp L3_join

L3_join:
  y_2 = phi()  # reads ^y_2
  print y_2
  => (end)
```
