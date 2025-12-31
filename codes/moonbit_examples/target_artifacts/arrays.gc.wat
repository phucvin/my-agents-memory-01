(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data ",\00 \00]\00[\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\003\006\006\00:\005\00-\003\006\006\00:\003\003\00I\00n\00v\00a\00l\00i\00d\00 \00s\00t\00a\00r\00t\00 \00i\00n\00d\00e\00x\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\004\009\001\00:\009\00-\004\009\001\00:\004\000\00i\00n\00v\00a\00l\00i\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00 \00p\00a\00i\00r\000\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00r\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00v\00i\00e\00w\00.\00m\00b\00t\00:\001\001\001\00:\005\00-\001\001\001\00:\003\006\00I\00n\00v\00a\00l\00i\00d\00 \00i\00n\00d\00e\00x\00 \00f\00o\00r\00 \00V\00i\00e\00w\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\000\00:\005\00-\002\009\000\00:\003\001\00C\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\0A\00\0A\00 \00 \00a\00t\00 \00D\00o\00u\00b\00l\00e\00d\00 \00a\00r\00r\00a\00y\00:\00 \00S\00u\00m\00 \00o\00f\00 \00a\00r\00r\00a\00y\00 \00e\00l\00e\00m\00e\00n\00t\00s\00:\00 \00O\00r\00i\00g\00i\00n\00a\00l\00 \00a\00r\00r\00a\00y\00:\00 \00\01\00\00\00\02\00\00\00\03\00\00\00\04\00\00\00\05\00\00\00/\00:\00-\00")
(type $moonbit.enum
 (sub
  (struct
   (field  i32))))
(type $moonbit.string
 (array (mut i16)))
(type $moonbit.bytes
 (array (mut i8)))
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
(func $moonbit.unsafe_bytes_sub_string (param $src (ref $moonbit.bytes)) (param $offset i32) (param $length i32) (result (ref $moonbit.string))
 (local $dst (ref $moonbit.string))
 (local $strlen i32)
 (local $ch i32)
 (local $i i32)
 (local $j i32)
 (local.set $strlen
  (i32.shr_s
   (local.get $length)
   (i32.const 1)))
 (local.set $dst
  (array.new $moonbit.string
   (i32.const 0)
   (local.get $strlen)))
 (loop $loop
  (if
   (i32.lt_s
    (local.get $i)
    (local.get $strlen))
   (then
    (local.set $j
     (i32.add
      (local.get $offset)
      (i32.shl
       (local.get $i)
       (i32.const 1))))
    (local.set $ch
     (i32.or
      (array.get_u $moonbit.bytes
       (local.get $src)
       (local.get $j))
      (i32.shl
       (array.get_u $moonbit.bytes
        (local.get $src)
        (i32.add
         (local.get $j)
         (i32.const 1)))
       (i32.const 8))))
    (array.set $moonbit.string
     (local.get $dst)
     (local.get $i)
     (local.get $ch))
    (local.set $i
     (i32.add
      (local.get $i)
      (i32.const 1)))
    (br $loop))
   (else)))
 (local.get $dst))
(memory $moonbit.memory 1)
(type $StringView
 (struct
  (field  (ref $moonbit.string))
  (field  i32)
  (field  i32)))
(rec
 (type $@moonbitlang/core/builtin.Logger
  (sub
   (struct
    (field  (ref $@moonbitlang/core/builtin.Logger.method_0))
    (field  (ref $@moonbitlang/core/builtin.Logger.method_1))
    (field  (ref $@moonbitlang/core/builtin.Logger.method_2))
    (field  (ref $@moonbitlang/core/builtin.Logger.method_3)))))
 (type $@moonbitlang/core/builtin.Logger.method_0
  (func
   (param anyref) (param (ref $moonbit.string))
   (result i32)))
 (type $@moonbitlang/core/builtin.Logger.method_1
  (func
   (param anyref) (param (ref $moonbit.string)) (param i32) (param i32)
   (result i32)))
 (type $@moonbitlang/core/builtin.Logger.method_2
  (func
   (param anyref) (param (ref $StringView))
   (result i32)))
 (type $@moonbitlang/core/builtin.Logger.method_3
  (func
   (param anyref) (param i32)
   (result i32))))
(type $@moonbitlang/core/builtin.StringBuilder
 (struct
  (field  (mut (ref $moonbit.bytes)))
  (field  (mut i32))))
(type $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
 (sub
  $@moonbitlang/core/builtin.Logger
  (struct
   (field  (ref $@moonbitlang/core/builtin.Logger.method_0))
   (field  (ref $@moonbitlang/core/builtin.Logger.method_1))
   (field  (ref $@moonbitlang/core/builtin.Logger.method_2))
   (field  (ref $@moonbitlang/core/builtin.Logger.method_3))
   (field  (ref $@moonbitlang/core/builtin.StringBuilder)))))
(type $moonbit.array_i32
 (array (mut i32)))
(type $<StringView*Option<StringView>>
 (struct
  (field  (ref $StringView))
  (field  (ref null $StringView))))
(rec
 (type $<Int>=>Int-sig
  (func
   (param (ref $<Int>=>Int)) (param i32)
   (result i32)))
 (type $<Int>=>Int
  (sub
   (struct
    (field  (mut (ref null $<Int>=>Int-sig)))))))
(rec
 (type $<<Int>=>Int>=>Int-sig
  (func
   (param (ref $<<Int>=>Int>=>Int)) (param (ref $<Int>=>Int))
   (result i32)))
 (type $<<Int>=>Int>=>Int
  (sub
   (struct
    (field  (mut (ref null $<<Int>=>Int>=>Int-sig)))))))
(type $Ref<Int>
 (struct
  (field  (mut i32))))
(rec
 (type $<>=>Option<Int>-sig
  (func
   (param (ref $<>=>Option<Int>))
   (result i64)))
 (type $<>=>Option<Int>
  (sub
   (struct
    (field  (mut (ref null $<>=>Option<Int>-sig)))))))
(type $@moonbitlang/core/builtin.ArrayView<Int>
 (struct
  (field  (ref $moonbit.array_i32))
  (field  i32)
  (field  i32)))
(type $ArrayView::iterator|Int|.*p.fn/4-cap
 (sub
  $<>=>Option<Int>
  (struct
   (field  (mut (ref null $<>=>Option<Int>-sig)))
   (field  (mut (ref null $@moonbitlang/core/builtin.ArrayView<Int>)))
   (field  (mut (ref null $Ref<Int>))))))
(type $Ref<Bool>
 (struct
  (field  (mut i32))))
(type $Logger::write_iter.inner|Int|.fn/2-cap
 (sub
  $<Int>=>Int
  (struct
   (field  (mut (ref null $<Int>=>Int-sig)))
   (field  (mut (ref null $Ref<Bool>)))
   (field  (mut (ref null $moonbit.string)))
   (field  (mut (ref null $@moonbitlang/core/builtin.Logger))))))
(type $@moonbitlang/core/builtin.Array<Int>
 (struct
  (field  (mut (ref $moonbit.array_i32)))
  (field  (mut i32))))
(type $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok
 (sub final
  $moonbit.enum
  (struct
   (field  i32)
   (field  (ref $StringView)))))
(type $Iterator::iter|Int|.fn/3-cap
 (sub
  $<<Int>=>Int>=>Int
  (struct
   (field  (mut (ref null $<<Int>=>Int>=>Int-sig)))
   (field  (mut (ref null $<>=>Option<Int>))))))
(type $@moonbitlang/core/builtin.SourceLocRepr
 (struct
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))))
(type $Logger::write_iter.inner|Int|.fn/1-cap
 (sub
  $<Int>=>Int
  (struct
   (field  (mut (ref null $<Int>=>Int-sig)))
   (field  (mut (ref null $moonbit.string)))
   (field  (mut (ref null $@moonbitlang/core/builtin.Logger))))))
(type $<StringView*StringView>
 (struct
  (field  (ref $StringView))
  (field  (ref $StringView))))
(type $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
 (sub final
  $moonbit.enum
  (struct
   (field  i32)
   (field  (ref $moonbit.enum)))))
(type $FixedArray<UInt16>
 (array (mut i16)))
(elem
 declare
 func
 $Logger::write_iter.inner|Int|.fn/2
 $Iterator::iter|Int|.fn/3
 $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger
 $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger
 $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger
 $ArrayView::iterator|Int|.*p.fn/4
 $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|
 $Logger::write_iter.inner|Int|.fn/1)
(global $moonbitlang/core/builtin.parse.*bind|5401
 (mut (ref null $moonbit.string))
 (ref.null $moonbit.string)
)
(global $moonbitlang/core/builtin.parse.*bind|5440
 (mut (ref null $moonbit.string))
 (ref.null $moonbit.string)
)
(global $moonbitlang/core/builtin.parse.*bind|5434
 (mut (ref null $moonbit.string))
 (ref.null $moonbit.string)
)
(global $moonbitlang/core/builtin.parse.*bind|5421
 (mut (ref null $moonbit.string))
 (ref.null $moonbit.string)
)
(global $moonbitlang/core/builtin.parse.*bind|5415
 (mut (ref null $moonbit.string))
 (ref.null $moonbit.string)
)
(global $moonbitlang/core/builtin.output.*bind|8190
 (mut (ref null $moonbit.string))
 (ref.null $moonbit.string)
)
(global $moonbitlang/core/builtin.output.*bind|8184
 (mut (ref null $moonbit.string))
 (ref.null $moonbit.string)
)
(global $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/72
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/builtin.brute_force_find.constr/86
 (mut i64)
 (i64.const 0)
)
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 23)
 (array.new_default $moonbit.string_pool_type)
)
(global $moonbit.constr/1
 (ref $moonbit.enum)
 (i32.const 1)
 (struct.new $moonbit.enum)
)
(global $moonbit.constr/0
 (ref $moonbit.enum)
 (i32.const 0)
 (struct.new $moonbit.enum)
)
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/371 (ref $moonbit.string)) (param $logger/372 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (call $@moonbitlang/core/builtin.SourceLocRepr::parse
   (local.get $self/371))
  (local.get $logger/372)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/357 (ref $@moonbitlang/core/builtin.SourceLocRepr)) (param $logger/370 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (local $pkg/356 (ref $StringView))
 (local $*bind/358 i64)
 (local $*bind/359 (ref $<StringView*Option<StringView>>))
 (local $*Some/360 i64)
 (local $*first_slash/361 i32)
 (local $*bind/362 i64)
 (local $*Some/363 i64)
 (local $*second_slash/364 i32)
 (local $module_name_end/365 i32)
 (local $*module_name/366 (ref $StringView))
 (local $*package_name/367 (ref null $StringView))
 (local $*Some/368 (ref null $StringView))
 (local $*pkg_name/369 (ref $StringView))
 (local $*bind/551 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/552 (ref $@moonbitlang/core/builtin.Logger))
 (local.set $*module_name/366
  (struct.get $<StringView*Option<StringView>> 0
   (local.tee $*bind/359
    (if (result (ref $<StringView*Option<StringView>>))
     (i64.eq
      (local.tee $*bind/358
       (call $StringView::find
        (local.tee $pkg/356
         (struct.get $@moonbitlang/core/builtin.SourceLocRepr 0
          (local.get $self/357)))
        (struct.new $StringView
         (ref.as_non_null
          (global.get $moonbitlang/core/builtin.output.*bind|8190))
         (i32.const 0)
         (array.len
          (ref.as_non_null
           (global.get $moonbitlang/core/builtin.output.*bind|8190))))))
      (i64.const 4294967296))
     (then
      (struct.new $<StringView*Option<StringView>>
       (local.get $pkg/356)
       (ref.null none)))
     (else
      (local.set $*first_slash/361
       (i32.wrap_i64
        (local.tee $*Some/360
         (local.get $*bind/358))))
      (if (result (ref $<StringView*Option<StringView>>))
       (i64.eq
        (local.tee $*bind/362
         (call $StringView::find
          (call $StringView::view.inner
           (local.get $pkg/356)
           (i32.add
            (local.get $*first_slash/361)
            (i32.const 1))
           (i64.const 4294967296))
          (struct.new $StringView
           (ref.as_non_null
            (global.get $moonbitlang/core/builtin.output.*bind|8184))
           (i32.const 0)
           (array.len
            (ref.as_non_null
             (global.get $moonbitlang/core/builtin.output.*bind|8184))))))
        (i64.const 4294967296))
       (then
        (struct.new $<StringView*Option<StringView>>
         (local.get $pkg/356)
         (ref.null none)))
       (else
        (local.set $*second_slash/364
         (i32.wrap_i64
          (local.tee $*Some/363
           (local.get $*bind/362))))
        (local.set $module_name_end/365
         (i32.add
          (i32.add
           (local.get $*first_slash/361)
           (i32.const 1))
          (local.get $*second_slash/364)))
        (struct.new $<StringView*Option<StringView>>
         (call $StringView::view.inner
          (local.get $pkg/356)
          (i32.const 0)
          (i64.extend_i32_s
           (local.get $module_name_end/365)))
         (call $StringView::view.inner
          (local.get $pkg/356)
          (i32.add
           (local.get $module_name_end/365)
           (i32.const 1))
          (i64.const 4294967296))))))))))
 (if
  (ref.is_null
   (local.tee $*package_name/367
    (struct.get $<StringView*Option<StringView>> 1
     (local.get $*bind/359))))
  (then)
  (else
   (local.set $*pkg_name/369
    (ref.as_non_null
     (local.tee $*Some/368
      (local.get $*package_name/367))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_2
     (local.get $logger/370)
     (local.get $*pkg_name/369)
     (struct.get $@moonbitlang/core/builtin.Logger 2
      (local.get $logger/370))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_3
     (local.tee $*bind/551
      (local.get $logger/370))
     (i32.const 47)
     (struct.get $@moonbitlang/core/builtin.Logger 3
      (local.get $*bind/551))))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/370)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 1
    (local.get $self/357))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/370)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/370)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 2
    (local.get $self/357))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/370)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/370)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 3
    (local.get $self/357))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/370)
   (i32.const 45)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/370)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 4
    (local.get $self/357))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/370)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/370)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 5
    (local.get $self/357))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/370))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/370)
   (i32.const 64)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/370))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_2
  (local.tee $*bind/552
   (local.get $logger/370))
  (local.get $*module_name/366)
  (struct.get $@moonbitlang/core/builtin.Logger 2
   (local.get $*bind/552))))
