(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data "0\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00d\00o\00u\00b\00l\00e\00/\00i\00n\00t\00e\00r\00n\00a\00l\00/\00r\00y\00u\00:\00r\00y\00u\00.\00m\00b\00t\00:\001\001\006\00:\003\00-\001\001\006\00:\004\005\00I\00l\00l\00e\00g\00a\00l\00A\00r\00g\00u\00m\00e\00n\00t\00E\00x\00c\00e\00p\00t\00i\00o\00n\00 \000\00.\000\00I\00n\00f\00i\00n\00i\00t\00y\00-\00N\00a\00N\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\003\006\006\00:\005\00-\003\006\006\00:\003\003\00I\00n\00v\00a\00l\00i\00d\00 \00s\00t\00a\00r\00t\00 \00i\00n\00d\00e\00x\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\004\009\001\00:\009\00-\004\009\001\00:\004\000\00i\00n\00v\00a\00l\00i\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00 \00p\00a\00i\00r\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\006\006\003\00:\005\00-\006\006\003\00:\004\004\00r\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00v\00i\00e\00w\00.\00m\00b\00t\00:\001\001\001\00:\005\00-\001\001\001\00:\003\006\00I\00n\00v\00a\00l\00i\00d\00 \00i\00n\00d\00e\00x\00 \00f\00o\00r\00 \00V\00i\00e\00w\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\000\00:\005\00-\002\009\000\00:\003\001\00C\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\0A\00\0A\00 \00 \00a\00t\00 \00A\00r\00e\00a\00 \00o\00f\00 \00r\00e\00c\00t\00a\00n\00g\00l\00e\00:\00 \00A\00r\00e\00a\00 \00o\00f\00 \00c\00i\00r\00c\00l\00e\00:\00 \00/\00:\00")
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
(type $Shape.Rectangle
 (sub final
  $moonbit.enum
  (struct
   (field  i32)
   (field  f64)
   (field  f64))))
(type $<StringView*Option<StringView>>
 (struct
  (field  (ref $StringView))
  (field  (ref null $StringView))))
(type $ReadOnlyArray<UInt64>
 (array (mut i64)))
(type $Shape.Circle
 (sub final
  $moonbit.enum
  (struct
   (field  i32)
   (field  f64))))
(type $ReadOnlyArray<UInt>
 (array (mut i32)))
(type $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok
 (sub final
  $moonbit.enum
  (struct
   (field  i32)
   (field  (ref $StringView)))))
(type $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
 (struct
  (field  i64)
  (field  i32)))
(type $@moonbitlang/core/builtin.SourceLocRepr
 (struct
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))))
(type $@moonbitlang/core/double/internal/ryu.Umul128
 (struct
  (field  i64)
  (field  i64)))
(type $<StringView*StringView>
 (struct
  (field  (ref $StringView))
  (field  (ref $StringView))))
(type $@moonbitlang/core/double/internal/ryu.Pow5Pair
 (struct
  (field  i64)
  (field  i64)))
(type $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
 (sub final
  $moonbit.enum
  (struct
   (field  i32)
   (field  (ref $moonbit.enum)))))
(type $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result
 (struct
  (field  i64)
  (field  i64)
  (field  i64)))
(type $FixedArray<UInt16>
 (array (mut i16)))
(elem
 declare
 func
 $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger
 $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger
 $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger
 $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
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
(global $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/56
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/builtin.brute_force_find.constr/70
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2
 (mut (ref null $ReadOnlyArray<UInt64>))
 (ref.null $ReadOnlyArray<UInt64>)
)
(global $moonbitlang/core/double/internal/ryu.gPOW5_INV_OFFSETS
 (mut (ref null $ReadOnlyArray<UInt>))
 (ref.null $ReadOnlyArray<UInt>)
)
(global $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2
 (mut (ref null $ReadOnlyArray<UInt64>))
 (ref.null $ReadOnlyArray<UInt64>)
)
(global $moonbitlang/core/double/internal/ryu.gPOW5_OFFSETS
 (mut (ref null $ReadOnlyArray<UInt>))
 (ref.null $ReadOnlyArray<UInt>)
)
(global $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE
 (mut (ref null $ReadOnlyArray<UInt64>))
 (ref.null $ReadOnlyArray<UInt64>)
)
(global $moonbitlang/core/double/internal/ryu.ryu_to_string.record/514
 (mut (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (ref.null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64)
)
(global $username/moonbit_examples/cmd/enums.*main.c/537
 (mut (ref null $moonbit.enum))
 (ref.null $moonbit.enum)
)
(global $username/moonbit_examples/cmd/enums.*main.r/538
 (mut (ref null $moonbit.enum))
 (ref.null $moonbit.enum)
)
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 24)
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
(global $moonbit.string.default
 (ref $moonbit.string)
 (array.new_fixed $moonbit.string 0)
)
(func $username/moonbit_examples/cmd/enums.area (param $shape/531 (ref $moonbit.enum)) (result f64)
 (local $*Circle/532 (ref $Shape.Circle))
 (local $*r/533 f64)
 (local $*Rectangle/534 (ref $Shape.Rectangle))
 (local $*w/535 f64)
 (local $*h/536 f64)
 (local $tag/791 i32)
 (if (result f64)
  (i32.eq
   (local.tee $tag/791
    (struct.get $moonbit.enum 0
     (local.get $shape/531)))
   (i32.const 0))
  (then
   (local.set $*r/533
    (struct.get $Shape.Circle 1
     (local.tee $*Circle/532
      (ref.cast (ref $Shape.Circle)
       (local.get $shape/531)))))
   (f64.mul
    (f64.mul
     (f64.const 0x1.921f9f01b866ep+1)
     (local.get $*r/533))
    (local.get $*r/533)))
  (else
   (local.set $*w/535
    (struct.get $Shape.Rectangle 1
     (local.tee $*Rectangle/534
      (ref.cast (ref $Shape.Rectangle)
       (local.get $shape/531)))))
   (local.set $*h/536
    (struct.get $Shape.Rectangle 2
     (local.get $*Rectangle/534)))
   (f64.mul
    (local.get $*w/535)
    (local.get $*h/536)))))
(func $@moonbitlang/core/builtin.Show::Double::output (param $self/530 f64) (param $logger/529 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/529)
  (call $Double::to_string
   (local.get $self/530))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/529))))
(func $Double::to_string (param $self/528 f64) (result (ref $moonbit.string))
 (call $moonbitlang/core/double/internal/ryu.ryu_to_string
  (local.get $self/528)))
(func $moonbitlang/core/double/internal/ryu.ryu_to_string (param $val/515 f64) (result (ref $moonbit.string))
 (local $bits/516 i64)
 (local $ieeeSign/517 i32)
 (local $ieeeMantissa/518 i64)
 (local $ieeeExponent/519 i32)
 (local $small/521 (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $*Some/522 (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $*f/523 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $q/525 i64)
 (local $r/526 i64)
 (local $v/520 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $x/524 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (if
  (f64.eq
   (local.get $val/515)
   (f64.const 0x0p+0))
  (then
   (call $moonbit.string_literal
    (i32.const 0)
    (i32.const 0)
    (i32.const 1))
   (return))
  (else))
 (i64.and
  (i64.shr_u
   (local.tee $bits/516
    (i64.reinterpret_f64
     (local.get $val/515)))
   (i64.extend_i32_s
    (i32.const 63)))
  (i64.const 1))
 (local.set $ieeeSign/517
  (i64.ne
   (i64.const 0)))
 (local.set $ieeeMantissa/518
  (i64.and
   (local.get $bits/516)
   (i64.const 4503599627370495)))
 (if
  (if (result i32)
   (i32.eq
    (local.tee $ieeeExponent/519
     (i32.wrap_i64
      (i64.and
       (i64.shr_u
        (local.get $bits/516)
        (i64.extend_i32_s
         (i32.const 52)))
       (i64.const 2047))))
    (i32.const 2047))
   (then
    (i32.const 1))
   (else
    (if (result i32)
     (i32.eq
      (local.get $ieeeExponent/519)
      (i32.const 0))
     (then
      (i64.eq
       (local.get $ieeeMantissa/518)
       (i64.const 0)))
     (else
      (i32.const 0)))))
  (then
   (local.get $ieeeSign/517)
   (local.get $ieeeExponent/519)
   (call $moonbitlang/core/double/internal/ryu.copy_special_str
    (i32.ne
     (i32.const 0))
    (local.get $ieeeMantissa/518)
    (i64.ne
     (i64.const 0)))
   (return))
  (else))
 (local.set $v/520
  (ref.as_non_null
   (global.get $moonbitlang/core/double/internal/ryu.ryu_to_string.record/514)))
 (if
  (ref.is_null
   (local.tee $small/521
    (call $moonbitlang/core/double/internal/ryu.d2d_small_int
     (local.get $ieeeMantissa/518)
     (local.get $ieeeExponent/519))))
  (then
   (local.set $v/520
    (call $moonbitlang/core/double/internal/ryu.d2d
     (local.get $ieeeMantissa/518)
     (local.get $ieeeExponent/519))))
  (else
   (local.set $x/524
    (local.tee $*f/523
     (ref.as_non_null
      (local.tee $*Some/522
       (local.get $small/521)))))
   (block $break:527
    (loop $loop:527
     (local.set $q/525
      (i64.div_u
       (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 0
        (local.get $x/524))
       (i64.const 10)))
     (local.tee $r/526
      (i64.sub
       (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 0
        (local.get $x/524))
       (i64.mul
        (i64.const 10)
        (local.get $q/525))))
     (if
      (i64.ne
       (i64.const 0))
      (then
       (br $break:527))
      (else))
     (local.set $x/524
      (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
       (local.get $q/525)
       (i32.add
        (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 1
         (local.get $x/524))
        (i32.const 1))))
     (br $loop:527)))
   (local.set $v/520
    (local.get $x/524))))
 (call $moonbitlang/core/double/internal/ryu.to_chars
  (local.get $v/520)
  (local.get $ieeeSign/517)))
(func $moonbitlang/core/double/internal/ryu.d2d_small_int (param $ieeeMantissa/509 i64) (param $ieeeExponent/511 i32) (result (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $m2/508 i64)
 (local $e2/510 i32)
 (local $mask/512 i64)
 (local $fraction/513 i64)
 (local.set $m2/508
  (i64.or
   (i64.const 4503599627370496)
   (local.get $ieeeMantissa/509)))
 (if
  (i32.gt_s
   (local.tee $e2/510
    (i32.sub
     (i32.sub
      (local.get $ieeeExponent/511)
      (i32.const 1023))
     (i32.const 52)))
   (i32.const 0))
  (then
   (ref.null none)
   (return))
  (else))
 (if
  (i32.lt_s
   (local.get $e2/510)
   (i32.const -52))
  (then
   (ref.null none)
   (return))
  (else))
 (local.set $mask/512
  (i64.sub
   (i64.shl
    (i64.const 1)
    (i64.extend_i32_s
     (i32.sub
      (i32.const 0)
      (local.get $e2/510))))
   (i64.const 1)))
 (local.tee $fraction/513
  (i64.and
   (local.get $m2/508)
   (local.get $mask/512)))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (ref.null none)
   (return))
  (else))
 (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
  (i64.shr_u
   (local.get $m2/508)
   (i64.extend_i32_s
    (i32.sub
     (i32.const 0)
     (local.get $e2/510))))
  (i32.const 0)))
(func $moonbitlang/core/double/internal/ryu.to_chars (param $v/482 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64)) (param $sign/480 i32) (result (ref $moonbit.string))
 (local $result/478 (ref $moonbit.bytes))
 (local $olength/483 i32)
 (local $scientificNotation/485 i32)
 (local $*end41/486 i32)
 (local $i/487 i32)
 (local $c/488 i64)
 (local $a/490 i32)
 (local $b/491 i32)
 (local $c/492 i32)
 (local $a/493 i32)
 (local $b/494 i32)
 (local $i/495 i32)
 (local $current/497 i32)
 (local $i/498 i32)
 (local $i/500 i32)
 (local $*end64/502 i32)
 (local $i/503 i32)
 (local $i/506 i32)
 (local $index/479 i32)
 (local $output/481 i64)
 (local $exp/484 i32)
 (local $current/505 i32)
 (local.set $result/478
  (array.new $moonbit.bytes
   (i32.const 0)
   (i32.const 25)))
 (local.set $index/479
  (i32.const 0))
 (if
  (local.get $sign/480)
  (then
   (array.set $moonbit.bytes
    (local.get $result/478)
    (local.get $index/479)
    (i32.const 45))
   (local.set $index/479
    (i32.add
     (local.get $index/479)
     (i32.const 1))))
  (else))
 (local.set $olength/483
  (call $moonbitlang/core/double/internal/ryu.decimal_length17
   (local.tee $output/481
    (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 0
     (local.get $v/482)))))
 (if (result (ref $moonbit.string))
  (local.tee $scientificNotation/485
   (i32.eqz
    (if (result i32)
     (i32.ge_s
      (local.tee $exp/484
       (i32.sub
        (i32.add
         (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 1
          (local.get $v/482))
         (local.get $olength/483))
        (i32.const 1)))
      (i32.const -6))
     (then
      (i32.lt_s
       (local.get $exp/484)
       (i32.const 21)))
     (else
      (i32.const 0)))))
  (then
   (local.set $*end41/486
    (i32.sub
     (local.get $olength/483)
     (i32.const 1)))
   (i32.const 0)
   (loop $loop:489 (param i32)
    (local.tee $i/487)
    (local.get $*end41/486)
    (i32.lt_s)
    (if
     (then
      (local.set $c/488
       (i64.rem_u
        (local.get $output/481)
        (i64.const 10)))
      (local.set $output/481
       (i64.div_u
        (local.get $output/481)
        (i64.const 10)))
      (array.set $moonbit.bytes
       (local.get $result/478)
       (i32.sub
        (i32.add
         (local.get $index/479)
         (local.get $olength/483))
        (local.get $i/487))
       (i32.and
        (i32.add
         (i32.const 48)
         (i32.wrap_i64
          (local.get $c/488)))
        (i32.const 255)))
      (i32.add
       (local.get $i/487)
       (i32.const 1))
      (br $loop:489))
     (else)))
   (array.set $moonbit.bytes
    (local.get $result/478)
    (local.get $index/479)
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (i32.wrap_i64
        (local.get $output/481))
       (i32.const 10)))
     (i32.const 255)))
   (if
    (i32.gt_s
     (local.get $olength/483)
     (i32.const 1))
    (then
     (array.set $moonbit.bytes
      (local.get $result/478)
      (i32.add
       (local.get $index/479)
       (i32.const 1))
      (i32.const 46)))
    (else
     (local.set $index/479
      (i32.sub
       (local.get $index/479)
       (i32.const 1)))))
   (local.set $index/479
    (i32.add
     (local.get $index/479)
     (i32.add
      (local.get $olength/483)
      (i32.const 1))))
   (array.set $moonbit.bytes
    (local.get $result/478)
    (local.get $index/479)
    (i32.const 101))
   (local.set $index/479
    (i32.add
     (local.get $index/479)
     (i32.const 1)))
   (if
    (i32.lt_s
     (local.get $exp/484)
     (i32.const 0))
    (then
     (array.set $moonbit.bytes
      (local.get $result/478)
      (local.get $index/479)
      (i32.const 45))
     (local.set $index/479
      (i32.add
       (local.get $index/479)
       (i32.const 1)))
     (local.set $exp/484
      (i32.sub
       (i32.const 0)
       (local.get $exp/484))))
    (else
     (array.set $moonbit.bytes
      (local.get $result/478)
      (local.get $index/479)
      (i32.const 43))
     (local.set $index/479
      (i32.add
       (local.get $index/479)
       (i32.const 1)))))
   (if
    (i32.ge_s
     (local.get $exp/484)
     (i32.const 100))
    (then
     (local.set $a/490
      (i32.div_s
       (local.get $exp/484)
       (i32.const 100)))
     (local.set $b/491
      (i32.rem_s
       (i32.div_s
        (local.get $exp/484)
        (i32.const 10))
       (i32.const 10)))
     (local.set $c/492
      (i32.rem_s
       (local.get $exp/484)
       (i32.const 10)))
     (array.set $moonbit.bytes
      (local.get $result/478)
      (local.get $index/479)
      (i32.and
       (i32.add
        (i32.const 48)
        (local.get $a/490))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $result/478)
      (i32.add
       (local.get $index/479)
       (i32.const 1))
      (i32.and
       (i32.add
        (i32.const 48)
        (local.get $b/491))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $result/478)
      (i32.add
       (local.get $index/479)
       (i32.const 2))
      (i32.and
       (i32.add
        (i32.const 48)
        (local.get $c/492))
       (i32.const 255)))
     (local.set $index/479
      (i32.add
       (local.get $index/479)
       (i32.const 3))))
    (else
     (if
      (i32.ge_s
       (local.get $exp/484)
       (i32.const 10))
      (then
       (local.set $a/493
        (i32.div_s
         (local.get $exp/484)
         (i32.const 10)))
       (local.set $b/494
        (i32.rem_s
         (local.get $exp/484)
         (i32.const 10)))
       (array.set $moonbit.bytes
        (local.get $result/478)
        (local.get $index/479)
        (i32.and
         (i32.add
          (i32.const 48)
          (local.get $a/493))
         (i32.const 255)))
       (array.set $moonbit.bytes
        (local.get $result/478)
        (i32.add
         (local.get $index/479)
         (i32.const 1))
        (i32.and
         (i32.add
          (i32.const 48)
          (local.get $b/494))
         (i32.const 255)))
       (local.set $index/479
        (i32.add
         (local.get $index/479)
         (i32.const 2))))
      (else
       (array.set $moonbit.bytes
        (local.get $result/478)
        (local.get $index/479)
        (i32.and
         (i32.add
          (i32.const 48)
          (local.get $exp/484))
         (i32.const 255)))
       (local.set $index/479
        (i32.add
         (local.get $index/479)
         (i32.const 1)))))))
   (call $moonbitlang/core/double/internal/ryu.string_from_bytes
    (local.get $result/478)
    (i32.const 0)
    (local.get $index/479)))
  (else
   (if
    (i32.lt_s
     (local.get $exp/484)
     (i32.const 0))
    (then
     (array.set $moonbit.bytes
      (local.get $result/478)
      (local.get $index/479)
      (i32.const 48))
     (local.set $index/479
      (i32.add
       (local.get $index/479)
       (i32.const 1)))
     (array.set $moonbit.bytes
      (local.get $result/478)
      (local.get $index/479)
      (i32.const 46))
     (local.set $index/479
      (i32.add
       (local.get $index/479)
       (i32.const 1)))
     (i32.const -1)
     (loop $loop:496 (param i32)
      (local.tee $i/495)
      (local.get $exp/484)
      (i32.gt_s)
      (if
       (then
        (array.set $moonbit.bytes
         (local.get $result/478)
         (local.get $index/479)
         (i32.const 48))
        (local.set $index/479
         (i32.add
          (local.get $index/479)
          (i32.const 1)))
        (i32.sub
         (local.get $i/495)
         (i32.const 1))
        (br $loop:496))
       (else)))
     (local.set $current/497
      (local.get $index/479))
     (i32.const 0)
     (loop $loop:499 (param i32)
      (local.tee $i/498)
      (local.get $olength/483)
      (i32.lt_s)
      (if
       (then
        (array.set $moonbit.bytes
         (local.get $result/478)
         (i32.sub
          (i32.sub
           (i32.add
            (local.get $current/497)
            (local.get $olength/483))
           (local.get $i/498))
          (i32.const 1))
         (i32.and
          (i32.add
           (i32.const 48)
           (i32.wrap_i64
            (i64.rem_u
             (local.get $output/481)
             (i64.const 10))))
          (i32.const 255)))
        (local.set $output/481
         (i64.div_u
          (local.get $output/481)
          (i64.const 10)))
        (local.set $index/479
         (i32.add
          (local.get $index/479)
          (i32.const 1)))
        (i32.add
         (local.get $i/498)
         (i32.const 1))
        (br $loop:499))
       (else))))
    (else
     (if
      (i32.ge_s
       (i32.add
        (local.get $exp/484)
        (i32.const 1))
       (local.get $olength/483))
      (then
       (i32.const 0)
       (loop $loop:501 (param i32)
        (local.tee $i/500)
        (local.get $olength/483)
        (i32.lt_s)
        (if
         (then
          (array.set $moonbit.bytes
           (local.get $result/478)
           (i32.sub
            (i32.sub
             (i32.add
              (local.get $index/479)
              (local.get $olength/483))
             (local.get $i/500))
            (i32.const 1))
           (i32.and
            (i32.add
             (i32.const 48)
             (i32.wrap_i64
              (i64.rem_u
               (local.get $output/481)
               (i64.const 10))))
            (i32.const 255)))
          (local.set $output/481
           (i64.div_u
            (local.get $output/481)
            (i64.const 10)))
          (i32.add
           (local.get $i/500)
           (i32.const 1))
          (br $loop:501))
         (else)))
       (local.set $index/479
        (i32.add
         (local.get $index/479)
         (local.get $olength/483)))
       (local.set $*end64/502
        (i32.add
         (local.get $exp/484)
         (i32.const 1)))
       (local.get $olength/483)
       (loop $loop:504 (param i32)
        (local.tee $i/503)
        (local.get $*end64/502)
        (i32.lt_s)
        (if
         (then
          (array.set $moonbit.bytes
           (local.get $result/478)
           (local.get $index/479)
           (i32.const 48))
          (local.set $index/479
           (i32.add
            (local.get $index/479)
            (i32.const 1)))
          (i32.add
           (local.get $i/503)
           (i32.const 1))
          (br $loop:504))
         (else))))
      (else
       (local.set $current/505
        (i32.add
         (local.get $index/479)
         (i32.const 1)))
       (i32.const 0)
       (loop $loop:507 (param i32)
        (local.tee $i/506)
        (local.get $olength/483)
        (i32.lt_s)
        (if
         (then
          (if
           (i32.eq
            (i32.sub
             (i32.sub
              (local.get $olength/483)
              (local.get $i/506))
             (i32.const 1))
            (local.get $exp/484))
           (then
            (array.set $moonbit.bytes
             (local.get $result/478)
             (i32.sub
              (i32.sub
               (i32.add
                (local.get $current/505)
                (local.get $olength/483))
               (local.get $i/506))
              (i32.const 1))
             (i32.const 46))
            (local.set $current/505
             (i32.sub
              (local.get $current/505)
              (i32.const 1))))
           (else))
          (array.set $moonbit.bytes
           (local.get $result/478)
           (i32.sub
            (i32.sub
             (i32.add
              (local.get $current/505)
              (local.get $olength/483))
             (local.get $i/506))
            (i32.const 1))
           (i32.and
            (i32.add
             (i32.const 48)
             (i32.wrap_i64
              (i64.rem_u
               (local.get $output/481)
               (i64.const 10))))
            (i32.const 255)))
          (local.set $output/481
           (i64.div_u
            (local.get $output/481)
            (i64.const 10)))
          (i32.add
           (local.get $i/506)
           (i32.const 1))
          (br $loop:507))
         (else)))
       (local.set $index/479
        (i32.add
         (local.get $index/479)
         (i32.add
          (local.get $olength/483)
          (i32.const 1))))))))
   (call $moonbitlang/core/double/internal/ryu.string_from_bytes
    (local.get $result/478)
    (i32.const 0)
    (local.get $index/479)))))
