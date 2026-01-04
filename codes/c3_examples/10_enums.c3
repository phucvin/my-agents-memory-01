module enums;
import std::io;

enum Color : int {
    RED,
    GREEN,
    BLUE
}

fn void main() {
    Color c = Color.GREEN;

    if (c == Color.RED) {
        io::printn("Red");
    } else if (c == Color.GREEN) {
        io::printn("Green");
    } else {
        io::printn("Blue");
    }

    // Switch (if C3 supports switch on enum)
    switch (c) {
        case RED: io::printn("It's Red");
        case GREEN: io::printn("It's Green");
        case BLUE: io::printn("It's Blue");
    }
}
