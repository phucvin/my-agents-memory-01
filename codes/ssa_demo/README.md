# SSA Conversion Prototype

This project demonstrates a prototype for converting code to Static Single Assignment (SSA) form. It supports integers, variables, `if` statements, and `while` loops.

## Features

- **IR**: Simple AST and CFG-based Intermediate Representation.
- **CFG Construction**: Converts linear/structured code into Basic Blocks.
- **SSA Conversion**:
  - Dominance Frontier calculation.
  - Phi-node insertion.
  - Variable renaming (versioning).

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
  => L1_then, L2_else

L1_then:
  y = 2
  jmp L3_join
  => L3_join

L2_else:
  jmp L3_join
  => L3_join

L3_join:
  print y
  => (end)
```

SSA CFG:
```
L0_entry:
  x_0 = 1
  y_0 = 1
  br x_0, L1_then, L2_else
  => L1_then, L2_else

L1_then:
  y_1 = 2
  jmp L3_join
  => L3_join

L2_else:
  jmp L3_join
  => L3_join

L3_join:
  y_2 = phi([y_1, L1_then], [y_0, L2_else])
  print y_2
  => (end)
```
