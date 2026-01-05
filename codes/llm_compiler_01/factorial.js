function factorial(n) {
  if (n == 0) return 1;
  return n * factorial(n - 1);
}

// Minimal test: print '!' (33) + factorial(5) (120) = 153? No, let's just output the result.
// But putchar prints char.
// Let's just define the function.
// Or run it and print result if it fits byte.
// 5! = 120, which is 'x'.
putchar(factorial(5));
