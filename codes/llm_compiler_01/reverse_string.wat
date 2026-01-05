(module
  (import "env" "putchar" (func $putchar (param i32)))

  (type $string (array (mut i8)))
  (data $s_data "Hello World")

  (func $print_string (param $s (ref $string))
    (local $i i32)
    (local $len i32)
    (local.set $len (array.len (local.get $s)))
    (local.set $i (i32.const 0))
    (loop $loop
      (if (i32.lt_u (local.get $i) (local.get $len))
        (then
          (call $putchar (array.get_u $string (local.get $s) (local.get $i)))
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $loop)
        )
      )
    )
  )

  (func $main (export "main")
    (local $s (ref $string))
    (local $res (ref $string))
    (local $len i32)
    (local $i i32)
    (local $j i32)

    ;; s = "Hello World" (len 11)
    (local.set $len (i32.const 11))
    (local.set $s (array.new_data $string $s_data (i32.const 0) (local.get $len)))

    ;; res = new string[11]
    (local.set $res (array.new_default $string (local.get $len)))

    ;; loop i from len-1 down to 0
    (local.set $i (i32.sub (local.get $len) (i32.const 1))) ;; i = 10
    (local.set $j (i32.const 0)) ;; j = 0

    (loop $loop
      (if (i32.ge_s (local.get $i) (i32.const 0))
        (then
          ;; res[j] = s[i]
          (array.set $string
            (local.get $res)
            (local.get $j)
            (array.get $string (local.get $s) (local.get $i))
          )
          ;; i--, j++
          (local.set $i (i32.sub (local.get $i) (i32.const 1)))
          (local.set $j (i32.add (local.get $j) (i32.const 1)))
          (br $loop)
        )
      )
    )

    (call $print_string (local.get $res))
    (call $putchar (i32.const 10))
  )
)