(func $moonbitlang/core/double/internal/ryu.d2d (param $ieeeMantissa/424 i64) (param $ieeeExponent/423 i32) (result (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $even/425 i32)
 (local $mv/426 i64)
 (local $mmShift/427 i32)
 (local $q/434 i32)
 (local $k/435 i32)
 (local $i/436 i32)
 (local $pow5/437 (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $*bind/438 (ref $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result))
 (local $*vrOut/439 i64)
 (local $*vpOut/440 i64)
 (local $*vmOut/441 i64)
 (local $mvMod5/442 i32)
 (local $q/443 i32)
 (local $i/444 i32)
 (local $k/445 i32)
 (local $j/446 i32)
 (local $pow5/447 (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $*bind/448 (ref $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result))
 (local $*vrOut/449 i64)
 (local $*vpOut/450 i64)
 (local $*vmOut/451 i64)
 (local $vpDiv10/455 i64)
 (local $vmDiv10/456 i64)
 (local $vmMod10/458 i32)
 (local $vrDiv10/459 i64)
 (local $vrMod10/460 i32)
 (local $vmDiv10/461 i64)
 (local $vmMod10/462 i32)
 (local $vpDiv10/464 i64)
 (local $vrDiv10/465 i64)
 (local $vrMod10/466 i32)
 (local $vpDiv100/468 i64)
 (local $vmDiv100/469 i64)
 (local $vrDiv100/470 i64)
 (local $vrMod100/471 i32)
 (local $vpDiv10/472 i64)
 (local $vmDiv10/473 i64)
 (local $vrDiv10/475 i64)
 (local $vrMod10/476 i32)
 (local $exp/477 i32)
 (local $*p/738 i32)
 (local $*p/741 i32)
 (local $*p/748 i32)
 (local $*p/751 i32)
 (local $*p/754 i32)
 (local $*p/763 i32)
 (local $*p/766 i32)
 (local $e2/421 i32)
 (local $m2/422 i64)
 (local $vr/428 i64)
 (local $vp/429 i64)
 (local $vm/430 i64)
 (local $e10/431 i32)
 (local $vmIsTrailingZeros/432 i32)
 (local $vrIsTrailingZeros/433 i32)
 (local $removed/452 i32)
 (local $lastRemovedDigit/453 i32)
 (local $output/454 i64)
 (local $roundUp/467 i32)
 (local.set $e2/421
  (i32.const 0))
 (local.set $m2/422
  (i64.const 0))
 (if
  (i32.eq
   (local.get $ieeeExponent/423)
   (i32.const 0))
  (then
   (local.set $e2/421
    (i32.const -1076))
   (local.set $m2/422
    (local.get $ieeeMantissa/424)))
  (else
   (local.set $e2/421
    (i32.sub
     (i32.sub
      (i32.sub
       (local.get $ieeeExponent/423)
       (i32.const 1023))
      (i32.const 52))
     (i32.const 2)))
   (local.set $m2/422
    (i64.or
     (i64.const 4503599627370496)
     (local.get $ieeeMantissa/424)))))
 (local.set $even/425
  (i64.eq
   (i64.and
    (local.get $m2/422)
    (i64.const 1))
   (i64.const 0)))
 (local.set $mv/426
  (i64.mul
   (i64.const 4)
   (local.get $m2/422)))
 (local.get $ieeeMantissa/424)
 (local.set $mmShift/427
  (if (result i32)
   (i64.ne
    (i64.const 0))
   (then
    (i32.const 1))
   (else
    (i32.le_u
     (local.get $ieeeExponent/423)
     (i32.const 1)))))
 (local.set $vr/428
  (i64.const 0))
 (local.set $vp/429
  (i64.const 0))
 (local.set $vm/430
  (i64.const 0))
 (local.set $e10/431
  (i32.const 0))
 (local.set $vmIsTrailingZeros/432
  (i32.const 0))
 (local.set $vrIsTrailingZeros/433
  (i32.const 0))
 (if
  (i32.ge_s
   (local.get $e2/421)
   (i32.const 0))
  (then
   (local.set $e10/431
    (local.tee $q/434
     (i32.sub
      (i32.shr_u
       (i32.mul
        (local.tee $*p/738
         (local.get $e2/421))
        (i32.const 78913))
       (i32.const 18))
      (if (result i32)
       (local.tee $*p/741
        (i32.gt_s
         (local.get $e2/421)
         (i32.const 3)))
       (then
        (i32.const 1))
       (else
        (i32.const 0))))))
   (local.set $k/435
    (i32.sub
     (i32.add
      (i32.const 125)
      (i32.add
       (i32.shr_u
        (i32.mul
         (local.get $q/434)
         (i32.const 1217359))
        (i32.const 19))
       (i32.const 1)))
     (i32.const 1)))
   (local.set $i/436
    (i32.add
     (i32.add
      (i32.sub
       (i32.const 0)
       (local.get $e2/421))
      (local.get $q/434))
     (local.get $k/435)))
   (local.set $pow5/437
    (call $moonbitlang/core/double/internal/ryu.double_computeInvPow5
     (local.get $q/434)))
   (local.set $*vrOut/439
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 0
     (local.tee $*bind/438
      (call $moonbitlang/core/double/internal/ryu.mulShiftAll64
       (local.get $m2/422)
       (local.get $pow5/437)
       (local.get $i/436)
       (local.get $mmShift/427)))))
   (local.set $*vpOut/440
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 1
     (local.get $*bind/438)))
   (local.set $*vmOut/441
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 2
     (local.get $*bind/438)))
   (local.set $vr/428
    (local.get $*vrOut/439))
   (local.set $vp/429
    (local.get $*vpOut/440))
   (local.set $vm/430
    (local.get $*vmOut/441))
   (if
    (i32.le_s
     (local.get $q/434)
     (i32.const 21))
    (then
     (if
      (i32.eq
       (local.tee $mvMod5/442
        (i32.sub
         (i32.wrap_i64
          (local.get $mv/426))
         (i32.mul
          (i32.const 5)
          (i32.wrap_i64
           (i64.div_u
            (local.get $mv/426)
            (i64.const 5))))))
       (i32.const 0))
      (then
       (local.set $vrIsTrailingZeros/433
        (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
         (local.get $mv/426)
         (local.get $q/434))))
      (else
       (if
        (local.get $even/425)
        (then
         (local.set $vmIsTrailingZeros/432
          (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
           (i64.sub
            (i64.sub
             (local.get $mv/426)
             (i64.const 1))
            (if (result i64)
             (local.get $mmShift/427)
             (then
              (i64.const 1))
             (else
              (i64.const 0))))
           (local.get $q/434))))
        (else
         (local.set $vp/429
          (i64.sub
           (local.get $vp/429)
           (if (result i64)
            (local.tee $*p/748
             (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
              (i64.add
               (local.get $mv/426)
               (i64.const 2))
              (local.get $q/434)))
            (then
             (i64.const 1))
            (else
             (i64.const 0))))))))))
    (else)))
  (else
   (local.set $e10/431
    (i32.add
     (local.tee $q/443
      (i32.sub
       (i32.shr_u
        (i32.mul
         (local.tee $*p/751
          (i32.sub
           (i32.const 0)
           (local.get $e2/421)))
         (i32.const 732923))
        (i32.const 20))
       (if (result i32)
        (local.tee $*p/754
         (i32.gt_s
          (i32.sub
           (i32.const 0)
           (local.get $e2/421))
          (i32.const 1)))
        (then
         (i32.const 1))
        (else
         (i32.const 0)))))
     (local.get $e2/421)))
   (local.set $k/445
    (i32.sub
     (i32.add
      (i32.shr_u
       (i32.mul
        (local.tee $i/444
         (i32.sub
          (i32.sub
           (i32.const 0)
           (local.get $e2/421))
          (local.get $q/443)))
        (i32.const 1217359))
       (i32.const 19))
      (i32.const 1))
     (i32.const 125)))
   (local.set $j/446
    (i32.sub
     (local.get $q/443)
     (local.get $k/445)))
   (local.set $pow5/447
    (call $moonbitlang/core/double/internal/ryu.double_computePow5
     (local.get $i/444)))
   (local.set $*vrOut/449
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 0
     (local.tee $*bind/448
      (call $moonbitlang/core/double/internal/ryu.mulShiftAll64
       (local.get $m2/422)
       (local.get $pow5/447)
       (local.get $j/446)
       (local.get $mmShift/427)))))
   (local.set $*vpOut/450
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 1
     (local.get $*bind/448)))
   (local.set $*vmOut/451
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 2
     (local.get $*bind/448)))
   (local.set $vr/428
    (local.get $*vrOut/449))
   (local.set $vp/429
    (local.get $*vpOut/450))
   (local.set $vm/430
    (local.get $*vmOut/451))
   (if
    (i32.le_s
     (local.get $q/443)
     (i32.const 1))
    (then
     (local.set $vrIsTrailingZeros/433
      (i32.const 1))
     (if
      (local.get $even/425)
      (then
       (local.set $vmIsTrailingZeros/432
        (i32.eq
         (if (result i32)
          (local.get $mmShift/427)
          (then
           (i32.const 1))
          (else
           (i32.const 0)))
         (i32.const 1))))
      (else
       (local.set $vp/429
        (i64.sub
         (local.get $vp/429)
         (i64.const 1))))))
    (else
     (if
      (i32.lt_s
       (local.get $q/443)
       (i32.const 63))
      (then
       (local.set $vrIsTrailingZeros/433
        (i64.eq
         (i64.and
          (local.get $mv/426)
          (i64.sub
           (i64.shl
            (i64.const 1)
            (i64.extend_i32_s
             (local.get $q/443)))
           (i64.const 1)))
         (i64.const 0))))
      (else))))))
 (local.set $removed/452
  (i32.const 0))
 (local.set $lastRemovedDigit/453
  (i32.const 0))
 (local.set $output/454
  (i64.const 0))
 (if
  (if (result i32)
   (local.get $vmIsTrailingZeros/432)
   (then
    (i32.const 1))
   (else
    (local.get $vrIsTrailingZeros/433)))
  (then
   (block $break:457
    (loop $loop:457
     (local.set $vpDiv10/455
      (i64.div_u
       (local.get $vp/429)
       (i64.const 10)))
     (local.set $vmDiv10/456
      (i64.div_u
       (local.get $vm/430)
       (i64.const 10)))
     (if
      (i64.le_u
       (local.get $vpDiv10/455)
       (local.get $vmDiv10/456))
      (then
       (br $break:457))
      (else))
     (local.set $vmMod10/458
      (i32.sub
       (i32.wrap_i64
        (local.get $vm/430))
       (i32.mul
        (i32.const 10)
        (i32.wrap_i64
         (local.get $vmDiv10/456)))))
     (local.set $vrDiv10/459
      (i64.div_u
       (local.get $vr/428)
       (i64.const 10)))
     (local.set $vrMod10/460
      (i32.sub
       (i32.wrap_i64
        (local.get $vr/428))
       (i32.mul
        (i32.const 10)
        (i32.wrap_i64
         (local.get $vrDiv10/459)))))
     (local.set $vmIsTrailingZeros/432
      (if (result i32)
       (local.get $vmIsTrailingZeros/432)
       (then
        (i32.eq
         (local.get $vmMod10/458)
         (i32.const 0)))
       (else
        (i32.const 0))))
     (local.set $vrIsTrailingZeros/433
      (if (result i32)
       (local.get $vrIsTrailingZeros/433)
       (then
        (i32.eq
         (local.get $lastRemovedDigit/453)
         (i32.const 0)))
       (else
        (i32.const 0))))
     (local.set $lastRemovedDigit/453
      (local.get $vrMod10/460))
     (local.set $vr/428
      (local.get $vrDiv10/459))
     (local.set $vp/429
      (local.get $vpDiv10/455))
     (local.set $vm/430
      (local.get $vmDiv10/456))
     (local.set $removed/452
      (i32.add
       (local.get $removed/452)
       (i32.const 1)))
     (br $loop:457)))
   (if
    (local.get $vmIsTrailingZeros/432)
    (then
     (block $break:463
      (loop $loop:463
       (local.set $vmDiv10/461
        (i64.div_u
         (local.get $vm/430)
         (i64.const 10)))
       (local.tee $vmMod10/462
        (i32.sub
         (i32.wrap_i64
          (local.get $vm/430))
         (i32.mul
          (i32.const 10)
          (i32.wrap_i64
           (local.get $vmDiv10/461)))))
       (if
        (i32.ne
         (i32.const 0))
        (then
         (br $break:463))
        (else))
       (local.set $vpDiv10/464
        (i64.div_u
         (local.get $vp/429)
         (i64.const 10)))
       (local.set $vrDiv10/465
        (i64.div_u
         (local.get $vr/428)
         (i64.const 10)))
       (local.set $vrMod10/466
        (i32.sub
         (i32.wrap_i64
          (local.get $vr/428))
         (i32.mul
          (i32.const 10)
          (i32.wrap_i64
           (local.get $vrDiv10/465)))))
       (local.set $vrIsTrailingZeros/433
        (if (result i32)
         (local.get $vrIsTrailingZeros/433)
         (then
          (i32.eq
           (local.get $lastRemovedDigit/453)
           (i32.const 0)))
         (else
          (i32.const 0))))
       (local.set $lastRemovedDigit/453
        (local.get $vrMod10/466))
       (local.set $vr/428
        (local.get $vrDiv10/465))
       (local.set $vp/429
        (local.get $vpDiv10/464))
       (local.set $vm/430
        (local.get $vmDiv10/461))
       (local.set $removed/452
        (i32.add
         (local.get $removed/452)
         (i32.const 1)))
       (br $loop:463))))
    (else))
   (if
    (if (result i32)
     (local.get $vrIsTrailingZeros/433)
     (then
      (if (result i32)
       (i32.eq
        (local.get $lastRemovedDigit/453)
        (i32.const 5))
       (then
        (i64.eq
         (i64.rem_u
          (local.get $vr/428)
          (i64.const 2))
         (i64.const 0)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (local.set $lastRemovedDigit/453
      (i32.const 4)))
    (else))
   (local.set $output/454
    (i64.add
     (local.get $vr/428)
     (if (result i64)
      (local.tee $*p/763
       (if (result i32)
        (if (result i32)
         (i64.eq
          (local.get $vr/428)
          (local.get $vm/430))
         (then
          (if (result i32)
           (i32.eqz
            (local.get $even/425))
           (then
            (i32.const 1))
           (else
            (i32.eqz
             (local.get $vmIsTrailingZeros/432)))))
         (else
          (i32.const 0)))
        (then
         (i32.const 1))
        (else
         (i32.ge_s
          (local.get $lastRemovedDigit/453)
          (i32.const 5)))))
      (then
       (i64.const 1))
      (else
       (i64.const 0))))))
  (else
   (local.set $roundUp/467
    (i32.const 0))
   (local.set $vpDiv100/468
    (i64.div_u
     (local.get $vp/429)
     (i64.const 100)))
   (local.set $vmDiv100/469
    (i64.div_u
     (local.get $vm/430)
     (i64.const 100)))
   (if
    (i64.gt_u
     (local.get $vpDiv100/468)
     (local.get $vmDiv100/469))
    (then
     (local.set $vrDiv100/470
      (i64.div_u
       (local.get $vr/428)
       (i64.const 100)))
     (local.set $roundUp/467
      (i32.ge_s
       (local.tee $vrMod100/471
        (i32.sub
         (i32.wrap_i64
          (local.get $vr/428))
         (i32.mul
          (i32.const 100)
          (i32.wrap_i64
           (local.get $vrDiv100/470)))))
       (i32.const 50)))
     (local.set $vr/428
      (local.get $vrDiv100/470))
     (local.set $vp/429
      (local.get $vpDiv100/468))
     (local.set $vm/430
      (local.get $vmDiv100/469))
     (local.set $removed/452
      (i32.add
       (local.get $removed/452)
       (i32.const 2))))
    (else))
   (block $break:474
    (loop $loop:474
     (local.set $vpDiv10/472
      (i64.div_u
       (local.get $vp/429)
       (i64.const 10)))
     (local.set $vmDiv10/473
      (i64.div_u
       (local.get $vm/430)
       (i64.const 10)))
     (if
      (i64.le_u
       (local.get $vpDiv10/472)
       (local.get $vmDiv10/473))
      (then
       (br $break:474))
      (else))
     (local.set $vrDiv10/475
      (i64.div_u
       (local.get $vr/428)
       (i64.const 10)))
     (local.set $roundUp/467
      (i32.ge_s
       (local.tee $vrMod10/476
        (i32.sub
         (i32.wrap_i64
          (local.get $vr/428))
         (i32.mul
          (i32.const 10)
          (i32.wrap_i64
           (local.get $vrDiv10/475)))))
       (i32.const 5)))
     (local.set $vr/428
      (local.get $vrDiv10/475))
     (local.set $vp/429
      (local.get $vpDiv10/472))
     (local.set $vm/430
      (local.get $vmDiv10/473))
     (local.set $removed/452
      (i32.add
       (local.get $removed/452)
       (i32.const 1)))
     (br $loop:474)))
   (local.set $output/454
    (i64.add
     (local.get $vr/428)
     (if (result i64)
      (local.tee $*p/766
       (if (result i32)
        (i64.eq
         (local.get $vr/428)
         (local.get $vm/430))
        (then
         (i32.const 1))
        (else
         (local.get $roundUp/467))))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))))
 (local.set $exp/477
  (i32.add
   (local.get $e10/431)
   (local.get $removed/452)))
 (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
  (local.get $output/454)
  (local.get $exp/477)))
(func $moonbitlang/core/double/internal/ryu.decimal_length17 (param $v/420 i64) (result i32)
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000000000000))
  (then
   (i32.const 17)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000000000000))
  (then
   (i32.const 16)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000000000000))
  (then
   (i32.const 15)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000000000))
  (then
   (i32.const 14)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000000000))
  (then
   (i32.const 13)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000000000))
  (then
   (i32.const 12)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000000))
  (then
   (i32.const 11)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000000))
  (then
   (i32.const 10)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000000))
  (then
   (i32.const 9)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000))
  (then
   (i32.const 8)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000))
  (then
   (i32.const 7)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000))
  (then
   (i32.const 6)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000))
  (then
   (i32.const 5)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000))
  (then
   (i32.const 4)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100))
  (then
   (i32.const 3)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10))
  (then
   (i32.const 2)
   (return))
  (else))
 (i32.const 1))
