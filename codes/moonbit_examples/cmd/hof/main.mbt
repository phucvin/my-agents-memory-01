fn apply(f : (Int) -> Int, x : Int) -> Int {
  f(x)
}

fn main {
  let double = fn(x) { x * 2 }
  let square = fn(x) { x * x }

  println("Apply double to 5: \{apply(double, 5)}")
  println("Apply square to 5: \{apply(square, 5)}")
}
