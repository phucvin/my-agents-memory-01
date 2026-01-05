(module
  (import "env" "putchar" (func $putchar (param i32)))

  (func $print_int (param $n i32)
    (if (i32.lt_s (local.get $n) (i32.const 0))
      (then
        (call $putchar (i32.const 45)) ;; '-'
        (local.set $n (i32.mul (local.get $n) (i32.const -1)))
      )
    )
    (if (i32.ge_s (local.get $n) (i32.const 10))
      (then
        (call $print_int (i32.div_s (local.get $n) (i32.const 10)))
      )
    )
    (call $putchar (i32.add (i32.rem_s (local.get $n) (i32.const 10)) (i32.const 48)))
  )

  (type $IntArray (array (mut i32)))

  (func $main (export "main")
    (local $arr (ref $IntArray))
    (local $sum i32)
    (local $i i32)
    (local $len i32)

    ;; arr = [10, 20, 30, 40, 50]
    (local.set $arr (array.new_fixed $IntArray 5
      (i32.const 10) (i32.const 20) (i32.const 30) (i32.const 40) (i32.const 50)))

    (local.set $sum (i32.const 0))
    (local.set $i (i32.const 0))
    (local.set $len (i32.const 5))

    (loop $loop
      (if (i32.lt_s (local.get $i) (local.get $len))
        (then
          ;; sum = sum + arr[i]
          (local.set $sum
            (i32.add
              (local.get $sum)
              (array.get $IntArray (local.get $arr) (local.get $i))
            )
          )
          ;; i++
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $loop)
        )
      )
    )

    (call $print_int (local.get $sum))
    (call $putchar (i32.const 10))
  )
)