(func $moonbitlang/core/double/internal/ryu.double_computeInvPow5 (param $i/403 i32) (result (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $base/402 i32)
 (local $base2/404 i32)
 (local $offset/405 i32)
 (local $mul0/406 i64)
 (local $mul1/407 i64)
 (local $m/408 i64)
 (local $*bind/409 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low1/410 i64)
 (local $*high1/411 i64)
 (local $*bind/412 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low0/413 i64)
 (local $*high0/414 i64)
 (local $sum/415 i64)
 (local $delta/417 i32)
 (local $a/418 i64)
 (local $b/419 i64)
 (local $*p/715 i32)
 (local $*p/718 i32)
 (local $*p/729 i32)
 (local $*p/732 i32)
 (local $*p/735 i64)
 (local $high1/416 i64)
 (local.set $offset/405
  (i32.sub
   (local.tee $base2/404
    (i32.mul
     (local.tee $base/402
      (i32.div_s
       (i32.sub
        (i32.add
         (local.get $i/403)
         (i32.const 26))
        (i32.const 1))
       (i32.const 26)))
     (i32.const 26)))
   (local.get $i/403)))
 (local.set $*p/715
  (i32.mul
   (local.get $base/402)
   (i32.const 2)))
 (local.set $mul0/406
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
   (local.get $*p/715)))
 (local.set $*p/718
  (i32.add
   (i32.mul
    (local.get $base/402)
    (i32.const 2))
   (i32.const 1)))
 (local.set $mul1/407
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
   (local.get $*p/718)))
 (if
  (i32.eq
   (local.get $offset/405)
   (i32.const 0))
  (then
   (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
    (local.get $mul0/406)
    (local.get $mul1/407))
   (return))
  (else))
 (local.set $*low1/410
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/409
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.tee $m/408
      (array.get $ReadOnlyArray<UInt64>
       (ref.as_non_null
        (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
       (local.get $offset/405)))
     (local.get $mul1/407)))))
 (local.set $*high1/411
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/409)))
 (local.set $*low0/413
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/412
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.get $m/408)
     (local.get $mul0/406)))))
 (local.set $sum/415
  (i64.add
   (local.tee $*high0/414
    (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
     (local.get $*bind/412)))
   (local.get $*low1/410)))
 (local.set $high1/416
  (local.get $*high1/411))
 (if
  (i64.lt_u
   (local.get $sum/415)
   (local.get $*high0/414))
  (then
   (local.set $high1/416
    (i64.add
     (local.get $high1/416)
     (i64.const 1))))
  (else))
 (local.set $delta/417
  (i32.sub
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $base2/404)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $i/403)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))))
 (i64.add
  (i64.or
   (i64.shl
    (local.get $sum/415)
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $delta/417))))
   (i64.shr_u
    (local.get $*low0/413)
    (i64.extend_i32_s
     (local.get $delta/417))))
  (i64.const 1))
 (local.set $*p/729
  (i32.div_s
   (local.get $i/403)
   (i32.const 16)))
 (i64.extend_i32_u
  (local.tee $*p/732
   (i32.and
    (i32.shr_u
     (array.get $ReadOnlyArray<UInt>
      (ref.as_non_null
       (global.get $moonbitlang/core/double/internal/ryu.gPOW5_INV_OFFSETS))
      (local.get $*p/729))
     (i32.shl
      (i32.rem_s
       (local.get $i/403)
       (i32.const 16))
      (i32.const 1)))
    (i32.const 3))))
 (i64.add)
 (local.set $a/418)
 (local.set $b/419
  (i64.or
   (i64.shl
    (local.tee $*p/735
     (local.get $high1/416))
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $delta/417))))
   (i64.shr_u
    (local.get $sum/415)
    (i64.extend_i32_s
     (local.get $delta/417)))))
 (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
  (local.get $a/418)
  (local.get $b/419)))
(func $moonbitlang/core/double/internal/ryu.double_computePow5 (param $i/385 i32) (result (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $base/384 i32)
 (local $base2/386 i32)
 (local $offset/387 i32)
 (local $mul0/388 i64)
 (local $mul1/389 i64)
 (local $m/390 i64)
 (local $*bind/391 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low1/392 i64)
 (local $*high1/393 i64)
 (local $*bind/394 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low0/395 i64)
 (local $*high0/396 i64)
 (local $sum/397 i64)
 (local $delta/399 i32)
 (local $a/400 i64)
 (local $b/401 i64)
 (local $*p/692 i32)
 (local $*p/695 i32)
 (local $*p/706 i32)
 (local $*p/709 i32)
 (local $*p/712 i64)
 (local $high1/398 i64)
 (local.set $base2/386
  (i32.mul
   (local.tee $base/384
    (i32.div_s
     (local.get $i/385)
     (i32.const 26)))
   (i32.const 26)))
 (local.set $offset/387
  (i32.sub
   (local.get $i/385)
   (local.get $base2/386)))
 (local.set $*p/692
  (i32.mul
   (local.get $base/384)
   (i32.const 2)))
 (local.set $mul0/388
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
   (local.get $*p/692)))
 (local.set $*p/695
  (i32.add
   (i32.mul
    (local.get $base/384)
    (i32.const 2))
   (i32.const 1)))
 (local.set $mul1/389
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
   (local.get $*p/695)))
 (if
  (i32.eq
   (local.get $offset/387)
   (i32.const 0))
  (then
   (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
    (local.get $mul0/388)
    (local.get $mul1/389))
   (return))
  (else))
 (local.set $*low1/392
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/391
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.tee $m/390
      (array.get $ReadOnlyArray<UInt64>
       (ref.as_non_null
        (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
       (local.get $offset/387)))
     (local.get $mul1/389)))))
 (local.set $*high1/393
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/391)))
 (local.set $*low0/395
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/394
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.get $m/390)
     (local.get $mul0/388)))))
 (local.set $sum/397
  (i64.add
   (local.tee $*high0/396
    (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
     (local.get $*bind/394)))
   (local.get $*low1/392)))
 (local.set $high1/398
  (local.get $*high1/393))
 (if
  (i64.lt_u
   (local.get $sum/397)
   (local.get $*high0/396))
  (then
   (local.set $high1/398
    (i64.add
     (local.get $high1/398)
     (i64.const 1))))
  (else))
 (local.set $delta/399
  (i32.sub
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $i/385)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $base2/386)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))))
 (i64.or
  (i64.shl
   (local.get $sum/397)
   (i64.extend_i32_s
    (i32.sub
     (i32.const 64)
     (local.get $delta/399))))
  (i64.shr_u
   (local.get $*low0/395)
   (i64.extend_i32_s
    (local.get $delta/399))))
 (local.set $*p/706
  (i32.div_s
   (local.get $i/385)
   (i32.const 16)))
 (i64.extend_i32_u
  (local.tee $*p/709
   (i32.and
    (i32.shr_u
     (array.get $ReadOnlyArray<UInt>
      (ref.as_non_null
       (global.get $moonbitlang/core/double/internal/ryu.gPOW5_OFFSETS))
      (local.get $*p/706))
     (i32.shl
      (i32.rem_s
       (local.get $i/385)
       (i32.const 16))
      (i32.const 1)))
    (i32.const 3))))
 (i64.add)
 (local.set $a/400)
 (local.set $b/401
  (i64.or
   (i64.shl
    (local.tee $*p/712
     (local.get $high1/398))
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $delta/399))))
   (i64.shr_u
    (local.get $sum/397)
    (i64.extend_i32_s
     (local.get $delta/399)))))
 (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
  (local.get $a/400)
  (local.get $b/401)))
