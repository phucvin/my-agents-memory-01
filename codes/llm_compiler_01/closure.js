// Closure
function makeAdder(x) {
  return function(y) {
    return x + y;
  };
}
let add5 = makeAdder(5);
putchar(add5(60)); // 65 -> 'A'
