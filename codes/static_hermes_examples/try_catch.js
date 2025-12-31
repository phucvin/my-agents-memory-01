// 8. Try-Catch Exception Handling
function riskyOperation(val) {
  if (val < 0) {
    throw new Error("Value cannot be negative");
  }
  return Math.sqrt(val);
}

try {
  print("Sqrt(16): " + riskyOperation(16));
  print("Sqrt(-1): " + riskyOperation(-1)); // This will throw
} catch (e) {
  print("Caught exception: " + e.message);
} finally {
  print("Cleanup done");
}
