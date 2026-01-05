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
    (local $a i32)
    (local $b i32)
    (local $i i32)
    (local $temp i32)

    (local.set $a (i32.const 0))
    (local.set $b (i32.const 1))
    (local.set $i (i32.const 0))

    (loop $loop
      (if (i32.lt_s (local.get $i) (local.get $n))
        (then
          ;; temp = a
          (local.set $temp (local.get $a))
          ;; a = b
          (local.set $a (local.get $b))
          ;; b = temp + b
          (local.set $b (i32.add (local.get $temp) (local.get $b)))
          ;; i++
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $loop)
        )
      )
    )
    (local.get $a)
  )

  (func $main (export "main")
    (call $print_int (call $fib (i32.const 10)))
    (call $putchar (i32.const 10))
  )
)
