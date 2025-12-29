// The compiler aims to hoist loop-invariant calculations out of the loop
// to avoid re-calculating them every iteration.

// Case 1: Division by zero is Undefined Behavior (and traps on x86).
// The compiler CANNOT blindly hoist (b / c) out of the loop.
// If n <= 0, the loop never runs, so the division never happens in the original code.
// If the compiler hoisted it, and c == 0, the program would crash even if n <= 0.
// To avoid introducing a bug on the (n <= 0) path, the compiler must NOT hoist
// the division (or must guard it).
//
// In the assembly, you will see the `idiv` instruction is guarded by a check on `n`.
void cannot_hoist_trap(int* a, int b, int c, int n) {
    for (int i = 0; i < n; ++i) {
        a[i] = b / c;
    }
}

// Case 2: Manual hoisting.
// Here the programmer explicitly calculates `b / c` before the loop.
// This will crash if c == 0 even if n <= 0.
// In the assembly, the `idiv` instruction will appear BEFORE the check on `n`.
void manual_hoist_trap(int* a, int b, int c, int n) {
    int temp = b / c;
    for (int i = 0; i < n; ++i) {
        a[i] = temp;
    }
}

// Case 3: Bitwise operations are usually safe and defined for all inputs.
// The compiler CAN hoist (b | c) safely because it never traps.
// However, modern compilers might still perform dead-code elimination if the loop
// doesn't run, so it might still look guarded.
void can_hoist_safe(int* a, int b, int c, int n) {
    for (int i = 0; i < n; ++i) {
        a[i] = b | c;
    }
}