(func $moonbitlang/core/builtin.println|String| (param $input/355 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/355))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int| (param $self/354 (ref $@moonbitlang/core/builtin.Array<Int>)) (param $logger/353 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Logger::write_iter.inner|Int|
  (local.get $logger/353)
  (call $@moonbitlang/core/builtin.Array::iter|Int|
   (local.get $self/354))
  (call $moonbit.string_literal
   (i32.const 2)
   (i32.const 6)
   (i32.const 1))
  (call $moonbit.string_literal
   (i32.const 1)
   (i32.const 4)
   (i32.const 1))
  (call $moonbit.string_literal
   (i32.const 0)
   (i32.const 0)
   (i32.const 2))
  (i32.const 0)))
(func $@moonbitlang/core/builtin.Array::iter|Int| (param $self/352 (ref $@moonbitlang/core/builtin.Array<Int>)) (result (ref $<<Int>=>Int>=>Int))
 (call $@moonbitlang/core/builtin.Iterator::iter|Int|
  (call $@moonbitlang/core/builtin.Array::iterator|Int|
   (local.get $self/352))))
(func $@moonbitlang/core/builtin.Array::iterator|Int| (param $self/351 (ref $@moonbitlang/core/builtin.Array<Int>)) (result (ref $<>=>Option<Int>))
 (call $@moonbitlang/core/builtin.ArrayView::iterator|Int|
  (struct.new $@moonbitlang/core/builtin.ArrayView<Int>
   (struct.get $@moonbitlang/core/builtin.Array<Int> 0
    (local.get $self/351))
   (i32.const 0)
   (struct.get $@moonbitlang/core/builtin.Array<Int> 1
    (local.get $self/351)))))
(func $@moonbitlang/core/builtin.ArrayView::iterator|Int| (param $self/349 (ref $@moonbitlang/core/builtin.ArrayView<Int>)) (result (ref $<>=>Option<Int>))
 (local $i/348 (ref $Ref<Int>))
 (local $*p/520 (ref $<>=>Option<Int>))
 (local.set $i/348
  (struct.new $Ref<Int>
   (i32.const 0)))
 (local.tee $*p/520
  (struct.new $ArrayView::iterator|Int|.*p.fn/4-cap
   (ref.func $ArrayView::iterator|Int|.*p.fn/4)
   (local.get $self/349)
   (local.get $i/348))))
(func $ArrayView::iterator|Int|.*p.fn/4 (type $<>=>Option<Int>-sig) (param $*env/549 (ref $<>=>Option<Int>)) (result i64)
 (local $i/348 (ref $Ref<Int>))
 (local $self/349 (ref $@moonbitlang/core/builtin.ArrayView<Int>))
 (local $elem/350 i32)
 (local $*casted_env/550 (ref $ArrayView::iterator|Int|.*p.fn/4-cap))
 (local.set $i/348
  (ref.as_non_null
   (struct.get $ArrayView::iterator|Int|.*p.fn/4-cap 2
    (local.tee $*casted_env/550
     (ref.cast (ref $ArrayView::iterator|Int|.*p.fn/4-cap)
      (local.get $*env/549))))))
 (local.set $self/349
  (ref.as_non_null
   (struct.get $ArrayView::iterator|Int|.*p.fn/4-cap 1
    (local.get $*casted_env/550))))
 (if (result i64)
  (i32.lt_s
   (struct.get $Ref<Int> 0
    (local.get $i/348))
   (i32.sub
    (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 2
     (local.get $self/349))
    (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 1
     (local.get $self/349))))
  (then
   (local.set $elem/350
    (array.get $moonbit.array_i32
     (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 0
      (local.get $self/349))
     (i32.add
      (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 1
       (local.get $self/349))
      (struct.get $Ref<Int> 0
       (local.get $i/348)))))
   (struct.set $Ref<Int> 0
    (local.get $i/348)
    (i32.add
     (struct.get $Ref<Int> 0
      (local.get $i/348))
     (i32.const 1)))
   (i64.extend_i32_s
    (local.get $elem/350)))
  (else
   (i64.const 4294967296))))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/346 i32) (param $logger/345 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/345)
  (call $Int::to_string.inner
   (local.get $self/346)
   (i32.const 10))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/345))))
(func $@moonbitlang/core/builtin.Array::push|Int| (param $self/342 (ref $@moonbitlang/core/builtin.Array<Int>)) (param $value/344 i32) (result i32)
 (local $length/343 i32)
 (if
  (i32.eq
   (struct.get $@moonbitlang/core/builtin.Array<Int> 1
    (local.get $self/342))
   (array.len
    (struct.get $@moonbitlang/core/builtin.Array<Int> 0
     (local.get $self/342))))
  (then
   (drop
    (call $@moonbitlang/core/builtin.Array::realloc|Int|
     (local.get $self/342))))
  (else))
 (local.set $length/343
  (struct.get $@moonbitlang/core/builtin.Array<Int> 1
   (local.get $self/342)))
 (array.set $moonbit.array_i32
  (struct.get $@moonbitlang/core/builtin.Array<Int> 0
   (local.get $self/342))
  (local.get $length/343)
  (local.get $value/344))
 (struct.set $@moonbitlang/core/builtin.Array<Int> 1
  (local.get $self/342)
  (i32.add
   (local.get $length/343)
   (i32.const 1)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Array::realloc|Int| (param $self/340 (ref $@moonbitlang/core/builtin.Array<Int>)) (result i32)
 (local $old_cap/339 i32)
 (local $new_cap/341 i32)
 (local.set $new_cap/341
  (if (result i32)
   (i32.eq
    (local.tee $old_cap/339
     (struct.get $@moonbitlang/core/builtin.Array<Int> 1
      (local.get $self/340)))
    (i32.const 0))
   (then
    (i32.const 8))
   (else
    (i32.mul
     (local.get $old_cap/339)
     (i32.const 2)))))
 (call $@moonbitlang/core/builtin.Array::resize_buffer|Int|
  (local.get $self/340)
  (local.get $new_cap/341)))
(func $@moonbitlang/core/builtin.Array::resize_buffer|Int| (param $self/336 (ref $@moonbitlang/core/builtin.Array<Int>)) (param $new_capacity/334 i32) (result i32)
 (local $new_buf/333 (ref $moonbit.array_i32))
 (local $old_buf/335 (ref $moonbit.array_i32))
 (local $old_cap/337 i32)
 (local $copy_len/338 i32)
 (local.set $new_buf/333
  (array.new_default $moonbit.array_i32
   (local.get $new_capacity/334)))
 (local.set $copy_len/338
  (if (result i32)
   (i32.lt_s
    (local.tee $old_cap/337
     (array.len
      (local.tee $old_buf/335
       (struct.get $@moonbitlang/core/builtin.Array<Int> 0
        (local.get $self/336)))))
    (local.get $new_capacity/334))
   (then
    (local.get $old_cap/337))
   (else
    (local.get $new_capacity/334))))
 (drop
  (call $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int|
   (local.get $new_buf/333)
   (i32.const 0)
   (local.get $old_buf/335)
   (i32.const 0)
   (local.get $copy_len/338)))
 (struct.set $@moonbitlang/core/builtin.Array<Int> 0
  (local.get $self/336)
  (local.get $new_buf/333))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/331 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/332 (ref $StringView)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/331)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/331))
    (i32.mul
     (i32.sub
      (struct.get $StringView 2
       (local.get $str/332))
      (struct.get $StringView 1
       (local.get $str/332)))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/331))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/331))
   (struct.get $StringView 0
    (local.get $str/332))
   (struct.get $StringView 1
    (local.get $str/332))
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/332))
    (struct.get $StringView 1
     (local.get $str/332)))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/331)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/331))
   (i32.mul
    (i32.sub
     (struct.get $StringView 2
      (local.get $str/332))
     (struct.get $StringView 1
      (local.get $str/332)))
    (i32.const 2))))
 (i32.const 0))
(func $String::offset_of_nth_char.inner (param $self/328 (ref $moonbit.string)) (param $i/329 i32) (param $start_offset/330 i32) (param $end_offset/326 i64) (result i64)
 (local $end_offset/325 i32)
 (local $*Some/327 i64)
 (local.set $end_offset/325
  (if (result i32)
   (i64.eq
    (local.get $end_offset/326)
    (i64.const 4294967296))
   (then
    (array.len
     (local.get $self/328)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/327
      (local.get $end_offset/326))))))
 (if (result i64)
  (i32.ge_s
   (local.get $i/329)
   (i32.const 0))
  (then
   (call $String::offset_of_nth_char_forward
    (local.get $self/328)
    (local.get $i/329)
    (local.get $start_offset/330)
    (local.get $end_offset/325)))
  (else
   (call $String::offset_of_nth_char_backward
    (local.get $self/328)
    (i32.sub
     (i32.const 0)
     (local.get $i/329))
    (local.get $start_offset/330)
    (local.get $end_offset/325)))))
