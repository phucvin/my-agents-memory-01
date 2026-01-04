module arrays;
import std::io;

fn void main() {
    // Fixed size array
    int[5] arr = { 1, 2, 3, 4, 5 };

    io::printn("Array elements:");
    foreach (val : arr) {
        io::printfn("%d", val);
    }

    // Slice
    int[] slice = arr[1..3];
    io::printn("Slice elements (1..3):");
    foreach (val : slice) {
        io::printfn("%d", val);
    }
}
