(module
  (import "env" "putchar" (func $putchar (param i32)))

  (func $print_bool (param $b i32)
    (if (local.get $b)
      (then (call $putchar (i32.const 116)) (call $putchar (i32.const 114)) (call $putchar (i32.const 117)) (call $putchar (i32.const 101))) ;; true
      (else (call $putchar (i32.const 102)) (call $putchar (i32.const 97)) (call $putchar (i32.const 108)) (call $putchar (i32.const 115)) (call $putchar (i32.const 101))) ;; false
    )
    (call $putchar (i32.const 10))
  )

  (func $isEven (param $n i32) (result i32)
    (i32.eq (i32.rem_s (local.get $n) (i32.const 2)) (i32.const 0))
  )

  (func $main (export "main")
    (call $print_bool (call $isEven (i32.const 4)))
    (call $print_bool (call $isEven (i32.const 5)))
  )
)
