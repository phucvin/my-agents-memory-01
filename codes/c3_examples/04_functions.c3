module functions;
import std::io;

fn int add(int a, int b) {
    return a + b;
}

fn void greet(String name) {
    io::printfn("Hello, %s!", name);
}

fn void main() {
    int sum = add(5, 3);
    io::printfn("Sum: %d", sum);
    greet("User");
}
