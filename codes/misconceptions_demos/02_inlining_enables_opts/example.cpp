#include <limits.h>

// The function to be inlined
// It has a check that becomes redundant if 'denom' is known at compile time.
int sat_div(int num, int denom) {
    if (denom == 0) {
        return (num > 0) ? INT_MAX : INT_MIN;
    }
    return num / denom;
}

// Case 1: Constant propagation possible after inlining
int foo_const(int a) {
    // When sat_div is inlined here, denom becomes 3.
    // The 'if (3 == 0)' check is constant-folded to false.
    // The dead code is removed.
    // The division 'a / 3' remains (and might be strength-reduced to multiplication).
    return sat_div(a, 3);
}

// Case 2: Constant propagation NOT possible (variable denominator)
int foo_var(int a, int b) {
    return sat_div(a, b);
}
