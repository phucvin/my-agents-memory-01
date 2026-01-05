(module
  (import "env" "putchar" (func $putchar (param i32)))

  (func $main
    (local $i i32)
    (local.set $i (i32.const 0))

    (block $break
      (loop $loop
        (br_if $break (i32.ge_s (local.get $i) (i32.const 10)))

        ;; putchar('0' + i)
        (call $putchar (i32.add (i32.const 48) (local.get $i)))

        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $loop)
      )
    )
    ;; putchar('\n')
    (call $putchar (i32.const 10))
  )

  (start $main)
)