(func $String::offset_of_nth_char_forward (param $self/323 (ref $moonbit.string)) (param $n/321 i32) (param $start_offset/317 i32) (param $end_offset/318 i32) (result i64)
 (local $c/322 i32)
 (local $utf16_offset/319 i32)
 (local $char_count/320 i32)
 (if (result i64)
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/317)
    (i32.const 0))
   (then
    (i32.le_s
     (local.get $start_offset/317)
     (local.get $end_offset/318)))
   (else
    (i32.const 0)))
  (then
   (local.set $utf16_offset/319
    (local.get $start_offset/317))
   (local.set $char_count/320
    (i32.const 0))
   (loop $loop:324
    (if
     (if (result i32)
      (i32.lt_s
       (local.get $utf16_offset/319)
       (local.get $end_offset/318))
      (then
       (i32.lt_s
        (local.get $char_count/320)
        (local.get $n/321)))
      (else
       (i32.const 0)))
     (then
      (local.set $c/322
       (array.get_u $moonbit.string
        (local.get $self/323)
        (local.get $utf16_offset/319)))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 55296)
         (local.get $c/322))
        (then
         (i32.le_s
          (local.get $c/322)
          (i32.const 56319)))
        (else
         (i32.const 0)))
       (then
        (local.set $utf16_offset/319
         (i32.add
          (local.get $utf16_offset/319)
          (i32.const 2))))
       (else
        (local.set $utf16_offset/319
         (i32.add
          (local.get $utf16_offset/319)
          (i32.const 1)))))
      (local.set $char_count/320
       (i32.add
        (local.get $char_count/320)
        (i32.const 1)))
      (br $loop:324))
     (else)))
   (if (result i64)
    (if (result i32)
     (i32.lt_s
      (local.get $char_count/320)
      (local.get $n/321))
     (then
      (i32.const 1))
     (else
      (i32.ge_s
       (local.get $utf16_offset/319)
       (local.get $end_offset/318))))
    (then
     (i64.const 4294967296))
    (else
     (i64.extend_i32_s
      (local.get $utf16_offset/319)))))
  (else
   (call $moonbitlang/core/builtin.abort|Option<Int>|
    (call $moonbit.string_literal
     (i32.const 4)
     (i32.const 106)
     (i32.const 19))
    (call $moonbit.string_literal
     (i32.const 3)
     (i32.const 8)
     (i32.const 49))))))
(func $String::offset_of_nth_char_backward (param $self/315 (ref $moonbit.string)) (param $n/313 i32) (param $start_offset/312 i32) (param $end_offset/311 i32) (result i64)
 (local $c/314 i32)
 (local $char_count/309 i32)
 (local $utf16_offset/310 i32)
 (local.set $char_count/309
  (i32.const 0))
 (local.set $utf16_offset/310
  (local.get $end_offset/311))
 (loop $loop:316
  (if
   (if (result i32)
    (i32.ge_s
     (i32.sub
      (local.get $utf16_offset/310)
      (i32.const 1))
     (local.get $start_offset/312))
    (then
     (i32.lt_s
      (local.get $char_count/309)
      (local.get $n/313)))
    (else
     (i32.const 0)))
   (then
    (local.set $c/314
     (array.get_u $moonbit.string
      (local.get $self/315)
      (i32.sub
       (local.get $utf16_offset/310)
       (i32.const 1))))
    (if
     (if (result i32)
      (i32.le_s
       (i32.const 56320)
       (local.get $c/314))
      (then
       (i32.le_s
        (local.get $c/314)
        (i32.const 57343)))
      (else
       (i32.const 0)))
     (then
      (local.set $utf16_offset/310
       (i32.sub
        (local.get $utf16_offset/310)
        (i32.const 2))))
     (else
      (local.set $utf16_offset/310
       (i32.sub
        (local.get $utf16_offset/310)
        (i32.const 1)))))
    (local.set $char_count/309
     (i32.add
      (local.get $char_count/309)
      (i32.const 1)))
    (br $loop:316))
   (else)))
 (if (result i64)
  (if (result i32)
   (i32.lt_s
    (local.get $char_count/309)
    (local.get $n/313))
   (then
    (i32.const 1))
   (else
    (i32.lt_s
     (local.get $utf16_offset/310)
     (local.get $start_offset/312))))
  (then
   (i64.const 4294967296))
  (else
   (i64.extend_i32_s
    (local.get $utf16_offset/310)))))
(func $String::char_length_ge.inner (param $self/301 (ref $moonbit.string)) (param $len/304 i32) (param $start_offset/308 i32) (param $end_offset/299 i64) (result i32)
 (local $end_offset/298 i32)
 (local $*Some/300 i64)
 (local $index/302 i32)
 (local $count/303 i32)
 (local $c1/305 i32)
 (local $c2/306 i32)
 (local.set $end_offset/298
  (if (result i32)
   (i64.eq
    (local.get $end_offset/299)
    (i64.const 4294967296))
   (then
    (array.len
     (local.get $self/301)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/300
      (local.get $end_offset/299))))))
 (local.get $start_offset/308)
 (i32.const 0)
 (loop $loop:307 (param i32) (param i32) (result i32)
  (local.set $count/303)
  (local.tee $index/302)
  (local.get $end_offset/298)
  (i32.lt_s)
  (if (result i32)
   (then
    (i32.lt_s
     (local.get $count/303)
     (local.get $len/304)))
   (else
    (i32.const 0)))
  (if (result i32)
   (then
    (local.set $c1/305
     (array.get_u $moonbit.string
      (local.get $self/301)
      (local.get $index/302)))
    (if
     (if (result i32)
      (if (result i32)
       (i32.le_s
        (i32.const 55296)
        (local.get $c1/305))
       (then
        (i32.le_s
         (local.get $c1/305)
         (i32.const 56319)))
       (else
        (i32.const 0)))
      (then
       (i32.lt_s
        (i32.add
         (local.get $index/302)
         (i32.const 1))
        (local.get $end_offset/298)))
      (else
       (i32.const 0)))
     (then
      (local.set $c2/306
       (array.get_u $moonbit.string
        (local.get $self/301)
        (i32.add
         (local.get $index/302)
         (i32.const 1))))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 56320)
         (local.get $c2/306))
        (then
         (i32.le_s
          (local.get $c2/306)
          (i32.const 57343)))
        (else
         (i32.const 0)))
       (then
        (i32.add
         (local.get $index/302)
         (i32.const 2))
        (i32.add
         (local.get $count/303)
         (i32.const 1))
        (br $loop:307))
       (else
        (drop
         (call $moonbitlang/core/builtin.abort|Unit|
          (call $moonbit.string_literal
           (i32.const 6)
           (i32.const 242)
           (i32.const 22))
          (call $moonbit.string_literal
           (i32.const 5)
           (i32.const 144)
           (i32.const 49)))))))
     (else))
    (i32.add
     (local.get $index/302)
     (i32.const 1))
    (i32.add
     (local.get $count/303)
     (i32.const 1))
    (br $loop:307))
   (else
    (i32.ge_s
     (local.get $count/303)
     (local.get $len/304))))))
(func $@moonbitlang/core/builtin.Iterator::iter|Int| (param $self/292 (ref $<>=>Option<Int>)) (result (ref $<<Int>=>Int>=>Int))
 (struct.new $Iterator::iter|Int|.fn/3-cap
  (ref.func $Iterator::iter|Int|.fn/3)
  (local.get $self/292)))
(func $Iterator::iter|Int|.fn/3 (type $<<Int>=>Int>=>Int-sig) (param $*env/547 (ref $<<Int>=>Int>=>Int)) (param $yield_/290 (ref $<Int>=>Int)) (result i32)
 (local $*bind/291 i64)
 (local $self/292 (ref $<>=>Option<Int>))
 (local $*Some/293 i64)
 (local $*x/294 i32)
 (local $*bind/295 i32)
 (local $*casted_env/548 (ref $Iterator::iter|Int|.fn/3-cap))
 (local.set $self/292
  (ref.as_non_null
   (struct.get $Iterator::iter|Int|.fn/3-cap 1
    (local.tee $*casted_env/548
     (ref.cast (ref $Iterator::iter|Int|.fn/3-cap)
      (local.get $*env/547))))))
 (block $break:296 (result i32)
  (loop $loop:296 (result i32)
   (if (result i32)
    (i64.eq
     (local.tee $*bind/291
      (call $@moonbitlang/core/builtin.Iterator::next|Int|
       (local.get $self/292)))
     (i64.const 4294967296))
    (then
     (i32.const 1))
    (else
     (local.set $*x/294
      (i32.wrap_i64
       (local.tee $*Some/293
        (local.get $*bind/291))))
     (if
      (i32.eq
       (local.tee $*bind/295
        (call_ref $<Int>=>Int-sig
         (local.get $yield_/290)
         (local.get $*x/294)
         (struct.get $<Int>=>Int 0
          (local.get $yield_/290))))
       (i32.const 1))
      (then)
      (else
       (i32.const 0)
       (br $break:296)))
     (br $loop:296))))))
(func $@moonbitlang/core/builtin.Iterator::next|Int| (param $self/289 (ref $<>=>Option<Int>)) (result i64)
 (local $*func/288 (ref $<>=>Option<Int>))
 (call_ref $<>=>Option<Int>-sig
  (local.tee $*func/288
   (local.get $self/289))
  (struct.get $<>=>Option<Int> 0
   (local.get $*func/288))))
(func $Int::to_string.inner (param $self/271 i32) (param $radix/270 i32) (result (ref $moonbit.string))
 (local $is_negative/272 i32)
 (local $num/273 i32)
 (local $buffer/274 (ref $FixedArray<UInt16>))
 (local $digit_len/275 i32)
 (local $total_len/276 i32)
 (local $buffer/277 (ref $FixedArray<UInt16>))
 (local $digit_start/278 i32)
 (local $digit_len/279 i32)
 (local $total_len/280 i32)
 (local $buffer/281 (ref $FixedArray<UInt16>))
 (local $digit_start/282 i32)
 (local $digit_len/283 i32)
 (local $total_len/284 i32)
 (local $buffer/285 (ref $FixedArray<UInt16>))
 (local $digit_start/286 i32)
 (if
  (if (result i32)
   (i32.lt_s
    (local.get $radix/270)
    (i32.const 2))
   (then
    (i32.const 1))
   (else
    (i32.gt_s
     (local.get $radix/270)
     (i32.const 36))))
  (then
   (drop
    (call $moonbitlang/core/builtin.abort|Unit|
     (call $moonbit.string_literal
      (i32.const 9)
      (i32.const 392)
      (i32.const 30))
     (call $moonbit.string_literal
      (i32.const 8)
      (i32.const 288)
      (i32.const 52)))))
  (else))
 (if
  (i32.eq
   (local.get $self/271)
   (i32.const 0))
  (then
   (call $moonbit.string_literal
    (i32.const 7)
    (i32.const 286)
    (i32.const 1))
   (return))
  (else))
 (local.set $num/273
  (if (result i32)
   (local.tee $is_negative/272
    (i32.lt_s
     (local.get $self/271)
     (i32.const 0)))
   (then
    (i32.sub
     (i32.const 0)
     (local.get $self/271)))
   (else
    (local.get $self/271))))
 (local.set $buffer/274
  (if (result (ref $FixedArray<UInt16>))
   (i32.eq
    (local.get $radix/270)
    (i32.const 10))
   (then
    (local.set $total_len/276
     (i32.add
      (local.tee $digit_len/275
       (call $moonbitlang/core/builtin.dec_count32
        (local.get $num/273)))
      (if (result i32)
       (local.get $is_negative/272)
       (then
        (i32.const 1))
       (else
        (i32.const 0)))))
    (local.set $buffer/277
     (array.new $FixedArray<UInt16>
      (i32.const 0)
      (local.get $total_len/276)))
    (local.set $digit_start/278
     (if (result i32)
      (local.get $is_negative/272)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/277)
      (local.get $num/273)
      (local.get $digit_start/278)
      (local.get $total_len/276)))
    (local.get $buffer/277))
   (else
    (if (result (ref $FixedArray<UInt16>))
     (i32.eq
      (local.get $radix/270)
      (i32.const 16))
     (then
      (local.set $total_len/280
       (i32.add
        (local.tee $digit_len/279
         (call $moonbitlang/core/builtin.hex_count32
          (local.get $num/273)))
        (if (result i32)
         (local.get $is_negative/272)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/281
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/280)))
      (local.set $digit_start/282
       (if (result i32)
        (local.get $is_negative/272)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/281)
        (local.get $num/273)
        (local.get $digit_start/282)
        (local.get $total_len/280)))
      (local.get $buffer/281))
     (else
      (local.set $total_len/284
       (i32.add
        (local.tee $digit_len/283
         (call $moonbitlang/core/builtin.radix_count32
          (local.get $num/273)
          (local.get $radix/270)))
        (if (result i32)
         (local.get $is_negative/272)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/285
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/284)))
      (local.set $digit_start/286
       (if (result i32)
        (local.get $is_negative/272)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_generic
        (local.get $buffer/285)
        (local.get $num/273)
        (local.get $digit_start/286)
        (local.get $total_len/284)
        (local.get $radix/270)))
      (local.get $buffer/285))))))
 (if
  (local.get $is_negative/272)
  (then
   (array.set $FixedArray<UInt16>
    (local.get $buffer/274)
    (i32.const 0)
    (i32.const 45)))
  (else))
 (local.get $buffer/274))
