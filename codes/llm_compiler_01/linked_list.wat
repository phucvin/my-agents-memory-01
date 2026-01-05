(module
  (import "env" "putchar" (func $putchar (param i32)))

  ;; Node { val: i32, next: Node? }
  (type $Node (struct (field (mut i32)) (field (mut (ref null $Node)))))

  (func $main
    (local $head (ref null $Node))
    (local $curr (ref null $Node))

    ;; Build list 3 -> null
    (local.set $head
      (struct.new $Node (i32.const 3) (ref.null $Node))
    )
    ;; 2 -> 3
    (local.set $head
      (struct.new $Node (i32.const 2) (local.get $head))
    )
    ;; 1 -> 2
    (local.set $head
      (struct.new $Node (i32.const 1) (local.get $head))
    )

    (local.set $curr (local.get $head))

    (block $break
      (loop $loop
        ;; if curr == null break
        (br_if $break (ref.is_null (local.get $curr)))

        ;; print(curr.val + 48)
        (call $putchar
          (i32.add
            (struct.get $Node 0 (ref.cast (ref $Node) (local.get $curr)))
            (i32.const 48)
          )
        )

        ;; curr = curr.next
        (local.set $curr
          (struct.get $Node 1 (ref.cast (ref $Node) (local.get $curr)))
        )
        (br $loop)
      )
    )
    (call $putchar (i32.const 10))
  )

  (start $main)
)
