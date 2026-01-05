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

  (func $fib (param $n i32) (result i32)
    (if (i32.lt_s (local.get $n) (i32.const 2))
      (then (return (local.get $n)))
    )
    (i32.add
      (call $fib (i32.sub (local.get $n) (i32.const 1)))
      (call $fib (i32.sub (local.get $n) (i32.const 2)))
    )
  )

  (func $main (export "main")
    (call $print_int (call $fib (i32.const 10)))
    (call $putchar (i32.const 10)) ;; newline
  )
)