(func $moonbitlang/core/builtin.radix_count32 (param $value/264 i32) (param $radix/267 i32) (result i32)
 (local $base/266 i32)
 (local $num/265 i32)
 (local $count/268 i32)
 (if
  (i32.eq
   (local.get $value/264)
   (i32.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.set $num/265
  (local.get $value/264))
 (local.set $base/266
  (local.get $radix/267))
 (local.set $count/268
  (i32.const 0))
 (loop $loop:269
  (if
   (i32.gt_u
    (local.get $num/265)
    (i32.const 0))
   (then
    (local.set $count/268
     (i32.add
      (local.get $count/268)
      (i32.const 1)))
    (local.set $num/265
     (i32.div_u
      (local.get $num/265)
      (local.get $base/266)))
    (br $loop:269))
   (else)))
 (local.get $count/268))
(func $moonbitlang/core/builtin.hex_count32 (param $value/262 i32) (result i32)
 (local $leading_zeros/263 i32)
 (if (result i32)
  (i32.eq
   (local.get $value/262)
   (i32.const 0))
  (then
   (i32.const 1))
  (else
   (local.set $leading_zeros/263
    (i32.clz
     (local.get $value/262)))
   (i32.add
    (i32.div_s
     (i32.sub
      (i32.const 31)
      (local.get $leading_zeros/263))
     (i32.const 4))
    (i32.const 1)))))
(func $moonbitlang/core/builtin.dec_count32 (param $value/261 i32) (result i32)
 (if (result i32)
  (i32.ge_u
   (local.get $value/261)
   (i32.const 100000))
  (then
   (if (result i32)
    (i32.ge_u
     (local.get $value/261)
     (i32.const 10000000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/261)
       (i32.const 1000000000))
      (then
       (i32.const 10))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/261)
         (i32.const 100000000))
        (then
         (i32.const 9))
        (else
         (i32.const 8))))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/261)
       (i32.const 1000000))
      (then
       (i32.const 7))
      (else
       (i32.const 6))))))
  (else
   (if (result i32)
    (i32.ge_u
     (local.get $value/261)
     (i32.const 1000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/261)
       (i32.const 10000))
      (then
       (i32.const 5))
      (else
       (i32.const 4))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/261)
       (i32.const 100))
      (then
       (i32.const 3))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/261)
         (i32.const 10))
        (then
         (i32.const 2))
        (else
         (i32.const 1))))))))))
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/251 (ref $FixedArray<UInt16>)) (param $num/239 i32) (param $digit_start/242 i32) (param $total_len/241 i32) (result i32)
 (local $t/243 i32)
 (local $r/244 i32)
 (local $d1/245 i32)
 (local $d2/246 i32)
 (local $d1_hi/247 i32)
 (local $d1_lo/248 i32)
 (local $d2_hi/249 i32)
 (local $d2_lo/250 i32)
 (local $t/254 i32)
 (local $d/255 i32)
 (local $d_hi/256 i32)
 (local $d_lo/257 i32)
 (local $d_hi/259 i32)
 (local $d_lo/260 i32)
 (local $num/238 i32)
 (local $offset/240 i32)
 (local $remaining/253 i32)
 (local.set $num/238
  (local.get $num/239))
 (local.set $offset/240
  (i32.sub
   (local.get $total_len/241)
   (local.get $digit_start/242)))
 (loop $loop:252
  (if
   (i32.ge_u
    (local.get $num/238)
    (i32.const 10000))
   (then
    (local.set $t/243
     (i32.div_u
      (local.get $num/238)
      (i32.const 10000)))
    (local.set $r/244
     (i32.rem_u
      (local.get $num/238)
      (i32.const 10000)))
    (local.set $num/238
     (local.get $t/243))
    (local.set $d1/245
     (i32.div_s
      (local.get $r/244)
      (i32.const 100)))
    (local.set $d2/246
     (i32.rem_s
      (local.get $r/244)
      (i32.const 100)))
    (local.set $offset/240
     (i32.sub
      (local.get $offset/240)
      (i32.const 4)))
    (local.set $d1_hi/247
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d1/245)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d1_lo/248
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d1/245)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_hi/249
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d2/246)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_lo/250
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d2/246)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/251)
     (i32.add
      (local.get $digit_start/242)
      (local.get $offset/240))
     (local.get $d1_hi/247))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/251)
     (i32.add
      (i32.add
       (local.get $digit_start/242)
       (local.get $offset/240))
      (i32.const 1))
     (local.get $d1_lo/248))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/251)
     (i32.add
      (i32.add
       (local.get $digit_start/242)
       (local.get $offset/240))
      (i32.const 2))
     (local.get $d2_hi/249))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/251)
     (i32.add
      (i32.add
       (local.get $digit_start/242)
       (local.get $offset/240))
      (i32.const 3))
     (local.get $d2_lo/250))
    (br $loop:252))
   (else)))
 (local.set $remaining/253
  (local.get $num/238))
 (loop $loop:258
  (if
   (i32.ge_s
    (local.get $remaining/253)
    (i32.const 100))
   (then
    (local.set $t/254
     (i32.div_s
      (local.get $remaining/253)
      (i32.const 100)))
    (local.set $d/255
     (i32.rem_s
      (local.get $remaining/253)
      (i32.const 100)))
    (local.set $remaining/253
     (local.get $t/254))
    (local.set $offset/240
     (i32.sub
      (local.get $offset/240)
      (i32.const 2)))
    (local.set $d_hi/256
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d/255)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d_lo/257
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d/255)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/251)
     (i32.add
      (local.get $digit_start/242)
      (local.get $offset/240))
     (local.get $d_hi/256))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/251)
     (i32.add
      (i32.add
       (local.get $digit_start/242)
       (local.get $offset/240))
      (i32.const 1))
     (local.get $d_lo/257))
    (br $loop:258))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.get $remaining/253)
   (i32.const 10))
  (then
   (local.set $offset/240
    (i32.sub
     (local.get $offset/240)
     (i32.const 2)))
   (local.set $d_hi/259
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.div_s
       (local.get $remaining/253)
       (i32.const 10)))
     (i32.const 65535)))
   (local.set $d_lo/260
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (local.get $remaining/253)
       (i32.const 10)))
     (i32.const 65535)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/251)
    (i32.add
     (local.get $digit_start/242)
     (local.get $offset/240))
    (local.get $d_hi/259))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/251)
    (i32.add
     (i32.add
      (local.get $digit_start/242)
      (local.get $offset/240))
     (i32.const 1))
    (local.get $d_lo/260))
   (i32.const 0))
  (else
   (local.set $offset/240
    (i32.sub
     (local.get $offset/240)
     (i32.const 1)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/251)
    (i32.add
     (local.get $digit_start/242)
     (local.get $offset/240))
    (i32.and
     (i32.add
      (i32.const 48)
      (local.get $remaining/253))
     (i32.const 65535)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/233 (ref $FixedArray<UInt16>)) (param $num/227 i32) (param $digit_start/225 i32) (param $total_len/224 i32) (param $radix/229 i32) (result i32)
 (local $base/228 i32)
 (local $shift/230 i32)
 (local $mask/231 i32)
 (local $digit/232 i32)
 (local $q/235 i32)
 (local $digit/236 i32)
 (local $offset/223 i32)
 (local $n/226 i32)
 (local.set $offset/223
  (i32.sub
   (local.get $total_len/224)
   (local.get $digit_start/225)))
 (local.set $n/226
  (local.get $num/227))
 (local.set $base/228
  (local.get $radix/229))
 (if (result i32)
  (i32.eq
   (i32.and
    (local.get $radix/229)
    (i32.sub
     (local.get $radix/229)
     (i32.const 1)))
   (i32.const 0))
  (then
   (local.set $shift/230
    (i32.ctz
     (local.get $radix/229)))
   (local.set $mask/231
    (i32.sub
     (local.get $base/228)
     (i32.const 1)))
   (loop $loop:234
    (if
     (i32.gt_u
      (local.get $n/226)
      (i32.const 0))
     (then
      (local.set $offset/223
       (i32.sub
        (local.get $offset/223)
        (i32.const 1)))
      (local.set $digit/232
       (i32.and
        (local.get $n/226)
        (local.get $mask/231)))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/233)
       (i32.add
        (local.get $digit_start/225)
        (local.get $offset/223))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 10)
          (i32.const 452)
          (i32.const 36))
         (local.get $digit/232))
        (i32.const 65535)))
      (local.set $n/226
       (i32.shr_u
        (local.get $n/226)
        (local.get $shift/230)))
      (br $loop:234))
     (else)))
   (i32.const 0))
  (else
   (loop $loop:237
    (if
     (i32.gt_u
      (local.get $n/226)
      (i32.const 0))
     (then
      (local.set $offset/223
       (i32.sub
        (local.get $offset/223)
        (i32.const 1)))
      (local.set $q/235
       (i32.div_u
        (local.get $n/226)
        (local.get $base/228)))
      (local.set $digit/236
       (i32.sub
        (local.get $n/226)
        (i32.mul
         (local.get $q/235)
         (local.get $base/228))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/233)
       (i32.add
        (local.get $digit_start/225)
        (local.get $offset/223))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 10)
          (i32.const 452)
          (i32.const 36))
         (local.get $digit/236))
        (i32.const 65535)))
      (local.set $n/226
       (local.get $q/235))
      (br $loop:237))
     (else)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/220 (ref $FixedArray<UInt16>)) (param $num/216 i32) (param $digit_start/214 i32) (param $total_len/213 i32) (result i32)
 (local $byte_val/217 i32)
 (local $hi/218 i32)
 (local $lo/219 i32)
 (local $nibble/222 i32)
 (local $offset/212 i32)
 (local $n/215 i32)
 (local.set $offset/212
  (i32.sub
   (local.get $total_len/213)
   (local.get $digit_start/214)))
 (local.set $n/215
  (local.get $num/216))
 (loop $loop:221
  (if
   (i32.ge_s
    (local.get $offset/212)
    (i32.const 2))
   (then
    (local.set $offset/212
     (i32.sub
      (local.get $offset/212)
      (i32.const 2)))
    (local.set $hi/218
     (i32.div_s
      (local.tee $byte_val/217
       (i32.and
        (local.get $n/215)
        (i32.const 255)))
      (i32.const 16)))
    (local.set $lo/219
     (i32.rem_s
      (local.get $byte_val/217)
      (i32.const 16)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/220)
     (i32.add
      (local.get $digit_start/214)
      (local.get $offset/212))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 10)
        (i32.const 452)
        (i32.const 36))
       (local.get $hi/218))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/220)
     (i32.add
      (i32.add
       (local.get $digit_start/214)
       (local.get $offset/212))
      (i32.const 1))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 10)
        (i32.const 452)
        (i32.const 36))
       (local.get $lo/219))
      (i32.const 65535)))
    (local.set $n/215
     (i32.shr_u
      (local.get $n/215)
      (i32.const 8)))
    (br $loop:221))
   (else)))
 (if (result i32)
  (i32.eq
   (local.get $offset/212)
   (i32.const 1))
  (then
   (local.set $nibble/222
    (i32.and
     (local.get $n/215)
     (i32.const 15)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/220)
    (local.get $digit_start/214)
    (i32.and
     (array.get_u $moonbit.string
      (call $moonbit.string_literal
       (i32.const 10)
       (i32.const 452)
       (i32.const 36))
      (local.get $nibble/222))
     (i32.const 65535)))
   (i32.const 0))
  (else
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::write_iter.inner|Int| (param $self/203 (ref $@moonbitlang/core/builtin.Logger)) (param $iter/206 (ref $<<Int>=>Int>=>Int)) (param $prefix/204 (ref $moonbit.string)) (param $suffix/211 (ref $moonbit.string)) (param $sep/208 (ref $moonbit.string)) (param $trailing/205 i32) (result i32)
 (local $first/209 (ref $Ref<Bool>))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_0
   (local.get $self/203)
   (local.get $prefix/204)
   (struct.get $@moonbitlang/core/builtin.Logger 0
    (local.get $self/203))))
 (if
  (local.get $trailing/205)
  (then
   (drop
    (call_ref $<<Int>=>Int>=>Int-sig
     (local.get $iter/206)
     (struct.new $Logger::write_iter.inner|Int|.fn/1-cap
      (ref.func $Logger::write_iter.inner|Int|.fn/1)
      (local.get $sep/208)
      (local.get $self/203))
     (struct.get $<<Int>=>Int>=>Int 0
      (local.get $iter/206)))))
  (else
   (local.set $first/209
    (struct.new $Ref<Bool>
     (i32.const 1)))
   (drop
    (call_ref $<<Int>=>Int>=>Int-sig
     (local.get $iter/206)
     (struct.new $Logger::write_iter.inner|Int|.fn/2-cap
      (ref.func $Logger::write_iter.inner|Int|.fn/2)
      (local.get $first/209)
      (local.get $sep/208)
      (local.get $self/203))
     (struct.get $<<Int>=>Int>=>Int 0
      (local.get $iter/206))))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $self/203)
  (local.get $suffix/211)
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $self/203))))
(func $Logger::write_iter.inner|Int|.fn/2 (type $<Int>=>Int-sig) (param $*env/545 (ref $<Int>=>Int)) (param $x/210 i32) (result i32)
 (local $self/203 (ref $@moonbitlang/core/builtin.Logger))
 (local $sep/208 (ref $moonbit.string))
 (local $first/209 (ref $Ref<Bool>))
 (local $*casted_env/546 (ref $Logger::write_iter.inner|Int|.fn/2-cap))
 (local.set $self/203
  (ref.as_non_null
   (struct.get $Logger::write_iter.inner|Int|.fn/2-cap 3
    (local.tee $*casted_env/546
     (ref.cast (ref $Logger::write_iter.inner|Int|.fn/2-cap)
      (local.get $*env/545))))))
 (local.set $sep/208
  (ref.as_non_null
   (struct.get $Logger::write_iter.inner|Int|.fn/2-cap 2
    (local.get $*casted_env/546))))
 (if
  (struct.get $Ref<Bool> 0
   (local.tee $first/209
    (ref.as_non_null
     (struct.get $Logger::write_iter.inner|Int|.fn/2-cap 1
      (local.get $*casted_env/546)))))
  (then
   (struct.set $Ref<Bool> 0
    (local.get $first/209)
    (i32.const 0)))
  (else
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_0
     (local.get $self/203)
     (local.get $sep/208)
     (struct.get $@moonbitlang/core/builtin.Logger 0
      (local.get $self/203))))))
 (drop
  (call $@moonbitlang/core/builtin.Logger::write_object|Int|
   (local.get $self/203)
   (local.get $x/210)))
 (i32.const 1))
