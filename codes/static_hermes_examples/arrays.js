// 1. Array operations
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// Filter even numbers
var evens = [];
for (var i = 0; i < numbers.length; i++) {
  if (numbers[i] % 2 === 0) {
    evens.push(numbers[i]);
  }
}

print("Evens: " + evens);

// Map to squares
var squares = [];
for (var i = 0; i < evens.length; i++) {
  squares.push(evens[i] * evens[i]);
}

print("Squares of evens: " + squares);
