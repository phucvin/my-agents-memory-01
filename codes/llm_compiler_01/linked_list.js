// Linked list 1 -> 2 -> 3
let list = { val: 1, next: { val: 2, next: { val: 3, next: null } } };
let current = list;
while (current != null) {
  putchar(current.val + 48);
  current = current.next;
}
putchar(10);
