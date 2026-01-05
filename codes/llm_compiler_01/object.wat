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

  ;; Object shape: {x: i32, y: i32}
  (type $Point (struct (field (mut i32)) (field (mut i32))))

  (func $main (export "main")
    (local $p (ref $Point))
    ;; p = {x: 10, y: 20}
    (local.set $p (struct.new $Point (i32.const 10) (i32.const 20)))
    ;; print(p.x + p.y)
    (call $print_int
      (i32.add
        (struct.get $Point 0 (local.get $p))
        (struct.get $Point 1 (local.get $p))
      )
    )
    (call $putchar (i32.const 10))
  )
)
