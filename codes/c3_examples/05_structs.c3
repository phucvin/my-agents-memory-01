module structs;
import std::io;

struct Point {
    int x;
    int y;
}

fn void main() {
    Point p = { 10, 20 };
    io::printfn("Point: (%d, %d)", p.x, p.y);

    p.x = 30;
    io::printfn("Updated Point: (%d, %d)", p.x, p.y);
}
