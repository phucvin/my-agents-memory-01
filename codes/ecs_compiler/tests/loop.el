fn main() -> int {
    var i: int = 0;
    while i < 10 {
        if (i / 2) * 2 == i {
            print(i);
        }
        i = i + 1;
    }
    return 0;
}
