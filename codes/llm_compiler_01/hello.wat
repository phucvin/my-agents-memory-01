(module
  (import "env" "putchar" (func $putchar (param i32)))

  ;; Define a string as an array of bytes
  (type $string (array i8))

  (func $main
    (local $str (ref $string))
    (local $len i32)
    (local $i i32)

    ;; Create the string "Hello World\n"
    ;; Length 12
    (local.set $str
      (array.new_fixed $string 12
        (i32.const 72) ;; H
        (i32.const 101) ;; e
        (i32.const 108) ;; l
        (i32.const 108) ;; l
        (i32.const 111) ;; o
        (i32.const 32)  ;; space
        (i32.const 87)  ;; W
        (i32.const 111) ;; o
        (i32.const 114) ;; r
        (i32.const 108) ;; l
        (i32.const 100) ;; d
        (i32.const 10)  ;; \n
      )
    )

    (local.set $len (array.len (local.get $str)))
    (local.set $i (i32.const 0))

    (block $break
      (loop $loop
        (br_if $break (i32.ge_u (local.get $i) (local.get $len)))

        ;; putchar(str[i])
        (call $putchar
          (array.get_u $string (local.get $str) (local.get $i))
        )

        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $loop)
      )
    )
  )

  (start $main)
)