(func $moonbitlang/core/double/internal/ryu.mulShiftAll64 (param $m/358 i64) (param $mul/355 (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair)) (param $j/371 i32) (param $mmShift/373 i32) (result (ref $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result))
 (local $*mul0/354 i64)
 (local $*mul1/356 i64)
 (local $m/357 i64)
 (local $*bind/359 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*lo/360 i64)
 (local $*tmp/361 i64)
 (local $*bind/362 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*lo2/363 i64)
 (local $*hi2/364 i64)
 (local $mid/365 i64)
 (local $hi/366 i64)
 (local $lo2/367 i64)
 (local $mid2/368 i64)
 (local $hi2/369 i64)
 (local $vp/370 i64)
 (local $lo3/374 i64)
 (local $mid3/375 i64)
 (local $hi3/376 i64)
 (local $lo3/377 i64)
 (local $mid3/378 i64)
 (local $hi3/379 i64)
 (local $lo4/380 i64)
 (local $mid4/381 i64)
 (local $hi4/382 i64)
 (local $vr/383 i64)
 (local $*p/680 i32)
 (local $*p/683 i32)
 (local $*p/686 i32)
 (local $*p/689 i32)
 (local $vm/372 i64)
 (local.set $*mul0/354
  (struct.get $@moonbitlang/core/double/internal/ryu.Pow5Pair 0
   (local.get $mul/355)))
 (local.set $*mul1/356
  (struct.get $@moonbitlang/core/double/internal/ryu.Pow5Pair 1
   (local.get $mul/355)))
 (local.set $*lo/360
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/359
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.tee $m/357
      (i64.shl
       (local.get $m/358)
       (i64.extend_i32_s
        (i32.const 1))))
     (local.get $*mul0/354)))))
 (local.set $*tmp/361
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/359)))
 (local.set $*lo2/363
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/362
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.get $m/357)
     (local.get $*mul1/356)))))
 (local.set $*hi2/364
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/362)))
 (local.set $mid/365
  (i64.add
   (local.get $*tmp/361)
   (local.get $*lo2/363)))
 (local.set $hi/366
  (i64.add
   (local.get $*hi2/364)
   (if (result i64)
    (i64.lt_u
     (local.get $mid/365)
     (local.get $*tmp/361))
    (then
     (i64.const 1))
    (else
     (i64.const 0)))))
 (local.set $lo2/367
  (i64.add
   (local.get $*lo/360)
   (local.get $*mul0/354)))
 (local.set $mid2/368
  (i64.add
   (i64.add
    (local.get $mid/365)
    (local.get $*mul1/356))
   (if (result i64)
    (i64.lt_u
     (local.get $lo2/367)
     (local.get $*lo/360))
    (then
     (i64.const 1))
    (else
     (i64.const 0)))))
 (local.set $hi2/369
  (i64.add
   (local.get $hi/366)
   (if (result i64)
    (i64.lt_u
     (local.get $mid2/368)
     (local.get $mid/365))
    (then
     (i64.const 1))
    (else
     (i64.const 0)))))
 (local.set $*p/680
  (i32.sub
   (i32.sub
    (local.get $j/371)
    (i32.const 64))
   (i32.const 1)))
 (local.set $vp/370
  (i64.or
   (i64.shl
    (local.get $hi2/369)
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $*p/680))))
   (i64.shr_u
    (local.get $mid2/368)
    (i64.extend_i32_s
     (local.get $*p/680)))))
 (local.set $vm/372
  (i64.const 0))
 (if
  (local.get $mmShift/373)
  (then
   (local.set $lo3/374
    (i64.sub
     (local.get $*lo/360)
     (local.get $*mul0/354)))
   (local.set $mid3/375
    (i64.sub
     (i64.sub
      (local.get $mid/365)
      (local.get $*mul1/356))
     (if (result i64)
      (i64.lt_u
       (local.get $*lo/360)
       (local.get $lo3/374))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $hi3/376
    (i64.sub
     (local.get $hi/366)
     (if (result i64)
      (i64.lt_u
       (local.get $mid/365)
       (local.get $mid3/375))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $*p/683
    (i32.sub
     (i32.sub
      (local.get $j/371)
      (i32.const 64))
     (i32.const 1)))
   (local.set $vm/372
    (i64.or
     (i64.shl
      (local.get $hi3/376)
      (i64.extend_i32_s
       (i32.sub
        (i32.const 64)
        (local.get $*p/683))))
     (i64.shr_u
      (local.get $mid3/375)
      (i64.extend_i32_s
       (local.get $*p/683))))))
  (else
   (local.set $lo3/377
    (i64.add
     (local.get $*lo/360)
     (local.get $*lo/360)))
   (local.set $mid3/378
    (i64.add
     (i64.add
      (local.get $mid/365)
      (local.get $mid/365))
     (if (result i64)
      (i64.lt_u
       (local.get $lo3/377)
       (local.get $*lo/360))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $hi3/379
    (i64.add
     (i64.add
      (local.get $hi/366)
      (local.get $hi/366))
     (if (result i64)
      (i64.lt_u
       (local.get $mid3/378)
       (local.get $mid/365))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $lo4/380
    (i64.sub
     (local.get $lo3/377)
     (local.get $*mul0/354)))
   (local.set $mid4/381
    (i64.sub
     (i64.sub
      (local.get $mid3/378)
      (local.get $*mul1/356))
     (if (result i64)
      (i64.lt_u
       (local.get $lo3/377)
       (local.get $lo4/380))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $hi4/382
    (i64.sub
     (local.get $hi3/379)
     (if (result i64)
      (i64.lt_u
       (local.get $mid3/378)
       (local.get $mid4/381))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $*p/686
    (i32.sub
     (local.get $j/371)
     (i32.const 64)))
   (local.set $vm/372
    (i64.or
     (i64.shl
      (local.get $hi4/382)
      (i64.extend_i32_s
       (i32.sub
        (i32.const 64)
        (local.get $*p/686))))
     (i64.shr_u
      (local.get $mid4/381)
      (i64.extend_i32_s
       (local.get $*p/686)))))))
 (local.set $*p/689
  (i32.sub
   (i32.sub
    (local.get $j/371)
    (i32.const 64))
   (i32.const 1)))
 (struct.new $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result
  (local.tee $vr/383
   (i64.or
    (i64.shl
     (local.get $hi/366)
     (i64.extend_i32_s
      (i32.sub
       (i32.const 64)
       (local.get $*p/689))))
    (i64.shr_u
     (local.get $mid/365)
     (i64.extend_i32_s
      (local.get $*p/689)))))
  (local.get $vp/370)
  (local.get $vm/372)))
(func $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5 (param $value/350 i64) (param $p/351 i32) (result i32)
 (i32.ge_s
  (call $moonbitlang/core/double/internal/ryu.pow5Factor
   (local.get $value/350))
  (local.get $p/351)))
(func $moonbitlang/core/double/internal/ryu.pow5Factor (param $value/346 i64) (result i32)
 (local $count/347 i32)
 (local $value/348 i64)
 (i64.rem_u
  (local.get $value/346)
  (i64.const 5))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 0)
   (return))
  (else))
 (i64.rem_u
  (local.get $value/346)
  (i64.const 25))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (i64.rem_u
  (local.get $value/346)
  (i64.const 125))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 2)
   (return))
  (else))
 (i64.rem_u
  (local.get $value/346)
  (i64.const 625))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 3)
   (return))
  (else))
 (local.set $count/347
  (i32.const 4))
 (local.set $value/348
  (i64.div_u
   (local.get $value/346)
   (i64.const 625)))
 (loop $loop:349
  (if
   (i64.gt_u
    (local.get $value/348)
    (i64.const 0))
   (then
    (i64.rem_u
     (local.get $value/348)
     (i64.const 5))
    (if
     (i64.ne
      (i64.const 0))
     (then
      (local.get $count/347)
      (return))
     (else))
    (local.set $value/348
     (i64.div_u
      (local.get $value/348)
      (i64.const 5)))
    (local.set $count/347
     (i32.add
      (local.get $count/347)
      (i32.const 1)))
    (br $loop:349))
   (else)))
 (call $moonbitlang/core/builtin.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.string_literal
    (i32.const 2)
    (i32.const 118)
    (i32.const 25))
   (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|UInt64|
    (local.get $value/348)))
  (call $moonbit.string_literal
   (i32.const 1)
   (i32.const 2)
   (i32.const 58))))
(func $moonbitlang/core/double/internal/ryu.umul128 (param $a/333 i64) (param $b/336 i64) (result (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $aLo/332 i64)
 (local $aHi/334 i64)
 (local $bLo/335 i64)
 (local $bHi/337 i64)
 (local $x/338 i64)
 (local $y/339 i64)
 (local $z/340 i64)
 (local $w/341 i64)
 (local $lo/342 i64)
 (local.set $aLo/332
  (i64.and
   (local.get $a/333)
   (i64.const 4294967295)))
 (local.set $aHi/334
  (i64.shr_u
   (local.get $a/333)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $bLo/335
  (i64.and
   (local.get $b/336)
   (i64.const 4294967295)))
 (local.set $bHi/337
  (i64.shr_u
   (local.get $b/336)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $x/338
  (i64.mul
   (local.get $aLo/332)
   (local.get $bLo/335)))
 (local.set $y/339
  (i64.add
   (i64.mul
    (local.get $aHi/334)
    (local.get $bLo/335))
   (i64.shr_u
    (local.get $x/338)
    (i64.extend_i32_s
     (i32.const 32)))))
 (local.set $z/340
  (i64.add
   (i64.mul
    (local.get $aLo/332)
    (local.get $bHi/337))
   (i64.and
    (local.get $y/339)
    (i64.const 4294967295))))
 (local.set $w/341
  (i64.add
   (i64.add
    (i64.mul
     (local.get $aHi/334)
     (local.get $bHi/337))
    (i64.shr_u
     (local.get $y/339)
     (i64.extend_i32_s
      (i32.const 32))))
   (i64.shr_u
    (local.get $z/340)
    (i64.extend_i32_s
     (i32.const 32)))))
 (struct.new $@moonbitlang/core/double/internal/ryu.Umul128
  (local.tee $lo/342
   (i64.mul
    (local.get $a/333)
    (local.get $b/336)))
  (local.get $w/341)))
(func $moonbitlang/core/double/internal/ryu.string_from_bytes (param $bytes/327 (ref $moonbit.bytes)) (param $from/331 i32) (param $to/329 i32) (result (ref $moonbit.string))
 (local $buf/326 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $i/328 i32)
 (local $*p/677 i32)
 (local.set $buf/326
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (array.len
    (local.get $bytes/327))))
 (local.get $from/331)
 (loop $loop:330 (param i32)
  (local.tee $i/328)
  (local.get $to/329)
  (i32.lt_s)
  (if
   (then
    (drop
     (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
      (local.get $buf/326)
      (local.tee $*p/677
       (array.get_u $moonbit.bytes
        (local.get $bytes/327)
        (local.get $i/328)))))
    (i32.add
     (local.get $i/328)
     (i32.const 1))
    (br $loop:330))
   (else)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $buf/326)))
(func $moonbitlang/core/double/internal/ryu.copy_special_str (param $sign/322 i32) (param $exponent/323 i32) (param $mantissa/320 i32) (result (ref $moonbit.string))
 (local $s/321 (ref $moonbit.string))
 (if
  (local.get $mantissa/320)
  (then
   (call $moonbit.string_literal
    (i32.const 6)
    (i32.const 192)
    (i32.const 3))
   (return))
  (else))
 (local.set $s/321
  (if (result (ref $moonbit.string))
   (local.get $sign/322)
   (then
    (call $moonbit.string_literal
     (i32.const 5)
     (i32.const 190)
     (i32.const 1)))
   (else
    (global.get $moonbit.string.default))))
 (if
  (local.get $exponent/323)
  (then
   (call $moonbit.add_string
    (local.get $s/321)
    (call $moonbit.string_literal
     (i32.const 4)
     (i32.const 174)
     (i32.const 8)))
   (return))
  (else))
 (call $moonbit.add_string
  (local.get $s/321)
  (call $moonbit.string_literal
   (i32.const 3)
   (i32.const 168)
   (i32.const 3))))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/317 (ref $moonbit.string)) (param $logger/318 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (call $@moonbitlang/core/builtin.SourceLocRepr::parse
   (local.get $self/317))
  (local.get $logger/318)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/303 (ref $@moonbitlang/core/builtin.SourceLocRepr)) (param $logger/316 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (local $pkg/302 (ref $StringView))
 (local $*bind/304 i64)
 (local $*bind/305 (ref $<StringView*Option<StringView>>))
 (local $*Some/306 i64)
 (local $*first_slash/307 i32)
 (local $*bind/308 i64)
 (local $*Some/309 i64)
 (local $*second_slash/310 i32)
 (local $module_name_end/311 i32)
 (local $*module_name/312 (ref $StringView))
 (local $*package_name/313 (ref null $StringView))
 (local $*Some/314 (ref null $StringView))
 (local $*pkg_name/315 (ref $StringView))
 (local $*bind/789 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/790 (ref $@moonbitlang/core/builtin.Logger))
 (local.set $*module_name/312
  (struct.get $<StringView*Option<StringView>> 0
   (local.tee $*bind/305
    (if (result (ref $<StringView*Option<StringView>>))
     (i64.eq
      (local.tee $*bind/304
       (call $StringView::find
        (local.tee $pkg/302
         (struct.get $@moonbitlang/core/builtin.SourceLocRepr 0
          (local.get $self/303)))
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
       (local.get $pkg/302)
       (ref.null none)))
     (else
      (local.set $*first_slash/307
       (i32.wrap_i64
        (local.tee $*Some/306
         (local.get $*bind/304))))
      (if (result (ref $<StringView*Option<StringView>>))
       (i64.eq
        (local.tee $*bind/308
         (call $StringView::find
          (call $StringView::view.inner
           (local.get $pkg/302)
           (i32.add
            (local.get $*first_slash/307)
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
         (local.get $pkg/302)
         (ref.null none)))
       (else
        (local.set $*second_slash/310
         (i32.wrap_i64
          (local.tee $*Some/309
           (local.get $*bind/308))))
        (local.set $module_name_end/311
         (i32.add
          (i32.add
           (local.get $*first_slash/307)
           (i32.const 1))
          (local.get $*second_slash/310)))
        (struct.new $<StringView*Option<StringView>>
         (call $StringView::view.inner
          (local.get $pkg/302)
          (i32.const 0)
          (i64.extend_i32_s
           (local.get $module_name_end/311)))
         (call $StringView::view.inner
          (local.get $pkg/302)
          (i32.add
           (local.get $module_name_end/311)
           (i32.const 1))
          (i64.const 4294967296))))))))))
 (if
  (ref.is_null
   (local.tee $*package_name/313
    (struct.get $<StringView*Option<StringView>> 1
     (local.get $*bind/305))))
  (then)
  (else
   (local.set $*pkg_name/315
    (ref.as_non_null
     (local.tee $*Some/314
      (local.get $*package_name/313))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_2
     (local.get $logger/316)
     (local.get $*pkg_name/315)
     (struct.get $@moonbitlang/core/builtin.Logger 2
      (local.get $logger/316))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_3
     (local.tee $*bind/789
      (local.get $logger/316))
     (i32.const 47)
     (struct.get $@moonbitlang/core/builtin.Logger 3
      (local.get $*bind/789))))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/316)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 1
    (local.get $self/303))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/316)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/316)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 2
    (local.get $self/303))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/316)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/316)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 3
    (local.get $self/303))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/316)
   (i32.const 45)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/316)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 4
    (local.get $self/303))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/316)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/316)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 5
    (local.get $self/303))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/316))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/316)
   (i32.const 64)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/316))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_2
  (local.tee $*bind/790
   (local.get $logger/316))
  (local.get $*module_name/312)
  (struct.get $@moonbitlang/core/builtin.Logger 2
   (local.get $*bind/790))))
(func $moonbitlang/core/builtin.println|String| (param $input/298 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/298))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::UInt64::output (param $self/291 i64) (param $logger/290 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/290)
  (call $UInt64::to_string.inner
   (local.get $self/291)
   (i32.const 10))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/290))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/288 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/289 (ref $StringView)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/288)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/288))
    (i32.mul
     (i32.sub
      (struct.get $StringView 2
       (local.get $str/289))
      (struct.get $StringView 1
       (local.get $str/289)))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/288))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/288))
   (struct.get $StringView 0
    (local.get $str/289))
   (struct.get $StringView 1
    (local.get $str/289))
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/289))
    (struct.get $StringView 1
     (local.get $str/289)))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/288)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/288))
   (i32.mul
    (i32.sub
     (struct.get $StringView 2
      (local.get $str/289))
     (struct.get $StringView 1
      (local.get $str/289)))
    (i32.const 2))))
 (i32.const 0))
(func $String::offset_of_nth_char.inner (param $self/285 (ref $moonbit.string)) (param $i/286 i32) (param $start_offset/287 i32) (param $end_offset/283 i64) (result i64)
 (local $end_offset/282 i32)
 (local $*Some/284 i64)
 (local.set $end_offset/282
  (if (result i32)
   (i64.eq
    (local.get $end_offset/283)
    (i64.const 4294967296))
   (then
    (array.len
     (local.get $self/285)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/284
      (local.get $end_offset/283))))))
 (if (result i64)
  (i32.ge_s
   (local.get $i/286)
   (i32.const 0))
  (then
   (call $String::offset_of_nth_char_forward
    (local.get $self/285)
    (local.get $i/286)
    (local.get $start_offset/287)
    (local.get $end_offset/282)))
  (else
   (call $String::offset_of_nth_char_backward
    (local.get $self/285)
    (i32.sub
     (i32.const 0)
     (local.get $i/286))
    (local.get $start_offset/287)
    (local.get $end_offset/282)))))
