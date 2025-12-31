interface Greeter {
    greet() string;
}

struct Person {
    name string;
}

func (p Person) greet() {
    print("Hello", p.name);
}

func main() {
    var p = new Person;
    p.name = "Alice";

    // Explicit type hint to trigger interface check?
    // Host parser doesn't support type hint in var decl for non-literals easily in my test code syntax?
    // `var p = new Person;` infers struct Person.
    // If I pass `p` to a function expecting `Greeter`.

    // Test logic:
    // This file is just to prove Parser handles `func (r T) Name`
    // and TypeChecker logic exists.
    // Execution of method via interface is not strictly required by "implements interface" check,
    // but useful.

    p.greet();
}
