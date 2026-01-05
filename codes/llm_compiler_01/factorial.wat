(module
  (import "env" "putchar" (func $putchar (param i32)))

  (func $factorial (param $n i32) (result i32)
    (if (result i32) (i32.eqz (local.get $n))
      (then (i32.const 1))
      (else
        (i32.mul
          (local.get $n)
          (call $factorial (i32.sub (local.get $n) (i32.const 1)))
        )
      )
    )
  )

  (func $main
    ;; factorial(5) = 120
    (call $putchar (call $factorial (i32.const 5)))
  )

  (start $main)
)
