(module
  (import "env" "putchar" (func $putchar (param i32)))

  (func $add (param $a i32) (param $b i32) (result i32)
    (i32.add (local.get $a) (local.get $b))
  )

  (func $main
    ;; add(30, 35) = 65 ('A')
    (call $putchar (call $add (i32.const 30) (i32.const 35)))
  )

  (start $main)
)
