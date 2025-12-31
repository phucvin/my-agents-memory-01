struct Box[T] {
  value : T
}

fn Box::new[T](value : T) -> Box[T] {
  { value: value }
}

fn Box::unwrap[T](self : Box[T]) -> T {
  self.value
}

fn main {
  let int_box = Box::new(42)
  let str_box = Box::new("Hello Generics")

  println("Int box contains: \{int_box.unwrap()}")
  println("String box contains: \{str_box.unwrap()}")
}
