# Objects Analysis

## JavaScript Code (`objects.js`)

```javascript
var person = {
  firstName: "John",
  lastName: "Doe",
  age: 30,
  isEmployed: true,
  address: {
    city: "New York",
    zip: "10001"
  }
};
// ... access and modify ...
```

## C Code Analysis (`objects.c`)

### 1. Object Creation
The object literal is created using buffers and shape tables for efficiency.
```c
locals.t1 = _sh_ljs_new_object_with_buffer(shr, shUnit, 0, 0); // Inner address object?
locals.t0 = _sh_ljs_new_object_with_buffer(shr, shUnit, 1, 12); // Main person object?
_sh_prstore_object(shr, &locals.t1, 4, &locals.t0); // Store inner object into outer?
```
Wait, let's look closely at `_sh_ljs_new_object_with_buffer(shr, shUnit, shape_idx, val_buffer_offset)`.
- `shape_idx` 0 corresponds to `s_obj_shape_table[0]` (5 props: firstName, lastName, age, isEmployed, address).
- `shape_idx` 1 corresponds to `s_obj_shape_table[1]` (2 props: city, zip).

The buffers `s_literal_val_buffer` and `s_obj_key_buffer` likely encode the keys and values.

### 2. Property Access
Access is optimized with inline caches.
```c
// person.firstName
locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, get_read_prop_cache(shUnit) + 1);
locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[0] /*firstName*/, get_read_prop_cache(shUnit) + 2);
```

### 3. Nested Access
`person.address.city`:
```c
locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[12] /*person*/, ...);
locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[4] /*address*/, ...);
locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t1,get_symbols(shUnit)[7] /*city*/, ...);
```

### 4. Property Update
`person.age += 1`:
```c
// Get age
locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t2,get_symbols(shUnit)[2] /*age*/, ...);
// Add 1
locals.t1 = _sh_ljs_add_rjs_inline(shr, &locals.t1, &np1);
// Put back
_sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t2, get_symbols(shUnit)[2] /*age*/, &locals.t1, get_write_prop_cache(shUnit) + 1);
```

### Interesting Observations
- **Object Shape**: The compiler identifies the "shape" of object literals (keys and their order) and stores them in `s_obj_shape_table`. This allows creating objects with pre-calculated layouts.
- **Literal Buffers**: Values for the object literals are stored in a compressed format in `s_literal_val_buffer`.
- **Pre-store**: `_sh_prstore_object` seems to be used to link the nested object (address) into the parent object during initialization, likely "Pre-Store" optimization for literal creation.