(func $Logger::write_iter.inner|Int|.fn/1 (type $<Int>=>Int-sig) (param $*env/543 (ref $<Int>=>Int)) (param $x/207 i32) (result i32)
 (local $self/203 (ref $@moonbitlang/core/builtin.Logger))
 (local $sep/208 (ref $moonbit.string))
 (local $*casted_env/544 (ref $Logger::write_iter.inner|Int|.fn/1-cap))
 (local.set $self/203
  (ref.as_non_null
   (struct.get $Logger::write_iter.inner|Int|.fn/1-cap 2
    (local.tee $*casted_env/544
     (ref.cast (ref $Logger::write_iter.inner|Int|.fn/1-cap)
      (local.get $*env/543))))))
 (local.set $sep/208
  (ref.as_non_null
   (struct.get $Logger::write_iter.inner|Int|.fn/1-cap 1
    (local.get $*casted_env/544))))
 (drop
  (call $@moonbitlang/core/builtin.Logger::write_object|Int|
   (local.get $self/203)
   (local.get $x/207)))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_0
   (local.get $self/203)
   (local.get $sep/208)
   (struct.get $@moonbitlang/core/builtin.Logger 0
    (local.get $self/203))))
 (i32.const 1))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/202 (ref $moonbit.string)) (result (ref $moonbit.string))
 (local $logger/201 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/201
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/202)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/201))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/201)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/200 i32) (result (ref $moonbit.string))
 (local $logger/199 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/199
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/200)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/199))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/199)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>| (param $self/198 (ref $@moonbitlang/core/builtin.Array<Int>)) (result (ref $moonbit.string))
 (local $logger/197 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/197
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int|
   (local.get $self/198)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/197))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/197)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/189 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $value/192 (ref $moonbit.string)) (param $start/193 i32) (param $len/194 i32) (result i32)
 (local $*try_err/191 (ref $moonbit.enum))
 (local $*bind/542 (ref $moonbit.enum))
 (local $tag/554 i32)
 (local.get $self/189)
 (block $outer/553 (result (ref $StringView))
  (block $join:190 (result (ref $moonbit.enum))
   (if (result (ref $StringView))
    (i32.eq
     (local.tee $tag/554
      (struct.get $moonbit.enum 0
       (local.tee $*bind/542
        (call $String::sub.inner
         (local.get $value/192)
         (local.get $start/193)
         (i64.extend_i32_s
          (i32.add
           (local.get $start/193)
           (local.get $len/194)))))))
     (i32.const 1))
    (then
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
       (local.get $*bind/542))))
    (else
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
       (local.get $*bind/542)))
     (br $join:190)))
   (br $outer/553))
  (local.set $*try_err/191)
  (unreachable))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view))
