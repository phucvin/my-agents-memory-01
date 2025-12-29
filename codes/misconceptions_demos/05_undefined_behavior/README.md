# Undefined Behavior and Optimizations

**Misconception:** "Undefined Behavior (UB) only enables optimizations."

**Reality:** While UB allows the compiler to make assumptions that enable some optimizations (like removing overflow checks), avoiding the introduction of UB can *prevent* other optimizations (like loop hoisting). The compiler cannot perform a transformation if it might introduce UB on a path where it didn't exist before.

## 1. UB Enables Optimization (`signed_overflow.cpp`)

In C++, signed integer overflow is UB. The compiler assumes it never happens.
Unsigned integer overflow is defined to wrap around.

**The Demo:**
- `signed_overflow_check`: Checks `(a + 1) > a`.
  - Since signed overflow is UB, `a + 1` is mathematically always greater than `a`.
  - The compiler optimizes this entire function to `return true` (constant 1).
- `unsigned_overflow_check`: Checks `(a + 1) > a` for unsigned integers.
  - Wraparound is defined. `UINT_MAX + 1` is `0`. `0 > UINT_MAX` is false.
  - The compiler must emit the comparison instruction.

**Inspect:**
Run `make` and open `signed_overflow.s`.
- `signed_overflow_check` will likely just be `mov eax, 1; ret`.
- `unsigned_overflow_check` will have `cmp` or `add` instructions.

## 2. UB Disables Optimization (`loop_hoist.cpp`)

The compiler wants to move loop-invariant code out of the loop ("Loop Invariant Code Motion" or LICM).

**The Demo:**
- `cannot_hoist_trap`: Calculates `b / c` inside a loop.
  - If `n <= 0`, the loop body never executes, so division by zero never happens.
  - If the compiler hoists `b / c` before the loop check, and `c == 0`, the program crashes even if `n <= 0`.
  - Because this transformation would turn a safe program (for `n <= 0`) into a crashing one, the compiler cannot hoist the division (without adding complex guards).
- `can_hoist_safe`: Calculates `b | c` inside a loop.
  - This operation is safe. The compiler hoists it freely.

**Inspect:**
Run `make` and open `loop_hoist.s`.
- In `cannot_hoist_trap`, look for the `idiv` instruction. It should be *inside* the loop (after the loop check/jump labels) or guarded.
- In `can_hoist_safe`, the `or` instruction (or calculation) will be done *before* the loop starts.
