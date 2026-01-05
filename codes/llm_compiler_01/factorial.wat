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

  (func $fact (param $n i32) (result i32)
    (if (i32.eq (local.get $n) (i32.const 0))
      (then (return (i32.const 1)))
    )
    (i32.mul (local.get $n) (call $fact (i32.sub (local.get $n) (i32.const 1))))
  )

  (func $main (export "main")
    (call $print_int (call $fact (i32.const 5)))
    (call $putchar (i32.const 10))
  )
)
