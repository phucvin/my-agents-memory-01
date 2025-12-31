///|
fn factorial(n : Int) -> Int {
  let mut result = 1
  for i = 1; i <= n; i = i + 1 {
    result = result * i
  }
  result
}

fn main {
  let n = 5
  println("Factorial of \{n} is \{factorial(n)}")
}
