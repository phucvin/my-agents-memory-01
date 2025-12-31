(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data "H\00e\00l\00l\00o\00,\00 \00M\00o\00o\00n\00B\00i\00t\00!\00")
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
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 1)
 (array.new_default $moonbit.string_pool_type)
)
(func $moonbitlang/core/builtin.println|String| (param $input/2 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/2))
 (i32.const 0))
(func $*main*/1
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.string_literal
    (i32.const 0)
    (i32.const 0)
    (i32.const 15)))))
(export "_start" (func $*main*/1))