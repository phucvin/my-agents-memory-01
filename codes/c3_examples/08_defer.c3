module defers;
import std::io;

fn void main() {
    io::printn("Start");
    defer io::printn("End (Deferred)");

    io::printn("Middle");

    {
        defer io::printn("Inner Scope Deferred");
        io::printn("Inner Scope");
    }
}
