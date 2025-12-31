# Bitwise Operations Analysis

## JavaScript Code (`bitwise.js`)

```javascript
var a = 5;  // 0101
var b = 3;  // 0011

print("a & b = " + (a & b));
print("a | b = " + (a | b));
print("a ^ b = " + (a ^ b));
print("~a = " + (~a));
print("a << 1 = " + (a << 1));
print("a >> 1 = " + (a >> 1));
```

## C Code Analysis (`bitwise.c`)

### 1. Variable Declaration
Variables `a` and `b` are declared and initialized in the global scope object:
```c
_sh_ljs_declare_global_var(shr, get_symbols(shUnit)[1] /*a*/);
// ...
np1 = _sh_ljs_double(5);
_sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[1] /*a*/, &np1, ...);
```

### 2. Bitwise AND (`&`)
`a & b` translates to `_sh_ljs_bit_and_rjs_inline`:
```c
locals.t2 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[1] /*a*/, ...);
locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[2] /*b*/, ...);
locals.t1 = _sh_ljs_bit_and_rjs_inline(shr, &locals.t2, &locals.t3);
```

### 3. Bitwise NOT (`~`)
`~a` uses `_sh_ljs_bit_not_rjs_inline`:
```c
locals.t1 = _sh_ljs_bit_not_rjs_inline(shr, &locals.t2);
```

### 4. Shifts (`<<`, `>>`)
Left shift uses `_sh_ljs_lshift_rjs_inline`:
```c
locals.t1 = _sh_ljs_lshift_rjs_inline(shr, &locals.t2, &np1);
```
Right shift uses `_sh_ljs_rshift_rjs_inline`:
```c
locals.t1 = _sh_ljs_rshift_rjs_inline(shr, &locals.t2, &np1);
```

### Interesting Observations
- **Inline Operations**: Almost all bitwise operations are mapped to `_inline` suffixed functions in the runtime (e.g., `_sh_ljs_bit_and_rjs_inline`), suggesting they are optimized paths.
- **Double Representation**: Even though bitwise operations work on integers, the literals like `5` and `3` are initialized as doubles (`_sh_ljs_double(5)`) because JS numbers are doubles. The runtime handles the conversion to Int32 for bitwise ops.
