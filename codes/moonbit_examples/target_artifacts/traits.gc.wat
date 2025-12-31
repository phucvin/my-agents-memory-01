(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data "M\00e\00o\00w\00!\00 \00I\00 \00a\00m\00 \00W\00o\00o\00f\00!\00 \00I\00 \00a\00m\00 \00W\00h\00i\00s\00k\00e\00r\00s\00B\00u\00d\00d\00y\00")
(type $moonbit.string
 (array (mut i16)))
(type $moonbit.string_pool_type
 (array (mut (ref null $moonbit.string))))
(func $moonbit.println (param $str (ref $moonbit.string))
 (local $counter i32)
 (loop $loop
  (if
   (i32.lt_s
    (local.get $counter)
    (array.len
     (local.get $str)))
   (then
    (call $printc
     (array.get_u $moonbit.string
      (local.get $str)
      (local.get $counter)))
    (local.set $counter
     (i32.add
      (local.get $counter)
      (i32.const 1)))
    (br $loop))
   (else)))
 (call $printc
  (i32.const 10)))
(func $moonbit.add_string (param $x (ref $moonbit.string)) (param $y (ref $moonbit.string)) (result (ref $moonbit.string))
 (local $lenx i32)
 (local $leny i32)
 (local $len i32)
 (local $ptr (ref $moonbit.string))
 (local.set $lenx
  (array.len
   (local.get $x)))
 (local.set $leny
  (array.len
   (local.get $y)))
 (local.set $len
  (i32.add
   (local.get $lenx)
   (local.get $leny)))
 (local.set $ptr
  (array.new_default $moonbit.string
   (local.get $len)))
 (array.copy $moonbit.string $moonbit.string
  (local.get $ptr)
  (i32.const 0)
  (local.get $x)
  (i32.const 0)
  (local.get $lenx))
 (array.copy $moonbit.string $moonbit.string
  (local.get $ptr)
  (local.get $lenx)
  (local.get $y)
  (i32.const 0)
  (local.get $leny))
 (local.get $ptr))
(func $moonbit.string_literal (param $index i32) (param $offset i32) (param $length i32) (result (ref $moonbit.string))
 (local $cached (ref null $moonbit.string))
 (local $new_string (ref $moonbit.string))
 (if
  (i32.eqz
   (ref.is_null
    (local.tee $cached
     (array.get $moonbit.string_pool_type
      (global.get $moonbit.string_pool)
      (local.get $index)))))
  (then
   (ref.as_non_null
    (local.get $cached))
   (return))
  (else))
 (local.set $new_string
  (array.new_data $moonbit.string $moonbit.const_data
   (local.get $offset)
   (local.get $length)))
 (array.set $moonbit.string_pool_type
  (global.get $moonbit.string_pool)
  (local.get $index)
  (local.get $new_string))
 (local.get $new_string))
(memory $moonbit.memory 1)
(type $Dog
 (struct
  (field  (ref $moonbit.string))))
(type $Cat
 (struct
  (field  (ref $moonbit.string))))
(global $username/moonbit_examples/cmd/traits.*main.dog/7
 (mut (ref null $Dog))
 (ref.null $Dog)
)
(global $username/moonbit_examples/cmd/traits.*main.cat/8
 (mut (ref null $Cat))
 (ref.null $Cat)
)
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 4)
 (array.new_default $moonbit.string_pool_type)
)
(func $username/moonbit_examples/cmd/traits.introduce|Cat| (param $animal/6 (ref $Cat)) (result i32)
 (call $moonbitlang/core/builtin.println|String|
  (call $moonbit.add_string
   (call $moonbit.string_literal
    (i32.const 0)
    (i32.const 0)
    (i32.const 11))
   (struct.get $Cat 0
    (local.get $animal/6)))))
(func $username/moonbit_examples/cmd/traits.introduce|Dog| (param $animal/5 (ref $Dog)) (result i32)
 (call $moonbitlang/core/builtin.println|String|
  (call $moonbit.add_string
   (call $moonbit.string_literal
    (i32.const 1)
    (i32.const 22)
    (i32.const 11))
   (struct.get $Dog 0
    (local.get $animal/5)))))
(func $moonbitlang/core/builtin.println|String| (param $input/2 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/2))
 (i32.const 0))
(start $*init*/2)
(func $*init*/2
 (global.set $username/moonbit_examples/cmd/traits.*main.dog/7
  (struct.new $Dog
   (call $moonbit.string_literal
    (i32.const 3)
    (i32.const 60)
    (i32.const 5))))
 (global.set $username/moonbit_examples/cmd/traits.*main.cat/8
  (struct.new $Cat
   (call $moonbit.string_literal
    (i32.const 2)
    (i32.const 44)
    (i32.const 8)))))
(func $*main*/1
 (drop
  (call $username/moonbit_examples/cmd/traits.introduce|Dog|
   (ref.as_non_null
    (global.get $username/moonbit_examples/cmd/traits.*main.dog/7))))
 (drop
  (call $username/moonbit_examples/cmd/traits.introduce|Cat|
   (ref.as_non_null
    (global.get $username/moonbit_examples/cmd/traits.*main.cat/8)))))
(export "_start" (func $*main*/1))