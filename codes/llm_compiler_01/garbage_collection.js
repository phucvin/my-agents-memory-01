// Garbage Collection (Allocating loop)
// We create many objects, letting them go out of scope.
// Wasm GC engine handles cleanup.
for (let i = 0; i < 1000; i++) {
  let temp = { val: i };
}
putchar(79); // 'O'
putchar(75); // 'K'
