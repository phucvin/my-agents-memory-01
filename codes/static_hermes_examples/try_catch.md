# Try-Catch Analysis

## JavaScript Code (`try_catch.js`)

```javascript
try {
  // ...
  throw new Error("...");
} catch (e) {
  // ...
} finally {
  // ...
}
```

## C Code Analysis (`try_catch.c`)

### 1. Exception Handling Setup
The C code uses `_sh_try` and `SHJmpBuf` (setjmp/longjmp mechanism usually).
```c
SHJmpBuf jmpBuf;
volatile uint32_t tryState = 0; // State machine for finally block
if (__builtin_expect(_sh_try(shr, &jmpBuf), 0) != 0) goto L_catch;
```

### 2. Try Block
Logic runs normally. If an exception occurs, execution jumps to `L_catch`.
`tryState` tracks execution progress (1 = inside try, 2 = ...).

### 3. Throwing
In `_1_riskyOperation`:
```c
locals.t1 = _sh_ljs_create_this(..., Error, ...);
// ... construct error ...
_sh_throw(shr, locals.t0);
```

### 4. Catch Block
```c
L_catch:
  // ...
  _sh_catch_no_pop(shr, (SHLocals*)&locals, frame, 10);
  switch (tryState) { ... }
```
The catch block retrieves the thrown value using `_sh_get_clear_thrown_value(shr)`.

### 5. Finally Block
The code structure ensures `finally` logic runs whether exiting normally or via exception (implied by the state machine and `_sh_end_try`).

### Interesting Observations
- **Setjmp/Longjmp**: `_sh_try` likely wraps `setjmp`. `_sh_throw` performs the jump.
- **State Machine**: A `tryState` variable is used to manage control flow into the `catch` and `finally` blocks, handling different exit paths from the `try` block.
- **Volatile**: `tryState` is marked `volatile` to prevent register caching across the `setjmp` boundary (which clobbers registers).
