# SSA Conversion Prototype (Functional SSA)

This project demonstrates a prototype for converting code to **Functional SSA** form (also known as Block Arguments). It supports integers, variables, `if` statements, and `while` loops.

In Functional SSA, Phi nodes are replaced by Basic Block parameters. Predecessors pass arguments to the successor blocks, similar to function calls.

## Features

- **IR**: Simple AST and CFG-based Intermediate Representation.
- **CFG Construction**: Converts linear/structured code into Basic Blocks.
- **SSA Conversion**:
  - Dominance Frontier calculation.
  - Phi-node insertion & Renaming (Standard SSA).
  - **Functional Conversion**: Transforms Phis into Block Parameters and Jump Arguments.

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

Functional SSA CFG:
```
L0_entry:
  x_0 = 1
  y_0 = 1
  br x_0, L1_then, L2_else

L1_then:
  y_1 = 2
  jmp L3_join (y_1)

L2_else:
  jmp L3_join (y_0)

L3_join(y_2):
  print y_2
  => (end)
```
