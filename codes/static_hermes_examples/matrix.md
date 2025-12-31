# Matrix Analysis

## JavaScript Code (`matrix.js`)

```javascript
// 2x2 Matrix multiplication
function multiplyMatrix(A, B) {
  var C = [
    [0, 0],
    [0, 0]
  ];
  C[0][0] = A[0][0] * B[0][0] + A[0][1] * B[1][0];
  C[0][1] = A[0][0] * B[0][1] + A[0][1] * B[1][1];
  C[1][0] = A[1][0] * B[0][0] + A[1][1] * B[1][0];
  C[1][1] = A[1][0] * B[0][1] + A[1][1] * B[1][1];
  return C;
}

var m1 = [
  [1, 2],
  [3, 4]
];
var m2 = [
  [5, 6],
  [7, 8]
];

var result = multiplyMatrix(m1, m2);
// ... print result ...
```

## C Code Analysis (`matrix.c`)

### 1. Nested Array Creation
Creating the result matrix `C`:
```c
locals.t0 = _sh_ljs_new_array_with_buffer(shr, shUnit, 0, 2, 0); // [0, 0]
locals.t2 = _sh_ljs_new_array_with_buffer(shr, shUnit, 0, 2, 0); // [0, 0]
locals.t3 = _sh_ljs_new_array(shr, 2); // C = []
// Store rows into C
_sh_ljs_put_by_val_loose_rjs(shr, &locals.t3, &np0, &locals.t0); // C[0] = row1
_sh_ljs_put_by_val_loose_rjs(shr, &locals.t3, &np2, &locals.t2); // C[1] = row2
```

### 2. Element Access and Arithmetic
`C[0][0] = A[0][0] * B[0][0] + A[0][1] * B[1][0];`
This involves a chain of loads:
```c
// A[0][0]
locals.t2 = _sh_ljs_param(frame, 1); // A
locals.t2 = _sh_ljs_get_by_val_rjs(shr,&locals.t2, &np0); // A[0]
locals.t2 = _sh_ljs_get_by_val_rjs(shr,&locals.t2, &np0); // A[0][0]

// B[0][0]
locals.t5 = _sh_ljs_param(frame, 2); // B
locals.t5 = _sh_ljs_get_by_val_rjs(shr,&locals.t5, &np0); // B[0]
locals.t5 = _sh_ljs_get_by_val_rjs(shr,&locals.t5, &np0); // B[0][0]

// Multiply
locals.t2 = _sh_ljs_mul_rjs_inline(shr, &locals.t2, &locals.t5);

// ... similar for A[0][1] * B[1][0] ...

// Add
locals.t2 = _sh_ljs_add_rjs_inline(shr, &locals.t2, &locals.t4);

// Store to C[0][0]
locals.t4 = _sh_ljs_get_by_val_rjs(shr,&locals.t1, &np0); // C[0]
_sh_ljs_put_by_val_loose_rjs(shr, &locals.t4, &np0, &locals.t2); // C[0][0] = result
```

### Interesting Observations
- **Array of Arrays**: Multidimensional arrays are strictly arrays of arrays, requiring multiple `get_by_val` calls.
- **Verbose Access**: The C code for a single line of matrix math is quite verbose due to the explicit load/store for every intermediate value.
- **No Vectorization**: Unlike a C optimizer which might vectorize this, the JS->C compilation here (at this level) preserves the semantic operations of JS, though `gcc -O3` on the resulting C file might be able to optimize it further if the runtime functions are inlinable and analyzable.
