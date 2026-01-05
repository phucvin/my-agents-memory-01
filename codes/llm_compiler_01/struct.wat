(module
  (import "env" "putchar" (func $putchar (param i32)))

  ;; Define Point struct { x: i32, y: i32 }
  (type $Point (struct (field (mut i32)) (field (mut i32))))

  (func $main
    (local $p (ref $Point))
    (local $sum i32)

    ;; Create point { x: 10, y: 20 }
    (local.set $p
      (struct.new $Point
        (i32.const 10)
        (i32.const 20)
      )
    )

    ;; sum = p.x + p.y
    (local.set $sum
      (i32.add
        (struct.get $Point 0 (local.get $p))
        (struct.get $Point 1 (local.get $p))
      )
    )

    ;; putchar(sum + 35) => 30 + 35 = 65 ('A')
    (call $putchar (i32.add (local.get $sum) (i32.const 35)))
  )

  (start $main)
)
