(module
  (import "env" "putchar" (func $putchar (param i32)))

  (type $Obj (struct (field i32)))

  (func $main
    (local $i i32)
    (local $temp (ref null $Obj))

    (local.set $i (i32.const 0))

    (block $break
      (loop $loop
        (br_if $break (i32.ge_s (local.get $i) (i32.const 1000)))

        ;; Allocate new object (and drop reference in next iteration)
        (local.set $temp (struct.new $Obj (local.get $i)))

        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $loop)
      )
    )

    (call $putchar (i32.const 79)) ;; O
    (call $putchar (i32.const 75)) ;; K
  )

  (start $main)
)
