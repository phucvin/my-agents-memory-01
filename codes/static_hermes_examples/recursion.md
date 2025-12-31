# Recursion Analysis

## JavaScript Code (`recursion.js`)

```javascript
function fib(n) {
  if (n <= 1) return n;
  return fib(n - 1) + fib(n - 2);
}
// ... loop and print ...
```

## C Code Analysis (`recursion.c`)

### 1. Function Definition (`fib`)
Compiled to `_1_fib`.
- **Condition**: `if (n <= 1)`
```c
locals.t0 = _sh_ljs_param(frame, 1);
np0 = _sh_ljs_double(1);
np1 = _sh_ljs_bool(_sh_ljs_less_equal_rjs_inline(shr, &locals.t0, &np0));
if(_sh_ljs_get_bool(np1)) goto L2; // Return n (L2 uses locals.t0 which holds n)
```
- **Recursive Step**:
```c
L1:
  // fib(n-1)
  frame[3] = ... get fib ...
  frame[1] = _sh_ljs_sub_rjs_inline(shr, &locals.t0, &np0); // n - 1
  locals.t2 = _sh_ljs_call(shr, frame, 1);

  // fib(n-2)
  frame[3] = ... get fib ...
  np0 = _sh_ljs_double(2);
  frame[1] = _sh_ljs_sub_rjs_inline(shr, &locals.t0, &np0); // n - 2
  locals.t1 = _sh_ljs_call(shr, frame, 1);

  // Add results
  locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t1);
  return locals.t1;
```

### Interesting Observations
- **Stack Depth**: The stack depth `10` in `_sh_enter(shr, &locals.head, 10)` in `_0_global` vs `1` (plus args) in `_1_fib` suggests `_sh_enter` allocates space for locals and temporary registers. `locals.head.count` indicates the number of GC-managed locals.
- **Tail Call**: There is no tail call optimization evident here; standard recursive calls are used.
