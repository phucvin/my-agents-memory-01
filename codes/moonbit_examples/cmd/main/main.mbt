///|
fn main {
  println("Running 10 MoonBit Examples")

  println("\n--- 1. Hello World ---")
  example_hello()

  println("\n--- 2. Fibonacci (Recursion) ---")
  example_fibonacci()

  println("\n--- 3. Factorial (Loop) ---")
  example_factorial()

  println("\n--- 4. Array Operations ---")
  example_arrays()

  println("\n--- 5. Structs & Methods ---")
  example_structs()

  println("\n--- 6. Enums & Pattern Matching ---")
  example_enums()

  println("\n--- 7. Higher Order Functions ---")
  example_hof()

  println("\n--- 8. Option Type ---")
  example_option()

  println("\n--- 9. Generics (Box) ---")
  example_generics()

  println("\n--- 10. Traits (Speak) ---")
  example_traits()
}

// 1. Hello World
fn example_hello() -> Unit {
  println("Hello, MoonBit!")
}

// 2. Fibonacci
fn fib(n : Int) -> Int {
  if n <= 1 {
    n
  } else {
    fib(n - 1) + fib(n - 2)
  }
}

fn example_fibonacci() -> Unit {
  let n = 10
  println("Fibonacci of \{n} is \{fib(n)}")
}

// 3. Factorial
fn factorial(n : Int) -> Int {
  let mut result = 1
  for i = 1; i <= n; i = i + 1 {
    result = result * i
  }
  result
}

fn example_factorial() -> Unit {
  let n = 5
  println("Factorial of \{n} is \{factorial(n)}")
}

// 4. Array Operations
fn example_arrays() -> Unit {
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

// 5. Structs
struct User {
  id : Int
  name : String
  email : String
}

fn User::new(id : Int, name : String, email : String) -> User {
  { id, name, email }
}

fn User::display(self : User) -> String {
  "User(id=\{self.id}, name=\{self.name}, email=\{self.email})"
}

fn example_structs() -> Unit {
  let user = User::new(1, "Alice", "alice@example.com")
  println(user.display())
}

// 6. Enums & Pattern Matching
enum Shape {
  Circle(Double)
  Rectangle(Double, Double)
}

fn area(shape : Shape) -> Double {
  match shape {
    Circle(r) => 3.14159 * r * r
    Rectangle(w, h) => w * h
  }
}

fn example_enums() -> Unit {
  let c = Circle(5.0)
  let r = Rectangle(4.0, 6.0)

  println("Area of circle: \{area(c)}")
  println("Area of rectangle: \{area(r)}")
}

// 7. Higher Order Functions
fn apply(f : (Int) -> Int, x : Int) -> Int {
  f(x)
}

fn example_hof() -> Unit {
  let double = fn(x) { x * 2 }
  let square = fn(x) { x * x }

  println("Apply double to 5: \{apply(double, 5)}")
  println("Apply square to 5: \{apply(square, 5)}")
}

// 8. Option Type
fn safe_divide(a : Int, b : Int) -> Int? {
  if b == 0 {
    None
  } else {
    Some(a / b)
  }
}

fn example_option() -> Unit {
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

// 9. Generics
struct Box[T] {
  value : T
}

fn Box::new[T](value : T) -> Box[T] {
  { value: value }
}

fn Box::unwrap[T](self : Box[T]) -> T {
  self.value
}

fn example_generics() -> Unit {
  let int_box = Box::new(42)
  let str_box = Box::new("Hello Generics")

  println("Int box contains: \{int_box.unwrap()}")
  println("String box contains: \{str_box.unwrap()}")
}

// 10. Traits
trait Speak {
  speak(Self) -> String
}

struct Dog {
  name : String
}

struct Cat {
  name : String
}

impl Speak for Dog with speak(self) {
  "Woof! I am " + self.name
}

impl Speak for Cat with speak(self) {
  "Meow! I am " + self.name
}

fn introduce[T : Speak](animal : T) -> Unit {
  println(animal.speak())
}

fn example_traits() -> Unit {
  let dog : Dog = { name: "Buddy" }
  let cat : Cat = { name: "Whiskers" }

  introduce(dog)
  introduce(cat)
}
