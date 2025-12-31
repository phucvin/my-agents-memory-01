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

fn main {
  let user = User::new(1, "Alice", "alice@example.com")
  println(user.display())
}
