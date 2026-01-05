function isPrime(n) {
  if (n < 2) return 0;
  for (var i = 2; i * i <= n; i++) {
    if (n % i === 0) return 0;
  }
  return 1;
}
print(isPrime(17));
print(isPrime(20));