(func $String::sub.inner (param $self/182 (ref $moonbit.string)) (param $start/188 i32) (param $end/184 i64) (result (ref $moonbit.enum))
 (local $len/181 i32)
 (local $end/183 i32)
 (local $*Some/185 i64)
 (local $*end/186 i32)
 (local $start/187 i32)
 (local $*p/492 i32)
 (local $*p/495 i32)
 (local.set $len/181
  (array.len
   (local.get $self/182)))
 (local.set $end/183
  (if (result i32)
   (i64.eq
    (local.get $end/184)
    (i64.const 4294967296))
   (then
    (local.get $len/181))
   (else
    (if (result i32)
     (i32.lt_s
      (local.tee $*end/186
       (i32.wrap_i64
        (local.tee $*Some/185
         (local.get $end/184))))
      (i32.const 0))
     (then
      (i32.add
       (local.get $len/181)
       (local.get $*end/186)))
     (else
      (local.get $*end/186))))))
 (if (result (ref $moonbit.enum))
  (if (result i32)
   (i32.ge_s
    (local.tee $start/187
     (if (result i32)
      (i32.lt_s
       (local.get $start/188)
       (i32.const 0))
      (then
       (i32.add
        (local.get $len/181)
        (local.get $start/188)))
      (else
       (local.get $start/188))))
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start/187)
      (local.get $end/183))
     (then
      (i32.le_s
       (local.get $end/183)
       (local.get $len/181)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $start/187)
      (local.get $len/181))
     (then
      (local.set $*p/492
       (array.get_u $moonbit.string
        (local.get $self/182)
        (local.get $start/187)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/492))
       (then
        (i32.le_s
         (local.get $*p/492)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
      (i32.const 0)
      (global.get $moonbit.constr/0))
     (return))
    (else))
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $end/183)
      (local.get $len/181))
     (then
      (local.set $*p/495
       (array.get_u $moonbit.string
        (local.get $self/182)
        (local.get $end/183)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/495))
       (then
        (i32.le_s
         (local.get $*p/495)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
      (i32.const 0)
      (global.get $moonbit.constr/0))
     (return))
    (else))
   (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok
    (i32.const 1)
    (struct.new $StringView
     (local.get $self/182)
     (local.get $start/187)
     (local.get $end/183))))
  (else
   (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
    (i32.const 0)
    (global.get $moonbit.constr/1)))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/179 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/180 (ref $moonbit.string)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/179)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/179))
    (i32.mul
     (array.len
      (local.get $str/180))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/179))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/179))
   (local.get $str/180)
   (i32.const 0)
   (array.len
    (local.get $str/180))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/179)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/179))
   (i32.mul
    (array.len
     (local.get $str/180))
    (i32.const 2))))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/171 (ref $moonbit.bytes)) (param $bytes_offset/166 i32) (param $str/173 (ref $moonbit.string)) (param $str_offset/169 i32) (param $length/167 i32) (result i32)
 (local $e1/165 i32)
 (local $e2/168 i32)
 (local $len1/170 i32)
 (local $len2/172 i32)
 (local $end_str_offset/174 i32)
 (local $i/175 i32)
 (local $j/176 i32)
 (local $c/177 i32)
 (local $*p/486 i32)
 (local $*p/489 i32)
 (local.set $e1/165
  (i32.sub
   (i32.add
    (local.get $bytes_offset/166)
    (i32.mul
     (local.get $length/167)
     (i32.const 2)))
   (i32.const 1)))
 (local.set $e2/168
  (i32.sub
   (i32.add
    (local.get $str_offset/169)
    (local.get $length/167))
   (i32.const 1)))
 (local.set $len1/170
  (array.len
   (local.get $self/171)))
 (local.set $len2/172
  (array.len
   (local.get $str/173)))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $length/167)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $bytes_offset/166)
      (i32.const 0))
     (then
      (if (result i32)
       (i32.lt_s
        (local.get $e1/165)
        (local.get $len1/170))
       (then
        (if (result i32)
         (i32.ge_s
          (local.get $str_offset/169)
          (i32.const 0))
         (then
          (i32.lt_s
           (local.get $e2/168)
           (local.get $len2/172)))
         (else
          (i32.const 0))))
       (else
        (i32.const 0))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $end_str_offset/174
    (i32.add
     (local.get $str_offset/169)
     (local.get $length/167)))
   (local.get $str_offset/169)
   (local.get $bytes_offset/166)
   (loop $loop:178 (param i32) (param i32)
    (local.set $j/176)
    (local.tee $i/175)
    (local.get $end_str_offset/174)
    (i32.lt_s)
    (if
     (then
      (local.set $c/177
       (array.get_u $moonbit.string
        (local.get $str/173)
        (local.get $i/175)))
      (array.set $moonbit.bytes
       (local.get $self/171)
       (local.get $j/176)
       (i32.and
        (local.tee $*p/486
         (i32.and
          (local.get $c/177)
          (i32.const 255)))
        (i32.const 255)))
      (array.set $moonbit.bytes
       (local.get $self/171)
       (i32.add
        (local.get $j/176)
        (i32.const 1))
       (i32.and
        (local.tee $*p/489
         (i32.shr_u
          (local.get $c/177)
          (i32.const 8)))
        (i32.const 255)))
      (i32.add
       (local.get $i/175)
       (i32.const 1))
      (i32.add
       (local.get $j/176)
       (i32.const 2))
      (br $loop:178))
     (else)))
   (i32.const 0))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/133 (ref $moonbit.string)) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
 (local $*x/134 i32)
 (local $*x/135 (ref $StringView))
 (local $*Some/136 i64)
 (local $*bind/137 i64)
 (local $*Some/138 i64)
 (local $*pkg_end/139 i32)
 (local $pkg/140 (ref $StringView))
 (local $*bind/141 i64)
 (local $*Some/142 i64)
 (local $*start_loc_end/143 i32)
 (local $end_loc/144 (ref $StringView))
 (local $*bind/145 (ref null $<StringView*StringView>))
 (local $*Some/146 (ref null $<StringView*StringView>))
 (local $*x/147 (ref $<StringView*StringView>))
 (local $*end_line/148 (ref $StringView))
 (local $*end_column/149 (ref $StringView))
 (local $rest/150 (ref $StringView))
 (local $*bind/152 i64)
 (local $*Some/153 i64)
 (local $*start_line_end/154 i32)
 (local $*bind/155 i64)
 (local $*Some/156 i64)
 (local $*filename_end/157 i32)
 (local $start_loc/158 (ref $StringView))
 (local $*bind/159 (ref null $<StringView*StringView>))
 (local $*Some/160 (ref null $<StringView*StringView>))
 (local $*x/161 (ref $<StringView*StringView>))
 (local $*start_line/162 (ref $StringView))
 (local $*start_column/163 (ref $StringView))
 (local $filename/164 (ref $StringView))
 (local $*bind/384 i64)
 (block $join:132
  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
   (call $String::char_length_ge.inner
    (local.get $repr/133)
    (i32.const 1)
    (i32.const 0)
    (i64.extend_i32_s
     (array.len
      (local.get $repr/133))))
   (then
    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
     (i32.eq
      (local.tee $*x/134
       (array.get_u $moonbit.string
        (local.get $repr/133)
        (i32.const 0)))
      (i32.const 64))
     (then
      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
       (i64.eq
        (local.tee $*bind/137
         (call $StringView::find
          (local.tee $*x/135
           (struct.new $StringView
            (local.get $repr/133)
            (if (result i32)
             (i64.eq
              (local.tee $*bind/384
               (call $String::offset_of_nth_char.inner
                (local.get $repr/133)
                (i32.const 1)
                (i32.const 0)
                (i64.extend_i32_s
                 (array.len
                  (local.get $repr/133)))))
              (i64.const 4294967296))
             (then
              (array.len
               (local.get $repr/133)))
             (else
              (i32.wrap_i64
               (local.tee $*Some/136
                (local.get $*bind/384)))))
            (array.len
             (local.get $repr/133))))
          (struct.new $StringView
           (ref.as_non_null
            (global.get $moonbitlang/core/builtin.parse.*bind|5440))
           (i32.const 0)
           (array.len
            (ref.as_non_null
             (global.get $moonbitlang/core/builtin.parse.*bind|5440))))))
        (i64.const 4294967296))
       (then
        (unreachable))
       (else
        (local.set $*pkg_end/139
         (i32.wrap_i64
          (local.tee $*Some/138
           (local.get $*bind/137))))
        (local.set $pkg/140
         (call $StringView::view.inner
          (local.get $*x/135)
          (i32.const 0)
          (i64.extend_i32_s
           (local.get $*pkg_end/139))))
        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
         (i64.eq
          (local.tee $*bind/141
           (call $StringView::rev_find
            (local.get $*x/135)
            (struct.new $StringView
             (ref.as_non_null
              (global.get $moonbitlang/core/builtin.parse.*bind|5434))
             (i32.const 0)
             (array.len
              (ref.as_non_null
               (global.get $moonbitlang/core/builtin.parse.*bind|5434))))))
          (i64.const 4294967296))
         (then
          (unreachable))
         (else
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (i32.add
             (local.tee $*start_loc_end/143
              (i32.wrap_i64
               (local.tee $*Some/142
                (local.get $*bind/141))))
             (i32.const 1))
            (i32.sub
             (struct.get $StringView 2
              (local.get $*x/135))
             (struct.get $StringView 1
              (local.get $*x/135))))
           (then
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (ref.is_null
              (local.tee $*bind/145
               (call $moonbitlang/core/builtin.parse.parse_loc|1101
                (local.tee $end_loc/144
                 (call $StringView::view.inner
                  (local.get $*x/135)
                  (i32.add
                   (local.get $*start_loc_end/143)
                   (i32.const 1))
                  (i64.const 4294967296))))))
             (then
              (unreachable))
             (else
              (local.set $*end_line/148
               (struct.get $<StringView*StringView> 0
                (local.tee $*x/147
                 (ref.as_non_null
                  (local.tee $*Some/146
                   (local.get $*bind/145))))))
              (local.set $*end_column/149
               (struct.get $<StringView*StringView> 1
                (local.get $*x/147)))
              (local.set $rest/150
               (call $StringView::view.inner
                (local.get $*x/135)
                (i32.const 0)
                (i64.extend_i32_s
                 (local.get $*start_loc_end/143))))
              (block $join:151
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i64.eq
                 (local.tee $*bind/152
                  (call $StringView::rev_find
                   (local.get $rest/150)
                   (struct.new $StringView
                    (ref.as_non_null
                     (global.get $moonbitlang/core/builtin.parse.*bind|5421))
                    (i32.const 0)
                    (array.len
                     (ref.as_non_null
                      (global.get $moonbitlang/core/builtin.parse.*bind|5421))))))
                 (i64.const 4294967296))
                (then
                 (br $join:151))
                (else
                 (local.set $*start_line_end/154
                  (i32.wrap_i64
                   (local.tee $*Some/153
                    (local.get $*bind/152))))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i64.eq
                   (local.tee $*bind/155
                    (call $StringView::rev_find
                     (call $StringView::view.inner
                      (local.get $rest/150)
                      (i32.const 0)
                      (i64.extend_i32_s
                       (local.get $*start_line_end/154)))
                     (struct.new $StringView
                      (ref.as_non_null
                       (global.get $moonbitlang/core/builtin.parse.*bind|5415))
                      (i32.const 0)
                      (array.len
                       (ref.as_non_null
                        (global.get $moonbitlang/core/builtin.parse.*bind|5415))))))
                   (i64.const 4294967296))
                  (then
                   (br $join:151))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (i32.add
                      (local.tee $*filename_end/157
                       (i32.wrap_i64
                        (local.tee $*Some/156
                         (local.get $*bind/155))))
                      (i32.const 1))
                     (i32.sub
                      (struct.get $StringView 2
                       (local.get $rest/150))
                      (struct.get $StringView 1
                       (local.get $rest/150))))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (ref.is_null
                       (local.tee $*bind/159
                        (call $moonbitlang/core/builtin.parse.parse_loc|1101
                         (local.tee $start_loc/158
                          (call $StringView::view.inner
                           (local.get $rest/150)
                           (i32.add
                            (local.get $*filename_end/157)
                            (i32.const 1))
                           (i64.const 4294967296))))))
                      (then
                       (unreachable))
                      (else
                       (local.set $*start_line/162
                        (struct.get $<StringView*StringView> 0
                         (local.tee $*x/161
                          (ref.as_non_null
                           (local.tee $*Some/160
                            (local.get $*bind/159))))))
                       (local.set $*start_column/163
                        (struct.get $<StringView*StringView> 1
                         (local.get $*x/161)))
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $*filename_end/157)
                         (i32.add
                          (local.get $*pkg_end/139)
                          (i32.const 1)))
                        (then
                         (local.set $filename/164
                          (call $StringView::view.inner
                           (local.get $rest/150)
                           (i32.add
                            (local.get $*pkg_end/139)
                            (i32.const 1))
                           (i64.extend_i32_s
                            (local.get $*filename_end/157))))
                         (struct.new $@moonbitlang/core/builtin.SourceLocRepr
                          (local.get $pkg/140)
                          (local.get $filename/164)
                          (local.get $*start_line/162)
                          (local.get $*start_column/163)
                          (local.get $*end_line/148)
                          (local.get $*end_column/149)))
                        (else
                         (unreachable))))))
                    (else
                     (unreachable)))))))
               (return))
              (unreachable))))
           (else
            (unreachable))))))))
     (else
      (br $join:132))))
   (else
    (br $join:132)))
  (return))
 (unreachable))
(func $moonbitlang/core/builtin.parse.parse_loc|1101 (param $view/129 (ref $StringView)) (result (ref null $<StringView*StringView>))
 (local $*bind/128 i64)
 (local $*Some/130 i64)
 (local $*i/131 i32)
 (if (result (ref null $<StringView*StringView>))
  (i64.eq
   (local.tee $*bind/128
    (call $StringView::find
     (local.get $view/129)
     (struct.new $StringView
      (ref.as_non_null
       (global.get $moonbitlang/core/builtin.parse.*bind|5401))
      (i32.const 0)
      (array.len
       (ref.as_non_null
        (global.get $moonbitlang/core/builtin.parse.*bind|5401))))))
   (i64.const 4294967296))
  (then
   (ref.null none))
  (else
   (if (result (ref null $<StringView*StringView>))
    (if (result i32)
     (i32.gt_s
      (local.tee $*i/131
       (i32.wrap_i64
        (local.tee $*Some/130
         (local.get $*bind/128))))
      (i32.const 0))
     (then
      (i32.lt_s
       (i32.add
        (local.get $*i/131)
        (i32.const 1))
       (i32.sub
        (struct.get $StringView 2
         (local.get $view/129))
        (struct.get $StringView 1
         (local.get $view/129)))))
     (else
      (i32.const 0)))
    (then
     (struct.new $<StringView*StringView>
      (call $StringView::view.inner
       (local.get $view/129)
       (i32.const 0)
       (i64.extend_i32_s
        (local.get $*i/131)))
      (call $StringView::view.inner
       (local.get $view/129)
       (i32.add
        (local.get $*i/131)
        (i32.const 1))
       (i64.const 4294967296))))
    (else
     (ref.null none))))))
(func $StringView::view.inner (param $self/126 (ref $StringView)) (param $start_offset/127 i32) (param $end_offset/124 i64) (result (ref $StringView))
 (local $end_offset/123 i32)
 (local $*Some/125 i64)
 (local.set $end_offset/123
  (if (result i32)
   (i64.eq
    (local.get $end_offset/124)
    (i64.const 4294967296))
   (then
    (i32.sub
     (struct.get $StringView 2
      (local.get $self/126))
     (struct.get $StringView 1
      (local.get $self/126))))
   (else
    (i32.wrap_i64
     (local.tee $*Some/125
      (local.get $end_offset/124))))))
 (if (result (ref $StringView))
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/127)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start_offset/127)
      (local.get $end_offset/123))
     (then
      (i32.le_s
       (local.get $end_offset/123)
       (i32.sub
        (struct.get $StringView 2
         (local.get $self/126))
        (struct.get $StringView 1
         (local.get $self/126)))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (struct.new $StringView
    (struct.get $StringView 0
     (local.get $self/126))
    (i32.add
     (struct.get $StringView 1
      (local.get $self/126))
     (local.get $start_offset/127))
    (i32.add
     (struct.get $StringView 1
      (local.get $self/126))
     (local.get $end_offset/123))))
  (else
   (call $moonbitlang/core/builtin.abort|StringView|
    (call $moonbit.string_literal
     (i32.const 12)
     (i32.const 630)
     (i32.const 22))
    (call $moonbit.string_literal
     (i32.const 11)
     (i32.const 524)
     (i32.const 53))))))
(func $StringView::rev_find (param $self/122 (ref $StringView)) (param $str/121 (ref $StringView)) (result i64)
 (if (result i64)
  (i32.le_s
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/121))
    (struct.get $StringView 1
     (local.get $str/121)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_rev_find
    (local.get $self/122)
    (local.get $str/121)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_rev_find
    (local.get $self/122)
    (local.get $str/121)))))
