// This function has the 'inline' keyword.
// The compiler treats this as a hint. In LLVM IR, it doesn't explicitly add 'inlinehint'
// at -O0 sometimes, but it marks it as 'linkonce_odr' (link once, one definition rule)
// which allows it to be defined in headers.
// The 'inlinehint' attribute might appear depending on clang version or optimization levels in frontend.
inline int sum_inline(int a, int b) {
    return a + b;
}

// This function does not have the 'inline' keyword.
int sum_no_inline(int a, int b) {
    return a + b;
}

// We call them here.
int main(int argc, char** argv) {
    return sum_inline(argc, 1) + sum_no_inline(argc, 2);
}
