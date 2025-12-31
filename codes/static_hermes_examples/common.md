# Common Observations in Static Hermes Generated C Code

Analyzing the C output from the Static Hermes compiler across multiple examples reveals consistent patterns in how JavaScript is translated to C.

## 1. Unit Structure
Every compiled JS file maps to a "Unit" in C, structured with:
- **`UnitData` struct**: Contains symbol tables, string pools, and property caches.
- **`CREATE_THIS_UNIT`**: A factory function to initialize the unit and register it with the runtime.
- **`_0_global`**: The entry point corresponding to the top-level scope of the JS module.

## 2. Memory Management
- **Stack Frames**: The C stack is used to manage the JS stack. Functions begin with `_sh_enter(shr, &locals.head, stack_depth)` and end with `_sh_leave`.
- **Garbage Collection Roots**: The `SHLocals` struct declared at the start of every function serves as the GC root set for that function frame.
- **Literal Buffers**: Object and Array literals are often initialized using `_sh_ljs_new_object_with_buffer` or `_sh_ljs_new_array_with_buffer`, referencing static byte arrays (`s_literal_val_buffer`) for compact initialization.

## 3. Execution Model
- **Inline Caching**: Property access heavily utilizes "Property Caches" (`SHReadPropertyCacheEntry`, `SHWritePropertyCacheEntry`). Calls like `_sh_ljs_get_by_id_rjs_inline` take a cache pointer to optimize repeated lookups.
- **Symbol Pooling**: Strings and identifiers are interned into a symbol table (`symbol_data`), allowing fast integer-based comparisons and lookups instead of string comparisons.
- **SSA and Phi Nodes**: The presence of comments like `// PhiInst` and the use of `goto` for control flow suggests the compiler flattens an SSA (Static Single Assignment) graph into C. Loops and conditionals are translated into label-and-goto spaghetti code.

## 4. Runtime Intrinsics
- **Inline Functions**: Common operations (math, bitwise) map to `_inline` suffixed runtime functions (e.g., `_sh_ljs_add_rjs_inline`). This likely allows the C compiler (GCC/Clang) to inline the JS semantics directly into the native binary, enabling further optimizations.
- **Type Handling**: Values are wrapped in `SHLegacyValue` (or similar), which seems to be a NaN-boxed or tagged union representation. Helper functions like `_sh_ljs_double()` or `_sh_ljs_bool()` create these values.

## 5. Exception Handling
- **Setjmp/Longjmp**: `try-catch` blocks are implemented using a `_sh_try` mechanism (likely wrapping `setjmp`) and `_sh_throw` (wrapping `longjmp`).
- **State Machines**: A volatile `tryState` variable manages the complex control flow required for `finally` blocks, ensuring cleanup happens on both normal and exceptional paths.

## 6. Optimization
- **Static Dispatch**: Where possible, the compiler seems to resolve things statically (e.g., vtables for function info), but dynamic JS semantics (like looking up "print" on the global object) are preserved with inline caches to speed them up.
- **String Concatenation**: Specific intrinsics like `_sh_string_concat` handle string building efficiently.
