// 6. Control Flow
function checkGrade(score) {
  var grade;
  if (score >= 90) {
    grade = 'A';
  } else if (score >= 80) {
    grade = 'B';
  } else if (score >= 70) {
    grade = 'C';
  } else if (score >= 60) {
    grade = 'D';
  } else {
    grade = 'F';
  }
  return grade;
}

print("Score 95: " + checkGrade(95));
print("Score 82: " + checkGrade(82));
print("Score 50: " + checkGrade(50));

var count = 0;
while (count < 3) {
  print("While count: " + count);
  count++;
}

do {
  print("Do-while count: " + count);
  count--;
} while (count > 0);
