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

  (func $collatz (param $n i32) (result i32)
    (local $steps i32)
    (local.set $steps (i32.const 0))

    (loop $loop
      (if (i32.gt_s (local.get $n) (i32.const 1))
        (then
          ;; if n % 2 == 0
          (if (i32.eq (i32.rem_s (local.get $n) (i32.const 2)) (i32.const 0))
            (then
              ;; n = n / 2
              (local.set $n (i32.div_s (local.get $n) (i32.const 2)))
            )
            (else
              ;; n = 3 * n + 1
              (local.set $n (i32.add (i32.mul (local.get $n) (i32.const 3)) (i32.const 1)))
            )
          )
          ;; steps++
          (local.set $steps (i32.add (local.get $steps) (i32.const 1)))
          (br $loop)
        )
      )
    )
    (local.get $steps)
  )

  (func $main (export "main")
    (call $print_int (call $collatz (i32.const 27)))
    (call $putchar (i32.const 10))
  )
)
