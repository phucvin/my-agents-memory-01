fn main {
  let arr = [1, 2, 3, 4, 5]
  println("Original array: \{arr}")

  let mut sum = 0
  for x in arr {
    sum = sum + x
  }
  println("Sum of array elements: \{sum}")

  // Map operation (manual)
  let doubled = []
  for x in arr {
    doubled.push(x * 2)
  }
  println("Doubled array: \{doubled}")
}
