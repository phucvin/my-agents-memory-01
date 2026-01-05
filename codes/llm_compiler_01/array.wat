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

  ;; Array type: [i32]
  (type $IntArray (array (mut i32)))

  (func $main (export "main")
    (local $arr (ref $IntArray))
    ;; arr = [1, 2, 3]
    (local.set $arr (array.new_fixed $IntArray 3 (i32.const 1) (i32.const 2) (i32.const 3)))

    ;; print(arr[0] + arr[1] + arr[2])
    (call $print_int
      (i32.add
        (i32.add
          (array.get $IntArray (local.get $arr) (i32.const 0))
          (array.get $IntArray (local.get $arr) (i32.const 1))
        )
        (array.get $IntArray (local.get $arr) (i32.const 2))
      )
    )
    (call $putchar (i32.const 10))
  )
)
