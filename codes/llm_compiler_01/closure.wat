(module
  (import "env" "putchar" (func $putchar (param i32)))

  ;; Closure struct: stores context 'x'
  (type $Context (struct (field i32)))

  ;; Function type for the inner function: takes context and 'y'
  (type $FuncType (func (param (ref $Context) i32) (result i32)))

  ;; The closure object combines the function pointer and the context
  ;; Note: In full Wasm GC, we usually use func references.
  ;; Here we simulate a closure by passing the context explicitly.
  ;; But wait, func references `(ref $FuncType)` are not closures themselves.
  ;; We can use `(struct (field (ref $FuncType)) (field (ref $Context)))` as the closure object.

  (type $Closure (struct (field (ref $FuncType)) (field (ref $Context))))

  ;; The code for the inner function
  (func $adder_code (param $ctx (ref $Context)) (param $y i32) (result i32)
    (i32.add
      (struct.get $Context 0 (local.get $ctx)) ;; get x from context
      (local.get $y)
    )
  )

  (func $main
    (local $ctx (ref $Context))
    (local $closure (ref $Closure))
    (local $res i32)

    ;; makeAdder(5) -> Create context with x=5
    (local.set $ctx (struct.new $Context (i32.const 5)))

    ;; Create closure object
    (local.set $closure
      (struct.new $Closure
        (ref.func $adder_code)
        (local.get $ctx)
      )
    )

    ;; Call closure(60)
    ;; invoke: func(context, 60)
    (local.set $res
      (call_ref $FuncType
        (struct.get $Closure 1 (local.get $closure)) ;; context
        (i32.const 60)                               ;; y
        (struct.get $Closure 0 (local.get $closure)) ;; func ref
      )
    )

    (call $putchar (local.get $res))
  )

  (elem declare func $adder_code)
  (start $main)
)
