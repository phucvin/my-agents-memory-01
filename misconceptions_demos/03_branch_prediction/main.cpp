#include <cstdio>

// Use noinline to prevent the compiler from just optimizing everything away
// inside test_branch.
void __attribute__((noinline)) critical_function() {
    asm(""); // Prevent total emptiness
}

void __attribute__((noinline)) rare_function() {
    asm("");
}

void test_branch(int x) {
    // __builtin_expect(expression, expected_value)
    // We tell the compiler that 'x == 0' is likely to be true (1).
    if (__builtin_expect(x == 0, 1)) {
        critical_function();
    } else {
        rare_function();
    }
}

void test_branch_unlikely(int x) {
    // We tell the compiler that 'x == 0' is unlikely (0).
    if (__builtin_expect(x == 0, 0)) {
        critical_function();
    } else {
        rare_function();
    }
}

int main() {
    volatile int i = 0;
    test_branch(i);
    test_branch_unlikely(i);
    return 0;
}
