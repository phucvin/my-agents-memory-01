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

fn main {
  let c = Circle(5.0)
  let r = Rectangle(4.0, 6.0)

  println("Area of circle: \{area(c)}")
  println("Area of rectangle: \{area(r)}")
}
