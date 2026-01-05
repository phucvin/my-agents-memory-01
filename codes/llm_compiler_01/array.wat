(module
  (import "env" "putchar" (func $putchar (param i32)))

  ;; Define array of mutable i32
  (type $arr (array (mut i32)))

  (func $main
    (local $arr (ref $arr))
    (local $len i32)
    (local $i i32)
    (local $sum i32)

    ;; Create array [10, 20, 30]
    (local.set $arr
      (array.new_fixed $arr 3
        (i32.const 10)
        (i32.const 20)
        (i32.const 30)
      )
    )

    (local.set $len (array.len (local.get $arr)))
    (local.set $i (i32.const 0))
    (local.set $sum (i32.const 0))

    (block $break
      (loop $loop
        (br_if $break (i32.ge_u (local.get $i) (local.get $len)))

        (local.set $sum
          (i32.add
            (local.get $sum)
            (array.get $arr (local.get $arr) (local.get $i))
          )
        )

        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $loop)
      )
    )

    ;; putchar(sum + 5) => 60 + 5 = 65 ('A')
    (call $putchar (i32.add (local.get $sum) (i32.const 5)))
  )

  (start $main)
)
