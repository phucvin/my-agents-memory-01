# Objects with Field Addition Analysis

## JavaScript Code (`objects_add_field.js`)

```javascript
var point = {
  x: 10,
  y: 20
};
// ...
point.z = 30; // Add new field
// ...
point.z += 5; // Modify
```

## C Code Analysis (`objects_add_field.c`)

### 1. Initial Object Creation
The object `point` is created with an initial shape containing `x` and `y`.
```c
locals.t1 = _sh_ljs_new_object_with_buffer(shr, shUnit, 0, 0);
_sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t0, get_symbols(shUnit)[3] /*point*/, &locals.t1, ...);
```
- `s_obj_shape_table[0]` defines the shape with 2 properties (`x`, `y`).
- `s_literal_val_buffer` contains the initial values 10 and 20.

### 2. Adding a New Field
When `point.z = 30` is executed, the property `z` is added dynamically.
```c
locals.t1 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t0,get_symbols(shUnit)[3] /*point*/, ...);
np1 = _sh_ljs_double(30);
_sh_ljs_put_by_id_loose_rjs(shr, shUnit, &locals.t1, get_symbols(shUnit)[7] /*z*/, &np1, get_write_prop_cache(shUnit) + 1);
```
- The function `_sh_ljs_put_by_id_loose_rjs` handles adding the new property.
- Unlike the initial properties, this assignment uses a general "put by id" mechanism, but it still utilizes a write property cache (`get_write_prop_cache(shUnit) + 1`) to optimize future writes to `z`.

### 3. Accessing the New Field
Accessing `z` later uses the same inline cache mechanism as `x` and `y`.
```c
locals.t3 = _sh_ljs_get_by_id_rjs_inline(shr,&locals.t3,get_symbols(shUnit)[7] /*z*/, get_read_prop_cache(shUnit) + 12);
```

### Comparison with `objects.js`

| Feature | `objects.js` | `objects_add_field.js` |
| :--- | :--- | :--- |
| **Object Creation** | Created with *all* properties (firstName, etc.) at once using a shape table. | Created with `x` and `y` using a shape table. |
| **Field Addition** | No fields added after creation. | Field `z` is added after creation. |
| **Performance** | All properties are pre-allocated and likely stored in fixed offsets (optimized shape). | Adding `z` might trigger a shape transition or use a slower path initially, though caches help mitigate this. |
| **Generated C** | Uses `_sh_prstore_object` for nested objects. | Uses `_sh_ljs_put_by_id_loose_rjs` for the new field. |

In `objects.js`, the compiler could see the full structure and optimized the creation using nested shapes. In `objects_add_field.js`, the compiler optimizes the initial literal but must handle `z` as a dynamic addition. However, Static Hermes still attempts to cache this access.
