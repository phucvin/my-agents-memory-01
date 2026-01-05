function fib(n) {
  var a = 0;
  var b = 1;
  for (var i = 0; i < n; i++) {
    var temp = a;
    a = b;
    b = temp + b;
  }
  return a;
}
print(fib(10));
