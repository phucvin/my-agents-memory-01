fn factorial(n: int) -> int {
    if n <= 1 {
        return 1;
    } else {
        return n * factorial(n - 1);
    }
}

fn main() -> int {
    var res: int = factorial(5);
    print(res);
    return 0;
}
