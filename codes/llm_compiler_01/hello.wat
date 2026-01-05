(module
  (import "env" "putchar" (func $putchar (param i32)))

  ;; Define a string type using Wasm GC array
  (type $string (array i8))

  ;; Data segment for "Hello World\n"
  (data $hello_data "Hello World\n")

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
    ;; Initialize string from data segment
    ;; In a real GC compiler, this might be more complex, but here we'll manually build it
    ;; or just allocate it. Let's allocate and fill for demonstration.
    (local.set $s (array.new_data $string $hello_data (i32.const 0) (i32.const 12)))
    (call $print_string (local.get $s))
  )
)
