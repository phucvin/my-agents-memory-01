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

  ;; Object shape: {a: i32, b: i32}
  ;; In JS, 'b' is added later, but here we define the final shape.
  ;; Initialize 'b' to 0 (undefined-ish) first.
  (type $Obj (struct (field (mut i32)) (field (mut i32))))

  (func $main (export "main")
    (local $o (ref $Obj))
    ;; obj = {a: 10} -> in our static view, we alloc with a=10, b=0
    (local.set $o (struct.new $Obj (i32.const 10) (i32.const 0)))

    ;; obj.b = 20
    (struct.set $Obj 1 (local.get $o) (i32.const 20))

    ;; print(obj.a + obj.b)
    (call $print_int
      (i32.add
        (struct.get $Obj 0 (local.get $o))
        (struct.get $Obj 1 (local.get $o))
      )
    )
    (call $putchar (i32.const 10))
  )
)