(func $moonbitlang/core/builtin.brute_force_rev_find (param $haystack/112 (ref $StringView)) (param $needle/114 (ref $StringView)) (result i64)
 (local $haystack_len/111 i32)
 (local $needle_len/113 i32)
 (local $needle_first/115 i32)
 (local $j/118 i32)
 (local $*p/463 i32)
 (local $*p/466 i32)
 (local $*p/469 i32)
 (local $i/116 i32)
 (local.set $haystack_len/111
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/112))
   (struct.get $StringView 1
    (local.get $haystack/112))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/113
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/114))
     (struct.get $StringView 1
      (local.get $needle/114))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/111)
     (local.get $needle_len/113))
    (then
     (local.set $*p/463
      (i32.const 0))
     (local.set $needle_first/115
      (array.get_u $moonbit.string
       (struct.get $StringView 0
        (local.get $needle/114))
       (i32.add
        (struct.get $StringView 1
         (local.get $needle/114))
        (local.get $*p/463))))
     (local.set $i/116
      (i32.sub
       (local.get $haystack_len/111)
       (local.get $needle_len/113)))
     (loop $loop:120
      (if
       (i32.ge_s
        (local.get $i/116)
        (i32.const 0))
       (then
        (loop $loop:117
         (if
          (if (result i32)
           (i32.ge_s
            (local.get $i/116)
            (i32.const 0))
           (then
            (local.set $*p/466
             (local.get $i/116))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/112))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/112))
              (local.get $*p/466)))
            (i32.ne
             (local.get $needle_first/115)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/116
            (i32.sub
             (local.get $i/116)
             (i32.const 1)))
           (br $loop:117))
          (else)))
        (if
         (i32.ge_s
          (local.get $i/116)
          (i32.const 0))
         (then
          (block $break:119
           (i32.const 1)
           (loop $loop:119 (param i32)
            (local.tee $j/118)
            (local.get $needle_len/113)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/469
               (i32.add
                (local.get $i/116)
                (local.get $j/118)))
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $haystack/112))
               (i32.add
                (struct.get $StringView 1
                 (local.get $haystack/112))
                (local.get $*p/469)))
              (if
               (i32.ne
                (array.get_u $moonbit.string
                 (struct.get $StringView 0
                  (local.get $needle/114))
                 (i32.add
                  (struct.get $StringView 1
                   (local.get $needle/114))
                  (local.get $j/118))))
               (then
                (br $break:119))
               (else))
              (i32.add
               (local.get $j/118)
               (i32.const 1))
              (br $loop:119))
             (else
              (i64.extend_i32_s
               (local.get $i/116))
              (return)))))
          (local.set $i/116
           (i32.sub
            (local.get $i/116)
            (i32.const 1))))
         (else))
        (br $loop:120))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (i64.extend_i32_s
    (local.get $haystack_len/111)))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_rev_find (param $haystack/101 (ref $StringView)) (param $needle/103 (ref $StringView)) (result i64)
 (local $haystack_len/100 i32)
 (local $needle_len/102 i32)
 (local $skip_table/104 (ref $moonbit.array_i32))
 (local $i/105 i32)
 (local $i/107 i32)
 (local $j/108 i32)
 (local $*p/452 i32)
 (local.set $haystack_len/100
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/101))
   (struct.get $StringView 1
    (local.get $haystack/101))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/102
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/103))
     (struct.get $StringView 1
      (local.get $needle/103))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/100)
     (local.get $needle_len/102))
    (then
     (local.set $skip_table/104
      (array.new $moonbit.array_i32
       (local.get $needle_len/102)
       (i32.const 256)))
     (i32.sub
      (local.get $needle_len/102)
      (i32.const 1))
     (loop $loop:106 (param i32)
      (local.tee $i/105)
      (i32.const 0)
      (i32.gt_s)
      (if
       (then
        (array.set $moonbit.array_i32
         (local.get $skip_table/104)
         (i32.and
          (array.get_u $moonbit.string
           (struct.get $StringView 0
            (local.get $needle/103))
           (i32.add
            (struct.get $StringView 1
             (local.get $needle/103))
            (local.get $i/105)))
          (i32.const 255))
         (local.get $i/105))
        (i32.sub
         (local.get $i/105)
         (i32.const 1))
        (br $loop:106))
       (else)))
     (i32.sub
      (local.get $haystack_len/100)
      (local.get $needle_len/102))
     (loop $loop:110 (param i32)
      (local.tee $i/107)
      (i32.const 0)
      (i32.ge_s)
      (if
       (then
        (block $break:109
         (i32.const 0)
         (loop $loop:109 (param i32)
          (local.tee $j/108)
          (local.get $needle_len/102)
          (i32.lt_s)
          (if
           (then
            (local.set $*p/452
             (i32.add
              (local.get $i/107)
              (local.get $j/108)))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/101))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/101))
              (local.get $*p/452)))
            (if
             (i32.ne
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $needle/103))
               (i32.add
                (struct.get $StringView 1
                 (local.get $needle/103))
                (local.get $j/108))))
             (then
              (br $break:109))
             (else))
            (i32.add
             (local.get $j/108)
             (i32.const 1))
            (br $loop:109))
           (else
            (i64.extend_i32_s
             (local.get $i/107))
            (return)))))
        (i32.sub
         (local.get $i/107)
         (array.get $moonbit.array_i32
          (local.get $skip_table/104)
          (i32.and
           (array.get_u $moonbit.string
            (struct.get $StringView 0
             (local.get $haystack/101))
            (i32.add
             (struct.get $StringView 1
              (local.get $haystack/101))
             (local.get $i/107)))
           (i32.const 255))))
        (br $loop:110))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (i64.extend_i32_s
    (local.get $haystack_len/100)))))
(func $StringView::find (param $self/99 (ref $StringView)) (param $str/98 (ref $StringView)) (result i64)
 (if (result i64)
  (i32.le_s
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/98))
    (struct.get $StringView 1
     (local.get $str/98)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_find
    (local.get $self/99)
    (local.get $str/98)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_find
    (local.get $self/99)
    (local.get $str/98)))))
(func $moonbitlang/core/builtin.brute_force_find (param $haystack/88 (ref $StringView)) (param $needle/90 (ref $StringView)) (result i64)
 (local $haystack_len/87 i32)
 (local $needle_len/89 i32)
 (local $needle_first/91 i32)
 (local $forward_len/92 i32)
 (local $j/95 i32)
 (local $*p/433 i32)
 (local $*p/436 i32)
 (local $*p/439 i32)
 (local $i/93 i32)
 (local.set $haystack_len/87
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/88))
   (struct.get $StringView 1
    (local.get $haystack/88))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/89
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/90))
     (struct.get $StringView 1
      (local.get $needle/90))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/87)
     (local.get $needle_len/89))
    (then
     (local.set $*p/433
      (i32.const 0))
     (local.set $needle_first/91
      (array.get_u $moonbit.string
       (struct.get $StringView 0
        (local.get $needle/90))
       (i32.add
        (struct.get $StringView 1
         (local.get $needle/90))
        (local.get $*p/433))))
     (local.set $forward_len/92
      (i32.sub
       (local.get $haystack_len/87)
       (local.get $needle_len/89)))
     (local.set $i/93
      (i32.const 0))
     (loop $loop:97
      (if
       (i32.le_s
        (local.get $i/93)
        (local.get $forward_len/92))
       (then
        (loop $loop:94
         (if
          (if (result i32)
           (i32.le_s
            (local.get $i/93)
            (local.get $forward_len/92))
           (then
            (local.set $*p/436
             (local.get $i/93))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/88))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/88))
              (local.get $*p/436)))
            (i32.ne
             (local.get $needle_first/91)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/93
            (i32.add
             (local.get $i/93)
             (i32.const 1)))
           (br $loop:94))
          (else)))
        (if
         (i32.le_s
          (local.get $i/93)
          (local.get $forward_len/92))
         (then
          (block $break:96
           (i32.const 1)
           (loop $loop:96 (param i32)
            (local.tee $j/95)
            (local.get $needle_len/89)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/439
               (i32.add
                (local.get $i/93)
                (local.get $j/95)))
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $haystack/88))
               (i32.add
                (struct.get $StringView 1
                 (local.get $haystack/88))
                (local.get $*p/439)))
              (if
               (i32.ne
                (array.get_u $moonbit.string
                 (struct.get $StringView 0
                  (local.get $needle/90))
                 (i32.add
                  (struct.get $StringView 1
                   (local.get $needle/90))
                  (local.get $j/95))))
               (then
                (br $break:96))
               (else))
              (i32.add
               (local.get $j/95)
               (i32.const 1))
              (br $loop:96))
             (else
              (i64.extend_i32_s
               (local.get $i/93))
              (return)))))
          (local.set $i/93
           (i32.add
            (local.get $i/93)
            (i32.const 1))))
         (else))
        (br $loop:97))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (global.get $moonbitlang/core/builtin.brute_force_find.constr/86))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_find (param $haystack/74 (ref $StringView)) (param $needle/76 (ref $StringView)) (result i64)
 (local $haystack_len/73 i32)
 (local $needle_len/75 i32)
 (local $skip_table/77 (ref $moonbit.array_i32))
 (local $*end4298/78 i32)
 (local $i/79 i32)
 (local $i/81 i32)
 (local $*end4304/82 i32)
 (local $j/83 i32)
 (local $*p/421 i32)
 (local $*p/426 i32)
 (local.set $haystack_len/73
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/74))
   (struct.get $StringView 1
    (local.get $haystack/74))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/75
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/76))
     (struct.get $StringView 1
      (local.get $needle/76))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/73)
     (local.get $needle_len/75))
    (then
     (local.set $skip_table/77
      (array.new $moonbit.array_i32
       (local.get $needle_len/75)
       (i32.const 256)))
     (local.set $*end4298/78
      (i32.sub
       (local.get $needle_len/75)
       (i32.const 1)))
     (i32.const 0)
     (loop $loop:80 (param i32)
      (local.tee $i/79)
      (local.get $*end4298/78)
      (i32.lt_s)
      (if
       (then
        (array.set $moonbit.array_i32
         (local.get $skip_table/77)
         (i32.and
          (array.get_u $moonbit.string
           (struct.get $StringView 0
            (local.get $needle/76))
           (i32.add
            (struct.get $StringView 1
             (local.get $needle/76))
            (local.get $i/79)))
          (i32.const 255))
         (i32.sub
          (i32.sub
           (local.get $needle_len/75)
           (i32.const 1))
          (local.get $i/79)))
        (i32.add
         (local.get $i/79)
         (i32.const 1))
        (br $loop:80))
       (else)))
     (i32.const 0)
     (loop $loop:85 (param i32)
      (local.tee $i/81)
      (i32.sub
       (local.get $haystack_len/73)
       (local.get $needle_len/75))
      (i32.le_s)
      (if
       (then
        (local.set $*end4304/82
         (i32.sub
          (local.get $needle_len/75)
          (i32.const 1)))
        (block $break:84
         (i32.const 0)
         (loop $loop:84 (param i32)
          (local.tee $j/83)
          (local.get $*end4304/82)
          (i32.le_s)
          (if
           (then
            (local.set $*p/421
             (i32.add
              (local.get $i/81)
              (local.get $j/83)))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/74))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/74))
              (local.get $*p/421)))
            (if
             (i32.ne
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $needle/76))
               (i32.add
                (struct.get $StringView 1
                 (local.get $needle/76))
                (local.get $j/83))))
             (then
              (br $break:84))
             (else))
            (i32.add
             (local.get $j/83)
             (i32.const 1))
            (br $loop:84))
           (else
            (i64.extend_i32_s
             (local.get $i/81))
            (return)))))
        (local.get $i/81)
        (local.get $skip_table/77)
        (local.set $*p/426
         (i32.sub
          (i32.add
           (local.get $i/81)
           (local.get $needle_len/75))
          (i32.const 1)))
        (i32.and
         (array.get_u $moonbit.string
          (struct.get $StringView 0
           (local.get $haystack/74))
          (i32.add
           (struct.get $StringView 1
            (local.get $haystack/74))
           (local.get $*p/426)))
         (i32.const 255))
        (array.get $moonbit.array_i32)
        (i32.add)
        (br $loop:85))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (global.get $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/72))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/63 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $ch/65 i32) (result i32)
 (local $inc/64 i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/63)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/63))
    (i32.const 4))))
 (local.set $inc/64
  (call $FixedArray::set_utf16le_char
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/63))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/63))
   (local.get $ch/65)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/63)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/63))
   (local.get $inc/64)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/58 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $required/59 i32) (result i32)
 (local $current_len/57 i32)
 (local $new_data/62 (ref $moonbit.bytes))
 (local $enough_space/60 i32)
 (local.set $current_len/57
  (array.len
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/58))))
 (if
  (i32.le_s
   (local.get $required/59)
   (local.get $current_len/57))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/60
  (local.get $current_len/57))
 (loop $loop:61
  (if
   (i32.lt_s
    (local.get $enough_space/60)
    (local.get $required/59))
   (then
    (local.set $enough_space/60
     (i32.mul
      (local.get $enough_space/60)
      (i32.const 2)))
    (br $loop:61))
   (else)))
 (array.copy $moonbit.bytes $moonbit.bytes
  (local.tee $new_data/62
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $enough_space/60)))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/58))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 1
   (local.get $self/58)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 0
  (local.get $self/58)
  (local.get $new_data/62))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/52 (ref $moonbit.bytes)) (param $offset/53 i32) (param $value/51 i32) (result i32)
 (local $code/50 i32)
 (local $hi/54 i32)
 (local $lo/55 i32)
 (local $hi/56 i32)
 (local $*p/395 i32)
 (local $*p/398 i32)
 (local $*p/401 i32)
 (local $*p/404 i32)
 (local $*p/407 i32)
 (local $*p/410 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/50
    (local.get $value/51))
   (i32.const 65536))
  (then
   (array.set $moonbit.bytes
    (local.get $self/52)
    (local.get $offset/53)
    (i32.and
     (local.tee $*p/395
      (i32.and
       (local.get $code/50)
       (i32.const 255)))
     (i32.const 255)))
   (array.set $moonbit.bytes
    (local.get $self/52)
    (i32.add
     (local.get $offset/53)
     (i32.const 1))
    (i32.and
     (local.tee $*p/398
      (i32.shr_u
       (local.get $code/50)
       (i32.const 8)))
     (i32.const 255)))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/50)
     (i32.const 1114112))
    (then
     (local.set $lo/55
      (i32.or
       (i32.shr_u
        (local.tee $hi/54
         (i32.sub
          (local.get $code/50)
          (i32.const 65536)))
        (i32.const 10))
       (i32.const 55296)))
     (local.set $hi/56
      (i32.or
       (i32.and
        (local.get $hi/54)
        (i32.const 1023))
       (i32.const 56320)))
     (array.set $moonbit.bytes
      (local.get $self/52)
      (local.get $offset/53)
      (i32.and
       (local.tee $*p/401
        (i32.and
         (local.get $lo/55)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/52)
      (i32.add
       (local.get $offset/53)
       (i32.const 1))
      (i32.and
       (local.tee $*p/404
        (i32.shr_u
         (local.get $lo/55)
         (i32.const 8)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/52)
      (i32.add
       (local.get $offset/53)
       (i32.const 2))
      (i32.and
       (local.tee $*p/407
        (i32.and
         (local.get $hi/56)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/52)
      (i32.add
       (local.get $offset/53)
       (i32.const 3))
      (i32.and
       (local.tee $*p/410
        (i32.shr_u
         (local.get $hi/56)
         (i32.const 8)))
       (i32.const 255)))
     (i32.const 4))
    (else
     (call $moonbitlang/core/builtin.abort|Int|
      (call $moonbit.string_literal
       (i32.const 14)
       (i32.const 770)
       (i32.const 17))
      (call $moonbit.string_literal
       (i32.const 13)
       (i32.const 674)
       (i32.const 48))))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/47 (ref $@moonbitlang/core/builtin.StringBuilder)) (result (ref $moonbit.string))
 (call $Bytes::to_unchecked_string.inner
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/47))
  (i32.const 0)
  (i64.extend_i32_s
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/47)))))
(func $Bytes::to_unchecked_string.inner (param $self/42 (ref $moonbit.bytes)) (param $offset/46 i32) (param $length/44 i64) (result (ref $moonbit.string))
 (local $len/41 i32)
 (local $length/43 i32)
 (local $*Some/45 i64)
 (local.set $len/41
  (array.len
   (local.get $self/42)))
 (local.set $length/43
  (if (result i32)
   (i64.eq
    (local.get $length/44)
    (i64.const 4294967296))
   (then
    (i32.sub
     (local.get $len/41)
     (local.get $offset/46)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/45
      (local.get $length/44))))))
 (if (result (ref $moonbit.string))
  (if (result i32)
   (i32.ge_s
    (local.get $offset/46)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $length/43)
      (i32.const 0))
     (then
      (i32.le_s
       (i32.add
        (local.get $offset/46)
        (local.get $length/43))
       (local.get $len/41)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (call $moonbitlang/core/builtin.unsafe_sub_string
    (local.get $self/42)
    (local.get $offset/46)
    (local.get $length/43)))
  (else
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/525 (ref $moonbit.bytes)) (param $*param/526 i32) (param $*param/527 i32) (result (ref $moonbit.string))
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/525)
  (local.get $*param/526)
  (local.get $*param/527)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/39 i32) (result (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $initial/38 i32)
 (local $data/40 (ref $moonbit.bytes))
 (local.set $initial/38
  (if (result i32)
   (i32.lt_s
    (local.get $size_hint/39)
    (i32.const 1))
   (then
    (i32.const 1))
   (else
    (local.get $size_hint/39))))
 (struct.new $@moonbitlang/core/builtin.StringBuilder
  (local.tee $data/40
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $initial/38)))
  (i32.const 0)))