(func $String::offset_of_nth_char_forward (param $self/280 (ref $moonbit.string)) (param $n/278 i32) (param $start_offset/274 i32) (param $end_offset/275 i32) (result i64)
 (local $c/279 i32)
 (local $utf16_offset/276 i32)
 (local $char_count/277 i32)
 (if (result i64)
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/274)
    (i32.const 0))
   (then
    (i32.le_s
     (local.get $start_offset/274)
     (local.get $end_offset/275)))
   (else
    (i32.const 0)))
  (then
   (local.set $utf16_offset/276
    (local.get $start_offset/274))
   (local.set $char_count/277
    (i32.const 0))
   (loop $loop:281
    (if
     (if (result i32)
      (i32.lt_s
       (local.get $utf16_offset/276)
       (local.get $end_offset/275))
      (then
       (i32.lt_s
        (local.get $char_count/277)
        (local.get $n/278)))
      (else
       (i32.const 0)))
     (then
      (local.set $c/279
       (array.get_u $moonbit.string
        (local.get $self/280)
        (local.get $utf16_offset/276)))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 55296)
         (local.get $c/279))
        (then
         (i32.le_s
          (local.get $c/279)
          (i32.const 56319)))
        (else
         (i32.const 0)))
       (then
        (local.set $utf16_offset/276
         (i32.add
          (local.get $utf16_offset/276)
          (i32.const 2))))
       (else
        (local.set $utf16_offset/276
         (i32.add
          (local.get $utf16_offset/276)
          (i32.const 1)))))
      (local.set $char_count/277
       (i32.add
        (local.get $char_count/277)
        (i32.const 1)))
      (br $loop:281))
     (else)))
   (if (result i64)
    (if (result i32)
     (i32.lt_s
      (local.get $char_count/277)
      (local.get $n/278))
     (then
      (i32.const 1))
     (else
      (i32.ge_s
       (local.get $utf16_offset/276)
       (local.get $end_offset/275))))
    (then
     (i64.const 4294967296))
    (else
     (i64.extend_i32_s
      (local.get $utf16_offset/276)))))
  (else
   (call $moonbitlang/core/builtin.abort|Option<Int>|
    (call $moonbit.string_literal
     (i32.const 8)
     (i32.const 296)
     (i32.const 19))
    (call $moonbit.string_literal
     (i32.const 7)
     (i32.const 198)
     (i32.const 49))))))
(func $String::offset_of_nth_char_backward (param $self/272 (ref $moonbit.string)) (param $n/270 i32) (param $start_offset/269 i32) (param $end_offset/268 i32) (result i64)
 (local $c/271 i32)
 (local $char_count/266 i32)
 (local $utf16_offset/267 i32)
 (local.set $char_count/266
  (i32.const 0))
 (local.set $utf16_offset/267
  (local.get $end_offset/268))
 (loop $loop:273
  (if
   (if (result i32)
    (i32.ge_s
     (i32.sub
      (local.get $utf16_offset/267)
      (i32.const 1))
     (local.get $start_offset/269))
    (then
     (i32.lt_s
      (local.get $char_count/266)
      (local.get $n/270)))
    (else
     (i32.const 0)))
   (then
    (local.set $c/271
     (array.get_u $moonbit.string
      (local.get $self/272)
      (i32.sub
       (local.get $utf16_offset/267)
       (i32.const 1))))
    (if
     (if (result i32)
      (i32.le_s
       (i32.const 56320)
       (local.get $c/271))
      (then
       (i32.le_s
        (local.get $c/271)
        (i32.const 57343)))
      (else
       (i32.const 0)))
     (then
      (local.set $utf16_offset/267
       (i32.sub
        (local.get $utf16_offset/267)
        (i32.const 2))))
     (else
      (local.set $utf16_offset/267
       (i32.sub
        (local.get $utf16_offset/267)
        (i32.const 1)))))
    (local.set $char_count/266
     (i32.add
      (local.get $char_count/266)
      (i32.const 1)))
    (br $loop:273))
   (else)))
 (if (result i64)
  (if (result i32)
   (i32.lt_s
    (local.get $char_count/266)
    (local.get $n/270))
   (then
    (i32.const 1))
   (else
    (i32.lt_s
     (local.get $utf16_offset/267)
     (local.get $start_offset/269))))
  (then
   (i64.const 4294967296))
  (else
   (i64.extend_i32_s
    (local.get $utf16_offset/267)))))
(func $String::char_length_ge.inner (param $self/258 (ref $moonbit.string)) (param $len/261 i32) (param $start_offset/265 i32) (param $end_offset/256 i64) (result i32)
 (local $end_offset/255 i32)
 (local $*Some/257 i64)
 (local $index/259 i32)
 (local $count/260 i32)
 (local $c1/262 i32)
 (local $c2/263 i32)
 (local.set $end_offset/255
  (if (result i32)
   (i64.eq
    (local.get $end_offset/256)
    (i64.const 4294967296))
   (then
    (array.len
     (local.get $self/258)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/257
      (local.get $end_offset/256))))))
 (local.get $start_offset/265)
 (i32.const 0)
 (loop $loop:264 (param i32) (param i32) (result i32)
  (local.set $count/260)
  (local.tee $index/259)
  (local.get $end_offset/255)
  (i32.lt_s)
  (if (result i32)
   (then
    (i32.lt_s
     (local.get $count/260)
     (local.get $len/261)))
   (else
    (i32.const 0)))
  (if (result i32)
   (then
    (local.set $c1/262
     (array.get_u $moonbit.string
      (local.get $self/258)
      (local.get $index/259)))
    (if
     (if (result i32)
      (if (result i32)
       (i32.le_s
        (i32.const 55296)
        (local.get $c1/262))
       (then
        (i32.le_s
         (local.get $c1/262)
         (i32.const 56319)))
       (else
        (i32.const 0)))
      (then
       (i32.lt_s
        (i32.add
         (local.get $index/259)
         (i32.const 1))
        (local.get $end_offset/255)))
      (else
       (i32.const 0)))
     (then
      (local.set $c2/263
       (array.get_u $moonbit.string
        (local.get $self/258)
        (i32.add
         (local.get $index/259)
         (i32.const 1))))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 56320)
         (local.get $c2/263))
        (then
         (i32.le_s
          (local.get $c2/263)
          (i32.const 57343)))
        (else
         (i32.const 0)))
       (then
        (i32.add
         (local.get $index/259)
         (i32.const 2))
        (i32.add
         (local.get $count/260)
         (i32.const 1))
        (br $loop:264))
       (else
        (drop
         (call $moonbitlang/core/builtin.abort|Unit|
          (call $moonbit.string_literal
           (i32.const 10)
           (i32.const 432)
           (i32.const 22))
          (call $moonbit.string_literal
           (i32.const 9)
           (i32.const 334)
           (i32.const 49)))))))
     (else))
    (i32.add
     (local.get $index/259)
     (i32.const 1))
    (i32.add
     (local.get $count/260)
     (i32.const 1))
    (br $loop:264))
   (else
    (i32.ge_s
     (local.get $count/260)
     (local.get $len/261))))))
(func $UInt64::to_string.inner (param $self/247 i64) (param $radix/246 i32) (result (ref $moonbit.string))
 (local $buffer/248 (ref $FixedArray<UInt16>))
 (local $len/249 i32)
 (local $buffer/250 (ref $FixedArray<UInt16>))
 (local $len/251 i32)
 (local $buffer/252 (ref $FixedArray<UInt16>))
 (local $len/253 i32)
 (local $buffer/254 (ref $FixedArray<UInt16>))
 (if
  (if (result i32)
   (i32.lt_s
    (local.get $radix/246)
    (i32.const 2))
   (then
    (i32.const 1))
   (else
    (i32.gt_s
     (local.get $radix/246)
     (i32.const 36))))
  (then
   (drop
    (call $moonbitlang/core/builtin.abort|Unit|
     (call $moonbit.string_literal
      (i32.const 12)
      (i32.const 580)
      (i32.const 30))
     (call $moonbit.string_literal
      (i32.const 11)
      (i32.const 476)
      (i32.const 52)))))
  (else))
 (if
  (i64.eq
   (local.get $self/247)
   (i64.const 0))
  (then
   (call $moonbit.string_literal
    (i32.const 0)
    (i32.const 0)
    (i32.const 1))
   (return))
  (else))
 (local.tee $buffer/248
  (if (result (ref $FixedArray<UInt16>))
   (i32.eq
    (local.get $radix/246)
    (i32.const 10))
   (then
    (local.set $len/249
     (call $moonbitlang/core/builtin.dec_count64
      (local.get $self/247)))
    (drop
     (call $moonbitlang/core/builtin.int64_to_string_dec
      (local.tee $buffer/250
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $len/249)))
      (local.get $self/247)
      (i32.const 0)
      (local.get $len/249)))
    (local.get $buffer/250))
   (else
    (if (result (ref $FixedArray<UInt16>))
     (i32.eq
      (local.get $radix/246)
      (i32.const 16))
     (then
      (local.set $len/251
       (call $moonbitlang/core/builtin.hex_count64
        (local.get $self/247)))
      (drop
       (call $moonbitlang/core/builtin.int64_to_string_hex
        (local.tee $buffer/252
         (array.new $FixedArray<UInt16>
          (i32.const 0)
          (local.get $len/251)))
        (local.get $self/247)
        (i32.const 0)
        (local.get $len/251)))
      (local.get $buffer/252))
     (else
      (local.set $len/253
       (call $moonbitlang/core/builtin.radix_count64
        (local.get $self/247)
        (local.get $radix/246)))
      (drop
       (call $moonbitlang/core/builtin.int64_to_string_generic
        (local.tee $buffer/254
         (array.new $FixedArray<UInt16>
          (i32.const 0)
          (local.get $len/253)))
        (local.get $self/247)
        (i32.const 0)
        (local.get $len/253)
        (local.get $radix/246)))
      (local.get $buffer/254)))))))
(func $moonbitlang/core/builtin.int64_to_string_dec (param $buffer/236 (ref $FixedArray<UInt16>)) (param $num/224 i64) (param $digit_start/227 i32) (param $total_len/226 i32) (result i32)
 (local $t/228 i64)
 (local $r/229 i32)
 (local $d1/230 i32)
 (local $d2/231 i32)
 (local $d1_hi/232 i32)
 (local $d1_lo/233 i32)
 (local $d2_hi/234 i32)
 (local $d2_lo/235 i32)
 (local $t/239 i32)
 (local $d/240 i32)
 (local $d_hi/241 i32)
 (local $d_lo/242 i32)
 (local $d_hi/244 i32)
 (local $d_lo/245 i32)
 (local $num/223 i64)
 (local $offset/225 i32)
 (local $remaining/238 i32)
 (local.set $num/223
  (local.get $num/224))
 (local.set $offset/225
  (i32.sub
   (local.get $total_len/226)
   (local.get $digit_start/227)))
 (loop $loop:237
  (if
   (i64.ge_u
    (local.get $num/223)
    (i64.const 10000))
   (then
    (local.set $t/228
     (i64.div_u
      (local.get $num/223)
      (i64.const 10000)))
    (local.set $r/229
     (i32.wrap_i64
      (i64.rem_u
       (local.get $num/223)
       (i64.const 10000))))
    (local.set $num/223
     (local.get $t/228))
    (local.set $d1/230
     (i32.div_s
      (local.get $r/229)
      (i32.const 100)))
    (local.set $d2/231
     (i32.rem_s
      (local.get $r/229)
      (i32.const 100)))
    (local.set $offset/225
     (i32.sub
      (local.get $offset/225)
      (i32.const 4)))
    (local.set $d1_hi/232
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d1/230)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d1_lo/233
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d1/230)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_hi/234
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d2/231)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_lo/235
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d2/231)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/236)
     (i32.add
      (local.get $digit_start/227)
      (local.get $offset/225))
     (local.get $d1_hi/232))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/236)
     (i32.add
      (i32.add
       (local.get $digit_start/227)
       (local.get $offset/225))
      (i32.const 1))
     (local.get $d1_lo/233))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/236)
     (i32.add
      (i32.add
       (local.get $digit_start/227)
       (local.get $offset/225))
      (i32.const 2))
     (local.get $d2_hi/234))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/236)
     (i32.add
      (i32.add
       (local.get $digit_start/227)
       (local.get $offset/225))
      (i32.const 3))
     (local.get $d2_lo/235))
    (br $loop:237))
   (else)))
 (local.set $remaining/238
  (i32.wrap_i64
   (local.get $num/223)))
 (loop $loop:243
  (if
   (i32.ge_s
    (local.get $remaining/238)
    (i32.const 100))
   (then
    (local.set $t/239
     (i32.div_s
      (local.get $remaining/238)
      (i32.const 100)))
    (local.set $d/240
     (i32.rem_s
      (local.get $remaining/238)
      (i32.const 100)))
    (local.set $remaining/238
     (local.get $t/239))
    (local.set $offset/225
     (i32.sub
      (local.get $offset/225)
      (i32.const 2)))
    (local.set $d_hi/241
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d/240)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d_lo/242
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d/240)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/236)
     (i32.add
      (local.get $digit_start/227)
      (local.get $offset/225))
     (local.get $d_hi/241))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/236)
     (i32.add
      (i32.add
       (local.get $digit_start/227)
       (local.get $offset/225))
      (i32.const 1))
     (local.get $d_lo/242))
    (br $loop:243))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.get $remaining/238)
   (i32.const 10))
  (then
   (local.set $offset/225
    (i32.sub
     (local.get $offset/225)
     (i32.const 2)))
   (local.set $d_hi/244
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.div_s
       (local.get $remaining/238)
       (i32.const 10)))
     (i32.const 65535)))
   (local.set $d_lo/245
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (local.get $remaining/238)
       (i32.const 10)))
     (i32.const 65535)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/236)
    (i32.add
     (local.get $digit_start/227)
     (local.get $offset/225))
    (local.get $d_hi/244))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/236)
    (i32.add
     (i32.add
      (local.get $digit_start/227)
      (local.get $offset/225))
     (i32.const 1))
    (local.get $d_lo/245))
   (i32.const 0))
  (else
   (local.set $offset/225
    (i32.sub
     (local.get $offset/225)
     (i32.const 1)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/236)
    (i32.add
     (local.get $digit_start/227)
     (local.get $offset/225))
    (i32.and
     (i32.add
      (i32.const 48)
      (local.get $remaining/238))
     (i32.const 65535)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int64_to_string_generic (param $buffer/218 (ref $FixedArray<UInt16>)) (param $num/212 i64) (param $digit_start/210 i32) (param $total_len/209 i32) (param $radix/214 i32) (result i32)
 (local $base/213 i64)
 (local $shift/215 i32)
 (local $mask/216 i64)
 (local $digit/217 i32)
 (local $q/220 i64)
 (local $digit/221 i32)
 (local $offset/208 i32)
 (local $n/211 i64)
 (local.set $offset/208
  (i32.sub
   (local.get $total_len/209)
   (local.get $digit_start/210)))
 (local.set $n/211
  (local.get $num/212))
 (local.set $base/213
  (i64.extend_i32_s
   (local.get $radix/214)))
 (if (result i32)
  (i32.eq
   (i32.and
    (local.get $radix/214)
    (i32.sub
     (local.get $radix/214)
     (i32.const 1)))
   (i32.const 0))
  (then
   (local.set $shift/215
    (i32.ctz
     (local.get $radix/214)))
   (local.set $mask/216
    (i64.sub
     (local.get $base/213)
     (i64.const 1)))
   (loop $loop:219
    (if
     (i64.gt_u
      (local.get $n/211)
      (i64.const 0))
     (then
      (local.set $offset/208
       (i32.sub
        (local.get $offset/208)
        (i32.const 1)))
      (local.set $digit/217
       (i32.wrap_i64
        (i64.and
         (local.get $n/211)
         (local.get $mask/216))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/218)
       (i32.add
        (local.get $digit_start/210)
        (local.get $offset/208))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 13)
          (i32.const 640)
          (i32.const 36))
         (local.get $digit/217))
        (i32.const 65535)))
      (local.set $n/211
       (i64.shr_u
        (local.get $n/211)
        (i64.extend_i32_s
         (local.get $shift/215))))
      (br $loop:219))
     (else)))
   (i32.const 0))
  (else
   (loop $loop:222
    (if
     (i64.gt_u
      (local.get $n/211)
      (i64.const 0))
     (then
      (local.set $offset/208
       (i32.sub
        (local.get $offset/208)
        (i32.const 1)))
      (local.set $q/220
       (i64.div_u
        (local.get $n/211)
        (local.get $base/213)))
      (local.set $digit/221
       (i32.wrap_i64
        (i64.sub
         (local.get $n/211)
         (i64.mul
          (local.get $q/220)
          (local.get $base/213)))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/218)
       (i32.add
        (local.get $digit_start/210)
        (local.get $offset/208))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 13)
          (i32.const 640)
          (i32.const 36))
         (local.get $digit/221))
        (i32.const 65535)))
      (local.set $n/211
       (local.get $q/220))
      (br $loop:222))
     (else)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int64_to_string_hex (param $buffer/205 (ref $FixedArray<UInt16>)) (param $num/201 i64) (param $digit_start/199 i32) (param $total_len/198 i32) (result i32)
 (local $byte_val/202 i32)
 (local $hi/203 i32)
 (local $lo/204 i32)
 (local $nibble/207 i32)
 (local $offset/197 i32)
 (local $n/200 i64)
 (local.set $offset/197
  (i32.sub
   (local.get $total_len/198)
   (local.get $digit_start/199)))
 (local.set $n/200
  (local.get $num/201))
 (loop $loop:206
  (if
   (i32.ge_s
    (local.get $offset/197)
    (i32.const 2))
   (then
    (local.set $offset/197
     (i32.sub
      (local.get $offset/197)
      (i32.const 2)))
    (local.set $hi/203
     (i32.div_s
      (local.tee $byte_val/202
       (i32.wrap_i64
        (i64.and
         (local.get $n/200)
         (i64.const 255))))
      (i32.const 16)))
    (local.set $lo/204
     (i32.rem_s
      (local.get $byte_val/202)
      (i32.const 16)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/205)
     (i32.add
      (local.get $digit_start/199)
      (local.get $offset/197))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 13)
        (i32.const 640)
        (i32.const 36))
       (local.get $hi/203))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/205)
     (i32.add
      (i32.add
       (local.get $digit_start/199)
       (local.get $offset/197))
      (i32.const 1))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 13)
        (i32.const 640)
        (i32.const 36))
       (local.get $lo/204))
      (i32.const 65535)))
    (local.set $n/200
     (i64.shr_u
      (local.get $n/200)
      (i64.extend_i32_s
       (i32.const 8))))
    (br $loop:206))
   (else)))
 (if (result i32)
  (i32.eq
   (local.get $offset/197)
   (i32.const 1))
  (then
   (local.set $nibble/207
    (i32.wrap_i64
     (i64.and
      (local.get $n/200)
      (i64.const 15))))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/205)
    (local.get $digit_start/199)
    (i32.and
     (array.get_u $moonbit.string
      (call $moonbit.string_literal
       (i32.const 13)
       (i32.const 640)
       (i32.const 36))
      (local.get $nibble/207))
     (i32.const 65535)))
   (i32.const 0))
  (else
   (i32.const 0))))
