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

  (func $is_prime (param $n i32) (result i32)
    (local $i i32)
    ;; if n < 2 return 0
    (if (i32.lt_s (local.get $n) (i32.const 2))
      (then (return (i32.const 0)))
    )

    ;; i = 2
    (local.set $i (i32.const 2))

    (loop $loop
      ;; while i * i <= n
      (if (i32.le_s (i32.mul (local.get $i) (local.get $i)) (local.get $n))
        (then
          ;; if n % i == 0 return 0
          (if (i32.eq (i32.rem_s (local.get $n) (local.get $i)) (i32.const 0))
            (then (return (i32.const 0)))
          )
          ;; i++
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $loop)
        )
      )
    )
    (return (i32.const 1))
  )

  (func $main (export "main")
    (call $print_int (call $is_prime (i32.const 17)))
    (call $putchar (i32.const 10))
    (call $print_int (call $is_prime (i32.const 20)))
    (call $putchar (i32.const 10))
  )
)
