(module
  (import "env" "putchar" (func $putchar (param i32)))

  (func $print_int (param $n i32)
    (local $div i32)
    (local $rem i32)
    ;; Handle negative numbers
    (if (i32.lt_s (local.get $n) (i32.const 0))
      (then
        (call $putchar (i32.const 45)) ;; '-'
        (local.set $n (i32.sub (i32.const 0) (local.get $n)))
      )
    )
    ;; Simple print logic for positive numbers (recursive)
    (if (i32.ge_s (local.get $n) (i32.const 10))
      (then
        (call $print_int (i32.div_s (local.get $n) (i32.const 10)))
      )
    )
    (call $putchar (i32.add (i32.rem_s (local.get $n) (i32.const 10)) (i32.const 48)))
  )

  (func $add (param $a i32) (param $b i32) (result i32)
    (i32.add (local.get $a) (local.get $b))
  )

  (func $main (export "main")
    (call $print_int (call $add (i32.const 10) (i32.const 20)))
    (call $putchar (i32.const 10)) ;; newline
  )
)
