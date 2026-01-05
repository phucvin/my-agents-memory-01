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

  ;; Shape: {type: i32, w: i32, h: i32, r: i32}
  (type $Shape (struct
    (field (mut i32)) ;; type (idx 0)
    (field (mut i32)) ;; w    (idx 1)
    (field (mut i32)) ;; h    (idx 2)
    (field (mut i32)) ;; r    (idx 3)
  ))

  (func $area (param $s (ref $Shape)) (result i32)
    (local $t i32)
    (local.set $t (struct.get $Shape 0 (local.get $s)))

    ;; if type == 1 (rect)
    (if (i32.eq (local.get $t) (i32.const 1))
      (then
        ;; w * h
        (return
          (i32.mul
            (struct.get $Shape 1 (local.get $s))
            (struct.get $Shape 2 (local.get $s))
          )
        )
      )
    )
    ;; if type == 2 (circle)
    (if (i32.eq (local.get $t) (i32.const 2))
      (then
        ;; 3 * r * r
        (return
          (i32.mul
            (i32.const 3)
            (i32.mul
              (struct.get $Shape 3 (local.get $s))
              (struct.get $Shape 3 (local.get $s))
            )
          )
        )
      )
    )
    (i32.const 0)
  )

  (func $main (export "main")
    (local $rect (ref $Shape))
    (local $circle (ref $Shape))

    ;; rect = {type: 1, w: 10, h: 20} -> r=0
    (local.set $rect (struct.new $Shape (i32.const 1) (i32.const 10) (i32.const 20) (i32.const 0)))

    ;; circle = {type: 2, r: 5} -> w=0, h=0
    (local.set $circle (struct.new $Shape (i32.const 2) (i32.const 0) (i32.const 0) (i32.const 5)))

    (call $print_int (call $area (local.get $rect)))
    (call $putchar (i32.const 10))

    (call $print_int (call $area (local.get $circle)))
    (call $putchar (i32.const 10))
  )
)
