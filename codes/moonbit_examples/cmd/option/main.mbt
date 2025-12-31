fn safe_divide(a : Int, b : Int) -> Int? {
  if b == 0 {
    None
  } else {
    Some(a / b)
  }
}

fn main {
  let a = 10
  let b = 2
  let c = 0

  match safe_divide(a, b) {
    Some(v) => println("\{a} / \{b} = \{v}")
    None => println("Cannot divide by zero")
  }

  match safe_divide(a, c) {
    Some(v) => println("\{a} / \{c} = \{v}")
    None => println("Cannot divide by zero")
  }
}