(func $moonbitlang/core/builtin.radix_count64 (param $value/191 i64) (param $radix/194 i32) (result i32)
 (local $base/193 i64)
 (local $num/192 i64)
 (local $count/195 i32)
 (if
  (i64.eq
   (local.get $value/191)
   (i64.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.set $num/192
  (local.get $value/191))
 (local.set $base/193
  (i64.extend_i32_s
   (local.get $radix/194)))
 (local.set $count/195
  (i32.const 0))
 (loop $loop:196
  (if
   (i64.gt_u
    (local.get $num/192)
    (i64.const 0))
   (then
    (local.set $count/195
     (i32.add
      (local.get $count/195)
      (i32.const 1)))
    (local.set $num/192
     (i64.div_u
      (local.get $num/192)
      (local.get $base/193)))
    (br $loop:196))
   (else)))
 (local.get $count/195))
(func $moonbitlang/core/builtin.hex_count64 (param $value/189 i64) (result i32)
 (local $leading_zeros/190 i32)
 (if (result i32)
  (i64.eq
   (local.get $value/189)
   (i64.const 0))
  (then
   (i32.const 1))
  (else
   (local.set $leading_zeros/190
    (i32.wrap_i64
     (i64.clz
      (local.get $value/189))))
   (i32.add
    (i32.div_s
     (i32.sub
      (i32.const 63)
      (local.get $leading_zeros/190))
     (i32.const 4))
    (i32.const 1)))))
(func $moonbitlang/core/builtin.dec_count64 (param $value/188 i64) (result i32)
 (if (result i32)
  (i64.ge_u
   (local.get $value/188)
   (i64.const 10000000000))
  (then
   (if (result i32)
    (i64.ge_u
     (local.get $value/188)
     (i64.const 100000000000000))
    (then
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 10000000000000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000000000000000))
        (then
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const -8446744073709551616))
          (then
           (i32.const 20))
          (else
           (i32.const 19))))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const 100000000000000000))
          (then
           (i32.const 18))
          (else
           (i32.const 17))))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000000000000))
        (then
         (i32.const 16))
        (else
         (i32.const 15))))))
    (else
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 1000000000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 10000000000000))
        (then
         (i32.const 14))
        (else
         (i32.const 13))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 100000000000))
        (then
         (i32.const 12))
        (else
         (i32.const 11))))))))
  (else
   (if (result i32)
    (i64.ge_u
     (local.get $value/188)
     (i64.const 100000))
    (then
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 10000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000000))
        (then
         (i32.const 10))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const 100000000))
          (then
           (i32.const 9))
          (else
           (i32.const 8))))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000))
        (then
         (i32.const 7))
        (else
         (i32.const 6))))))
    (else
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 1000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 10000))
        (then
         (i32.const 5))
        (else
         (i32.const 4))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 100))
        (then
         (i32.const 3))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const 10))
          (then
           (i32.const 2))
          (else
           (i32.const 1))))))))))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|UInt64| (param $self/187 i64) (result (ref $moonbit.string))
 (local $logger/186 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/186
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::UInt64::output
   (local.get $self/187)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/186))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/186)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/185 (ref $moonbit.string)) (result (ref $moonbit.string))
 (local $logger/184 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/184
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/185)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/184))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/184)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double| (param $self/183 f64) (result (ref $moonbit.string))
 (local $logger/182 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/182
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::Double::output
   (local.get $self/183)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/182))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/182)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/174 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $value/177 (ref $moonbit.string)) (param $start/178 i32) (param $len/179 i32) (result i32)
 (local $*try_err/176 (ref $moonbit.enum))
 (local $*bind/788 (ref $moonbit.enum))
 (local $tag/793 i32)
 (local.get $self/174)
 (block $outer/792 (result (ref $StringView))
  (block $join:175 (result (ref $moonbit.enum))
   (if (result (ref $StringView))
    (i32.eq
     (local.tee $tag/793
      (struct.get $moonbit.enum 0
       (local.tee $*bind/788
        (call $String::sub.inner
         (local.get $value/177)
         (local.get $start/178)
         (i64.extend_i32_s
          (i32.add
           (local.get $start/178)
           (local.get $len/179)))))))
     (i32.const 1))
    (then
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
       (local.get $*bind/788))))
    (else
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
       (local.get $*bind/788)))
     (br $join:175)))
   (br $outer/792))
  (local.set $*try_err/176)
  (unreachable))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view))
(func $String::sub.inner (param $self/167 (ref $moonbit.string)) (param $start/173 i32) (param $end/169 i64) (result (ref $moonbit.enum))
 (local $len/166 i32)
 (local $end/168 i32)
 (local $*Some/170 i64)
 (local $*end/171 i32)
 (local $start/172 i32)
 (local $*p/647 i32)
 (local $*p/650 i32)
 (local.set $len/166
  (array.len
   (local.get $self/167)))
 (local.set $end/168
  (if (result i32)
   (i64.eq
    (local.get $end/169)
    (i64.const 4294967296))
   (then
    (local.get $len/166))
   (else
    (if (result i32)
     (i32.lt_s
      (local.tee $*end/171
       (i32.wrap_i64
        (local.tee $*Some/170
         (local.get $end/169))))
      (i32.const 0))
     (then
      (i32.add
       (local.get $len/166)
       (local.get $*end/171)))
     (else
      (local.get $*end/171))))))
 (if (result (ref $moonbit.enum))
  (if (result i32)
   (i32.ge_s
    (local.tee $start/172
     (if (result i32)
      (i32.lt_s
       (local.get $start/173)
       (i32.const 0))
      (then
       (i32.add
        (local.get $len/166)
        (local.get $start/173)))
      (else
       (local.get $start/173))))
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start/172)
      (local.get $end/168))
     (then
      (i32.le_s
       (local.get $end/168)
       (local.get $len/166)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $start/172)
      (local.get $len/166))
     (then
      (local.set $*p/647
       (array.get_u $moonbit.string
        (local.get $self/167)
        (local.get $start/172)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/647))
       (then
        (i32.le_s
         (local.get $*p/647)
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
      (local.get $end/168)
      (local.get $len/166))
     (then
      (local.set $*p/650
       (array.get_u $moonbit.string
        (local.get $self/167)
        (local.get $end/168)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/650))
       (then
        (i32.le_s
         (local.get $*p/650)
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
     (local.get $self/167)
     (local.get $start/172)
     (local.get $end/168))))
  (else
   (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
    (i32.const 0)
    (global.get $moonbit.constr/1)))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/163 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/164 (ref $moonbit.string)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/163)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/163))
    (i32.mul
     (array.len
      (local.get $str/164))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/163))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/163))
   (local.get $str/164)
   (i32.const 0)
   (array.len
    (local.get $str/164))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/163)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/163))
   (i32.mul
    (array.len
     (local.get $str/164))
    (i32.const 2))))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/155 (ref $moonbit.bytes)) (param $bytes_offset/150 i32) (param $str/157 (ref $moonbit.string)) (param $str_offset/153 i32) (param $length/151 i32) (result i32)
 (local $e1/149 i32)
 (local $e2/152 i32)
 (local $len1/154 i32)
 (local $len2/156 i32)
 (local $end_str_offset/158 i32)
 (local $i/159 i32)
 (local $j/160 i32)
 (local $c/161 i32)
 (local $*p/641 i32)
 (local $*p/644 i32)
 (local.set $e1/149
  (i32.sub
   (i32.add
    (local.get $bytes_offset/150)
    (i32.mul
     (local.get $length/151)
     (i32.const 2)))
   (i32.const 1)))
 (local.set $e2/152
  (i32.sub
   (i32.add
    (local.get $str_offset/153)
    (local.get $length/151))
   (i32.const 1)))
 (local.set $len1/154
  (array.len
   (local.get $self/155)))
 (local.set $len2/156
  (array.len
   (local.get $str/157)))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $length/151)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $bytes_offset/150)
      (i32.const 0))
     (then
      (if (result i32)
       (i32.lt_s
        (local.get $e1/149)
        (local.get $len1/154))
       (then
        (if (result i32)
         (i32.ge_s
          (local.get $str_offset/153)
          (i32.const 0))
         (then
          (i32.lt_s
           (local.get $e2/152)
           (local.get $len2/156)))
         (else
          (i32.const 0))))
       (else
        (i32.const 0))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $end_str_offset/158
    (i32.add
     (local.get $str_offset/153)
     (local.get $length/151)))
   (local.get $str_offset/153)
   (local.get $bytes_offset/150)
   (loop $loop:162 (param i32) (param i32)
    (local.set $j/160)
    (local.tee $i/159)
    (local.get $end_str_offset/158)
    (i32.lt_s)
    (if
     (then
      (local.set $c/161
       (array.get_u $moonbit.string
        (local.get $str/157)
        (local.get $i/159)))
      (array.set $moonbit.bytes
       (local.get $self/155)
       (local.get $j/160)
       (i32.and
        (local.tee $*p/641
         (i32.and
          (local.get $c/161)
          (i32.const 255)))
        (i32.const 255)))
      (array.set $moonbit.bytes
       (local.get $self/155)
       (i32.add
        (local.get $j/160)
        (i32.const 1))
       (i32.and
        (local.tee $*p/644
         (i32.shr_u
          (local.get $c/161)
          (i32.const 8)))
        (i32.const 255)))
      (i32.add
       (local.get $i/159)
       (i32.const 1))
      (i32.add
       (local.get $j/160)
       (i32.const 2))
      (br $loop:162))
     (else)))
   (i32.const 0))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/117 (ref $moonbit.string)) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
 (local $*x/118 i32)
 (local $*x/119 (ref $StringView))
 (local $*Some/120 i64)
 (local $*bind/121 i64)
 (local $*Some/122 i64)
 (local $*pkg_end/123 i32)
 (local $pkg/124 (ref $StringView))
 (local $*bind/125 i64)
 (local $*Some/126 i64)
 (local $*start_loc_end/127 i32)
 (local $end_loc/128 (ref $StringView))
 (local $*bind/129 (ref null $<StringView*StringView>))
 (local $*Some/130 (ref null $<StringView*StringView>))
 (local $*x/131 (ref $<StringView*StringView>))
 (local $*end_line/132 (ref $StringView))
 (local $*end_column/133 (ref $StringView))
 (local $rest/134 (ref $StringView))
 (local $*bind/136 i64)
 (local $*Some/137 i64)
 (local $*start_line_end/138 i32)
 (local $*bind/139 i64)
 (local $*Some/140 i64)
 (local $*filename_end/141 i32)
 (local $start_loc/142 (ref $StringView))
 (local $*bind/143 (ref null $<StringView*StringView>))
 (local $*Some/144 (ref null $<StringView*StringView>))
 (local $*x/145 (ref $<StringView*StringView>))
 (local $*start_line/146 (ref $StringView))
 (local $*start_column/147 (ref $StringView))
 (local $filename/148 (ref $StringView))
 (local $*bind/539 i64)
 (block $join:116
  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
   (call $String::char_length_ge.inner
    (local.get $repr/117)
    (i32.const 1)
    (i32.const 0)
    (i64.extend_i32_s
     (array.len
      (local.get $repr/117))))
   (then
    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
     (i32.eq
      (local.tee $*x/118
       (array.get_u $moonbit.string
        (local.get $repr/117)
        (i32.const 0)))
      (i32.const 64))
     (then
      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
       (i64.eq
        (local.tee $*bind/121
         (call $StringView::find
          (local.tee $*x/119
           (struct.new $StringView
            (local.get $repr/117)
            (if (result i32)
             (i64.eq
              (local.tee $*bind/539
               (call $String::offset_of_nth_char.inner
                (local.get $repr/117)
                (i32.const 1)
                (i32.const 0)
                (i64.extend_i32_s
                 (array.len
                  (local.get $repr/117)))))
              (i64.const 4294967296))
             (then
              (array.len
               (local.get $repr/117)))
             (else
              (i32.wrap_i64
               (local.tee $*Some/120
                (local.get $*bind/539)))))
            (array.len
             (local.get $repr/117))))
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
        (local.set $*pkg_end/123
         (i32.wrap_i64
          (local.tee $*Some/122
           (local.get $*bind/121))))
        (local.set $pkg/124
         (call $StringView::view.inner
          (local.get $*x/119)
          (i32.const 0)
          (i64.extend_i32_s
           (local.get $*pkg_end/123))))
        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
         (i64.eq
          (local.tee $*bind/125
           (call $StringView::rev_find
            (local.get $*x/119)
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
             (local.tee $*start_loc_end/127
              (i32.wrap_i64
               (local.tee $*Some/126
                (local.get $*bind/125))))
             (i32.const 1))
            (i32.sub
             (struct.get $StringView 2
              (local.get $*x/119))
             (struct.get $StringView 1
              (local.get $*x/119))))
           (then
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (ref.is_null
              (local.tee $*bind/129
               (call $moonbitlang/core/builtin.parse.parse_loc|1101
                (local.tee $end_loc/128
                 (call $StringView::view.inner
                  (local.get $*x/119)
                  (i32.add
                   (local.get $*start_loc_end/127)
                   (i32.const 1))
                  (i64.const 4294967296))))))
             (then
              (unreachable))
             (else
              (local.set $*end_line/132
               (struct.get $<StringView*StringView> 0
                (local.tee $*x/131
                 (ref.as_non_null
                  (local.tee $*Some/130
                   (local.get $*bind/129))))))
              (local.set $*end_column/133
               (struct.get $<StringView*StringView> 1
                (local.get $*x/131)))
              (local.set $rest/134
               (call $StringView::view.inner
                (local.get $*x/119)
                (i32.const 0)
                (i64.extend_i32_s
                 (local.get $*start_loc_end/127))))
              (block $join:135
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i64.eq
                 (local.tee $*bind/136
                  (call $StringView::rev_find
                   (local.get $rest/134)
                   (struct.new $StringView
                    (ref.as_non_null
                     (global.get $moonbitlang/core/builtin.parse.*bind|5421))
                    (i32.const 0)
                    (array.len
                     (ref.as_non_null
                      (global.get $moonbitlang/core/builtin.parse.*bind|5421))))))
                 (i64.const 4294967296))
                (then
                 (br $join:135))
                (else
                 (local.set $*start_line_end/138
                  (i32.wrap_i64
                   (local.tee $*Some/137
                    (local.get $*bind/136))))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i64.eq
                   (local.tee $*bind/139
                    (call $StringView::rev_find
                     (call $StringView::view.inner
                      (local.get $rest/134)
                      (i32.const 0)
                      (i64.extend_i32_s
                       (local.get $*start_line_end/138)))
                     (struct.new $StringView
                      (ref.as_non_null
                       (global.get $moonbitlang/core/builtin.parse.*bind|5415))
                      (i32.const 0)
                      (array.len
                       (ref.as_non_null
                        (global.get $moonbitlang/core/builtin.parse.*bind|5415))))))
                   (i64.const 4294967296))
                  (then
                   (br $join:135))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (i32.add
                      (local.tee $*filename_end/141
                       (i32.wrap_i64
                        (local.tee $*Some/140
                         (local.get $*bind/139))))
                      (i32.const 1))
                     (i32.sub
                      (struct.get $StringView 2
                       (local.get $rest/134))
                      (struct.get $StringView 1
                       (local.get $rest/134))))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (ref.is_null
                       (local.tee $*bind/143
                        (call $moonbitlang/core/builtin.parse.parse_loc|1101
                         (local.tee $start_loc/142
                          (call $StringView::view.inner
                           (local.get $rest/134)
                           (i32.add
                            (local.get $*filename_end/141)
                            (i32.const 1))
                           (i64.const 4294967296))))))
                      (then
                       (unreachable))
                      (else
                       (local.set $*start_line/146
                        (struct.get $<StringView*StringView> 0
                         (local.tee $*x/145
                          (ref.as_non_null
                           (local.tee $*Some/144
                            (local.get $*bind/143))))))
                       (local.set $*start_column/147
                        (struct.get $<StringView*StringView> 1
                         (local.get $*x/145)))
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $*filename_end/141)
                         (i32.add
                          (local.get $*pkg_end/123)
                          (i32.const 1)))
                        (then
                         (local.set $filename/148
                          (call $StringView::view.inner
                           (local.get $rest/134)
                           (i32.add
                            (local.get $*pkg_end/123)
                            (i32.const 1))
                           (i64.extend_i32_s
                            (local.get $*filename_end/141))))
                         (struct.new $@moonbitlang/core/builtin.SourceLocRepr
                          (local.get $pkg/124)
                          (local.get $filename/148)
                          (local.get $*start_line/146)
                          (local.get $*start_column/147)
                          (local.get $*end_line/132)
                          (local.get $*end_column/133)))
                        (else
                         (unreachable))))))
                    (else
                     (unreachable)))))))
               (return))
              (unreachable))))
           (else
            (unreachable))))))))
     (else
      (br $join:116))))
   (else
    (br $join:116)))
  (return))
 (unreachable))
