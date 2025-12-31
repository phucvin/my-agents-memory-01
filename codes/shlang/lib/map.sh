// Implementation of Map using Arrays in Shlang
// Since we don't have generics, we'll use 'any' equivalent or specific MapStructs.
// But Shlang has structural typing.
// The user said: "implement map in shlang".
// This likely implies a generic-ish map or a map for the self-interpreter's use (Symbol Table).
// The symbol table needs to map String -> Value.

struct Entry {
    key string;
    // value Value; // Value struct needs to be defined in self-interpreter
    // For now let's make it generic-ish by using interfaces?
    // Shlang interface "Any" { } (empty interface matches all structs?)
    // No, empty interface only matches structs. Primitives (int, string) are not structs.
    // So we need a wrapper struct for values if we use interfaces.
    // OR we just define specific maps: MapStringInt, MapStringValue.

    // Let's assume we are building the self-interpreter.
    // It needs `MapStringValue`.
}

// We need to define `Value` struct for the self-interpreter first.
// But let's verify map logic with Int first.

struct IntEntry {
    key string;
    val int;
    next IntEntry; // Linked list
}

struct IntMap {
    buckets []IntEntry;
    size int;
}

func createIntMap(capacity) {
    var m = new IntMap;
    m.size = capacity;
    m.buckets = make_array(capacity); // Array of IntEntry (which are structs, so pointers/references?)
    // In Host C++ interpreter, ArrayInstance holds Values.
    // new Struct returns a reference (shared_ptr).
    // So elements are initialized to VOID/null?
    // Arrays init to {TypeKind::INT, 0}.
    // We need to check if we can store structs in array.
    // Yes, Value variant has StructInstance.
    return m;
}

func hash(s) {
    var h = 0;
    var i = 0;
    var l = len(s);
    while (i < l) {
        var c = char_code_at(s, i);
        h = (h * 31) + c;
        i = i + 1;
    }
    if (h < 0) { h = 0 - h; }
    return h;
}

func mapPut(m, key, val) {
    var h = hash(key);
    var bucketIdx = h % m.size;

    var head = m.buckets[bucketIdx];

    // Simple prepend without check for now (allow duplicates for speed/lazy)
    // Or check?
    // If head is 0 (int), it's empty.
    // Host treats non-struct as false?
    // Wait, `var head = ...`. If it's 0, it's false?
    // I added `if (cond.type == TypeKind::INT) isTrue = std::get<int>(cond.data) != 0;`

    var entry = new IntEntry;
    entry.key = key;
    entry.val = val;
    // entry.next = head; // This fails if head is 0 (int) and next expects IntEntry struct?
    // Structural typing: next is `IntEntry`.
    // If head is INT 0, and we assign to next (IntEntry), what happens?
    // Interpreter doesn't check type on assignment rigidly in `eval` (Host).
    // It just copies Value.
    // So `next` becomes INT 0.
    // When we read `next`, we get INT 0.
    // Loop `while(curr)`: checks if curr is true. INT 0 is false.
    // So it works!

    entry.next = head;
    m.buckets[bucketIdx] = entry;
}

func mapGet(m, key) {
    var h = hash(key);
    var bucketIdx = h % m.size;
    var curr = m.buckets[bucketIdx];

    while (curr) {
        if (curr.key == key) {
            return curr.val;
        }
        curr = curr.next;
    }
    return -1; // Not found
}

func main() {
    var m = createIntMap(10);
    mapPut(m, "foo", 42);
    mapPut(m, "bar", 100);

    print(mapGet(m, "foo"));
    print(mapGet(m, "bar"));
    print(mapGet(m, "baz"));
    print("End");
}
