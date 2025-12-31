// 10. Matrix Multiplication (Arrays of Arrays)
var A = [
  [1, 2],
  [3, 4]
];

var B = [
  [5, 6],
  [7, 8]
];

var C = [
  [0, 0],
  [0, 0]
];

for (var i = 0; i < 2; i++) {
  for (var j = 0; j < 2; j++) {
    var sum = 0;
    for (var k = 0; k < 2; k++) {
      sum += A[i][k] * B[k][j];
    }
    C[i][j] = sum;
  }
}

print("Result Matrix C:");
print(C[0][0] + " " + C[0][1]);
print(C[1][0] + " " + C[1][1]);
