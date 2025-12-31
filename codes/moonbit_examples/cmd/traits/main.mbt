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

fn main {
  let dog : Dog = { name: "Buddy" }
  let cat : Cat = { name: "Whiskers" }

  introduce(dog)
  introduce(cat)
}
