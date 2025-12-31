// 3. Functions and Closures

function makeCounter(start) {
  var count = start;
  return function() {
    return count++;
  };
}

var counter1 = makeCounter(10);
var counter2 = makeCounter(100);

print("Counter 1: " + counter1()); // 10
print("Counter 1: " + counter1()); // 11
print("Counter 2: " + counter2()); // 100
print("Counter 1: " + counter1()); // 12