(func $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int| (param $dst/33 (ref $moonbit.array_i32)) (param $dst_offset/34 i32) (param $src/35 (ref $moonbit.array_i32)) (param $src_offset/36 i32) (param $len/37 i32) (result i32)
 (array.copy $moonbit.array_i32 $moonbit.array_i32
  (local.get $dst/33)
  (local.get $dst_offset/34)
  (local.get $src/35)
  (local.get $src_offset/36)
  (local.get $len/37))
 (i32.const 0))
(func $moonbitlang/core/builtin.abort|Option<Int>| (param $string/13 (ref $moonbit.string)) (param $loc/14 (ref $moonbit.string)) (result i64)
 (call $moonbitlang/core/abort.abort|Option<Int>|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/13)
     (call $moonbit.string_literal
      (i32.const 16)
      (i32.const 806)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/14)))
   (call $moonbit.string_literal
    (i32.const 15)
    (i32.const 804)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|StringView| (param $string/11 (ref $moonbit.string)) (param $loc/12 (ref $moonbit.string)) (result (ref $StringView))
 (call $moonbitlang/core/abort.abort|StringView|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/11)
     (call $moonbit.string_literal
      (i32.const 16)
      (i32.const 806)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/12)))
   (call $moonbit.string_literal
    (i32.const 15)
    (i32.const 804)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/9 (ref $moonbit.string)) (param $loc/10 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Unit|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/9)
     (call $moonbit.string_literal
      (i32.const 16)
      (i32.const 806)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/10)))
   (call $moonbit.string_literal
    (i32.const 15)
    (i32.const 804)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/7 (ref $moonbit.string)) (param $loc/8 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/7)
     (call $moonbit.string_literal
      (i32.const 16)
      (i32.const 806)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/8)))
   (call $moonbit.string_literal
    (i32.const 15)
    (i32.const 804)
    (i32.const 1)))))
(func $@moonbitlang/core/builtin.Logger::write_object|Int| (param $self/6 (ref $@moonbitlang/core/builtin.Logger)) (param $obj/5 i32) (result i32)
 (call $@moonbitlang/core/builtin.Show::Int::output
  (local.get $obj/5)
  (local.get $self/6)))
(func $moonbitlang/core/abort.abort|Option<Int>| (param $msg/4 (ref $moonbit.string)) (result i64)
 (unreachable))
(func $moonbitlang/core/abort.abort|StringView| (param $msg/3 (ref $moonbit.string)) (result (ref $StringView))
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/2 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/1 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_3) (param $*obj/541 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/540 i32) (result i32)
 (local $*self/539 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/539
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/541))))
  (local.get $*param/540)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_2) (param $*obj/538 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/537 (ref $StringView)) (result i32)
 (local $*self/536 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/536
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/538))))
  (local.get $*param/537)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (type $@moonbitlang/core/builtin.Logger.method_1) (param $*obj/535 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/532 (ref $moonbit.string)) (param $*param/533 i32) (param $*param/534 i32) (result i32)
 (local $*self/531 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/531
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/535))))
  (local.get $*param/532)
  (local.get $*param/533)
  (local.get $*param/534)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_0) (param $*obj/530 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/529 (ref $moonbit.string)) (result i32)
 (local $*self/528 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/528
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/530))))
  (local.get $*param/529)))
(start $*init*/6)
(func $*init*/6
 (global.set $moonbitlang/core/builtin.parse.*bind|5401
  (call $moonbit.string_literal
   (i32.const 21)
   (i32.const 948)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5440
  (call $moonbit.string_literal
   (i32.const 21)
   (i32.const 948)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5434
  (call $moonbit.string_literal
   (i32.const 22)
   (i32.const 950)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5421
  (call $moonbit.string_literal
   (i32.const 21)
   (i32.const 948)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5415
  (call $moonbit.string_literal
   (i32.const 21)
   (i32.const 948)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.output.*bind|8190
  (call $moonbit.string_literal
   (i32.const 20)
   (i32.const 946)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.output.*bind|8184
  (call $moonbit.string_literal
   (i32.const 20)
   (i32.const 946)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/72
  (i64.extend_i32_s
   (i32.const 0)))
 (global.set $moonbitlang/core/builtin.brute_force_find.constr/86
  (i64.extend_i32_s
   (i32.const 0))))
(func $*main*/5
 (local $arr/373 (ref $@moonbitlang/core/builtin.Array<Int>))
 (local $*len/375 i32)
 (local $*i/376 i32)
 (local $x/377 i32)
 (local $doubled/379 (ref $@moonbitlang/core/builtin.Array<Int>))
 (local $*len/380 i32)
 (local $*i/381 i32)
 (local $x/382 i32)
 (local $sum/374 i32)
 (local.set $arr/373
  (struct.new $@moonbitlang/core/builtin.Array<Int>
   (array.new_data $moonbit.array_i32 $moonbit.const_data
    (i32.const 926)
    (i32.const 5))
   (i32.const 5)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 19)
     (i32.const 894)
     (i32.const 16))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
     (local.get $arr/373)))))
 (local.set $sum/374
  (i32.const 0))
 (local.set $*len/375
  (struct.get $@moonbitlang/core/builtin.Array<Int> 1
   (local.get $arr/373)))
 (i32.const 0)
 (loop $loop:378 (param i32)
  (local.tee $*i/376)
  (local.get $*len/375)
  (i32.lt_s)
  (if
   (then
    (local.set $x/377
     (array.get $moonbit.array_i32
      (struct.get $@moonbitlang/core/builtin.Array<Int> 0
       (local.get $arr/373))
      (local.get $*i/376)))
    (local.set $sum/374
     (i32.add
      (local.get $sum/374)
      (local.get $x/377)))
    (i32.add
     (local.get $*i/376)
     (i32.const 1))
    (br $loop:378))
   (else)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 18)
     (i32.const 848)
     (i32.const 23))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
     (local.get $sum/374)))))
 (local.set $doubled/379
  (struct.new $@moonbitlang/core/builtin.Array<Int>
   (array.new_fixed $moonbit.array_i32 0)
   (i32.const 0)))
 (local.set $*len/380
  (struct.get $@moonbitlang/core/builtin.Array<Int> 1
   (local.get $arr/373)))
 (i32.const 0)
 (loop $loop:383 (param i32)
  (local.tee $*i/381)
  (local.get $*len/380)
  (i32.lt_s)
  (if
   (then
    (local.set $x/382
     (array.get $moonbit.array_i32
      (struct.get $@moonbitlang/core/builtin.Array<Int> 0
       (local.get $arr/373))
      (local.get $*i/381)))
    (drop
     (call $@moonbitlang/core/builtin.Array::push|Int|
      (local.get $doubled/379)
      (i32.mul
       (local.get $x/382)
       (i32.const 2))))
    (i32.add
     (local.get $*i/381)
     (i32.const 1))
    (br $loop:383))
   (else)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 17)
     (i32.const 818)
     (i32.const 15))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
     (local.get $doubled/379))))))
(export "_start" (func $*main*/5))