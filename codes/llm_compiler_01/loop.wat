(module
  (import "env" "putchar" (func $putchar (param i32)))

  (func $print_int (param $n i32)
    (if (i32.ge_s (local.get $n) (i32.const 10))
      (then
        (call $print_int (i32.div_s (local.get $n) (i32.const 10)))
      )
    )
    (call $putchar (i32.add (i32.rem_s (local.get $n) (i32.const 10)) (i32.const 48)))
  )

  (func $main (export "main")
    (local $i i32)
    (local.set $i (i32.const 0))
    (loop $loop
      (if (i32.lt_s (local.get $i) (i32.const 5))
        (then
          (call $print_int (local.get $i))
          (call $putchar (i32.const 10))
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $loop)
        )
      )
    )
  )
)
