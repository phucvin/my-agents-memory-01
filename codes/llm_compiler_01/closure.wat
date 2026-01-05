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

  ;; Closure struct: captures 'x'
  (type $Closure (struct (field i32)))

  (func $makeAdder (param $x i32) (result (ref $Closure))
    (struct.new $Closure (local.get $x))
  )

  ;; The closure function itself: takes the environment (closure struct) and the argument 'y'
  (func $closure_func (param $env (ref $Closure)) (param $y i32) (result i32)
    (i32.add (struct.get $Closure 0 (local.get $env)) (local.get $y))
  )

  (func $main (export "main")
    (local $add5 (ref $Closure))
    (local.set $add5 (call $makeAdder (i32.const 5)))
    ;; Call the closure
    (call $print_int (call $closure_func (local.get $add5) (i32.const 2)))
    (call $putchar (i32.const 10))
  )
)
