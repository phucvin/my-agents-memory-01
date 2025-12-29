#include <limits.h>

// Case 1: Signed Integer Overflow is Undefined Behavior.
// The compiler can assume it NEVER happens.
// Therefore, (a + 1) > a is ALWAYS true, because if a + 1 overflowed,
// that would be UB, and the compiler assumes UB doesn't exist.
bool signed_overflow_check(int a) {
    return (a + 1) > a;
}

// Case 2: Unsigned Integer Overflow is Defined (wraps around).
// The compiler MUST perform the check because (UINT_MAX + 1) becomes 0,
// and 0 > UINT_MAX is false.
bool unsigned_overflow_check(unsigned int a) {
    return (a + 1) > a;
}
