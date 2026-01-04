module variables;
import std::io;

fn void main() {
    int a = 10;
    float b = 3.14;
    char c = 'A';
    bool d = true;
    String e = "String literal";

    io::printfn("Int: %d", a);
    io::printfn("Float: %f", b);
    io::printfn("Char: %c", c);
    io::printfn("Bool: %d", d);
    io::printfn("String: %s", e);
}
