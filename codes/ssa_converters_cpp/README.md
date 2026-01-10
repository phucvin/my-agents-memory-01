# SSA Converters Prototype

This project prototypes three different SSA (Static Single Assignment) forms in C++:
1.  **Standard SSA**: Uses `Phi` functions at block entries.
2.  **Functional SSA**: Uses Basic Block arguments.
3.  **Pizlo SSA** (SSA-SSU): Uses `Upsilon` (store to shadow) and `Phi` (load from shadow) instructions.

## Building

```bash
make
```

## Running

```bash
./ssa_converter
```

The program will output the Original IR and the converted forms for a test case containing a loop and conditional logic.