(func $moonbitlang/core/builtin.parse.parse_loc|1101 (param $view/113 (ref $StringView)) (result (ref null $<StringView*StringView>))
 (local $*bind/112 i64)
 (local $*Some/114 i64)
 (local $*i/115 i32)
 (if (result (ref null $<StringView*StringView>))
  (i64.eq
   (local.tee $*bind/112
    (call $StringView::find
     (local.get $view/113)
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
      (local.tee $*i/115
       (i32.wrap_i64
        (local.tee $*Some/114
         (local.get $*bind/112))))
      (i32.const 0))
     (then
      (i32.lt_s
       (i32.add
        (local.get $*i/115)
        (i32.const 1))
       (i32.sub
        (struct.get $StringView 2
         (local.get $view/113))
        (struct.get $StringView 1
         (local.get $view/113)))))
     (else
      (i32.const 0)))
    (then
     (struct.new $<StringView*StringView>
      (call $StringView::view.inner
       (local.get $view/113)
       (i32.const 0)
       (i64.extend_i32_s
        (local.get $*i/115)))
      (call $StringView::view.inner
       (local.get $view/113)
       (i32.add
        (local.get $*i/115)
        (i32.const 1))
       (i64.const 4294967296))))
    (else
     (ref.null none))))))
(func $StringView::view.inner (param $self/110 (ref $StringView)) (param $start_offset/111 i32) (param $end_offset/108 i64) (result (ref $StringView))
 (local $end_offset/107 i32)
 (local $*Some/109 i64)
 (local.set $end_offset/107
  (if (result i32)
   (i64.eq
    (local.get $end_offset/108)
    (i64.const 4294967296))
   (then
    (i32.sub
     (struct.get $StringView 2
      (local.get $self/110))
     (struct.get $StringView 1
      (local.get $self/110))))
   (else
    (i32.wrap_i64
     (local.tee $*Some/109
      (local.get $end_offset/108))))))
 (if (result (ref $StringView))
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/111)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start_offset/111)
      (local.get $end_offset/107))
     (then
      (i32.le_s
       (local.get $end_offset/107)
       (i32.sub
        (struct.get $StringView 2
         (local.get $self/110))
        (struct.get $StringView 1
         (local.get $self/110)))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (struct.new $StringView
    (struct.get $StringView 0
     (local.get $self/110))
    (i32.add
     (struct.get $StringView 1
      (local.get $self/110))
     (local.get $start_offset/111))
    (i32.add
     (struct.get $StringView 1
      (local.get $self/110))
     (local.get $end_offset/107))))
  (else
   (call $moonbitlang/core/builtin.abort|StringView|
    (call $moonbit.string_literal
     (i32.const 15)
     (i32.const 818)
     (i32.const 22))
    (call $moonbit.string_literal
     (i32.const 14)
     (i32.const 712)
     (i32.const 53))))))
(func $StringView::rev_find (param $self/106 (ref $StringView)) (param $str/105 (ref $StringView)) (result i64)
 (if (result i64)
  (i32.le_s
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/105))
    (struct.get $StringView 1
     (local.get $str/105)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_rev_find
    (local.get $self/106)
    (local.get $str/105)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_rev_find
    (local.get $self/106)
    (local.get $str/105)))))
(func $moonbitlang/core/builtin.brute_force_rev_find (param $haystack/96 (ref $StringView)) (param $needle/98 (ref $StringView)) (result i64)
 (local $haystack_len/95 i32)
 (local $needle_len/97 i32)
 (local $needle_first/99 i32)
 (local $j/102 i32)
 (local $*p/618 i32)
 (local $*p/621 i32)
 (local $*p/624 i32)
 (local $i/100 i32)
 (local.set $haystack_len/95
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/96))
   (struct.get $StringView 1
    (local.get $haystack/96))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/97
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/98))
     (struct.get $StringView 1
      (local.get $needle/98))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/95)
     (local.get $needle_len/97))
    (then
     (local.set $*p/618
      (i32.const 0))
     (local.set $needle_first/99
      (array.get_u $moonbit.string
       (struct.get $StringView 0
        (local.get $needle/98))
       (i32.add
        (struct.get $StringView 1
         (local.get $needle/98))
        (local.get $*p/618))))
     (local.set $i/100
      (i32.sub
       (local.get $haystack_len/95)
       (local.get $needle_len/97)))
     (loop $loop:104
      (if
       (i32.ge_s
        (local.get $i/100)
        (i32.const 0))
       (then
        (loop $loop:101
         (if
          (if (result i32)
           (i32.ge_s
            (local.get $i/100)
            (i32.const 0))
           (then
            (local.set $*p/621
             (local.get $i/100))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/96))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/96))
              (local.get $*p/621)))
            (i32.ne
             (local.get $needle_first/99)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/100
            (i32.sub
             (local.get $i/100)
             (i32.const 1)))
           (br $loop:101))
          (else)))
        (if
         (i32.ge_s
          (local.get $i/100)
          (i32.const 0))
         (then
          (block $break:103
           (i32.const 1)
           (loop $loop:103 (param i32)
            (local.tee $j/102)
            (local.get $needle_len/97)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/624
               (i32.add
                (local.get $i/100)
                (local.get $j/102)))
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $haystack/96))
               (i32.add
                (struct.get $StringView 1
                 (local.get $haystack/96))
                (local.get $*p/624)))
              (if
               (i32.ne
                (array.get_u $moonbit.string
                 (struct.get $StringView 0
                  (local.get $needle/98))
                 (i32.add
                  (struct.get $StringView 1
                   (local.get $needle/98))
                  (local.get $j/102))))
               (then
                (br $break:103))
               (else))
              (i32.add
               (local.get $j/102)
               (i32.const 1))
              (br $loop:103))
             (else
              (i64.extend_i32_s
               (local.get $i/100))
              (return)))))
          (local.set $i/100
           (i32.sub
            (local.get $i/100)
            (i32.const 1))))
         (else))
        (br $loop:104))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (i64.extend_i32_s
    (local.get $haystack_len/95)))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_rev_find (param $haystack/85 (ref $StringView)) (param $needle/87 (ref $StringView)) (result i64)
 (local $haystack_len/84 i32)
 (local $needle_len/86 i32)
 (local $skip_table/88 (ref $moonbit.array_i32))
 (local $i/89 i32)
 (local $i/91 i32)
 (local $j/92 i32)
 (local $*p/607 i32)
 (local.set $haystack_len/84
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/85))
   (struct.get $StringView 1
    (local.get $haystack/85))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/86
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/87))
     (struct.get $StringView 1
      (local.get $needle/87))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/84)
     (local.get $needle_len/86))
    (then
     (local.set $skip_table/88
      (array.new $moonbit.array_i32
       (local.get $needle_len/86)
       (i32.const 256)))
     (i32.sub
      (local.get $needle_len/86)
      (i32.const 1))
     (loop $loop:90 (param i32)
      (local.tee $i/89)
      (i32.const 0)
      (i32.gt_s)
      (if
       (then
        (array.set $moonbit.array_i32
         (local.get $skip_table/88)
         (i32.and
          (array.get_u $moonbit.string
           (struct.get $StringView 0
            (local.get $needle/87))
           (i32.add
            (struct.get $StringView 1
             (local.get $needle/87))
            (local.get $i/89)))
          (i32.const 255))
         (local.get $i/89))
        (i32.sub
         (local.get $i/89)
         (i32.const 1))
        (br $loop:90))
       (else)))
     (i32.sub
      (local.get $haystack_len/84)
      (local.get $needle_len/86))
     (loop $loop:94 (param i32)
      (local.tee $i/91)
      (i32.const 0)
      (i32.ge_s)
      (if
       (then
        (block $break:93
         (i32.const 0)
         (loop $loop:93 (param i32)
          (local.tee $j/92)
          (local.get $needle_len/86)
          (i32.lt_s)
          (if
           (then
            (local.set $*p/607
             (i32.add
              (local.get $i/91)
              (local.get $j/92)))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/85))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/85))
              (local.get $*p/607)))
            (if
             (i32.ne
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $needle/87))
               (i32.add
                (struct.get $StringView 1
                 (local.get $needle/87))
                (local.get $j/92))))
             (then
              (br $break:93))
             (else))
            (i32.add
             (local.get $j/92)
             (i32.const 1))
            (br $loop:93))
           (else
            (i64.extend_i32_s
             (local.get $i/91))
            (return)))))
        (i32.sub
         (local.get $i/91)
         (array.get $moonbit.array_i32
          (local.get $skip_table/88)
          (i32.and
           (array.get_u $moonbit.string
            (struct.get $StringView 0
             (local.get $haystack/85))
            (i32.add
             (struct.get $StringView 1
              (local.get $haystack/85))
             (local.get $i/91)))
           (i32.const 255))))
        (br $loop:94))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (i64.extend_i32_s
    (local.get $haystack_len/84)))))
(func $StringView::find (param $self/83 (ref $StringView)) (param $str/82 (ref $StringView)) (result i64)
 (if (result i64)
  (i32.le_s
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/82))
    (struct.get $StringView 1
     (local.get $str/82)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_find
    (local.get $self/83)
    (local.get $str/82)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_find
    (local.get $self/83)
    (local.get $str/82)))))
