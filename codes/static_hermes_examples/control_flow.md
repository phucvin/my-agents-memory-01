# Control Flow Analysis

## JavaScript Code (`control_flow.js`)

The code demonstrates:
1.  `if-else` chains in `checkGrade`.
2.  `while` loop.
3.  `do-while` loop.

## C Code Analysis (`control_flow.c`)

### 1. Function Definition (`checkGrade`)
The JS function is compiled to `_1_checkGrade`.
- **Arguments**: Access argument via `_sh_ljs_param(frame, 1)`.
- **If-Else Chain**: Implemented as a sequence of checks and `goto`.
```c
L0: // if (score >= 90)
  np0 = _sh_ljs_double(90);
  np0 = _sh_ljs_bool(_sh_ljs_greater_equal_rjs_inline(shr, &locals.t1, &np0));
  if(_sh_ljs_get_bool(np0)) goto L5; // Return 'A' (via L5, but L5 seems to be just the return point, wait)
  // Actually, L5 is the return block. The block before goto L5 sets locals.t0 = 'A'.
  goto L1;
```
Wait, the code structure is:
```c
  // ... check condition ...
  locals.t0 = _sh_ljs_get_string(shr, ... "A");
  if(_sh_ljs_get_bool(np0)) goto L5; // Jump to return if true
  goto L1; // Else check next condition
```
This pattern repeats for L1 (>= 80), L2 (>= 70), etc.

### 2. While Loop
In `_0_global`, the `while (count < 3)` loop:
```c
  // Check condition
  np0 = _sh_ljs_bool(_sh_ljs_less_rjs_inline(shr, &locals.t0, &np3));
  if(_sh_ljs_get_bool(np0)) goto L1; // Body
  goto L2; // Exit
L1:
  // Body logic...
  // Increment count...
  // Check condition again...
  if(_sh_ljs_get_bool(np0)) goto L1; // Loop back
  goto L2; // Exit
```

### 3. Do-While Loop
```c
L2:
  // Body logic ...
  // Decrement count ...
  // Check condition (count > 0)
  np0 = _sh_ljs_bool(_sh_ljs_greater_rjs_inline(shr, &locals.t3, &np1));
  if(_sh_ljs_get_bool(np0)) goto L2; // Loop back
  goto L3; // Exit
```

### Interesting Observations
- **Phi Nodes**: The comment `// PhiInst` appears in `_1_checkGrade` at label `L5`. This suggests the compiler uses an SSA-based intermediate representation (like LLVM or Hermes IR) before generating C code, and the C code generation flattens the Phi nodes into variable assignments in predecessor blocks (which explains why `locals.t0` is set in each block before jumping to `L5`).
- **Param Access**: `_sh_ljs_param(frame, 1)` retrieves the first argument. `frame[0]` is typically `this` or context.
