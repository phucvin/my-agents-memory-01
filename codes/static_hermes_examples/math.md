# Math Analysis

## JavaScript Code (`math.js`)

```javascript
function add(a, b) {
  return a + b;
}
print(add(20, 10));
```

## C Code Analysis (`math.c`)

### 1. Function Definition (`add`)
The simple `add` function is compiled to `_1_add`:
```c
static SHLegacyValue _1_add(SHRuntime *shr) {
  // ...
  locals.t1 = _sh_ljs_param(frame, 2); // Argument 'b'
  locals.t0 = _sh_ljs_param(frame, 1); // Argument 'a'
  locals.t0 = _sh_ljs_add_rjs_inline(shr, &locals.t0, &locals.t1); // a + b
  // ...
  return locals.t0;
}
```

### 2. Calling Convention
In `_0_global`, the call to `add(20, 10)`:
```c
frame[4] = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*add*/, ...);
frame[1] = _sh_ljs_double(20);
frame[2] = _sh_ljs_double(10);
// ... setup stack ...
frame[2] = _sh_ljs_call(shr, frame, 2); // 2 args
```
Note: `_sh_ljs_call` takes the number of arguments as the 3rd parameter (here `2`).

### Interesting Observations
- **Argument Access**: Arguments are accessed by index 1-based from the frame using `_sh_ljs_param`.
- **Inline Addition**: `_sh_ljs_add_rjs_inline` handles the addition, which supports JS semantics (string concatenation vs numeric addition) internally, though here it's likely optimized for numbers if types were inferred, but `rjs` suggests "runtime js" value handling.
