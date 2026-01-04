module pointers;
import std::io;

fn void main() {
    int val = 42;
    int* ptr = &val;

    io::printfn("Value: %d", val);
    io::printfn("Pointer Address: %p", ptr);
    io::printfn("Dereferenced: %d", *ptr);

    *ptr = 100;
    io::printfn("New Value: %d", val);
}
