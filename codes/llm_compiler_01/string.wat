(module
  (import "env" "putchar" (func $putchar (param i32)))

  (type $string (array (mut i8)))
  (data $s1_data "Hello")
  (data $s2_data " ")
  (data $s3_data "World")

  (func $concat (param $a (ref $string)) (param $b (ref $string)) (result (ref $string))
    (local $len_a i32)
    (local $len_b i32)
    (local $new_len i32)
    (local $res (ref $string))

    (local.set $len_a (array.len (local.get $a)))
    (local.set $len_b (array.len (local.get $b)))
    (local.set $new_len (i32.add (local.get $len_a) (local.get $len_b)))

    ;; Allocate new array
    (local.set $res (array.new_default $string (local.get $new_len)))

    ;; Copy content of a
    (array.copy $string $string
      (local.get $res) (i32.const 0)
      (local.get $a) (i32.const 0)
      (local.get $len_a)
    )

    ;; Copy content of b
    (array.copy $string $string
      (local.get $res) (local.get $len_a)
      (local.get $b) (i32.const 0)
      (local.get $len_b)
    )

    (local.get $res)
  )

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
    (local $s1 (ref $string))
    (local $s2 (ref $string))
    (local $s3 (ref $string))
    (local $res (ref $string))

    (local.set $s1 (array.new_data $string $s1_data (i32.const 0) (i32.const 5)))
    (local.set $s2 (array.new_data $string $s2_data (i32.const 0) (i32.const 1)))
    (local.set $s3 (array.new_data $string $s3_data (i32.const 0) (i32.const 5)))

    ;; res = s1 + s2
    (local.set $res (call $concat (local.get $s1) (local.get $s2)))
    ;; res = res + s3
    (local.set $res (call $concat (local.get $res) (local.get $s3)))

    (call $print_string (local.get $res))
    (call $putchar (i32.const 10))
  )
)
