#pragma once
#include <vector>
#include <array>
#include <cassert>

template <size_t N>
struct LruNode {
    int prev;
    int next;
};

template <size_t N>
class Lru {
public:
    std::array<LruNode<N>, N> data;
    int head;

    Lru() {
        head = 0;
        for (size_t i = 0; i < N; ++i) {
            data[i].prev = (i == 0) ? N - 1 : i - 1;
            data[i].next = (i == N - 1) ? 0 : i + 1;
        }
    }

    void remove(int i) {
        data[data[i].prev].next = data[i].next;
        data[data[i].next].prev = data[i].prev;
    }

    void insert_before(int i, int next) {
        int prev = data[next].prev;
        data[prev].next = i;
        data[next].prev = i;
        data[i].prev = prev;
        data[i].next = next;
    }

    void poke(int i) {
        int prev_newest = head;
        if (i == prev_newest) {
            return;
        }
        if (data[prev_newest].prev != i) {
            remove(i);
            insert_before(i, head);
        }
        head = i;
    }

    int pop() {
        int out = data[head].prev;
        head = out; // rotate so oldest becomes newest
        return out;
    }
};
