module macros;
import std::io;

macro void print_val(val) {
    $if ($typeof(val) == int):
        io::printfn("Int: %d", val);
    $else
        io::printn("Other type");
    $endif
}

fn void main() {
    print_val(10);
    print_val(3.14);
}
