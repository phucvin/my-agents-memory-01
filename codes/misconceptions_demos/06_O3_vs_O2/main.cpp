#include <iostream>
#include <vector>
#include <chrono>
#include <random>
#include <algorithm> // Required for std::shuffle
#include <memory>

// A Linked List traversal benchmark.
// This is dominated by pointer chasing (memory latency), which the compiler
// often cannot optimize significantly better at -O3 compared to -O2.
// Unlike Matrix Multiplication (which gets vectorized), this demonstrates
// that -O3 isn't a magic "make everything faster" switch.

struct Node {
    int value;
    Node* next;
};

const int NUM_NODES = 10000000; // 10 Million nodes to ensure significant time

int main() {
    // 1. Create a large linked list in a contiguous block to avoid allocation overhead noise,
    // but we will shuffle the links to ensure random memory access (pointer chasing).
    std::vector<Node> pool(NUM_NODES);
    std::vector<int> indices(NUM_NODES);
    for (int i = 0; i < NUM_NODES; ++i) indices[i] = i;

    // Shuffle indices to create random memory access pattern
    std::mt19937 gen(42);
    std::shuffle(indices.begin(), indices.end(), gen);

    // Link them up based on shuffled indices
    for (int i = 0; i < NUM_NODES - 1; ++i) {
        pool[indices[i]].next = &pool[indices[i+1]];
        pool[indices[i]].value = i;
    }
    pool[indices[NUM_NODES - 1]].next = nullptr;
    pool[indices[NUM_NODES - 1]].value = NUM_NODES - 1;

    Node* head = &pool[indices[0]];

    // 2. Benchmark the traversal
    long long sum = 0;
    auto start = std::chrono::high_resolution_clock::now();

    Node* current = head;
    while (current) {
        sum += current->value;
        current = current->next;
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double, std::milli> duration = end - start;

    std::cout << "Traversal Time: " << duration.count() << " ms" << std::endl;
    std::cout << "Sum (verification): " << sum << std::endl;

    return 0;
}