(func $moonbitlang/core/builtin.brute_force_find (param $haystack/72 (ref $StringView)) (param $needle/74 (ref $StringView)) (result i64)
 (local $haystack_len/71 i32)
 (local $needle_len/73 i32)
 (local $needle_first/75 i32)
 (local $forward_len/76 i32)
 (local $j/79 i32)
 (local $*p/588 i32)
 (local $*p/591 i32)
 (local $*p/594 i32)
 (local $i/77 i32)
 (local.set $haystack_len/71
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/72))
   (struct.get $StringView 1
    (local.get $haystack/72))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/73
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/74))
     (struct.get $StringView 1
      (local.get $needle/74))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/71)
     (local.get $needle_len/73))
    (then
     (local.set $*p/588
      (i32.const 0))
     (local.set $needle_first/75
      (array.get_u $moonbit.string
       (struct.get $StringView 0
        (local.get $needle/74))
       (i32.add
        (struct.get $StringView 1
         (local.get $needle/74))
        (local.get $*p/588))))
     (local.set $forward_len/76
      (i32.sub
       (local.get $haystack_len/71)
       (local.get $needle_len/73)))
     (local.set $i/77
      (i32.const 0))
     (loop $loop:81
      (if
       (i32.le_s
        (local.get $i/77)
        (local.get $forward_len/76))
       (then
        (loop $loop:78
         (if
          (if (result i32)
           (i32.le_s
            (local.get $i/77)
            (local.get $forward_len/76))
           (then
            (local.set $*p/591
             (local.get $i/77))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/72))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/72))
              (local.get $*p/591)))
            (i32.ne
             (local.get $needle_first/75)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/77
            (i32.add
             (local.get $i/77)
             (i32.const 1)))
           (br $loop:78))
          (else)))
        (if
         (i32.le_s
          (local.get $i/77)
          (local.get $forward_len/76))
         (then
          (block $break:80
           (i32.const 1)
           (loop $loop:80 (param i32)
            (local.tee $j/79)
            (local.get $needle_len/73)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/594
               (i32.add
                (local.get $i/77)
                (local.get $j/79)))
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $haystack/72))
               (i32.add
                (struct.get $StringView 1
                 (local.get $haystack/72))
                (local.get $*p/594)))
              (if
               (i32.ne
                (array.get_u $moonbit.string
                 (struct.get $StringView 0
                  (local.get $needle/74))
                 (i32.add
                  (struct.get $StringView 1
                   (local.get $needle/74))
                  (local.get $j/79))))
               (then
                (br $break:80))
               (else))
              (i32.add
               (local.get $j/79)
               (i32.const 1))
              (br $loop:80))
             (else
              (i64.extend_i32_s
               (local.get $i/77))
              (return)))))
          (local.set $i/77
           (i32.add
            (local.get $i/77)
            (i32.const 1))))
         (else))
        (br $loop:81))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (global.get $moonbitlang/core/builtin.brute_force_find.constr/70))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_find (param $haystack/58 (ref $StringView)) (param $needle/60 (ref $StringView)) (result i64)
 (local $haystack_len/57 i32)
 (local $needle_len/59 i32)
 (local $skip_table/61 (ref $moonbit.array_i32))
 (local $*end4298/62 i32)
 (local $i/63 i32)
 (local $i/65 i32)
 (local $*end4304/66 i32)
 (local $j/67 i32)
 (local $*p/576 i32)
 (local $*p/581 i32)
 (local.set $haystack_len/57
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/58))
   (struct.get $StringView 1
    (local.get $haystack/58))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/59
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/60))
     (struct.get $StringView 1
      (local.get $needle/60))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/57)
     (local.get $needle_len/59))
    (then
     (local.set $skip_table/61
      (array.new $moonbit.array_i32
       (local.get $needle_len/59)
       (i32.const 256)))
     (local.set $*end4298/62
      (i32.sub
       (local.get $needle_len/59)
       (i32.const 1)))
     (i32.const 0)
     (loop $loop:64 (param i32)
      (local.tee $i/63)
      (local.get $*end4298/62)
      (i32.lt_s)
      (if
       (then
        (array.set $moonbit.array_i32
         (local.get $skip_table/61)
         (i32.and
          (array.get_u $moonbit.string
           (struct.get $StringView 0
            (local.get $needle/60))
           (i32.add
            (struct.get $StringView 1
             (local.get $needle/60))
            (local.get $i/63)))
          (i32.const 255))
         (i32.sub
          (i32.sub
           (local.get $needle_len/59)
           (i32.const 1))
          (local.get $i/63)))
        (i32.add
         (local.get $i/63)
         (i32.const 1))
        (br $loop:64))
       (else)))
     (i32.const 0)
     (loop $loop:69 (param i32)
      (local.tee $i/65)
      (i32.sub
       (local.get $haystack_len/57)
       (local.get $needle_len/59))
      (i32.le_s)
      (if
       (then
        (local.set $*end4304/66
         (i32.sub
          (local.get $needle_len/59)
          (i32.const 1)))
        (block $break:68
         (i32.const 0)
         (loop $loop:68 (param i32)
          (local.tee $j/67)
          (local.get $*end4304/66)
          (i32.le_s)
          (if
           (then
            (local.set $*p/576
             (i32.add
              (local.get $i/65)
              (local.get $j/67)))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/58))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/58))
              (local.get $*p/576)))
            (if
             (i32.ne
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $needle/60))
               (i32.add
                (struct.get $StringView 1
                 (local.get $needle/60))
                (local.get $j/67))))
             (then
              (br $break:68))
             (else))
            (i32.add
             (local.get $j/67)
             (i32.const 1))
            (br $loop:68))
           (else
            (i64.extend_i32_s
             (local.get $i/65))
            (return)))))
        (local.get $i/65)
        (local.get $skip_table/61)
        (local.set $*p/581
         (i32.sub
          (i32.add
           (local.get $i/65)
           (local.get $needle_len/59))
          (i32.const 1)))
        (i32.and
         (array.get_u $moonbit.string
          (struct.get $StringView 0
           (local.get $haystack/58))
          (i32.add
           (struct.get $StringView 1
            (local.get $haystack/58))
           (local.get $*p/581)))
         (i32.const 255))
        (array.get $moonbit.array_i32)
        (i32.add)
        (br $loop:69))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (global.get $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/56))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/48 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $ch/50 i32) (result i32)
 (local $inc/49 i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/48)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/48))
    (i32.const 4))))
 (local.set $inc/49
  (call $FixedArray::set_utf16le_char
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/48))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/48))
   (local.get $ch/50)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/48)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/48))
   (local.get $inc/49)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/43 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $required/44 i32) (result i32)
 (local $current_len/42 i32)
 (local $new_data/47 (ref $moonbit.bytes))
 (local $enough_space/45 i32)
 (local.set $current_len/42
  (array.len
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/43))))
 (if
  (i32.le_s
   (local.get $required/44)
   (local.get $current_len/42))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/45
  (local.get $current_len/42))
 (loop $loop:46
  (if
   (i32.lt_s
    (local.get $enough_space/45)
    (local.get $required/44))
   (then
    (local.set $enough_space/45
     (i32.mul
      (local.get $enough_space/45)
      (i32.const 2)))
    (br $loop:46))
   (else)))
 (array.copy $moonbit.bytes $moonbit.bytes
  (local.tee $new_data/47
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $enough_space/45)))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/43))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 1
   (local.get $self/43)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 0
  (local.get $self/43)
  (local.get $new_data/47))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/37 (ref $moonbit.bytes)) (param $offset/38 i32) (param $value/36 i32) (result i32)
 (local $code/35 i32)
 (local $hi/39 i32)
 (local $lo/40 i32)
 (local $hi/41 i32)
 (local $*p/550 i32)
 (local $*p/553 i32)
 (local $*p/556 i32)
 (local $*p/559 i32)
 (local $*p/562 i32)
 (local $*p/565 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/35
    (local.get $value/36))
   (i32.const 65536))
  (then
   (array.set $moonbit.bytes
    (local.get $self/37)
    (local.get $offset/38)
    (i32.and
     (local.tee $*p/550
      (i32.and
       (local.get $code/35)
       (i32.const 255)))
     (i32.const 255)))
   (array.set $moonbit.bytes
    (local.get $self/37)
    (i32.add
     (local.get $offset/38)
     (i32.const 1))
    (i32.and
     (local.tee $*p/553
      (i32.shr_u
       (local.get $code/35)
       (i32.const 8)))
     (i32.const 255)))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/35)
     (i32.const 1114112))
    (then
     (local.set $lo/40
      (i32.or
       (i32.shr_u
        (local.tee $hi/39
         (i32.sub
          (local.get $code/35)
          (i32.const 65536)))
        (i32.const 10))
       (i32.const 55296)))
     (local.set $hi/41
      (i32.or
       (i32.and
        (local.get $hi/39)
        (i32.const 1023))
       (i32.const 56320)))
     (array.set $moonbit.bytes
      (local.get $self/37)
      (local.get $offset/38)
      (i32.and
       (local.tee $*p/556
        (i32.and
         (local.get $lo/40)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/37)
      (i32.add
       (local.get $offset/38)
       (i32.const 1))
      (i32.and
       (local.tee $*p/559
        (i32.shr_u
         (local.get $lo/40)
         (i32.const 8)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/37)
      (i32.add
       (local.get $offset/38)
       (i32.const 2))
      (i32.and
       (local.tee $*p/562
        (i32.and
         (local.get $hi/41)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/37)
      (i32.add
       (local.get $offset/38)
       (i32.const 3))
      (i32.and
       (local.tee $*p/565
        (i32.shr_u
         (local.get $hi/41)
         (i32.const 8)))
       (i32.const 255)))
     (i32.const 4))
    (else
     (call $moonbitlang/core/builtin.abort|Int|
      (call $moonbit.string_literal
       (i32.const 17)
       (i32.const 958)
       (i32.const 17))
      (call $moonbit.string_literal
       (i32.const 16)
       (i32.const 862)
       (i32.const 48))))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/32 (ref $@moonbitlang/core/builtin.StringBuilder)) (result (ref $moonbit.string))
 (call $Bytes::to_unchecked_string.inner
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/32))
  (i32.const 0)
  (i64.extend_i32_s
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/32)))))
(func $Bytes::to_unchecked_string.inner (param $self/27 (ref $moonbit.bytes)) (param $offset/31 i32) (param $length/29 i64) (result (ref $moonbit.string))
 (local $len/26 i32)
 (local $length/28 i32)
 (local $*Some/30 i64)
 (local.set $len/26
  (array.len
   (local.get $self/27)))
 (local.set $length/28
  (if (result i32)
   (i64.eq
    (local.get $length/29)
    (i64.const 4294967296))
   (then
    (i32.sub
     (local.get $len/26)
     (local.get $offset/31)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/30
      (local.get $length/29))))))
 (if (result (ref $moonbit.string))
  (if (result i32)
   (i32.ge_s
    (local.get $offset/31)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $length/28)
      (i32.const 0))
     (then
      (i32.le_s
       (i32.add
        (local.get $offset/31)
        (local.get $length/28))
       (local.get $len/26)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (call $moonbitlang/core/builtin.unsafe_sub_string
    (local.get $self/27)
    (local.get $offset/31)
    (local.get $length/28)))
  (else
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/771 (ref $moonbit.bytes)) (param $*param/772 i32) (param $*param/773 i32) (result (ref $moonbit.string))
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/771)
  (local.get $*param/772)
  (local.get $*param/773)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/24 i32) (result (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $initial/23 i32)
 (local $data/25 (ref $moonbit.bytes))
 (local.set $initial/23
  (if (result i32)
   (i32.lt_s
    (local.get $size_hint/24)
    (i32.const 1))
   (then
    (i32.const 1))
   (else
    (local.get $size_hint/24))))
 (struct.new $@moonbitlang/core/builtin.StringBuilder
  (local.tee $data/25
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $initial/23)))
  (i32.const 0)))
(func $moonbitlang/core/builtin.abort|Option<Int>| (param $string/11 (ref $moonbit.string)) (param $loc/12 (ref $moonbit.string)) (result i64)
 (call $moonbitlang/core/abort.abort|Option<Int>|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/11)
     (call $moonbit.string_literal
      (i32.const 19)
      (i32.const 994)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/12)))
   (call $moonbit.string_literal
    (i32.const 18)
    (i32.const 992)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/9 (ref $moonbit.string)) (param $loc/10 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Unit|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/9)
     (call $moonbit.string_literal
      (i32.const 19)
      (i32.const 994)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/10)))
   (call $moonbit.string_literal
    (i32.const 18)
    (i32.const 992)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|StringView| (param $string/7 (ref $moonbit.string)) (param $loc/8 (ref $moonbit.string)) (result (ref $StringView))
 (call $moonbitlang/core/abort.abort|StringView|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/7)
     (call $moonbit.string_literal
      (i32.const 19)
      (i32.const 994)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/8)))
   (call $moonbit.string_literal
    (i32.const 18)
    (i32.const 992)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/5 (ref $moonbit.string)) (param $loc/6 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/5)
     (call $moonbit.string_literal
      (i32.const 19)
      (i32.const 994)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/6)))
   (call $moonbit.string_literal
    (i32.const 18)
    (i32.const 992)
    (i32.const 1)))))
(func $moonbitlang/core/abort.abort|Option<Int>| (param $msg/4 (ref $moonbit.string)) (result i64)
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/3 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $moonbitlang/core/abort.abort|StringView| (param $msg/2 (ref $moonbit.string)) (result (ref $StringView))
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/1 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_3) (param $*obj/787 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/786 i32) (result i32)
 (local $*self/785 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/785
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/787))))
  (local.get $*param/786)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_2) (param $*obj/784 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/783 (ref $StringView)) (result i32)
 (local $*self/782 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/782
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/784))))
  (local.get $*param/783)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (type $@moonbitlang/core/builtin.Logger.method_1) (param $*obj/781 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/778 (ref $moonbit.string)) (param $*param/779 i32) (param $*param/780 i32) (result i32)
 (local $*self/777 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/777
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/781))))
  (local.get $*param/778)
  (local.get $*param/779)
  (local.get $*param/780)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_0) (param $*obj/776 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/775 (ref $moonbit.string)) (result i32)
 (local $*self/774 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/774
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/776))))
  (local.get $*param/775)))
(start $*init*/2)
(func $*init*/2
 (global.set $moonbitlang/core/builtin.parse.*bind|5401
  (call $moonbit.string_literal
   (i32.const 23)
   (i32.const 1078)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5440
  (call $moonbit.string_literal
   (i32.const 23)
   (i32.const 1078)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5434
  (call $moonbit.string_literal
   (i32.const 5)
   (i32.const 190)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5421
  (call $moonbit.string_literal
   (i32.const 23)
   (i32.const 1078)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5415
  (call $moonbit.string_literal
   (i32.const 23)
   (i32.const 1078)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.output.*bind|8190
  (call $moonbit.string_literal
   (i32.const 22)
   (i32.const 1076)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.output.*bind|8184
  (call $moonbit.string_literal
   (i32.const 22)
   (i32.const 1076)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/56
  (i64.extend_i32_s
   (i32.const 0)))
 (global.set $moonbitlang/core/builtin.brute_force_find.constr/70
  (i64.extend_i32_s
   (i32.const 0)))
 (i64.const 1)
 (i64.const 2305843009213693952)
 (i64.const 5955668970331000884)
 (i64.const 1784059615882449851)
 (i64.const 8982663654677661702)
 (i64.const 1380349269358112757)
 (i64.const 7286864317269821294)
 (i64.const 2135987035920910082)
 (i64.const 7005857020398200553)
 (i64.const 1652639921975621497)
 (i64.const -481418970354774919)
 (i64.const 1278668206209430417)
 (i64.const 8928596168509315048)
 (i64.const 1978643211784836272)
 (i64.const -8371072500651252758)
 (i64.const 1530901034580419511)
 (i64.const 597001226353042382)
 (i64.const 1184477304306571148)
 (i64.const 1527430471115325346)
 (i64.const 1832889850782397517)
 (i64.const -5913534206540532074)
 (i64.const 1418129833677084982)
 (i64.const 5577825024675947042)
 (i64.const 2194449627517475473)
 (i64.const -7439769533505684065)
 (i64.const 1697873161311732311)
 (i64.const -8133250842069730034)
 (i64.const 1313665730009899186)
 (i64.const -5745727253942878843)
 (i64.const 2032799256770390445)
 (global.set $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2
  (array.new_fixed $ReadOnlyArray<UInt64> 30))
 (i32.const 1414808916)
 (i32.const 67458373)
 (i32.const 268701696)
 (i32.const 4195348)
 (i32.const 1073807360)
 (i32.const 1091917141)
 (i32.const 1108)
 (i32.const 65604)
 (i32.const 1073741824)
 (i32.const 1140850753)
 (i32.const 1346716752)
 (i32.const 1431634004)
 (i32.const 1365595476)
 (i32.const 1073758208)
 (i32.const 16777217)
 (i32.const 66816)
 (i32.const 1364284433)
 (i32.const 89478484)
 (i32.const 0)
 (global.set $moonbitlang/core/double/internal/ryu.gPOW5_INV_OFFSETS
  (array.new_fixed $ReadOnlyArray<UInt> 19))
 (i64.const 0)
 (i64.const 1152921504606846976)
 (i64.const 0)
 (i64.const 1490116119384765625)
 (i64.const 1032610780636961552)
 (i64.const 1925929944387235853)
 (i64.const 7910200175544436838)
 (i64.const 1244603055572228341)
 (i64.const -1504838264676837686)
 (i64.const 1608611746708759036)
 (i64.const -5421850118411349444)
 (i64.const 2079081953128979843)
 (i64.const 6607496772837067824)
 (i64.const 1343575221513417750)
 (i64.const -1113817083813899013)
 (i64.const 1736530273035216783)
 (i64.const -5409364890226003632)
 (i64.const 2244412773384604712)
 (i64.const 1605989338741628675)
 (i64.const 1450417759929778918)
 (i64.const -8816519005292960336)
 (i64.const 1874621017369538693)
 (i64.const 665883850346957067)
 (i64.const 1211445438634777304)
 (i64.const -3514853404985837908)
 (i64.const 1565756531257009982)
 (global.set $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2
  (array.new_fixed $ReadOnlyArray<UInt64> 26))
 (i32.const 0)
 (i32.const 0)
 (i32.const 0)
 (i32.const 0)
 (i32.const 1073741824)
 (i32.const 1500076437)
 (i32.const 1431590229)
 (i32.const 1448432917)
 (i32.const 1091896580)
 (i32.const 1079333904)
 (i32.const 1146442053)
 (i32.const 1146111296)
 (i32.const 1163220304)
 (i32.const 1073758208)
 (i32.const -1773927360)
 (i32.const 1431721317)
 (i32.const 1413824581)
 (i32.const 1075134801)
 (i32.const 1431671125)
 (i32.const 1363170645)
 (i32.const 261)
 (global.set $moonbitlang/core/double/internal/ryu.gPOW5_OFFSETS
  (array.new_fixed $ReadOnlyArray<UInt> 21))
 (i64.const 1)
 (i64.const 5)
 (i64.const 25)
 (i64.const 125)
 (i64.const 625)
 (i64.const 3125)
 (i64.const 15625)
 (i64.const 78125)
 (i64.const 390625)
 (i64.const 1953125)
 (i64.const 9765625)
 (i64.const 48828125)
 (i64.const 244140625)
 (i64.const 1220703125)
 (i64.const 6103515625)
 (i64.const 30517578125)
 (i64.const 152587890625)
 (i64.const 762939453125)
 (i64.const 3814697265625)
 (i64.const 19073486328125)
 (i64.const 95367431640625)
 (i64.const 476837158203125)
 (i64.const 2384185791015625)
 (i64.const 11920928955078125)
 (i64.const 59604644775390625)
 (i64.const 298023223876953125)
 (global.set $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE
  (array.new_fixed $ReadOnlyArray<UInt64> 26))
 (global.set $moonbitlang/core/double/internal/ryu.ryu_to_string.record/514
  (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
   (i64.const 0)
   (i32.const 0)))
 (global.set $username/moonbit_examples/cmd/enums.*main.c/537
  (struct.new $Shape.Circle
   (i32.const 0)
   (f64.const 0x1.4p+2)))
 (global.set $username/moonbit_examples/cmd/enums.*main.r/538
  (struct.new $Shape.Rectangle
   (i32.const 1)
   (f64.const 0x1p+2)
   (f64.const 0x1.8p+2))))
(func $*main*/1
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 21)
     (i32.const 1044)
     (i32.const 16))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double|
     (call $username/moonbit_examples/cmd/enums.area
      (ref.as_non_null
       (global.get $username/moonbit_examples/cmd/enums.*main.c/537)))))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 20)
     (i32.const 1006)
     (i32.const 19))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double|
     (call $username/moonbit_examples/cmd/enums.area
      (ref.as_non_null
       (global.get $username/moonbit_examples/cmd/enums.*main.r/538))))))))
(export "_start" (func $*main*/1))