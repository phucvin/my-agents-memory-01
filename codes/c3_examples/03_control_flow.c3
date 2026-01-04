module control_flow;
import std::io;

fn void main() {
    int x = 5;

    if (x > 0) {
        io::printn("x is positive");
    } else {
        io::printn("x is non-positive");
    }

    io::printn("Counting to 5:");
    for (int i = 1; i <= 5; i++) {
        io::printfn("%d", i);
    }

    io::printn("While loop:");
    int j = 0;
    while (j < 3) {
        io::printfn("%d", j);
        j++;
    }
}
