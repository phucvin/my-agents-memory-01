(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data "0\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00d\00o\00u\00b\00l\00e\00/\00i\00n\00t\00e\00r\00n\00a\00l\00/\00r\00y\00u\00:\00r\00y\00u\00.\00m\00b\00t\00:\001\001\006\00:\003\00-\001\001\006\00:\004\005\00I\00l\00l\00e\00g\00a\00l\00A\00r\00g\00u\00m\00e\00n\00t\00E\00x\00c\00e\00p\00t\00i\00o\00n\00 \000\00.\000\00I\00n\00f\00i\00n\00i\00t\00y\00-\00N\00a\00N\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\006\006\003\00:\005\00-\006\006\003\00:\004\004\00r\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\008\00:\005\00-\002\009\008\00:\003\001\00C\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\0A\00\0A\00 \00 \00a\00t\00 \00A\00r\00e\00a\00 \00o\00f\00 \00r\00e\00c\00t\00a\00n\00g\00l\00e\00:\00 \00A\00r\00e\00a\00 \00o\00f\00 \00c\00i\00r\00c\00l\00e\00:\00 \00")
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
(global $moonbitlang/core/double/internal/ryu.ryu_to_string.record/487
 (mut (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (ref.null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64)
)
(global $username/moonbit_examples/cmd/enums.*main.c/510
 (mut (ref null $moonbit.enum))
 (ref.null $moonbit.enum)
)
(global $username/moonbit_examples/cmd/enums.*main.r/511
 (mut (ref null $moonbit.enum))
 (ref.null $moonbit.enum)
)
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 16)
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
(func $username/moonbit_examples/cmd/enums.area (param $shape/504 (ref $moonbit.enum)) (result f64)
 (local $*Circle/505 (ref $Shape.Circle))
 (local $*r/506 f64)
 (local $*Rectangle/507 (ref $Shape.Rectangle))
 (local $*w/508 f64)
 (local $*h/509 f64)
 (local $tag/781 i32)
 (if (result f64)
  (i32.eq
   (local.tee $tag/781
    (struct.get $moonbit.enum 0
     (local.get $shape/504)))
   (i32.const 0))
  (then
   (local.set $*r/506
    (struct.get $Shape.Circle 1
     (local.tee $*Circle/505
      (ref.cast (ref $Shape.Circle)
       (local.get $shape/504)))))
   (f64.mul
    (f64.mul
     (f64.const 0x1.921f9f01b866ep+1)
     (local.get $*r/506))
    (local.get $*r/506)))
  (else
   (local.set $*w/508
    (struct.get $Shape.Rectangle 1
     (local.tee $*Rectangle/507
      (ref.cast (ref $Shape.Rectangle)
       (local.get $shape/504)))))
   (local.set $*h/509
    (struct.get $Shape.Rectangle 2
     (local.get $*Rectangle/507)))
   (f64.mul
    (local.get $*w/508)
    (local.get $*h/509)))))
(func $@moonbitlang/core/builtin.Show::Double::output (param $self/503 f64) (param $logger/502 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/502)
  (call $Double::to_string
   (local.get $self/503))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/502))))
(func $Double::to_string (param $self/501 f64) (result (ref $moonbit.string))
 (call $moonbitlang/core/double/internal/ryu.ryu_to_string
  (local.get $self/501)))
(func $moonbitlang/core/double/internal/ryu.ryu_to_string (param $val/488 f64) (result (ref $moonbit.string))
 (local $bits/489 i64)
 (local $ieeeSign/490 i32)
 (local $ieeeMantissa/491 i64)
 (local $ieeeExponent/492 i32)
 (local $small/494 (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $*Some/495 (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $*f/496 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $q/498 i64)
 (local $r/499 i64)
 (local $v/493 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $x/497 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (if
  (f64.eq
   (local.get $val/488)
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
   (local.tee $bits/489
    (i64.reinterpret_f64
     (local.get $val/488)))
   (i64.extend_i32_s
    (i32.const 63)))
  (i64.const 1))
 (local.set $ieeeSign/490
  (i64.ne
   (i64.const 0)))
 (local.set $ieeeMantissa/491
  (i64.and
   (local.get $bits/489)
   (i64.const 4503599627370495)))
 (if
  (if (result i32)
   (i32.eq
    (local.tee $ieeeExponent/492
     (i32.wrap_i64
      (i64.and
       (i64.shr_u
        (local.get $bits/489)
        (i64.extend_i32_s
         (i32.const 52)))
       (i64.const 2047))))
    (i32.const 2047))
   (then
    (i32.const 1))
   (else
    (if (result i32)
     (i32.eq
      (local.get $ieeeExponent/492)
      (i32.const 0))
     (then
      (i64.eq
       (local.get $ieeeMantissa/491)
       (i64.const 0)))
     (else
      (i32.const 0)))))
  (then
   (local.get $ieeeSign/490)
   (local.get $ieeeExponent/492)
   (call $moonbitlang/core/double/internal/ryu.copy_special_str
    (i32.ne
     (i32.const 0))
    (local.get $ieeeMantissa/491)
    (i64.ne
     (i64.const 0)))
   (return))
  (else))
 (local.set $v/493
  (ref.as_non_null
   (global.get $moonbitlang/core/double/internal/ryu.ryu_to_string.record/487)))
 (if
  (ref.is_null
   (local.tee $small/494
    (call $moonbitlang/core/double/internal/ryu.d2d_small_int
     (local.get $ieeeMantissa/491)
     (local.get $ieeeExponent/492))))
  (then
   (local.set $v/493
    (call $moonbitlang/core/double/internal/ryu.d2d
     (local.get $ieeeMantissa/491)
     (local.get $ieeeExponent/492))))
  (else
   (local.set $x/497
    (local.tee $*f/496
     (ref.as_non_null
      (local.tee $*Some/495
       (local.get $small/494)))))
   (block $break:500
    (loop $loop:500
     (local.set $q/498
      (i64.div_u
       (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 0
        (local.get $x/497))
       (i64.const 10)))
     (local.tee $r/499
      (i64.sub
       (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 0
        (local.get $x/497))
       (i64.mul
        (i64.const 10)
        (local.get $q/498))))
     (if
      (i64.ne
       (i64.const 0))
      (then
       (br $break:500))
      (else))
     (local.set $x/497
      (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
       (local.get $q/498)
       (i32.add
        (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 1
         (local.get $x/497))
        (i32.const 1))))
     (br $loop:500)))
   (local.set $v/493
    (local.get $x/497))))
 (call $moonbitlang/core/double/internal/ryu.to_chars
  (local.get $v/493)
  (local.get $ieeeSign/490)))
(func $moonbitlang/core/double/internal/ryu.d2d_small_int (param $ieeeMantissa/482 i64) (param $ieeeExponent/484 i32) (result (ref null $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $m2/481 i64)
 (local $e2/483 i32)
 (local $mask/485 i64)
 (local $fraction/486 i64)
 (local.set $m2/481
  (i64.or
   (i64.const 4503599627370496)
   (local.get $ieeeMantissa/482)))
 (if
  (i32.gt_s
   (local.tee $e2/483
    (i32.sub
     (i32.sub
      (local.get $ieeeExponent/484)
      (i32.const 1023))
     (i32.const 52)))
   (i32.const 0))
  (then
   (ref.null none)
   (return))
  (else))
 (if
  (i32.lt_s
   (local.get $e2/483)
   (i32.const -52))
  (then
   (ref.null none)
   (return))
  (else))
 (local.set $mask/485
  (i64.sub
   (i64.shl
    (i64.const 1)
    (i64.extend_i32_s
     (i32.sub
      (i32.const 0)
      (local.get $e2/483))))
   (i64.const 1)))
 (local.tee $fraction/486
  (i64.and
   (local.get $m2/481)
   (local.get $mask/485)))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (ref.null none)
   (return))
  (else))
 (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
  (i64.shr_u
   (local.get $m2/481)
   (i64.extend_i32_s
    (i32.sub
     (i32.const 0)
     (local.get $e2/483))))
  (i32.const 0)))
(func $moonbitlang/core/double/internal/ryu.to_chars (param $v/455 (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64)) (param $sign/453 i32) (result (ref $moonbit.string))
 (local $result/451 (ref $moonbit.bytes))
 (local $olength/456 i32)
 (local $scientificNotation/458 i32)
 (local $*end41/459 i32)
 (local $i/460 i32)
 (local $c/461 i64)
 (local $a/463 i32)
 (local $b/464 i32)
 (local $c/465 i32)
 (local $a/466 i32)
 (local $b/467 i32)
 (local $i/468 i32)
 (local $current/470 i32)
 (local $i/471 i32)
 (local $i/473 i32)
 (local $*end64/475 i32)
 (local $i/476 i32)
 (local $i/479 i32)
 (local $index/452 i32)
 (local $output/454 i64)
 (local $exp/457 i32)
 (local $current/478 i32)
 (local.set $result/451
  (array.new $moonbit.bytes
   (i32.const 0)
   (i32.const 25)))
 (local.set $index/452
  (i32.const 0))
 (if
  (local.get $sign/453)
  (then
   (array.set $moonbit.bytes
    (local.get $result/451)
    (local.get $index/452)
    (i32.const 45))
   (local.set $index/452
    (i32.add
     (local.get $index/452)
     (i32.const 1))))
  (else))
 (local.set $olength/456
  (call $moonbitlang/core/double/internal/ryu.decimal_length17
   (local.tee $output/454
    (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 0
     (local.get $v/455)))))
 (if (result (ref $moonbit.string))
  (local.tee $scientificNotation/458
   (i32.eqz
    (if (result i32)
     (i32.ge_s
      (local.tee $exp/457
       (i32.sub
        (i32.add
         (struct.get $@moonbitlang/core/double/internal/ryu.FloatingDecimal64 1
          (local.get $v/455))
         (local.get $olength/456))
        (i32.const 1)))
      (i32.const -6))
     (then
      (i32.lt_s
       (local.get $exp/457)
       (i32.const 21)))
     (else
      (i32.const 0)))))
  (then
   (local.set $*end41/459
    (i32.sub
     (local.get $olength/456)
     (i32.const 1)))
   (i32.const 0)
   (loop $loop:462 (param i32)
    (local.tee $i/460)
    (local.get $*end41/459)
    (i32.lt_s)
    (if
     (then
      (local.set $c/461
       (i64.rem_u
        (local.get $output/454)
        (i64.const 10)))
      (local.set $output/454
       (i64.div_u
        (local.get $output/454)
        (i64.const 10)))
      (array.set $moonbit.bytes
       (local.get $result/451)
       (i32.sub
        (i32.add
         (local.get $index/452)
         (local.get $olength/456))
        (local.get $i/460))
       (i32.and
        (i32.add
         (i32.const 48)
         (i32.wrap_i64
          (local.get $c/461)))
        (i32.const 255)))
      (i32.add
       (local.get $i/460)
       (i32.const 1))
      (br $loop:462))
     (else)))
   (array.set $moonbit.bytes
    (local.get $result/451)
    (local.get $index/452)
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (i32.wrap_i64
        (local.get $output/454))
       (i32.const 10)))
     (i32.const 255)))
   (if
    (i32.gt_s
     (local.get $olength/456)
     (i32.const 1))
    (then
     (array.set $moonbit.bytes
      (local.get $result/451)
      (i32.add
       (local.get $index/452)
       (i32.const 1))
      (i32.const 46)))
    (else
     (local.set $index/452
      (i32.sub
       (local.get $index/452)
       (i32.const 1)))))
   (local.set $index/452
    (i32.add
     (local.get $index/452)
     (i32.add
      (local.get $olength/456)
      (i32.const 1))))
   (array.set $moonbit.bytes
    (local.get $result/451)
    (local.get $index/452)
    (i32.const 101))
   (local.set $index/452
    (i32.add
     (local.get $index/452)
     (i32.const 1)))
   (if
    (i32.lt_s
     (local.get $exp/457)
     (i32.const 0))
    (then
     (array.set $moonbit.bytes
      (local.get $result/451)
      (local.get $index/452)
      (i32.const 45))
     (local.set $index/452
      (i32.add
       (local.get $index/452)
       (i32.const 1)))
     (local.set $exp/457
      (i32.sub
       (i32.const 0)
       (local.get $exp/457))))
    (else
     (array.set $moonbit.bytes
      (local.get $result/451)
      (local.get $index/452)
      (i32.const 43))
     (local.set $index/452
      (i32.add
       (local.get $index/452)
       (i32.const 1)))))
   (if
    (i32.ge_s
     (local.get $exp/457)
     (i32.const 100))
    (then
     (local.set $a/463
      (i32.div_s
       (local.get $exp/457)
       (i32.const 100)))
     (local.set $b/464
      (i32.rem_s
       (i32.div_s
        (local.get $exp/457)
        (i32.const 10))
       (i32.const 10)))
     (local.set $c/465
      (i32.rem_s
       (local.get $exp/457)
       (i32.const 10)))
     (array.set $moonbit.bytes
      (local.get $result/451)
      (local.get $index/452)
      (i32.and
       (i32.add
        (i32.const 48)
        (local.get $a/463))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $result/451)
      (i32.add
       (local.get $index/452)
       (i32.const 1))
      (i32.and
       (i32.add
        (i32.const 48)
        (local.get $b/464))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $result/451)
      (i32.add
       (local.get $index/452)
       (i32.const 2))
      (i32.and
       (i32.add
        (i32.const 48)
        (local.get $c/465))
       (i32.const 255)))
     (local.set $index/452
      (i32.add
       (local.get $index/452)
       (i32.const 3))))
    (else
     (if
      (i32.ge_s
       (local.get $exp/457)
       (i32.const 10))
      (then
       (local.set $a/466
        (i32.div_s
         (local.get $exp/457)
         (i32.const 10)))
       (local.set $b/467
        (i32.rem_s
         (local.get $exp/457)
         (i32.const 10)))
       (array.set $moonbit.bytes
        (local.get $result/451)
        (local.get $index/452)
        (i32.and
         (i32.add
          (i32.const 48)
          (local.get $a/466))
         (i32.const 255)))
       (array.set $moonbit.bytes
        (local.get $result/451)
        (i32.add
         (local.get $index/452)
         (i32.const 1))
        (i32.and
         (i32.add
          (i32.const 48)
          (local.get $b/467))
         (i32.const 255)))
       (local.set $index/452
        (i32.add
         (local.get $index/452)
         (i32.const 2))))
      (else
       (array.set $moonbit.bytes
        (local.get $result/451)
        (local.get $index/452)
        (i32.and
         (i32.add
          (i32.const 48)
          (local.get $exp/457))
         (i32.const 255)))
       (local.set $index/452
        (i32.add
         (local.get $index/452)
         (i32.const 1)))))))
   (call $moonbitlang/core/double/internal/ryu.string_from_bytes
    (local.get $result/451)
    (i32.const 0)
    (local.get $index/452)))
  (else
   (if
    (i32.lt_s
     (local.get $exp/457)
     (i32.const 0))
    (then
     (array.set $moonbit.bytes
      (local.get $result/451)
      (local.get $index/452)
      (i32.const 48))
     (local.set $index/452
      (i32.add
       (local.get $index/452)
       (i32.const 1)))
     (array.set $moonbit.bytes
      (local.get $result/451)
      (local.get $index/452)
      (i32.const 46))
     (local.set $index/452
      (i32.add
       (local.get $index/452)
       (i32.const 1)))
     (i32.const -1)
     (loop $loop:469 (param i32)
      (local.tee $i/468)
      (local.get $exp/457)
      (i32.gt_s)
      (if
       (then
        (array.set $moonbit.bytes
         (local.get $result/451)
         (local.get $index/452)
         (i32.const 48))
        (local.set $index/452
         (i32.add
          (local.get $index/452)
          (i32.const 1)))
        (i32.sub
         (local.get $i/468)
         (i32.const 1))
        (br $loop:469))
       (else)))
     (local.set $current/470
      (local.get $index/452))
     (i32.const 0)
     (loop $loop:472 (param i32)
      (local.tee $i/471)
      (local.get $olength/456)
      (i32.lt_s)
      (if
       (then
        (array.set $moonbit.bytes
         (local.get $result/451)
         (i32.sub
          (i32.sub
           (i32.add
            (local.get $current/470)
            (local.get $olength/456))
           (local.get $i/471))
          (i32.const 1))
         (i32.and
          (i32.add
           (i32.const 48)
           (i32.wrap_i64
            (i64.rem_u
             (local.get $output/454)
             (i64.const 10))))
          (i32.const 255)))
        (local.set $output/454
         (i64.div_u
          (local.get $output/454)
          (i64.const 10)))
        (local.set $index/452
         (i32.add
          (local.get $index/452)
          (i32.const 1)))
        (i32.add
         (local.get $i/471)
         (i32.const 1))
        (br $loop:472))
       (else))))
    (else
     (if
      (i32.ge_s
       (i32.add
        (local.get $exp/457)
        (i32.const 1))
       (local.get $olength/456))
      (then
       (i32.const 0)
       (loop $loop:474 (param i32)
        (local.tee $i/473)
        (local.get $olength/456)
        (i32.lt_s)
        (if
         (then
          (array.set $moonbit.bytes
           (local.get $result/451)
           (i32.sub
            (i32.sub
             (i32.add
              (local.get $index/452)
              (local.get $olength/456))
             (local.get $i/473))
            (i32.const 1))
           (i32.and
            (i32.add
             (i32.const 48)
             (i32.wrap_i64
              (i64.rem_u
               (local.get $output/454)
               (i64.const 10))))
            (i32.const 255)))
          (local.set $output/454
           (i64.div_u
            (local.get $output/454)
            (i64.const 10)))
          (i32.add
           (local.get $i/473)
           (i32.const 1))
          (br $loop:474))
         (else)))
       (local.set $index/452
        (i32.add
         (local.get $index/452)
         (local.get $olength/456)))
       (local.set $*end64/475
        (i32.add
         (local.get $exp/457)
         (i32.const 1)))
       (local.get $olength/456)
       (loop $loop:477 (param i32)
        (local.tee $i/476)
        (local.get $*end64/475)
        (i32.lt_s)
        (if
         (then
          (array.set $moonbit.bytes
           (local.get $result/451)
           (local.get $index/452)
           (i32.const 48))
          (local.set $index/452
           (i32.add
            (local.get $index/452)
            (i32.const 1)))
          (i32.add
           (local.get $i/476)
           (i32.const 1))
          (br $loop:477))
         (else))))
      (else
       (local.set $current/478
        (i32.add
         (local.get $index/452)
         (i32.const 1)))
       (i32.const 0)
       (loop $loop:480 (param i32)
        (local.tee $i/479)
        (local.get $olength/456)
        (i32.lt_s)
        (if
         (then
          (if
           (i32.eq
            (i32.sub
             (i32.sub
              (local.get $olength/456)
              (local.get $i/479))
             (i32.const 1))
            (local.get $exp/457))
           (then
            (array.set $moonbit.bytes
             (local.get $result/451)
             (i32.sub
              (i32.sub
               (i32.add
                (local.get $current/478)
                (local.get $olength/456))
               (local.get $i/479))
              (i32.const 1))
             (i32.const 46))
            (local.set $current/478
             (i32.sub
              (local.get $current/478)
              (i32.const 1))))
           (else))
          (array.set $moonbit.bytes
           (local.get $result/451)
           (i32.sub
            (i32.sub
             (i32.add
              (local.get $current/478)
              (local.get $olength/456))
             (local.get $i/479))
            (i32.const 1))
           (i32.and
            (i32.add
             (i32.const 48)
             (i32.wrap_i64
              (i64.rem_u
               (local.get $output/454)
               (i64.const 10))))
            (i32.const 255)))
          (local.set $output/454
           (i64.div_u
            (local.get $output/454)
            (i64.const 10)))
          (i32.add
           (local.get $i/479)
           (i32.const 1))
          (br $loop:480))
         (else)))
       (local.set $index/452
        (i32.add
         (local.get $index/452)
         (i32.add
          (local.get $olength/456)
          (i32.const 1))))))))
   (call $moonbitlang/core/double/internal/ryu.string_from_bytes
    (local.get $result/451)
    (i32.const 0)
    (local.get $index/452)))))
(func $moonbitlang/core/double/internal/ryu.d2d (param $ieeeMantissa/397 i64) (param $ieeeExponent/396 i32) (result (ref $@moonbitlang/core/double/internal/ryu.FloatingDecimal64))
 (local $even/398 i32)
 (local $mv/399 i64)
 (local $mmShift/400 i32)
 (local $q/407 i32)
 (local $k/408 i32)
 (local $i/409 i32)
 (local $pow5/410 (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $*bind/411 (ref $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result))
 (local $*vrOut/412 i64)
 (local $*vpOut/413 i64)
 (local $*vmOut/414 i64)
 (local $mvMod5/415 i32)
 (local $q/416 i32)
 (local $i/417 i32)
 (local $k/418 i32)
 (local $j/419 i32)
 (local $pow5/420 (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $*bind/421 (ref $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result))
 (local $*vrOut/422 i64)
 (local $*vpOut/423 i64)
 (local $*vmOut/424 i64)
 (local $vpDiv10/428 i64)
 (local $vmDiv10/429 i64)
 (local $vmMod10/431 i32)
 (local $vrDiv10/432 i64)
 (local $vrMod10/433 i32)
 (local $vmDiv10/434 i64)
 (local $vmMod10/435 i32)
 (local $vpDiv10/437 i64)
 (local $vrDiv10/438 i64)
 (local $vrMod10/439 i32)
 (local $vpDiv100/441 i64)
 (local $vmDiv100/442 i64)
 (local $vrDiv100/443 i64)
 (local $vrMod100/444 i32)
 (local $vpDiv10/445 i64)
 (local $vmDiv10/446 i64)
 (local $vrDiv10/448 i64)
 (local $vrMod10/449 i32)
 (local $exp/450 i32)
 (local $*p/720 i32)
 (local $*p/723 i32)
 (local $*p/730 i32)
 (local $*p/733 i32)
 (local $*p/736 i32)
 (local $*p/745 i32)
 (local $*p/748 i32)
 (local $e2/394 i32)
 (local $m2/395 i64)
 (local $vr/401 i64)
 (local $vp/402 i64)
 (local $vm/403 i64)
 (local $e10/404 i32)
 (local $vmIsTrailingZeros/405 i32)
 (local $vrIsTrailingZeros/406 i32)
 (local $removed/425 i32)
 (local $lastRemovedDigit/426 i32)
 (local $output/427 i64)
 (local $roundUp/440 i32)
 (local.set $e2/394
  (i32.const 0))
 (local.set $m2/395
  (i64.const 0))
 (if
  (i32.eq
   (local.get $ieeeExponent/396)
   (i32.const 0))
  (then
   (local.set $e2/394
    (i32.const -1076))
   (local.set $m2/395
    (local.get $ieeeMantissa/397)))
  (else
   (local.set $e2/394
    (i32.sub
     (i32.sub
      (i32.sub
       (local.get $ieeeExponent/396)
       (i32.const 1023))
      (i32.const 52))
     (i32.const 2)))
   (local.set $m2/395
    (i64.or
     (i64.const 4503599627370496)
     (local.get $ieeeMantissa/397)))))
 (local.set $even/398
  (i64.eq
   (i64.and
    (local.get $m2/395)
    (i64.const 1))
   (i64.const 0)))
 (local.set $mv/399
  (i64.mul
   (i64.const 4)
   (local.get $m2/395)))
 (local.get $ieeeMantissa/397)
 (local.set $mmShift/400
  (if (result i32)
   (i64.ne
    (i64.const 0))
   (then
    (i32.const 1))
   (else
    (i32.le_u
     (local.get $ieeeExponent/396)
     (i32.const 1)))))
 (local.set $vr/401
  (i64.const 0))
 (local.set $vp/402
  (i64.const 0))
 (local.set $vm/403
  (i64.const 0))
 (local.set $e10/404
  (i32.const 0))
 (local.set $vmIsTrailingZeros/405
  (i32.const 0))
 (local.set $vrIsTrailingZeros/406
  (i32.const 0))
 (if
  (i32.ge_s
   (local.get $e2/394)
   (i32.const 0))
  (then
   (local.set $e10/404
    (local.tee $q/407
     (i32.sub
      (i32.shr_u
       (i32.mul
        (local.tee $*p/720
         (local.get $e2/394))
        (i32.const 78913))
       (i32.const 18))
      (if (result i32)
       (local.tee $*p/723
        (i32.gt_s
         (local.get $e2/394)
         (i32.const 3)))
       (then
        (i32.const 1))
       (else
        (i32.const 0))))))
   (local.set $k/408
    (i32.sub
     (i32.add
      (i32.const 125)
      (i32.add
       (i32.shr_u
        (i32.mul
         (local.get $q/407)
         (i32.const 1217359))
        (i32.const 19))
       (i32.const 1)))
     (i32.const 1)))
   (local.set $i/409
    (i32.add
     (i32.add
      (i32.sub
       (i32.const 0)
       (local.get $e2/394))
      (local.get $q/407))
     (local.get $k/408)))
   (local.set $pow5/410
    (call $moonbitlang/core/double/internal/ryu.double_computeInvPow5
     (local.get $q/407)))
   (local.set $*vrOut/412
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 0
     (local.tee $*bind/411
      (call $moonbitlang/core/double/internal/ryu.mulShiftAll64
       (local.get $m2/395)
       (local.get $pow5/410)
       (local.get $i/409)
       (local.get $mmShift/400)))))
   (local.set $*vpOut/413
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 1
     (local.get $*bind/411)))
   (local.set $*vmOut/414
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 2
     (local.get $*bind/411)))
   (local.set $vr/401
    (local.get $*vrOut/412))
   (local.set $vp/402
    (local.get $*vpOut/413))
   (local.set $vm/403
    (local.get $*vmOut/414))
   (if
    (i32.le_s
     (local.get $q/407)
     (i32.const 21))
    (then
     (if
      (i32.eq
       (local.tee $mvMod5/415
        (i32.sub
         (i32.wrap_i64
          (local.get $mv/399))
         (i32.mul
          (i32.const 5)
          (i32.wrap_i64
           (i64.div_u
            (local.get $mv/399)
            (i64.const 5))))))
       (i32.const 0))
      (then
       (local.set $vrIsTrailingZeros/406
        (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
         (local.get $mv/399)
         (local.get $q/407))))
      (else
       (if
        (local.get $even/398)
        (then
         (local.set $vmIsTrailingZeros/405
          (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
           (i64.sub
            (i64.sub
             (local.get $mv/399)
             (i64.const 1))
            (if (result i64)
             (local.get $mmShift/400)
             (then
              (i64.const 1))
             (else
              (i64.const 0))))
           (local.get $q/407))))
        (else
         (local.set $vp/402
          (i64.sub
           (local.get $vp/402)
           (if (result i64)
            (local.tee $*p/730
             (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
              (i64.add
               (local.get $mv/399)
               (i64.const 2))
              (local.get $q/407)))
            (then
             (i64.const 1))
            (else
             (i64.const 0))))))))))
    (else)))
  (else
   (local.set $e10/404
    (i32.add
     (local.tee $q/416
      (i32.sub
       (i32.shr_u
        (i32.mul
         (local.tee $*p/733
          (i32.sub
           (i32.const 0)
           (local.get $e2/394)))
         (i32.const 732923))
        (i32.const 20))
       (if (result i32)
        (local.tee $*p/736
         (i32.gt_s
          (i32.sub
           (i32.const 0)
           (local.get $e2/394))
          (i32.const 1)))
        (then
         (i32.const 1))
        (else
         (i32.const 0)))))
     (local.get $e2/394)))
   (local.set $k/418
    (i32.sub
     (i32.add
      (i32.shr_u
       (i32.mul
        (local.tee $i/417
         (i32.sub
          (i32.sub
           (i32.const 0)
           (local.get $e2/394))
          (local.get $q/416)))
        (i32.const 1217359))
       (i32.const 19))
      (i32.const 1))
     (i32.const 125)))
   (local.set $j/419
    (i32.sub
     (local.get $q/416)
     (local.get $k/418)))
   (local.set $pow5/420
    (call $moonbitlang/core/double/internal/ryu.double_computePow5
     (local.get $i/417)))
   (local.set $*vrOut/422
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 0
     (local.tee $*bind/421
      (call $moonbitlang/core/double/internal/ryu.mulShiftAll64
       (local.get $m2/395)
       (local.get $pow5/420)
       (local.get $j/419)
       (local.get $mmShift/400)))))
   (local.set $*vpOut/423
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 1
     (local.get $*bind/421)))
   (local.set $*vmOut/424
    (struct.get $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result 2
     (local.get $*bind/421)))
   (local.set $vr/401
    (local.get $*vrOut/422))
   (local.set $vp/402
    (local.get $*vpOut/423))
   (local.set $vm/403
    (local.get $*vmOut/424))
   (if
    (i32.le_s
     (local.get $q/416)
     (i32.const 1))
    (then
     (local.set $vrIsTrailingZeros/406
      (i32.const 1))
     (if
      (local.get $even/398)
      (then
       (local.set $vmIsTrailingZeros/405
        (i32.eq
         (if (result i32)
          (local.get $mmShift/400)
          (then
           (i32.const 1))
          (else
           (i32.const 0)))
         (i32.const 1))))
      (else
       (local.set $vp/402
        (i64.sub
         (local.get $vp/402)
         (i64.const 1))))))
    (else
     (if
      (i32.lt_s
       (local.get $q/416)
       (i32.const 63))
      (then
       (local.set $vrIsTrailingZeros/406
        (i64.eq
         (i64.and
          (local.get $mv/399)
          (i64.sub
           (i64.shl
            (i64.const 1)
            (i64.extend_i32_s
             (local.get $q/416)))
           (i64.const 1)))
         (i64.const 0))))
      (else))))))
 (local.set $removed/425
  (i32.const 0))
 (local.set $lastRemovedDigit/426
  (i32.const 0))
 (local.set $output/427
  (i64.const 0))
 (if
  (if (result i32)
   (local.get $vmIsTrailingZeros/405)
   (then
    (i32.const 1))
   (else
    (local.get $vrIsTrailingZeros/406)))
  (then
   (block $break:430
    (loop $loop:430
     (local.set $vpDiv10/428
      (i64.div_u
       (local.get $vp/402)
       (i64.const 10)))
     (local.set $vmDiv10/429
      (i64.div_u
       (local.get $vm/403)
       (i64.const 10)))
     (if
      (i64.le_u
       (local.get $vpDiv10/428)
       (local.get $vmDiv10/429))
      (then
       (br $break:430))
      (else))
     (local.set $vmMod10/431
      (i32.sub
       (i32.wrap_i64
        (local.get $vm/403))
       (i32.mul
        (i32.const 10)
        (i32.wrap_i64
         (local.get $vmDiv10/429)))))
     (local.set $vrDiv10/432
      (i64.div_u
       (local.get $vr/401)
       (i64.const 10)))
     (local.set $vrMod10/433
      (i32.sub
       (i32.wrap_i64
        (local.get $vr/401))
       (i32.mul
        (i32.const 10)
        (i32.wrap_i64
         (local.get $vrDiv10/432)))))
     (local.set $vmIsTrailingZeros/405
      (if (result i32)
       (local.get $vmIsTrailingZeros/405)
       (then
        (i32.eq
         (local.get $vmMod10/431)
         (i32.const 0)))
       (else
        (i32.const 0))))
     (local.set $vrIsTrailingZeros/406
      (if (result i32)
       (local.get $vrIsTrailingZeros/406)
       (then
        (i32.eq
         (local.get $lastRemovedDigit/426)
         (i32.const 0)))
       (else
        (i32.const 0))))
     (local.set $lastRemovedDigit/426
      (local.get $vrMod10/433))
     (local.set $vr/401
      (local.get $vrDiv10/432))
     (local.set $vp/402
      (local.get $vpDiv10/428))
     (local.set $vm/403
      (local.get $vmDiv10/429))
     (local.set $removed/425
      (i32.add
       (local.get $removed/425)
       (i32.const 1)))
     (br $loop:430)))
   (if
    (local.get $vmIsTrailingZeros/405)
    (then
     (block $break:436
      (loop $loop:436
       (local.set $vmDiv10/434
        (i64.div_u
         (local.get $vm/403)
         (i64.const 10)))
       (local.tee $vmMod10/435
        (i32.sub
         (i32.wrap_i64
          (local.get $vm/403))
         (i32.mul
          (i32.const 10)
          (i32.wrap_i64
           (local.get $vmDiv10/434)))))
       (if
        (i32.ne
         (i32.const 0))
        (then
         (br $break:436))
        (else))
       (local.set $vpDiv10/437
        (i64.div_u
         (local.get $vp/402)
         (i64.const 10)))
       (local.set $vrDiv10/438
        (i64.div_u
         (local.get $vr/401)
         (i64.const 10)))
       (local.set $vrMod10/439
        (i32.sub
         (i32.wrap_i64
          (local.get $vr/401))
         (i32.mul
          (i32.const 10)
          (i32.wrap_i64
           (local.get $vrDiv10/438)))))
       (local.set $vrIsTrailingZeros/406
        (if (result i32)
         (local.get $vrIsTrailingZeros/406)
         (then
          (i32.eq
           (local.get $lastRemovedDigit/426)
           (i32.const 0)))
         (else
          (i32.const 0))))
       (local.set $lastRemovedDigit/426
        (local.get $vrMod10/439))
       (local.set $vr/401
        (local.get $vrDiv10/438))
       (local.set $vp/402
        (local.get $vpDiv10/437))
       (local.set $vm/403
        (local.get $vmDiv10/434))
       (local.set $removed/425
        (i32.add
         (local.get $removed/425)
         (i32.const 1)))
       (br $loop:436))))
    (else))
   (if
    (if (result i32)
     (local.get $vrIsTrailingZeros/406)
     (then
      (if (result i32)
       (i32.eq
        (local.get $lastRemovedDigit/426)
        (i32.const 5))
       (then
        (i64.eq
         (i64.rem_u
          (local.get $vr/401)
          (i64.const 2))
         (i64.const 0)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (local.set $lastRemovedDigit/426
      (i32.const 4)))
    (else))
   (local.set $output/427
    (i64.add
     (local.get $vr/401)
     (if (result i64)
      (local.tee $*p/745
       (if (result i32)
        (if (result i32)
         (i64.eq
          (local.get $vr/401)
          (local.get $vm/403))
         (then
          (if (result i32)
           (i32.eqz
            (local.get $even/398))
           (then
            (i32.const 1))
           (else
            (i32.eqz
             (local.get $vmIsTrailingZeros/405)))))
         (else
          (i32.const 0)))
        (then
         (i32.const 1))
        (else
         (i32.ge_s
          (local.get $lastRemovedDigit/426)
          (i32.const 5)))))
      (then
       (i64.const 1))
      (else
       (i64.const 0))))))
  (else
   (local.set $roundUp/440
    (i32.const 0))
   (local.set $vpDiv100/441
    (i64.div_u
     (local.get $vp/402)
     (i64.const 100)))
   (local.set $vmDiv100/442
    (i64.div_u
     (local.get $vm/403)
     (i64.const 100)))
   (if
    (i64.gt_u
     (local.get $vpDiv100/441)
     (local.get $vmDiv100/442))
    (then
     (local.set $vrDiv100/443
      (i64.div_u
       (local.get $vr/401)
       (i64.const 100)))
     (local.set $roundUp/440
      (i32.ge_s
       (local.tee $vrMod100/444
        (i32.sub
         (i32.wrap_i64
          (local.get $vr/401))
         (i32.mul
          (i32.const 100)
          (i32.wrap_i64
           (local.get $vrDiv100/443)))))
       (i32.const 50)))
     (local.set $vr/401
      (local.get $vrDiv100/443))
     (local.set $vp/402
      (local.get $vpDiv100/441))
     (local.set $vm/403
      (local.get $vmDiv100/442))
     (local.set $removed/425
      (i32.add
       (local.get $removed/425)
       (i32.const 2))))
    (else))
   (block $break:447
    (loop $loop:447
     (local.set $vpDiv10/445
      (i64.div_u
       (local.get $vp/402)
       (i64.const 10)))
     (local.set $vmDiv10/446
      (i64.div_u
       (local.get $vm/403)
       (i64.const 10)))
     (if
      (i64.le_u
       (local.get $vpDiv10/445)
       (local.get $vmDiv10/446))
      (then
       (br $break:447))
      (else))
     (local.set $vrDiv10/448
      (i64.div_u
       (local.get $vr/401)
       (i64.const 10)))
     (local.set $roundUp/440
      (i32.ge_s
       (local.tee $vrMod10/449
        (i32.sub
         (i32.wrap_i64
          (local.get $vr/401))
         (i32.mul
          (i32.const 10)
          (i32.wrap_i64
           (local.get $vrDiv10/448)))))
       (i32.const 5)))
     (local.set $vr/401
      (local.get $vrDiv10/448))
     (local.set $vp/402
      (local.get $vpDiv10/445))
     (local.set $vm/403
      (local.get $vmDiv10/446))
     (local.set $removed/425
      (i32.add
       (local.get $removed/425)
       (i32.const 1)))
     (br $loop:447)))
   (local.set $output/427
    (i64.add
     (local.get $vr/401)
     (if (result i64)
      (local.tee $*p/748
       (if (result i32)
        (i64.eq
         (local.get $vr/401)
         (local.get $vm/403))
        (then
         (i32.const 1))
        (else
         (local.get $roundUp/440))))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))))
 (local.set $exp/450
  (i32.add
   (local.get $e10/404)
   (local.get $removed/425)))
 (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
  (local.get $output/427)
  (local.get $exp/450)))
(func $moonbitlang/core/double/internal/ryu.decimal_length17 (param $v/393 i64) (result i32)
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 10000000000000000))
  (then
   (i32.const 17)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 1000000000000000))
  (then
   (i32.const 16)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 100000000000000))
  (then
   (i32.const 15)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 10000000000000))
  (then
   (i32.const 14)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 1000000000000))
  (then
   (i32.const 13)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 100000000000))
  (then
   (i32.const 12)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 10000000000))
  (then
   (i32.const 11)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 1000000000))
  (then
   (i32.const 10)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 100000000))
  (then
   (i32.const 9)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 10000000))
  (then
   (i32.const 8)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 1000000))
  (then
   (i32.const 7)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 100000))
  (then
   (i32.const 6)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 10000))
  (then
   (i32.const 5)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 1000))
  (then
   (i32.const 4)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 100))
  (then
   (i32.const 3)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/393)
   (i64.const 10))
  (then
   (i32.const 2)
   (return))
  (else))
 (i32.const 1))
(func $moonbitlang/core/double/internal/ryu.double_computeInvPow5 (param $i/376 i32) (result (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $base/375 i32)
 (local $base2/377 i32)
 (local $offset/378 i32)
 (local $mul0/379 i64)
 (local $mul1/380 i64)
 (local $m/381 i64)
 (local $*bind/382 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low1/383 i64)
 (local $*high1/384 i64)
 (local $*bind/385 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low0/386 i64)
 (local $*high0/387 i64)
 (local $sum/388 i64)
 (local $delta/390 i32)
 (local $a/391 i64)
 (local $b/392 i64)
 (local $*p/697 i32)
 (local $*p/700 i32)
 (local $*p/711 i32)
 (local $*p/714 i32)
 (local $*p/717 i64)
 (local $high1/389 i64)
 (local.set $offset/378
  (i32.sub
   (local.tee $base2/377
    (i32.mul
     (local.tee $base/375
      (i32.div_s
       (i32.sub
        (i32.add
         (local.get $i/376)
         (i32.const 26))
        (i32.const 1))
       (i32.const 26)))
     (i32.const 26)))
   (local.get $i/376)))
 (local.set $*p/697
  (i32.mul
   (local.get $base/375)
   (i32.const 2)))
 (local.set $mul0/379
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
   (local.get $*p/697)))
 (local.set $*p/700
  (i32.add
   (i32.mul
    (local.get $base/375)
    (i32.const 2))
   (i32.const 1)))
 (local.set $mul1/380
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
   (local.get $*p/700)))
 (if
  (i32.eq
   (local.get $offset/378)
   (i32.const 0))
  (then
   (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
    (local.get $mul0/379)
    (local.get $mul1/380))
   (return))
  (else))
 (local.set $*low1/383
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/382
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.tee $m/381
      (array.get $ReadOnlyArray<UInt64>
       (ref.as_non_null
        (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
       (local.get $offset/378)))
     (local.get $mul1/380)))))
 (local.set $*high1/384
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/382)))
 (local.set $*low0/386
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/385
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.get $m/381)
     (local.get $mul0/379)))))
 (local.set $sum/388
  (i64.add
   (local.tee $*high0/387
    (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
     (local.get $*bind/385)))
   (local.get $*low1/383)))
 (local.set $high1/389
  (local.get $*high1/384))
 (if
  (i64.lt_u
   (local.get $sum/388)
   (local.get $*high0/387))
  (then
   (local.set $high1/389
    (i64.add
     (local.get $high1/389)
     (i64.const 1))))
  (else))
 (local.set $delta/390
  (i32.sub
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $base2/377)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $i/376)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))))
 (i64.add
  (i64.or
   (i64.shl
    (local.get $sum/388)
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $delta/390))))
   (i64.shr_u
    (local.get $*low0/386)
    (i64.extend_i32_s
     (local.get $delta/390))))
  (i64.const 1))
 (local.set $*p/711
  (i32.div_s
   (local.get $i/376)
   (i32.const 16)))
 (i64.extend_i32_u
  (local.tee $*p/714
   (i32.and
    (i32.shr_u
     (array.get $ReadOnlyArray<UInt>
      (ref.as_non_null
       (global.get $moonbitlang/core/double/internal/ryu.gPOW5_INV_OFFSETS))
      (local.get $*p/711))
     (i32.shl
      (i32.rem_s
       (local.get $i/376)
       (i32.const 16))
      (i32.const 1)))
    (i32.const 3))))
 (i64.add)
 (local.set $a/391)
 (local.set $b/392
  (i64.or
   (i64.shl
    (local.tee $*p/717
     (local.get $high1/389))
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $delta/390))))
   (i64.shr_u
    (local.get $sum/388)
    (i64.extend_i32_s
     (local.get $delta/390)))))
 (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
  (local.get $a/391)
  (local.get $b/392)))
(func $moonbitlang/core/double/internal/ryu.double_computePow5 (param $i/358 i32) (result (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair))
 (local $base/357 i32)
 (local $base2/359 i32)
 (local $offset/360 i32)
 (local $mul0/361 i64)
 (local $mul1/362 i64)
 (local $m/363 i64)
 (local $*bind/364 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low1/365 i64)
 (local $*high1/366 i64)
 (local $*bind/367 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*low0/368 i64)
 (local $*high0/369 i64)
 (local $sum/370 i64)
 (local $delta/372 i32)
 (local $a/373 i64)
 (local $b/374 i64)
 (local $*p/674 i32)
 (local $*p/677 i32)
 (local $*p/688 i32)
 (local $*p/691 i32)
 (local $*p/694 i64)
 (local $high1/371 i64)
 (local.set $base2/359
  (i32.mul
   (local.tee $base/357
    (i32.div_s
     (local.get $i/358)
     (i32.const 26)))
   (i32.const 26)))
 (local.set $offset/360
  (i32.sub
   (local.get $i/358)
   (local.get $base2/359)))
 (local.set $*p/674
  (i32.mul
   (local.get $base/357)
   (i32.const 2)))
 (local.set $mul0/361
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
   (local.get $*p/674)))
 (local.set $*p/677
  (i32.add
   (i32.mul
    (local.get $base/357)
    (i32.const 2))
   (i32.const 1)))
 (local.set $mul1/362
  (array.get $ReadOnlyArray<UInt64>
   (ref.as_non_null
    (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
   (local.get $*p/677)))
 (if
  (i32.eq
   (local.get $offset/360)
   (i32.const 0))
  (then
   (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
    (local.get $mul0/361)
    (local.get $mul1/362))
   (return))
  (else))
 (local.set $*low1/365
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/364
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.tee $m/363
      (array.get $ReadOnlyArray<UInt64>
       (ref.as_non_null
        (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
       (local.get $offset/360)))
     (local.get $mul1/362)))))
 (local.set $*high1/366
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/364)))
 (local.set $*low0/368
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/367
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.get $m/363)
     (local.get $mul0/361)))))
 (local.set $sum/370
  (i64.add
   (local.tee $*high0/369
    (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
     (local.get $*bind/367)))
   (local.get $*low1/365)))
 (local.set $high1/371
  (local.get $*high1/366))
 (if
  (i64.lt_u
   (local.get $sum/370)
   (local.get $*high0/369))
  (then
   (local.set $high1/371
    (i64.add
     (local.get $high1/371)
     (i64.const 1))))
  (else))
 (local.set $delta/372
  (i32.sub
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $i/358)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))
   (i32.add
    (i32.shr_u
     (i32.mul
      (local.get $base2/359)
      (i32.const 1217359))
     (i32.const 19))
    (i32.const 1))))
 (i64.or
  (i64.shl
   (local.get $sum/370)
   (i64.extend_i32_s
    (i32.sub
     (i32.const 64)
     (local.get $delta/372))))
  (i64.shr_u
   (local.get $*low0/368)
   (i64.extend_i32_s
    (local.get $delta/372))))
 (local.set $*p/688
  (i32.div_s
   (local.get $i/358)
   (i32.const 16)))
 (i64.extend_i32_u
  (local.tee $*p/691
   (i32.and
    (i32.shr_u
     (array.get $ReadOnlyArray<UInt>
      (ref.as_non_null
       (global.get $moonbitlang/core/double/internal/ryu.gPOW5_OFFSETS))
      (local.get $*p/688))
     (i32.shl
      (i32.rem_s
       (local.get $i/358)
       (i32.const 16))
      (i32.const 1)))
    (i32.const 3))))
 (i64.add)
 (local.set $a/373)
 (local.set $b/374
  (i64.or
   (i64.shl
    (local.tee $*p/694
     (local.get $high1/371))
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $delta/372))))
   (i64.shr_u
    (local.get $sum/370)
    (i64.extend_i32_s
     (local.get $delta/372)))))
 (struct.new $@moonbitlang/core/double/internal/ryu.Pow5Pair
  (local.get $a/373)
  (local.get $b/374)))
(func $moonbitlang/core/double/internal/ryu.mulShiftAll64 (param $m/331 i64) (param $mul/328 (ref $@moonbitlang/core/double/internal/ryu.Pow5Pair)) (param $j/344 i32) (param $mmShift/346 i32) (result (ref $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result))
 (local $*mul0/327 i64)
 (local $*mul1/329 i64)
 (local $m/330 i64)
 (local $*bind/332 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*lo/333 i64)
 (local $*tmp/334 i64)
 (local $*bind/335 (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $*lo2/336 i64)
 (local $*hi2/337 i64)
 (local $mid/338 i64)
 (local $hi/339 i64)
 (local $lo2/340 i64)
 (local $mid2/341 i64)
 (local $hi2/342 i64)
 (local $vp/343 i64)
 (local $lo3/347 i64)
 (local $mid3/348 i64)
 (local $hi3/349 i64)
 (local $lo3/350 i64)
 (local $mid3/351 i64)
 (local $hi3/352 i64)
 (local $lo4/353 i64)
 (local $mid4/354 i64)
 (local $hi4/355 i64)
 (local $vr/356 i64)
 (local $*p/662 i32)
 (local $*p/665 i32)
 (local $*p/668 i32)
 (local $*p/671 i32)
 (local $vm/345 i64)
 (local.set $*mul0/327
  (struct.get $@moonbitlang/core/double/internal/ryu.Pow5Pair 0
   (local.get $mul/328)))
 (local.set $*mul1/329
  (struct.get $@moonbitlang/core/double/internal/ryu.Pow5Pair 1
   (local.get $mul/328)))
 (local.set $*lo/333
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/332
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.tee $m/330
      (i64.shl
       (local.get $m/331)
       (i64.extend_i32_s
        (i32.const 1))))
     (local.get $*mul0/327)))))
 (local.set $*tmp/334
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/332)))
 (local.set $*lo2/336
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 0
   (local.tee $*bind/335
    (call $moonbitlang/core/double/internal/ryu.umul128
     (local.get $m/330)
     (local.get $*mul1/329)))))
 (local.set $*hi2/337
  (struct.get $@moonbitlang/core/double/internal/ryu.Umul128 1
   (local.get $*bind/335)))
 (local.set $mid/338
  (i64.add
   (local.get $*tmp/334)
   (local.get $*lo2/336)))
 (local.set $hi/339
  (i64.add
   (local.get $*hi2/337)
   (if (result i64)
    (i64.lt_u
     (local.get $mid/338)
     (local.get $*tmp/334))
    (then
     (i64.const 1))
    (else
     (i64.const 0)))))
 (local.set $lo2/340
  (i64.add
   (local.get $*lo/333)
   (local.get $*mul0/327)))
 (local.set $mid2/341
  (i64.add
   (i64.add
    (local.get $mid/338)
    (local.get $*mul1/329))
   (if (result i64)
    (i64.lt_u
     (local.get $lo2/340)
     (local.get $*lo/333))
    (then
     (i64.const 1))
    (else
     (i64.const 0)))))
 (local.set $hi2/342
  (i64.add
   (local.get $hi/339)
   (if (result i64)
    (i64.lt_u
     (local.get $mid2/341)
     (local.get $mid/338))
    (then
     (i64.const 1))
    (else
     (i64.const 0)))))
 (local.set $*p/662
  (i32.sub
   (i32.sub
    (local.get $j/344)
    (i32.const 64))
   (i32.const 1)))
 (local.set $vp/343
  (i64.or
   (i64.shl
    (local.get $hi2/342)
    (i64.extend_i32_s
     (i32.sub
      (i32.const 64)
      (local.get $*p/662))))
   (i64.shr_u
    (local.get $mid2/341)
    (i64.extend_i32_s
     (local.get $*p/662)))))
 (local.set $vm/345
  (i64.const 0))
 (if
  (local.get $mmShift/346)
  (then
   (local.set $lo3/347
    (i64.sub
     (local.get $*lo/333)
     (local.get $*mul0/327)))
   (local.set $mid3/348
    (i64.sub
     (i64.sub
      (local.get $mid/338)
      (local.get $*mul1/329))
     (if (result i64)
      (i64.lt_u
       (local.get $*lo/333)
       (local.get $lo3/347))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $hi3/349
    (i64.sub
     (local.get $hi/339)
     (if (result i64)
      (i64.lt_u
       (local.get $mid/338)
       (local.get $mid3/348))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $*p/665
    (i32.sub
     (i32.sub
      (local.get $j/344)
      (i32.const 64))
     (i32.const 1)))
   (local.set $vm/345
    (i64.or
     (i64.shl
      (local.get $hi3/349)
      (i64.extend_i32_s
       (i32.sub
        (i32.const 64)
        (local.get $*p/665))))
     (i64.shr_u
      (local.get $mid3/348)
      (i64.extend_i32_s
       (local.get $*p/665))))))
  (else
   (local.set $lo3/350
    (i64.add
     (local.get $*lo/333)
     (local.get $*lo/333)))
   (local.set $mid3/351
    (i64.add
     (i64.add
      (local.get $mid/338)
      (local.get $mid/338))
     (if (result i64)
      (i64.lt_u
       (local.get $lo3/350)
       (local.get $*lo/333))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $hi3/352
    (i64.add
     (i64.add
      (local.get $hi/339)
      (local.get $hi/339))
     (if (result i64)
      (i64.lt_u
       (local.get $mid3/351)
       (local.get $mid/338))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $lo4/353
    (i64.sub
     (local.get $lo3/350)
     (local.get $*mul0/327)))
   (local.set $mid4/354
    (i64.sub
     (i64.sub
      (local.get $mid3/351)
      (local.get $*mul1/329))
     (if (result i64)
      (i64.lt_u
       (local.get $lo3/350)
       (local.get $lo4/353))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $hi4/355
    (i64.sub
     (local.get $hi3/352)
     (if (result i64)
      (i64.lt_u
       (local.get $mid3/351)
       (local.get $mid4/354))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $*p/668
    (i32.sub
     (local.get $j/344)
     (i32.const 64)))
   (local.set $vm/345
    (i64.or
     (i64.shl
      (local.get $hi4/355)
      (i64.extend_i32_s
       (i32.sub
        (i32.const 64)
        (local.get $*p/668))))
     (i64.shr_u
      (local.get $mid4/354)
      (i64.extend_i32_s
       (local.get $*p/668)))))))
 (local.set $*p/671
  (i32.sub
   (i32.sub
    (local.get $j/344)
    (i32.const 64))
   (i32.const 1)))
 (struct.new $@moonbitlang/core/double/internal/ryu.MulShiftAll64Result
  (local.tee $vr/356
   (i64.or
    (i64.shl
     (local.get $hi/339)
     (i64.extend_i32_s
      (i32.sub
       (i32.const 64)
       (local.get $*p/671))))
    (i64.shr_u
     (local.get $mid/338)
     (i64.extend_i32_s
      (local.get $*p/671)))))
  (local.get $vp/343)
  (local.get $vm/345)))
(func $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5 (param $value/323 i64) (param $p/324 i32) (result i32)
 (i32.ge_s
  (call $moonbitlang/core/double/internal/ryu.pow5Factor
   (local.get $value/323))
  (local.get $p/324)))
(func $moonbitlang/core/double/internal/ryu.pow5Factor (param $value/319 i64) (result i32)
 (local $count/320 i32)
 (local $value/321 i64)
 (i64.rem_u
  (local.get $value/319)
  (i64.const 5))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 0)
   (return))
  (else))
 (i64.rem_u
  (local.get $value/319)
  (i64.const 25))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (i64.rem_u
  (local.get $value/319)
  (i64.const 125))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 2)
   (return))
  (else))
 (i64.rem_u
  (local.get $value/319)
  (i64.const 625))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 3)
   (return))
  (else))
 (local.set $count/320
  (i32.const 4))
 (local.set $value/321
  (i64.div_u
   (local.get $value/319)
   (i64.const 625)))
 (loop $loop:322
  (if
   (i64.gt_u
    (local.get $value/321)
    (i64.const 0))
   (then
    (i64.rem_u
     (local.get $value/321)
     (i64.const 5))
    (if
     (i64.ne
      (i64.const 0))
     (then
      (local.get $count/320)
      (return))
     (else))
    (local.set $value/321
     (i64.div_u
      (local.get $value/321)
      (i64.const 5)))
    (local.set $count/320
     (i32.add
      (local.get $count/320)
      (i32.const 1)))
    (br $loop:322))
   (else)))
 (call $moonbitlang/core/builtin.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.string_literal
    (i32.const 2)
    (i32.const 118)
    (i32.const 25))
   (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|UInt64|
    (local.get $value/321)))
  (call $moonbit.string_literal
   (i32.const 1)
   (i32.const 2)
   (i32.const 58))))
(func $moonbitlang/core/double/internal/ryu.umul128 (param $a/306 i64) (param $b/309 i64) (result (ref $@moonbitlang/core/double/internal/ryu.Umul128))
 (local $aLo/305 i64)
 (local $aHi/307 i64)
 (local $bLo/308 i64)
 (local $bHi/310 i64)
 (local $x/311 i64)
 (local $y/312 i64)
 (local $z/313 i64)
 (local $w/314 i64)
 (local $lo/315 i64)
 (local.set $aLo/305
  (i64.and
   (local.get $a/306)
   (i64.const 4294967295)))
 (local.set $aHi/307
  (i64.shr_u
   (local.get $a/306)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $bLo/308
  (i64.and
   (local.get $b/309)
   (i64.const 4294967295)))
 (local.set $bHi/310
  (i64.shr_u
   (local.get $b/309)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $x/311
  (i64.mul
   (local.get $aLo/305)
   (local.get $bLo/308)))
 (local.set $y/312
  (i64.add
   (i64.mul
    (local.get $aHi/307)
    (local.get $bLo/308))
   (i64.shr_u
    (local.get $x/311)
    (i64.extend_i32_s
     (i32.const 32)))))
 (local.set $z/313
  (i64.add
   (i64.mul
    (local.get $aLo/305)
    (local.get $bHi/310))
   (i64.and
    (local.get $y/312)
    (i64.const 4294967295))))
 (local.set $w/314
  (i64.add
   (i64.add
    (i64.mul
     (local.get $aHi/307)
     (local.get $bHi/310))
    (i64.shr_u
     (local.get $y/312)
     (i64.extend_i32_s
      (i32.const 32))))
   (i64.shr_u
    (local.get $z/313)
    (i64.extend_i32_s
     (i32.const 32)))))
 (struct.new $@moonbitlang/core/double/internal/ryu.Umul128
  (local.tee $lo/315
   (i64.mul
    (local.get $a/306)
    (local.get $b/309)))
  (local.get $w/314)))
(func $moonbitlang/core/double/internal/ryu.string_from_bytes (param $bytes/300 (ref $moonbit.bytes)) (param $from/304 i32) (param $to/302 i32) (result (ref $moonbit.string))
 (local $buf/299 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $i/301 i32)
 (local $*p/659 i32)
 (local.set $buf/299
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (array.len
    (local.get $bytes/300))))
 (local.get $from/304)
 (loop $loop:303 (param i32)
  (local.tee $i/301)
  (local.get $to/302)
  (i32.lt_s)
  (if
   (then
    (drop
     (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
      (local.get $buf/299)
      (local.tee $*p/659
       (array.get_u $moonbit.bytes
        (local.get $bytes/300)
        (local.get $i/301)))))
    (i32.add
     (local.get $i/301)
     (i32.const 1))
    (br $loop:303))
   (else)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $buf/299)))
(func $moonbitlang/core/double/internal/ryu.copy_special_str (param $sign/295 i32) (param $exponent/296 i32) (param $mantissa/293 i32) (result (ref $moonbit.string))
 (local $s/294 (ref $moonbit.string))
 (if
  (local.get $mantissa/293)
  (then
   (call $moonbit.string_literal
    (i32.const 6)
    (i32.const 192)
    (i32.const 3))
   (return))
  (else))
 (local.set $s/294
  (if (result (ref $moonbit.string))
   (local.get $sign/295)
   (then
    (call $moonbit.string_literal
     (i32.const 5)
     (i32.const 190)
     (i32.const 1)))
   (else
    (global.get $moonbit.string.default))))
 (if
  (local.get $exponent/296)
  (then
   (call $moonbit.add_string
    (local.get $s/294)
    (call $moonbit.string_literal
     (i32.const 4)
     (i32.const 174)
     (i32.const 8)))
   (return))
  (else))
 (call $moonbit.add_string
  (local.get $s/294)
  (call $moonbit.string_literal
   (i32.const 3)
   (i32.const 168)
   (i32.const 3))))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/290 (ref $moonbit.string)) (param $logger/291 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (call $@moonbitlang/core/builtin.SourceLocRepr::parse
   (local.get $self/290))
  (local.get $logger/291)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/253 (ref $@moonbitlang/core/builtin.SourceLocRepr)) (param $logger/289 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (local $pkg/252 (ref $StringView))
 (local $*data/254 (ref $moonbit.string))
 (local $*start/255 i32)
 (local $*end/256 i32)
 (local $*bind/262 (ref $<StringView*Option<StringView>>))
 (local $package_name/264 (ref $StringView))
 (local $*try_err/266 (ref $moonbit.enum))
 (local $module_name/267 (ref $StringView))
 (local $*try_err/269 (ref $moonbit.enum))
 (local $next_char/272 i32)
 (local $next_char/275 i32)
 (local $next_char/278 i32)
 (local $next_char/279 i32)
 (local $next_char/280 i32)
 (local $next_char/281 i32)
 (local $next_char/282 i32)
 (local $next_char/283 i32)
 (local $next_char/284 i32)
 (local $*module_name/285 (ref $StringView))
 (local $*package_name/286 (ref null $StringView))
 (local $*Some/287 (ref null $StringView))
 (local $*pkg_name/288 (ref $StringView))
 (local $*p/632 i32)
 (local $*p/635 i32)
 (local $*p/638 i32)
 (local $*p/641 i32)
 (local $*p/644 i32)
 (local $*p/647 i32)
 (local $*p/650 i32)
 (local $*p/653 i32)
 (local $*p/656 i32)
 (local $*bind/777 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/778 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/779 (ref $moonbit.enum))
 (local $*bind/780 (ref $moonbit.enum))
 (local $tag/787 i32)
 (local $tag/789 i32)
 (local $*cursor/257 i32)
 (local $accept_state/258 i32)
 (local $match_end/259 i32)
 (local $match_tag_saver_0/260 i32)
 (local $tag_0/261 i32)
 (local.set $*data/254
  (struct.get $StringView 0
   (local.tee $pkg/252
    (struct.get $@moonbitlang/core/builtin.SourceLocRepr 0
     (local.get $self/253)))))
 (local.set $*end/256
  (i32.add
   (local.tee $*start/255
    (struct.get $StringView 1
     (local.get $pkg/252)))
   (i32.sub
    (struct.get $StringView 2
     (local.get $pkg/252))
    (struct.get $StringView 1
     (local.get $pkg/252)))))
 (local.set $*cursor/257
  (local.get $*start/255))
 (local.set $accept_state/258
  (i32.const -1))
 (local.set $match_end/259
  (i32.const -1))
 (local.set $match_tag_saver_0/260
  (i32.const -1))
 (local.set $tag_0/261
  (i32.const -1))
 (block $outer/782 (result (ref $<StringView*Option<StringView>>))
  (block $join:263
   (loop $loop:271 (result (ref $<StringView*Option<StringView>>))
    (if (result (ref $<StringView*Option<StringView>>))
     (i32.lt_s
      (local.get $*cursor/257)
      (local.get $*end/256))
     (then
      (block $outer/783 (result (ref $<StringView*Option<StringView>>))
       (block $join:270
        (local.set $*p/632
         (local.get $*cursor/257))
        (local.set $next_char/272
         (array.get_u $moonbit.string
          (local.get $*data/254)
          (local.get $*p/632)))
        (local.set $*cursor/257
         (i32.add
          (local.get $*cursor/257)
          (i32.const 1)))
        (if (result (ref $<StringView*Option<StringView>>))
         (i32.lt_s
          (local.get $next_char/272)
          (i32.const 55296))
         (then
          (if (result (ref $<StringView*Option<StringView>>))
           (i32.lt_s
            (local.get $next_char/272)
            (i32.const 47))
           (then
            (br $join:270))
           (else
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.gt_s
              (local.get $next_char/272)
              (i32.const 47))
             (then
              (br $join:270))
             (else
              (loop $loop:274 (result (ref $<StringView*Option<StringView>>))
               (local.set $tag_0/261
                (local.get $*cursor/257))
               (if (result (ref $<StringView*Option<StringView>>))
                (i32.lt_s
                 (local.get $*cursor/257)
                 (local.get $*end/256))
                (then
                 (block $outer/784 (result (ref $<StringView*Option<StringView>>))
                  (block $join:273
                   (local.set $*p/635
                    (local.get $*cursor/257))
                   (local.set $next_char/275
                    (array.get_u $moonbit.string
                     (local.get $*data/254)
                     (local.get $*p/635)))
                   (local.set $*cursor/257
                    (i32.add
                     (local.get $*cursor/257)
                     (i32.const 1)))
                   (if (result (ref $<StringView*Option<StringView>>))
                    (i32.lt_s
                     (local.get $next_char/275)
                     (i32.const 55296))
                    (then
                     (if (result (ref $<StringView*Option<StringView>>))
                      (i32.lt_s
                       (local.get $next_char/275)
                       (i32.const 47))
                      (then
                       (br $join:273))
                      (else
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.gt_s
                         (local.get $next_char/275)
                         (i32.const 47))
                        (then
                         (br $join:273))
                        (else
                         (loop $loop:277 (result (ref $<StringView*Option<StringView>>))
                          (if (result (ref $<StringView*Option<StringView>>))
                           (i32.lt_s
                            (local.get $*cursor/257)
                            (local.get $*end/256))
                           (then
                            (block $outer/785 (result (ref $<StringView*Option<StringView>>))
                             (block $join:276
                              (local.set $*p/638
                               (local.get $*cursor/257))
                              (local.set $next_char/278
                               (array.get_u $moonbit.string
                                (local.get $*data/254)
                                (local.get $*p/638)))
                              (local.set $*cursor/257
                               (i32.add
                                (local.get $*cursor/257)
                                (i32.const 1)))
                              (if (result (ref $<StringView*Option<StringView>>))
                               (i32.lt_s
                                (local.get $next_char/278)
                                (i32.const 56319))
                               (then
                                (if (result (ref $<StringView*Option<StringView>>))
                                 (i32.lt_s
                                  (local.get $next_char/278)
                                  (i32.const 55296))
                                 (then
                                  (br $join:276))
                                 (else
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $*cursor/257)
                                    (local.get $*end/256))
                                   (then
                                    (local.set $*p/641
                                     (local.get $*cursor/257))
                                    (local.set $next_char/279
                                     (array.get_u $moonbit.string
                                      (local.get $*data/254)
                                      (local.get $*p/641)))
                                    (local.set $*cursor/257
                                     (i32.add
                                      (local.get $*cursor/257)
                                      (i32.const 1)))
                                    (if (result (ref $<StringView*Option<StringView>>))
                                     (i32.lt_s
                                      (local.get $next_char/279)
                                      (i32.const 56320))
                                     (then
                                      (br $join:263))
                                     (else
                                      (if (result (ref $<StringView*Option<StringView>>))
                                       (i32.gt_s
                                        (local.get $next_char/279)
                                        (i32.const 65535))
                                       (then
                                        (br $join:263))
                                       (else
                                        (br $loop:277))))))
                                   (else
                                    (br $join:263))))))
                               (else
                                (if (result (ref $<StringView*Option<StringView>>))
                                 (i32.gt_s
                                  (local.get $next_char/278)
                                  (i32.const 56319))
                                 (then
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $next_char/278)
                                    (i32.const 65536))
                                   (then
                                    (br $join:276))
                                   (else
                                    (br $join:263))))
                                 (else
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $*cursor/257)
                                    (local.get $*end/256))
                                   (then
                                    (local.set $*p/644
                                     (local.get $*cursor/257))
                                    (local.set $next_char/280
                                     (array.get_u $moonbit.string
                                      (local.get $*data/254)
                                      (local.get $*p/644)))
                                    (local.set $*cursor/257
                                     (i32.add
                                      (local.get $*cursor/257)
                                      (i32.const 1)))
                                    (if (result (ref $<StringView*Option<StringView>>))
                                     (i32.lt_s
                                      (local.get $next_char/280)
                                      (i32.const 56320))
                                     (then
                                      (br $join:263))
                                     (else
                                      (if (result (ref $<StringView*Option<StringView>>))
                                       (i32.gt_s
                                        (local.get $next_char/280)
                                        (i32.const 57343))
                                       (then
                                        (br $join:263))
                                       (else
                                        (br $loop:277))))))
                                   (else
                                    (br $join:263)))))))
                              (br $outer/785))
                             (br $loop:277)))
                           (else
                            (local.set $match_tag_saver_0/260
                             (local.get $tag_0/261))
                            (local.set $accept_state/258
                             (i32.const 0))
                            (local.set $match_end/259
                             (local.get $*cursor/257))
                            (br $join:263)))))))))
                    (else
                     (if (result (ref $<StringView*Option<StringView>>))
                      (i32.gt_s
                       (local.get $next_char/275)
                       (i32.const 56318))
                      (then
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.lt_s
                         (local.get $next_char/275)
                         (i32.const 57344))
                        (then
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.lt_s
                           (local.get $*cursor/257)
                           (local.get $*end/256))
                          (then
                           (local.set $*p/647
                            (local.get $*cursor/257))
                           (local.set $next_char/281
                            (array.get_u $moonbit.string
                             (local.get $*data/254)
                             (local.get $*p/647)))
                           (local.set $*cursor/257
                            (i32.add
                             (local.get $*cursor/257)
                             (i32.const 1)))
                           (if (result (ref $<StringView*Option<StringView>>))
                            (i32.lt_s
                             (local.get $next_char/281)
                             (i32.const 56320))
                            (then
                             (br $join:263))
                            (else
                             (if (result (ref $<StringView*Option<StringView>>))
                              (i32.gt_s
                               (local.get $next_char/281)
                               (i32.const 57343))
                              (then
                               (br $join:263))
                              (else
                               (br $loop:274))))))
                          (else
                           (br $join:263))))
                        (else
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.gt_s
                           (local.get $next_char/275)
                           (i32.const 65535))
                          (then
                           (br $join:263))
                          (else
                           (br $join:273))))))
                      (else
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.lt_s
                         (local.get $*cursor/257)
                         (local.get $*end/256))
                        (then
                         (local.set $*p/650
                          (local.get $*cursor/257))
                         (local.set $next_char/282
                          (array.get_u $moonbit.string
                           (local.get $*data/254)
                           (local.get $*p/650)))
                         (local.set $*cursor/257
                          (i32.add
                           (local.get $*cursor/257)
                           (i32.const 1)))
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.lt_s
                           (local.get $next_char/282)
                           (i32.const 56320))
                          (then
                           (br $join:263))
                          (else
                           (if (result (ref $<StringView*Option<StringView>>))
                            (i32.gt_s
                             (local.get $next_char/282)
                             (i32.const 65535))
                            (then
                             (br $join:263))
                            (else
                             (br $loop:274))))))
                        (else
                         (br $join:263)))))))
                   (br $outer/784))
                  (br $loop:274)))
                (else
                 (br $join:263)))))))))
         (else
          (if (result (ref $<StringView*Option<StringView>>))
           (i32.gt_s
            (local.get $next_char/272)
            (i32.const 56318))
           (then
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.lt_s
              (local.get $next_char/272)
              (i32.const 57344))
             (then
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.lt_s
                (local.get $*cursor/257)
                (local.get $*end/256))
               (then
                (local.set $*p/653
                 (local.get $*cursor/257))
                (local.set $next_char/283
                 (array.get_u $moonbit.string
                  (local.get $*data/254)
                  (local.get $*p/653)))
                (local.set $*cursor/257
                 (i32.add
                  (local.get $*cursor/257)
                  (i32.const 1)))
                (if (result (ref $<StringView*Option<StringView>>))
                 (i32.lt_s
                  (local.get $next_char/283)
                  (i32.const 56320))
                 (then
                  (br $join:263))
                 (else
                  (if (result (ref $<StringView*Option<StringView>>))
                   (i32.gt_s
                    (local.get $next_char/283)
                    (i32.const 57343))
                   (then
                    (br $join:263))
                   (else
                    (br $loop:271))))))
               (else
                (br $join:263))))
             (else
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.gt_s
                (local.get $next_char/272)
                (i32.const 65535))
               (then
                (br $join:263))
               (else
                (br $join:270))))))
           (else
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.lt_s
              (local.get $*cursor/257)
              (local.get $*end/256))
             (then
              (local.set $*p/656
               (local.get $*cursor/257))
              (local.set $next_char/284
               (array.get_u $moonbit.string
                (local.get $*data/254)
                (local.get $*p/656)))
              (local.set $*cursor/257
               (i32.add
                (local.get $*cursor/257)
                (i32.const 1)))
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.lt_s
                (local.get $next_char/284)
                (i32.const 56320))
               (then
                (br $join:263))
               (else
                (if (result (ref $<StringView*Option<StringView>>))
                 (i32.gt_s
                  (local.get $next_char/284)
                  (i32.const 65535))
                 (then
                  (br $join:263))
                 (else
                  (br $loop:271))))))
             (else
              (br $join:263)))))))
        (br $outer/783))
       (br $loop:271)))
     (else
      (br $join:263))))
   (br $outer/782))
  (if (result (ref $<StringView*Option<StringView>>))
   (i32.eq
    (local.get $accept_state/258)
    (i32.const 0))
   (then
    (block $outer/788 (result (ref $StringView))
     (block $join:265 (result (ref $moonbit.enum))
      (if (result (ref $StringView))
       (i32.eq
        (local.tee $tag/789
         (struct.get $moonbit.enum 0
          (local.tee $*bind/780
           (call $String::sub
            (local.get $*data/254)
            (i64.extend_i32_s
             (i32.add
              (local.get $match_tag_saver_0/260)
              (i32.const 1)))
            (i64.extend_i32_s
             (local.get $match_end/259))))))
        (i32.const 1))
       (then
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
          (local.get $*bind/780))))
       (else
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
          (local.get $*bind/780)))
        (br $join:265)))
      (br $outer/788))
     (local.set $*try_err/266)
     (unreachable))
    (local.set $package_name/264)
    (block $outer/786 (result (ref $StringView))
     (block $join:268 (result (ref $moonbit.enum))
      (if (result (ref $StringView))
       (i32.eq
        (local.tee $tag/787
         (struct.get $moonbit.enum 0
          (local.tee $*bind/779
           (call $String::sub
            (local.get $*data/254)
            (i64.extend_i32_s
             (local.get $*start/255))
            (i64.extend_i32_s
             (local.get $match_tag_saver_0/260))))))
        (i32.const 1))
       (then
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
          (local.get $*bind/779))))
       (else
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
          (local.get $*bind/779)))
        (br $join:268)))
      (br $outer/786))
     (local.set $*try_err/269)
     (unreachable))
    (local.tee $module_name/267)
    (local.get $package_name/264)
    (struct.new $<StringView*Option<StringView>>))
   (else
    (struct.new $<StringView*Option<StringView>>
     (local.get $pkg/252)
     (ref.null none)))))
 (local.tee $*bind/262)
 (struct.get $<StringView*Option<StringView>> 0)
 (local.set $*module_name/285)
 (if
  (ref.is_null
   (local.tee $*package_name/286
    (struct.get $<StringView*Option<StringView>> 1
     (local.get $*bind/262))))
  (then)
  (else
   (local.set $*pkg_name/288
    (ref.as_non_null
     (local.tee $*Some/287
      (local.get $*package_name/286))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_2
     (local.get $logger/289)
     (local.get $*pkg_name/288)
     (struct.get $@moonbitlang/core/builtin.Logger 2
      (local.get $logger/289))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_3
     (local.tee $*bind/777
      (local.get $logger/289))
     (i32.const 47)
     (struct.get $@moonbitlang/core/builtin.Logger 3
      (local.get $*bind/777))))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/289)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 1
    (local.get $self/253))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/289)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/289)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 2
    (local.get $self/253))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/289)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/289)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 3
    (local.get $self/253))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/289)
   (i32.const 45)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/289)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 4
    (local.get $self/253))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/289)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/289)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 5
    (local.get $self/253))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/289))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/289)
   (i32.const 64)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/289))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_2
  (local.tee $*bind/778
   (local.get $logger/289))
  (local.get $*module_name/285)
  (struct.get $@moonbitlang/core/builtin.Logger 2
   (local.get $*bind/778))))
(func $moonbitlang/core/builtin.println|String| (param $input/248 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/248))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::UInt64::output (param $self/241 i64) (param $logger/240 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/240)
  (call $UInt64::to_string.inner
   (local.get $self/241)
   (i32.const 10))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/240))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/238 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/239 (ref $StringView)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/238)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/238))
    (i32.mul
     (i32.sub
      (struct.get $StringView 2
       (local.get $str/239))
      (struct.get $StringView 1
       (local.get $str/239)))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/238))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/238))
   (struct.get $StringView 0
    (local.get $str/239))
   (struct.get $StringView 1
    (local.get $str/239))
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/239))
    (struct.get $StringView 1
     (local.get $str/239)))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/238)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/238))
   (i32.mul
    (i32.sub
     (struct.get $StringView 2
      (local.get $str/239))
     (struct.get $StringView 1
      (local.get $str/239)))
    (i32.const 2))))
 (i32.const 0))
(func $UInt64::to_string.inner (param $self/230 i64) (param $radix/229 i32) (result (ref $moonbit.string))
 (local $buffer/231 (ref $FixedArray<UInt16>))
 (local $len/232 i32)
 (local $buffer/233 (ref $FixedArray<UInt16>))
 (local $len/234 i32)
 (local $buffer/235 (ref $FixedArray<UInt16>))
 (local $len/236 i32)
 (local $buffer/237 (ref $FixedArray<UInt16>))
 (if
  (if (result i32)
   (i32.lt_s
    (local.get $radix/229)
    (i32.const 2))
   (then
    (i32.const 1))
   (else
    (i32.gt_s
     (local.get $radix/229)
     (i32.const 36))))
  (then
   (drop
    (call $moonbitlang/core/builtin.abort|Unit|
     (call $moonbit.string_literal
      (i32.const 8)
      (i32.const 302)
      (i32.const 30))
     (call $moonbit.string_literal
      (i32.const 7)
      (i32.const 198)
      (i32.const 52)))))
  (else))
 (if
  (i64.eq
   (local.get $self/230)
   (i64.const 0))
  (then
   (call $moonbit.string_literal
    (i32.const 0)
    (i32.const 0)
    (i32.const 1))
   (return))
  (else))
 (local.tee $buffer/231
  (if (result (ref $FixedArray<UInt16>))
   (i32.eq
    (local.get $radix/229)
    (i32.const 10))
   (then
    (local.set $len/232
     (call $moonbitlang/core/builtin.dec_count64
      (local.get $self/230)))
    (drop
     (call $moonbitlang/core/builtin.int64_to_string_dec
      (local.tee $buffer/233
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $len/232)))
      (local.get $self/230)
      (i32.const 0)
      (local.get $len/232)))
    (local.get $buffer/233))
   (else
    (if (result (ref $FixedArray<UInt16>))
     (i32.eq
      (local.get $radix/229)
      (i32.const 16))
     (then
      (local.set $len/234
       (call $moonbitlang/core/builtin.hex_count64
        (local.get $self/230)))
      (drop
       (call $moonbitlang/core/builtin.int64_to_string_hex
        (local.tee $buffer/235
         (array.new $FixedArray<UInt16>
          (i32.const 0)
          (local.get $len/234)))
        (local.get $self/230)
        (i32.const 0)
        (local.get $len/234)))
      (local.get $buffer/235))
     (else
      (local.set $len/236
       (call $moonbitlang/core/builtin.radix_count64
        (local.get $self/230)
        (local.get $radix/229)))
      (drop
       (call $moonbitlang/core/builtin.int64_to_string_generic
        (local.tee $buffer/237
         (array.new $FixedArray<UInt16>
          (i32.const 0)
          (local.get $len/236)))
        (local.get $self/230)
        (i32.const 0)
        (local.get $len/236)
        (local.get $radix/229)))
      (local.get $buffer/237)))))))
(func $moonbitlang/core/builtin.int64_to_string_dec (param $buffer/219 (ref $FixedArray<UInt16>)) (param $num/207 i64) (param $digit_start/210 i32) (param $total_len/209 i32) (result i32)
 (local $t/211 i64)
 (local $r/212 i32)
 (local $d1/213 i32)
 (local $d2/214 i32)
 (local $d1_hi/215 i32)
 (local $d1_lo/216 i32)
 (local $d2_hi/217 i32)
 (local $d2_lo/218 i32)
 (local $t/222 i32)
 (local $d/223 i32)
 (local $d_hi/224 i32)
 (local $d_lo/225 i32)
 (local $d_hi/227 i32)
 (local $d_lo/228 i32)
 (local $num/206 i64)
 (local $offset/208 i32)
 (local $remaining/221 i32)
 (local.set $num/206
  (local.get $num/207))
 (local.set $offset/208
  (i32.sub
   (local.get $total_len/209)
   (local.get $digit_start/210)))
 (loop $loop:220
  (if
   (i64.ge_u
    (local.get $num/206)
    (i64.const 10000))
   (then
    (local.set $t/211
     (i64.div_u
      (local.get $num/206)
      (i64.const 10000)))
    (local.set $r/212
     (i32.wrap_i64
      (i64.rem_u
       (local.get $num/206)
       (i64.const 10000))))
    (local.set $num/206
     (local.get $t/211))
    (local.set $d1/213
     (i32.div_s
      (local.get $r/212)
      (i32.const 100)))
    (local.set $d2/214
     (i32.rem_s
      (local.get $r/212)
      (i32.const 100)))
    (local.set $offset/208
     (i32.sub
      (local.get $offset/208)
      (i32.const 4)))
    (local.set $d1_hi/215
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d1/213)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d1_lo/216
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d1/213)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_hi/217
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d2/214)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_lo/218
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d2/214)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/219)
     (i32.add
      (local.get $digit_start/210)
      (local.get $offset/208))
     (local.get $d1_hi/215))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/219)
     (i32.add
      (i32.add
       (local.get $digit_start/210)
       (local.get $offset/208))
      (i32.const 1))
     (local.get $d1_lo/216))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/219)
     (i32.add
      (i32.add
       (local.get $digit_start/210)
       (local.get $offset/208))
      (i32.const 2))
     (local.get $d2_hi/217))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/219)
     (i32.add
      (i32.add
       (local.get $digit_start/210)
       (local.get $offset/208))
      (i32.const 3))
     (local.get $d2_lo/218))
    (br $loop:220))
   (else)))
 (local.set $remaining/221
  (i32.wrap_i64
   (local.get $num/206)))
 (loop $loop:226
  (if
   (i32.ge_s
    (local.get $remaining/221)
    (i32.const 100))
   (then
    (local.set $t/222
     (i32.div_s
      (local.get $remaining/221)
      (i32.const 100)))
    (local.set $d/223
     (i32.rem_s
      (local.get $remaining/221)
      (i32.const 100)))
    (local.set $remaining/221
     (local.get $t/222))
    (local.set $offset/208
     (i32.sub
      (local.get $offset/208)
      (i32.const 2)))
    (local.set $d_hi/224
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d/223)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d_lo/225
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d/223)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/219)
     (i32.add
      (local.get $digit_start/210)
      (local.get $offset/208))
     (local.get $d_hi/224))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/219)
     (i32.add
      (i32.add
       (local.get $digit_start/210)
       (local.get $offset/208))
      (i32.const 1))
     (local.get $d_lo/225))
    (br $loop:226))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.get $remaining/221)
   (i32.const 10))
  (then
   (local.set $offset/208
    (i32.sub
     (local.get $offset/208)
     (i32.const 2)))
   (local.set $d_hi/227
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.div_s
       (local.get $remaining/221)
       (i32.const 10)))
     (i32.const 65535)))
   (local.set $d_lo/228
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (local.get $remaining/221)
       (i32.const 10)))
     (i32.const 65535)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/219)
    (i32.add
     (local.get $digit_start/210)
     (local.get $offset/208))
    (local.get $d_hi/227))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/219)
    (i32.add
     (i32.add
      (local.get $digit_start/210)
      (local.get $offset/208))
     (i32.const 1))
    (local.get $d_lo/228))
   (i32.const 0))
  (else
   (local.set $offset/208
    (i32.sub
     (local.get $offset/208)
     (i32.const 1)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/219)
    (i32.add
     (local.get $digit_start/210)
     (local.get $offset/208))
    (i32.and
     (i32.add
      (i32.const 48)
      (local.get $remaining/221))
     (i32.const 65535)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int64_to_string_generic (param $buffer/201 (ref $FixedArray<UInt16>)) (param $num/195 i64) (param $digit_start/193 i32) (param $total_len/192 i32) (param $radix/197 i32) (result i32)
 (local $base/196 i64)
 (local $shift/198 i32)
 (local $mask/199 i64)
 (local $digit/200 i32)
 (local $q/203 i64)
 (local $digit/204 i32)
 (local $offset/191 i32)
 (local $n/194 i64)
 (local.set $offset/191
  (i32.sub
   (local.get $total_len/192)
   (local.get $digit_start/193)))
 (local.set $n/194
  (local.get $num/195))
 (local.set $base/196
  (i64.extend_i32_s
   (local.get $radix/197)))
 (if (result i32)
  (i32.eq
   (i32.and
    (local.get $radix/197)
    (i32.sub
     (local.get $radix/197)
     (i32.const 1)))
   (i32.const 0))
  (then
   (local.set $shift/198
    (i32.ctz
     (local.get $radix/197)))
   (local.set $mask/199
    (i64.sub
     (local.get $base/196)
     (i64.const 1)))
   (loop $loop:202
    (if
     (i64.gt_u
      (local.get $n/194)
      (i64.const 0))
     (then
      (local.set $offset/191
       (i32.sub
        (local.get $offset/191)
        (i32.const 1)))
      (local.set $digit/200
       (i32.wrap_i64
        (i64.and
         (local.get $n/194)
         (local.get $mask/199))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/201)
       (i32.add
        (local.get $digit_start/193)
        (local.get $offset/191))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 9)
          (i32.const 362)
          (i32.const 36))
         (local.get $digit/200))
        (i32.const 65535)))
      (local.set $n/194
       (i64.shr_u
        (local.get $n/194)
        (i64.extend_i32_s
         (local.get $shift/198))))
      (br $loop:202))
     (else)))
   (i32.const 0))
  (else
   (loop $loop:205
    (if
     (i64.gt_u
      (local.get $n/194)
      (i64.const 0))
     (then
      (local.set $offset/191
       (i32.sub
        (local.get $offset/191)
        (i32.const 1)))
      (local.set $q/203
       (i64.div_u
        (local.get $n/194)
        (local.get $base/196)))
      (local.set $digit/204
       (i32.wrap_i64
        (i64.sub
         (local.get $n/194)
         (i64.mul
          (local.get $q/203)
          (local.get $base/196)))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/201)
       (i32.add
        (local.get $digit_start/193)
        (local.get $offset/191))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 9)
          (i32.const 362)
          (i32.const 36))
         (local.get $digit/204))
        (i32.const 65535)))
      (local.set $n/194
       (local.get $q/203))
      (br $loop:205))
     (else)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int64_to_string_hex (param $buffer/188 (ref $FixedArray<UInt16>)) (param $num/184 i64) (param $digit_start/182 i32) (param $total_len/181 i32) (result i32)
 (local $byte_val/185 i32)
 (local $hi/186 i32)
 (local $lo/187 i32)
 (local $nibble/190 i32)
 (local $offset/180 i32)
 (local $n/183 i64)
 (local.set $offset/180
  (i32.sub
   (local.get $total_len/181)
   (local.get $digit_start/182)))
 (local.set $n/183
  (local.get $num/184))
 (loop $loop:189
  (if
   (i32.ge_s
    (local.get $offset/180)
    (i32.const 2))
   (then
    (local.set $offset/180
     (i32.sub
      (local.get $offset/180)
      (i32.const 2)))
    (local.set $hi/186
     (i32.div_s
      (local.tee $byte_val/185
       (i32.wrap_i64
        (i64.and
         (local.get $n/183)
         (i64.const 255))))
      (i32.const 16)))
    (local.set $lo/187
     (i32.rem_s
      (local.get $byte_val/185)
      (i32.const 16)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/188)
     (i32.add
      (local.get $digit_start/182)
      (local.get $offset/180))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 9)
        (i32.const 362)
        (i32.const 36))
       (local.get $hi/186))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/188)
     (i32.add
      (i32.add
       (local.get $digit_start/182)
       (local.get $offset/180))
      (i32.const 1))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 9)
        (i32.const 362)
        (i32.const 36))
       (local.get $lo/187))
      (i32.const 65535)))
    (local.set $n/183
     (i64.shr_u
      (local.get $n/183)
      (i64.extend_i32_s
       (i32.const 8))))
    (br $loop:189))
   (else)))
 (if (result i32)
  (i32.eq
   (local.get $offset/180)
   (i32.const 1))
  (then
   (local.set $nibble/190
    (i32.wrap_i64
     (i64.and
      (local.get $n/183)
      (i64.const 15))))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/188)
    (local.get $digit_start/182)
    (i32.and
     (array.get_u $moonbit.string
      (call $moonbit.string_literal
       (i32.const 9)
       (i32.const 362)
       (i32.const 36))
      (local.get $nibble/190))
     (i32.const 65535)))
   (i32.const 0))
  (else
   (i32.const 0))))
(func $moonbitlang/core/builtin.radix_count64 (param $value/174 i64) (param $radix/177 i32) (result i32)
 (local $base/176 i64)
 (local $num/175 i64)
 (local $count/178 i32)
 (if
  (i64.eq
   (local.get $value/174)
   (i64.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.set $num/175
  (local.get $value/174))
 (local.set $base/176
  (i64.extend_i32_s
   (local.get $radix/177)))
 (local.set $count/178
  (i32.const 0))
 (loop $loop:179
  (if
   (i64.gt_u
    (local.get $num/175)
    (i64.const 0))
   (then
    (local.set $count/178
     (i32.add
      (local.get $count/178)
      (i32.const 1)))
    (local.set $num/175
     (i64.div_u
      (local.get $num/175)
      (local.get $base/176)))
    (br $loop:179))
   (else)))
 (local.get $count/178))
(func $moonbitlang/core/builtin.hex_count64 (param $value/172 i64) (result i32)
 (local $leading_zeros/173 i32)
 (if (result i32)
  (i64.eq
   (local.get $value/172)
   (i64.const 0))
  (then
   (i32.const 1))
  (else
   (local.set $leading_zeros/173
    (i32.wrap_i64
     (i64.clz
      (local.get $value/172))))
   (i32.add
    (i32.div_s
     (i32.sub
      (i32.const 63)
      (local.get $leading_zeros/173))
     (i32.const 4))
    (i32.const 1)))))
(func $moonbitlang/core/builtin.dec_count64 (param $value/171 i64) (result i32)
 (if (result i32)
  (i64.ge_u
   (local.get $value/171)
   (i64.const 10000000000))
  (then
   (if (result i32)
    (i64.ge_u
     (local.get $value/171)
     (i64.const 100000000000000))
    (then
     (if (result i32)
      (i64.ge_u
       (local.get $value/171)
       (i64.const 10000000000000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 1000000000000000000))
        (then
         (if (result i32)
          (i64.ge_u
           (local.get $value/171)
           (i64.const -8446744073709551616))
          (then
           (i32.const 20))
          (else
           (i32.const 19))))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/171)
           (i64.const 100000000000000000))
          (then
           (i32.const 18))
          (else
           (i32.const 17))))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 1000000000000000))
        (then
         (i32.const 16))
        (else
         (i32.const 15))))))
    (else
     (if (result i32)
      (i64.ge_u
       (local.get $value/171)
       (i64.const 1000000000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 10000000000000))
        (then
         (i32.const 14))
        (else
         (i32.const 13))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 100000000000))
        (then
         (i32.const 12))
        (else
         (i32.const 11))))))))
  (else
   (if (result i32)
    (i64.ge_u
     (local.get $value/171)
     (i64.const 100000))
    (then
     (if (result i32)
      (i64.ge_u
       (local.get $value/171)
       (i64.const 10000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 1000000000))
        (then
         (i32.const 10))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/171)
           (i64.const 100000000))
          (then
           (i32.const 9))
          (else
           (i32.const 8))))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 1000000))
        (then
         (i32.const 7))
        (else
         (i32.const 6))))))
    (else
     (if (result i32)
      (i64.ge_u
       (local.get $value/171)
       (i64.const 1000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 10000))
        (then
         (i32.const 5))
        (else
         (i32.const 4))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/171)
         (i64.const 100))
        (then
         (i32.const 3))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/171)
           (i64.const 10))
          (then
           (i32.const 2))
          (else
           (i32.const 1))))))))))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|UInt64| (param $self/170 i64) (result (ref $moonbit.string))
 (local $logger/169 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/169
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::UInt64::output
   (local.get $self/170)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/169))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/169)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/168 (ref $moonbit.string)) (result (ref $moonbit.string))
 (local $logger/167 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/167
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/168)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/167))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/167)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double| (param $self/166 f64) (result (ref $moonbit.string))
 (local $logger/165 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/165
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::Double::output
   (local.get $self/166)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/165))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/165)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/156 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $value/159 (ref $moonbit.string)) (param $start/160 i32) (param $len/161 i32) (result i32)
 (local $*try_err/158 (ref $moonbit.enum))
 (local $*bind/776 (ref $moonbit.enum))
 (local $tag/791 i32)
 (local.get $self/156)
 (block $outer/790 (result (ref $StringView))
  (block $join:157 (result (ref $moonbit.enum))
   (if (result (ref $StringView))
    (i32.eq
     (local.tee $tag/791
      (struct.get $moonbit.enum 0
       (local.tee $*bind/776
        (call $String::sub.inner
         (local.get $value/159)
         (local.get $start/160)
         (i64.extend_i32_s
          (i32.add
           (local.get $start/160)
           (local.get $len/161)))))))
     (i32.const 1))
    (then
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
       (local.get $*bind/776))))
    (else
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
       (local.get $*bind/776)))
     (br $join:157)))
   (br $outer/790))
  (local.set $*try_err/158)
  (unreachable))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view))
(func $String::sub (param $self/154 (ref $moonbit.string)) (param $start.opt/152 i64) (param $end/155 i64) (result (ref $moonbit.enum))
 (local $start/151 i32)
 (local $*Some/153 i64)
 (local.set $start/151
  (if (result i32)
   (i64.eq
    (local.get $start.opt/152)
    (i64.const 4294967296))
   (then
    (i32.const 0))
   (else
    (i32.wrap_i64
     (local.tee $*Some/153
      (local.get $start.opt/152))))))
 (call $String::sub.inner
  (local.get $self/154)
  (local.get $start/151)
  (local.get $end/155)))
(func $String::sub.inner (param $self/144 (ref $moonbit.string)) (param $start/150 i32) (param $end/146 i64) (result (ref $moonbit.enum))
 (local $len/143 i32)
 (local $end/145 i32)
 (local $*Some/147 i64)
 (local $*end/148 i32)
 (local $start/149 i32)
 (local $*p/604 i32)
 (local $*p/607 i32)
 (local.set $len/143
  (array.len
   (local.get $self/144)))
 (local.set $end/145
  (if (result i32)
   (i64.eq
    (local.get $end/146)
    (i64.const 4294967296))
   (then
    (local.get $len/143))
   (else
    (if (result i32)
     (i32.lt_s
      (local.tee $*end/148
       (i32.wrap_i64
        (local.tee $*Some/147
         (local.get $end/146))))
      (i32.const 0))
     (then
      (i32.add
       (local.get $len/143)
       (local.get $*end/148)))
     (else
      (local.get $*end/148))))))
 (if (result (ref $moonbit.enum))
  (if (result i32)
   (i32.ge_s
    (local.tee $start/149
     (if (result i32)
      (i32.lt_s
       (local.get $start/150)
       (i32.const 0))
      (then
       (i32.add
        (local.get $len/143)
        (local.get $start/150)))
      (else
       (local.get $start/150))))
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start/149)
      (local.get $end/145))
     (then
      (i32.le_s
       (local.get $end/145)
       (local.get $len/143)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $start/149)
      (local.get $len/143))
     (then
      (local.set $*p/604
       (array.get_u $moonbit.string
        (local.get $self/144)
        (local.get $start/149)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/604))
       (then
        (i32.le_s
         (local.get $*p/604)
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
      (local.get $end/145)
      (local.get $len/143))
     (then
      (local.set $*p/607
       (array.get_u $moonbit.string
        (local.get $self/144)
        (local.get $end/145)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/607))
       (then
        (i32.le_s
         (local.get $*p/607)
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
     (local.get $self/144)
     (local.get $start/149)
     (local.get $end/145))))
  (else
   (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
    (i32.const 0)
    (global.get $moonbit.constr/1)))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/140 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/141 (ref $moonbit.string)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/140)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/140))
    (i32.mul
     (array.len
      (local.get $str/141))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/140))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/140))
   (local.get $str/141)
   (i32.const 0)
   (array.len
    (local.get $str/141))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/140)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/140))
   (i32.mul
    (array.len
     (local.get $str/141))
    (i32.const 2))))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/132 (ref $moonbit.bytes)) (param $bytes_offset/127 i32) (param $str/134 (ref $moonbit.string)) (param $str_offset/130 i32) (param $length/128 i32) (result i32)
 (local $e1/126 i32)
 (local $e2/129 i32)
 (local $len1/131 i32)
 (local $len2/133 i32)
 (local $end_str_offset/135 i32)
 (local $i/136 i32)
 (local $j/137 i32)
 (local $c/138 i32)
 (local $*p/598 i32)
 (local $*p/601 i32)
 (local.set $e1/126
  (i32.sub
   (i32.add
    (local.get $bytes_offset/127)
    (i32.mul
     (local.get $length/128)
     (i32.const 2)))
   (i32.const 1)))
 (local.set $e2/129
  (i32.sub
   (i32.add
    (local.get $str_offset/130)
    (local.get $length/128))
   (i32.const 1)))
 (local.set $len1/131
  (array.len
   (local.get $self/132)))
 (local.set $len2/133
  (array.len
   (local.get $str/134)))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $length/128)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $bytes_offset/127)
      (i32.const 0))
     (then
      (if (result i32)
       (i32.lt_s
        (local.get $e1/126)
        (local.get $len1/131))
       (then
        (if (result i32)
         (i32.ge_s
          (local.get $str_offset/130)
          (i32.const 0))
         (then
          (i32.lt_s
           (local.get $e2/129)
           (local.get $len2/133)))
         (else
          (i32.const 0))))
       (else
        (i32.const 0))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $end_str_offset/135
    (i32.add
     (local.get $str_offset/130)
     (local.get $length/128)))
   (local.get $str_offset/130)
   (local.get $bytes_offset/127)
   (loop $loop:139 (param i32) (param i32)
    (local.set $j/137)
    (local.tee $i/136)
    (local.get $end_str_offset/135)
    (i32.lt_s)
    (if
     (then
      (local.set $c/138
       (array.get_u $moonbit.string
        (local.get $str/134)
        (local.get $i/136)))
      (array.set $moonbit.bytes
       (local.get $self/132)
       (local.get $j/137)
       (i32.and
        (local.tee $*p/598
         (i32.and
          (local.get $c/138)
          (i32.const 255)))
        (i32.const 255)))
      (array.set $moonbit.bytes
       (local.get $self/132)
       (i32.add
        (local.get $j/137)
        (i32.const 1))
       (i32.and
        (local.tee $*p/601
         (i32.shr_u
          (local.get $c/138)
          (i32.const 8)))
        (i32.const 255)))
      (i32.add
       (local.get $i/136)
       (i32.const 1))
      (i32.add
       (local.get $j/137)
       (i32.const 2))
      (br $loop:139))
     (else)))
   (i32.const 0))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/49 (ref $moonbit.string)) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
 (local $*bind/48 (ref $StringView))
 (local $*data/50 (ref $moonbit.string))
 (local $*start/51 i32)
 (local $*end/52 i32)
 (local $start_line/70 (ref $StringView))
 (local $*try_err/72 (ref $moonbit.enum))
 (local $start_column/73 (ref $StringView))
 (local $*try_err/75 (ref $moonbit.enum))
 (local $pkg/76 (ref $StringView))
 (local $*try_err/78 (ref $moonbit.enum))
 (local $filename/79 (ref $StringView))
 (local $*try_err/81 (ref $moonbit.enum))
 (local $end_line/82 (ref $StringView))
 (local $*try_err/84 (ref $moonbit.enum))
 (local $end_column/85 (ref $StringView))
 (local $*try_err/87 (ref $moonbit.enum))
 (local $join_dispatch_19/89 i32)
 (local $dispatch_19/90 i32)
 (local $next_char/94 i32)
 (local $next_char/97 i32)
 (local $next_char/99 i32)
 (local $next_char/101 i32)
 (local $next_char/103 i32)
 (local $next_char/104 i32)
 (local $next_char/106 i32)
 (local $next_char/108 i32)
 (local $next_char/110 i32)
 (local $next_char/112 i32)
 (local $next_char/114 i32)
 (local $next_char/115 i32)
 (local $next_char/117 i32)
 (local $next_char/118 i32)
 (local $next_char/121 i32)
 (local $next_char/123 i32)
 (local $next_char/124 i32)
 (local $next_char/125 i32)
 (local $*p/544 i32)
 (local $*p/547 i32)
 (local $*p/550 i32)
 (local $*p/553 i32)
 (local $*p/556 i32)
 (local $*p/559 i32)
 (local $*p/562 i32)
 (local $*p/565 i32)
 (local $*p/568 i32)
 (local $*p/571 i32)
 (local $*p/574 i32)
 (local $*p/577 i32)
 (local $*p/580 i32)
 (local $*p/583 i32)
 (local $*p/586 i32)
 (local $*p/589 i32)
 (local $*p/592 i32)
 (local $*p/595 i32)
 (local $*bind/770 (ref $moonbit.enum))
 (local $*bind/771 (ref $moonbit.enum))
 (local $*bind/772 (ref $moonbit.enum))
 (local $*bind/773 (ref $moonbit.enum))
 (local $*bind/774 (ref $moonbit.enum))
 (local $*bind/775 (ref $moonbit.enum))
 (local $tag/819 i32)
 (local $tag/821 i32)
 (local $tag/823 i32)
 (local $tag/825 i32)
 (local $tag/827 i32)
 (local $tag/829 i32)
 (local $*cursor/53 i32)
 (local $accept_state/54 i32)
 (local $match_end/55 i32)
 (local $match_tag_saver_0/56 i32)
 (local $match_tag_saver_1/57 i32)
 (local $match_tag_saver_2/58 i32)
 (local $match_tag_saver_3/59 i32)
 (local $match_tag_saver_4/60 i32)
 (local $tag_0/61 i32)
 (local $tag_1/62 i32)
 (local $tag_1_1/63 i32)
 (local $tag_1_2/64 i32)
 (local $tag_3/65 i32)
 (local $tag_2/66 i32)
 (local $tag_2_1/67 i32)
 (local $tag_4/68 i32)
 (local.set $*data/50
  (struct.get $StringView 0
   (local.tee $*bind/48
    (struct.new $StringView
     (local.get $repr/49)
     (i32.const 0)
     (array.len
      (local.get $repr/49))))))
 (local.set $*end/52
  (i32.add
   (local.tee $*start/51
    (struct.get $StringView 1
     (local.get $*bind/48)))
   (i32.sub
    (struct.get $StringView 2
     (local.get $*bind/48))
    (struct.get $StringView 1
     (local.get $*bind/48)))))
 (local.set $*cursor/53
  (local.get $*start/51))
 (local.set $accept_state/54
  (i32.const -1))
 (local.set $match_end/55
  (i32.const -1))
 (local.set $match_tag_saver_0/56
  (i32.const -1))
 (local.set $match_tag_saver_1/57
  (i32.const -1))
 (local.set $match_tag_saver_2/58
  (i32.const -1))
 (local.set $match_tag_saver_3/59
  (i32.const -1))
 (local.set $match_tag_saver_4/60
  (i32.const -1))
 (local.set $tag_0/61
  (i32.const -1))
 (local.set $tag_1/62
  (i32.const -1))
 (local.set $tag_1_1/63
  (i32.const -1))
 (local.set $tag_1_2/64
  (i32.const -1))
 (local.set $tag_3/65
  (i32.const -1))
 (local.set $tag_2/66
  (i32.const -1))
 (local.set $tag_2_1/67
  (i32.const -1))
 (local.set $tag_4/68
  (i32.const -1))
 (block $join:69
  (block $join:88 (result i32)
   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
    (i32.lt_s
     (local.get $*cursor/53)
     (local.get $*end/52))
    (then
     (local.set $*p/544
      (local.get $*cursor/53))
     (local.set $next_char/118
      (array.get_u $moonbit.string
       (local.get $*data/50)
       (local.get $*p/544)))
     (local.set $*cursor/53
      (i32.add
       (local.get $*cursor/53)
       (i32.const 1)))
     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
      (i32.lt_s
       (local.get $next_char/118)
       (i32.const 65))
      (then
       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
        (i32.lt_s
         (local.get $next_char/118)
         (i32.const 64))
        (then
         (br $join:69))
        (else
         (loop $loop:120 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
          (local.set $tag_0/61
           (local.get $*cursor/53))
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $*cursor/53)
            (local.get $*end/52))
           (then
            (block $outer/792 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (block $join:119
              (local.set $*p/547
               (local.get $*cursor/53))
              (local.set $next_char/121
               (array.get_u $moonbit.string
                (local.get $*data/50)
                (local.get $*p/547)))
              (local.set $*cursor/53
               (i32.add
                (local.get $*cursor/53)
                (i32.const 1)))
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.lt_s
                (local.get $next_char/121)
                (i32.const 55296))
               (then
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/121)
                  (i32.const 58))
                 (then
                  (br $join:119))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/121)
                    (i32.const 58))
                   (then
                    (br $join:119))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $*cursor/53)
                      (local.get $*end/52))
                     (then
                      (block $outer/793 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (block $join:122
                        (local.set $*p/550
                         (local.get $*cursor/53))
                        (local.set $next_char/123
                         (array.get_u $moonbit.string
                          (local.get $*data/50)
                          (local.get $*p/550)))
                        (local.set $*cursor/53
                         (i32.add
                          (local.get $*cursor/53)
                          (i32.const 1)))
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.lt_s
                          (local.get $next_char/123)
                          (i32.const 56319))
                         (then
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.lt_s
                            (local.get $next_char/123)
                            (i32.const 55296))
                           (then
                            (br $join:122))
                           (else
                            (i32.const 7)
                            (br $join:88))))
                         (else
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.gt_s
                            (local.get $next_char/123)
                            (i32.const 56319))
                           (then
                            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                             (i32.lt_s
                              (local.get $next_char/123)
                              (i32.const 65536))
                             (then
                              (br $join:122))
                             (else
                              (br $join:69))))
                           (else
                            (i32.const 8)
                            (br $join:88)))))
                        (br $outer/793))
                       (i32.const 0)
                       (br $join:88)))
                     (else
                      (br $join:69))))))))
               (else
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.gt_s
                  (local.get $next_char/121)
                  (i32.const 56318))
                 (then
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $next_char/121)
                    (i32.const 57344))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $*cursor/53)
                      (local.get $*end/52))
                     (then
                      (local.set $*p/553
                       (local.get $*cursor/53))
                      (local.set $next_char/124
                       (array.get_u $moonbit.string
                        (local.get $*data/50)
                        (local.get $*p/553)))
                      (local.set $*cursor/53
                       (i32.add
                        (local.get $*cursor/53)
                        (i32.const 1)))
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.lt_s
                        (local.get $next_char/124)
                        (i32.const 56320))
                       (then
                        (br $join:69))
                       (else
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.gt_s
                          (local.get $next_char/124)
                          (i32.const 57343))
                         (then
                          (br $join:69))
                         (else
                          (br $loop:120))))))
                     (else
                      (br $join:69))))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.gt_s
                      (local.get $next_char/121)
                      (i32.const 65535))
                     (then
                      (br $join:69))
                     (else
                      (br $join:119))))))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $*cursor/53)
                    (local.get $*end/52))
                   (then
                    (local.set $*p/556
                     (local.get $*cursor/53))
                    (local.set $next_char/125
                     (array.get_u $moonbit.string
                      (local.get $*data/50)
                      (local.get $*p/556)))
                    (local.set $*cursor/53
                     (i32.add
                      (local.get $*cursor/53)
                      (i32.const 1)))
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/125)
                      (i32.const 56320))
                     (then
                      (br $join:69))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/125)
                        (i32.const 65535))
                       (then
                        (br $join:69))
                       (else
                        (br $loop:120))))))
                   (else
                    (br $join:69)))))))
              (br $outer/792))
             (br $loop:120)))
           (else
            (br $join:69)))))))
      (else
       (br $join:69))))
    (else
     (br $join:69)))
   (return))
  (local.tee $join_dispatch_19/89)
  (loop $loop:93 (param i32) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
   (local.set $dispatch_19/90)
   (block $outer/794 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
    (block $join:91
     (block $outer/795 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
      (block $join:95
       (block $switch_int/806 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
        (block $switch_default/807
         (block $switch_int_1/809
          (block $switch_int_7/815
           (block $switch_int_6/814
            (block $switch_int_5/813
             (block $switch_int_4/812
              (block $switch_int_8/816
               (block $switch_int_0/808
                (block $switch_int_2/810
                 (block $switch_int_3/811
                  (local.get $dispatch_19/90)
                  (br_table
                   $switch_int_0/808
                   $switch_int_1/809
                   $switch_int_2/810
                   $switch_int_3/811
                   $switch_int_4/812
                   $switch_int_5/813
                   $switch_int_6/814
                   $switch_int_7/815
                   $switch_int_8/816
                   $switch_default/807
                   ))
                 (local.set $tag_1_2/64
                  (local.get $tag_1_1/63))
                 (local.set $tag_1_1/63
                  (local.get $tag_1/62))
                 (local.set $tag_1/62
                  (local.get $*cursor/53))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $*cursor/53)
                   (local.get $*end/52))
                  (then
                   (block $outer/796 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (block $join:96
                     (local.set $*p/559
                      (local.get $*cursor/53))
                     (local.set $next_char/97
                      (array.get_u $moonbit.string
                       (local.get $*data/50)
                       (local.get $*p/559)))
                     (local.set $*cursor/53
                      (i32.add
                       (local.get $*cursor/53)
                       (i32.const 1)))
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/97)
                       (i32.const 55296))
                      (then
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $next_char/97)
                         (i32.const 58))
                        (then
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.lt_s
                           (local.get $next_char/97)
                           (i32.const 48))
                          (then
                           (br $join:96))
                          (else
                           (local.set $tag_1/62
                            (local.get $*cursor/53))
                           (local.set $tag_2_1/67
                            (local.get $tag_2/66))
                           (local.set $tag_2/66
                            (local.get $*cursor/53))
                           (local.set $tag_3/65
                            (local.get $*cursor/53))
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.lt_s
                             (local.get $*cursor/53)
                             (local.get $*end/52))
                            (then
                             (block $outer/797 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (block $join:98
                               (local.set $*p/562
                                (local.get $*cursor/53))
                               (local.set $next_char/99
                                (array.get_u $moonbit.string
                                 (local.get $*data/50)
                                 (local.get $*p/562)))
                               (local.set $*cursor/53
                                (i32.add
                                 (local.get $*cursor/53)
                                 (i32.const 1)))
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/99)
                                 (i32.const 59))
                                (then
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.lt_s
                                   (local.get $next_char/99)
                                   (i32.const 46))
                                  (then
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.lt_s
                                     (local.get $next_char/99)
                                     (i32.const 45))
                                    (then
                                     (br $join:98))
                                    (else
                                     (br $join:91))))
                                  (else
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.gt_s
                                     (local.get $next_char/99)
                                     (i32.const 47))
                                    (then
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/99)
                                       (i32.const 58))
                                      (then
                                       (i32.const 6)
                                       (br $loop:93))
                                      (else
                                       (i32.const 3)
                                       (br $loop:93))))
                                    (else
                                     (br $join:98))))))
                                (else
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.gt_s
                                   (local.get $next_char/99)
                                   (i32.const 55295))
                                  (then
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.lt_s
                                     (local.get $next_char/99)
                                     (i32.const 57344))
                                    (then
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/99)
                                       (i32.const 56319))
                                      (then
                                       (i32.const 7)
                                       (br $loop:93))
                                      (else
                                       (i32.const 8)
                                       (br $loop:93))))
                                    (else
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.gt_s
                                       (local.get $next_char/99)
                                       (i32.const 65535))
                                      (then
                                       (br $join:69))
                                      (else
                                       (br $join:98))))))
                                  (else
                                   (br $join:98)))))
                               (br $outer/797))
                              (i32.const 0)
                              (br $loop:93)))
                            (else
                             (br $join:69))))))
                        (else
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.gt_s
                           (local.get $next_char/97)
                           (i32.const 58))
                          (then
                           (br $join:96))
                          (else
                           (i32.const 1)
                           (br $loop:93))))))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/97)
                         (i32.const 56318))
                        (then
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.lt_s
                           (local.get $next_char/97)
                           (i32.const 57344))
                          (then
                           (i32.const 8)
                           (br $loop:93))
                          (else
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.gt_s
                             (local.get $next_char/97)
                             (i32.const 65535))
                            (then
                             (br $join:69))
                            (else
                             (br $join:96))))))
                        (else
                         (i32.const 7)
                         (br $loop:93)))))
                     (br $outer/796))
                    (i32.const 0)
                    (br $loop:93)))
                  (else
                   (br $join:69)))
                 (br $switch_int/806))
                (local.set $tag_1/62
                 (local.get $*cursor/53))
                (local.set $tag_2/66
                 (local.get $*cursor/53))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $*cursor/53)
                  (local.get $*end/52))
                 (then
                  (block $outer/798 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (block $join:100
                    (local.set $*p/565
                     (local.get $*cursor/53))
                    (local.set $next_char/101
                     (array.get_u $moonbit.string
                      (local.get $*data/50)
                      (local.get $*p/565)))
                    (local.set $*cursor/53
                     (i32.add
                      (local.get $*cursor/53)
                      (i32.const 1)))
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/101)
                      (i32.const 55296))
                     (then
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.lt_s
                        (local.get $next_char/101)
                        (i32.const 58))
                       (then
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.lt_s
                          (local.get $next_char/101)
                          (i32.const 48))
                         (then
                          (br $join:100))
                         (else
                          (i32.const 2)
                          (br $loop:93))))
                       (else
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.gt_s
                          (local.get $next_char/101)
                          (i32.const 58))
                         (then
                          (br $join:100))
                         (else
                          (i32.const 3)
                          (br $loop:93))))))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/101)
                        (i32.const 56318))
                       (then
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.lt_s
                          (local.get $next_char/101)
                          (i32.const 57344))
                         (then
                          (i32.const 8)
                          (br $loop:93))
                         (else
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.gt_s
                            (local.get $next_char/101)
                            (i32.const 65535))
                           (then
                            (br $join:69))
                           (else
                            (br $join:100))))))
                       (else
                        (i32.const 7)
                        (br $loop:93)))))
                    (br $outer/798))
                   (i32.const 0)
                   (br $loop:93)))
                 (else
                  (br $join:69)))
                (br $switch_int/806))
               (local.set $tag_1/62
                (local.get $*cursor/53))
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $*cursor/53)
                 (local.get $*end/52))
                (then
                 (block $outer/799 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (block $join:102
                   (local.set $*p/568
                    (local.get $*cursor/53))
                   (local.set $next_char/103
                    (array.get_u $moonbit.string
                     (local.get $*data/50)
                     (local.get $*p/568)))
                   (local.set $*cursor/53
                    (i32.add
                     (local.get $*cursor/53)
                     (i32.const 1)))
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/103)
                     (i32.const 55296))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/103)
                       (i32.const 58))
                      (then
                       (br $join:102))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/103)
                         (i32.const 58))
                        (then
                         (br $join:102))
                        (else
                         (i32.const 1)
                         (br $loop:93))))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/103)
                       (i32.const 56318))
                      (then
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $next_char/103)
                         (i32.const 57344))
                        (then
                         (i32.const 8)
                         (br $loop:93))
                        (else
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.gt_s
                           (local.get $next_char/103)
                           (i32.const 65535))
                          (then
                           (br $join:69))
                          (else
                           (br $join:102))))))
                      (else
                       (i32.const 7)
                       (br $loop:93)))))
                   (br $outer/799))
                  (i32.const 0)
                  (br $loop:93)))
                (else
                 (br $join:69)))
               (br $switch_int/806))
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.lt_s
                (local.get $*cursor/53)
                (local.get $*end/52))
               (then
                (local.set $*p/571
                 (local.get $*cursor/53))
                (local.set $next_char/104
                 (array.get_u $moonbit.string
                  (local.get $*data/50)
                  (local.get $*p/571)))
                (local.set $*cursor/53
                 (i32.add
                  (local.get $*cursor/53)
                  (i32.const 1)))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/104)
                  (i32.const 56320))
                 (then
                  (br $join:69))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/104)
                    (i32.const 57343))
                   (then
                    (br $join:69))
                   (else
                    (i32.const 0)
                    (br $loop:93))))))
               (else
                (br $join:69)))
              (br $switch_int/806))
             (local.set $tag_1/62
              (local.get $*cursor/53))
             (local.set $tag_4/68
              (local.get $*cursor/53))
             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (i32.lt_s
               (local.get $*cursor/53)
               (local.get $*end/52))
              (then
               (block $outer/800 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (block $join:105
                 (local.set $*p/574
                  (local.get $*cursor/53))
                 (local.set $next_char/106
                  (array.get_u $moonbit.string
                   (local.get $*data/50)
                   (local.get $*p/574)))
                 (local.set $*cursor/53
                  (i32.add
                   (local.get $*cursor/53)
                   (i32.const 1)))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/106)
                   (i32.const 55296))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/106)
                     (i32.const 58))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/106)
                       (i32.const 48))
                      (then
                       (br $join:105))
                      (else
                       (i32.const 4)
                       (br $loop:93))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/106)
                       (i32.const 58))
                      (then
                       (br $join:105))
                      (else
                       (local.set $tag_1_2/64
                        (local.get $tag_1_1/63))
                       (local.set $tag_1_1/63
                        (local.get $tag_1/62))
                       (local.set $tag_1/62
                        (local.get $*cursor/53))
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $*cursor/53)
                         (local.get $*end/52))
                        (then
                         (block $outer/801 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (block $join:107
                           (local.set $*p/577
                            (local.get $*cursor/53))
                           (local.set $next_char/108
                            (array.get_u $moonbit.string
                             (local.get $*data/50)
                             (local.get $*p/577)))
                           (local.set $*cursor/53
                            (i32.add
                             (local.get $*cursor/53)
                             (i32.const 1)))
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.lt_s
                             (local.get $next_char/108)
                             (i32.const 55296))
                            (then
                             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (i32.lt_s
                               (local.get $next_char/108)
                               (i32.const 58))
                              (then
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/108)
                                 (i32.const 48))
                                (then
                                 (br $join:107))
                                (else
                                 (local.set $tag_1/62
                                  (local.get $*cursor/53))
                                 (local.set $tag_2_1/67
                                  (local.get $tag_2/66))
                                 (local.set $tag_2/66
                                  (local.get $*cursor/53))
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.lt_s
                                   (local.get $*cursor/53)
                                   (local.get $*end/52))
                                  (then
                                   (block $outer/802 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (block $join:109
                                     (local.set $*p/580
                                      (local.get $*cursor/53))
                                     (local.set $next_char/110
                                      (array.get_u $moonbit.string
                                       (local.get $*data/50)
                                       (local.get $*p/580)))
                                     (local.set $*cursor/53
                                      (i32.add
                                       (local.get $*cursor/53)
                                       (i32.const 1)))
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/110)
                                       (i32.const 55296))
                                      (then
                                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                        (i32.lt_s
                                         (local.get $next_char/110)
                                         (i32.const 58))
                                        (then
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.lt_s
                                           (local.get $next_char/110)
                                           (i32.const 48))
                                          (then
                                           (br $join:109))
                                          (else
                                           (i32.const 5)
                                           (br $loop:93))))
                                        (else
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.gt_s
                                           (local.get $next_char/110)
                                           (i32.const 58))
                                          (then
                                           (br $join:109))
                                          (else
                                           (i32.const 3)
                                           (br $loop:93))))))
                                      (else
                                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                        (i32.gt_s
                                         (local.get $next_char/110)
                                         (i32.const 56318))
                                        (then
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.lt_s
                                           (local.get $next_char/110)
                                           (i32.const 57344))
                                          (then
                                           (i32.const 8)
                                           (br $loop:93))
                                          (else
                                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                            (i32.gt_s
                                             (local.get $next_char/110)
                                             (i32.const 65535))
                                            (then
                                             (br $join:69))
                                            (else
                                             (br $join:109))))))
                                        (else
                                         (i32.const 7)
                                         (br $loop:93)))))
                                     (br $outer/802))
                                    (i32.const 0)
                                    (br $loop:93)))
                                  (else
                                   (br $join:95))))))
                              (else
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.gt_s
                                 (local.get $next_char/108)
                                 (i32.const 58))
                                (then
                                 (br $join:107))
                                (else
                                 (i32.const 1)
                                 (br $loop:93))))))
                            (else
                             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (i32.gt_s
                               (local.get $next_char/108)
                               (i32.const 56318))
                              (then
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/108)
                                 (i32.const 57344))
                                (then
                                 (i32.const 8)
                                 (br $loop:93))
                                (else
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.gt_s
                                   (local.get $next_char/108)
                                   (i32.const 65535))
                                  (then
                                   (br $join:69))
                                  (else
                                   (br $join:107))))))
                              (else
                               (i32.const 7)
                               (br $loop:93)))))
                           (br $outer/801))
                          (i32.const 0)
                          (br $loop:93)))
                        (else
                         (br $join:69))))))))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/106)
                     (i32.const 56318))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/106)
                       (i32.const 57344))
                      (then
                       (i32.const 8)
                       (br $loop:93))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/106)
                         (i32.const 65535))
                        (then
                         (br $join:69))
                        (else
                         (br $join:105))))))
                    (else
                     (i32.const 7)
                     (br $loop:93)))))
                 (br $outer/800))
                (i32.const 0)
                (br $loop:93)))
              (else
               (br $join:69)))
             (br $switch_int/806))
            (local.set $tag_1/62
             (local.get $*cursor/53))
            (local.set $tag_2/66
             (local.get $*cursor/53))
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $*cursor/53)
              (local.get $*end/52))
             (then
              (block $outer/803 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (block $join:111
                (local.set $*p/583
                 (local.get $*cursor/53))
                (local.set $next_char/112
                 (array.get_u $moonbit.string
                  (local.get $*data/50)
                  (local.get $*p/583)))
                (local.set $*cursor/53
                 (i32.add
                  (local.get $*cursor/53)
                  (i32.const 1)))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/112)
                  (i32.const 55296))
                 (then
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $next_char/112)
                    (i32.const 58))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/112)
                      (i32.const 48))
                     (then
                      (br $join:111))
                     (else
                      (i32.const 5)
                      (br $loop:93))))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.gt_s
                      (local.get $next_char/112)
                      (i32.const 58))
                     (then
                      (br $join:111))
                     (else
                      (i32.const 3)
                      (br $loop:93))))))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/112)
                    (i32.const 56318))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/112)
                      (i32.const 57344))
                     (then
                      (i32.const 8)
                      (br $loop:93))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/112)
                        (i32.const 65535))
                       (then
                        (br $join:69))
                       (else
                        (br $join:111))))))
                   (else
                    (i32.const 7)
                    (br $loop:93)))))
                (br $outer/803))
               (i32.const 0)
               (br $loop:93)))
             (else
              (br $join:95)))
            (br $switch_int/806))
           (local.set $tag_1/62
            (local.get $*cursor/53))
           (local.set $tag_2/66
            (local.get $*cursor/53))
           (local.set $tag_3/65
            (local.get $*cursor/53))
           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
            (i32.lt_s
             (local.get $*cursor/53)
             (local.get $*end/52))
            (then
             (block $outer/804 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (block $join:113
               (local.set $*p/586
                (local.get $*cursor/53))
               (local.set $next_char/114
                (array.get_u $moonbit.string
                 (local.get $*data/50)
                 (local.get $*p/586)))
               (local.set $*cursor/53
                (i32.add
                 (local.get $*cursor/53)
                 (i32.const 1)))
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $next_char/114)
                 (i32.const 59))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/114)
                   (i32.const 46))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/114)
                     (i32.const 45))
                    (then
                     (br $join:113))
                    (else
                     (br $join:91))))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/114)
                     (i32.const 47))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/114)
                       (i32.const 58))
                      (then
                       (i32.const 6)
                       (br $loop:93))
                      (else
                       (i32.const 3)
                       (br $loop:93))))
                    (else
                     (br $join:113))))))
                (else
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.gt_s
                   (local.get $next_char/114)
                   (i32.const 55295))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/114)
                     (i32.const 57344))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/114)
                       (i32.const 56319))
                      (then
                       (i32.const 7)
                       (br $loop:93))
                      (else
                       (i32.const 8)
                       (br $loop:93))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/114)
                       (i32.const 65535))
                      (then
                       (br $join:69))
                      (else
                       (br $join:113))))))
                  (else
                   (br $join:113)))))
               (br $outer/804))
              (i32.const 0)
              (br $loop:93)))
            (else
             (br $join:69)))
           (br $switch_int/806))
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $*cursor/53)
            (local.get $*end/52))
           (then
            (local.set $*p/589
             (local.get $*cursor/53))
            (local.set $next_char/115
             (array.get_u $moonbit.string
              (local.get $*data/50)
              (local.get $*p/589)))
            (local.set $*cursor/53
             (i32.add
              (local.get $*cursor/53)
              (i32.const 1)))
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $next_char/115)
              (i32.const 56320))
             (then
              (br $join:69))
             (else
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.gt_s
                (local.get $next_char/115)
                (i32.const 65535))
               (then
                (br $join:69))
               (else
                (i32.const 0)
                (br $loop:93))))))
           (else
            (br $join:69)))
          (br $switch_int/806))
         (local.set $tag_1_1/63
          (local.get $tag_1/62))
         (local.set $tag_1/62
          (local.get $*cursor/53))
         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
          (i32.lt_s
           (local.get $*cursor/53)
           (local.get $*end/52))
          (then
           (block $outer/805 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
            (block $join:116
             (local.set $*p/592
              (local.get $*cursor/53))
             (local.set $next_char/117
              (array.get_u $moonbit.string
               (local.get $*data/50)
               (local.get $*p/592)))
             (local.set $*cursor/53
              (i32.add
               (local.get $*cursor/53)
               (i32.const 1)))
             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (i32.lt_s
               (local.get $next_char/117)
               (i32.const 55296))
              (then
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $next_char/117)
                 (i32.const 58))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/117)
                   (i32.const 48))
                  (then
                   (br $join:116))
                  (else
                   (i32.const 2)
                   (br $loop:93))))
                (else
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.gt_s
                   (local.get $next_char/117)
                   (i32.const 58))
                  (then
                   (br $join:116))
                  (else
                   (i32.const 1)
                   (br $loop:93))))))
              (else
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.gt_s
                 (local.get $next_char/117)
                 (i32.const 56318))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/117)
                   (i32.const 57344))
                  (then
                   (i32.const 8)
                   (br $loop:93))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/117)
                     (i32.const 65535))
                    (then
                     (br $join:69))
                    (else
                     (br $join:116))))))
                (else
                 (i32.const 7)
                 (br $loop:93)))))
             (br $outer/805))
            (i32.const 0)
            (br $loop:93)))
          (else
           (br $join:69)))
         (br $switch_int/806))
        (br $join:69))
       (br $outer/795))
      (local.set $tag_1/62
       (local.get $tag_1_2/64))
      (local.set $tag_2/66
       (local.get $tag_2_1/67))
      (local.set $match_tag_saver_0/56
       (local.get $tag_0/61))
      (local.set $match_tag_saver_1/57
       (local.get $tag_1/62))
      (local.set $match_tag_saver_2/58
       (local.get $tag_2/66))
      (local.set $match_tag_saver_3/59
       (local.get $tag_3/65))
      (local.set $match_tag_saver_4/60
       (local.get $tag_4/68))
      (local.set $accept_state/54
       (i32.const 0))
      (local.set $match_end/55
       (local.get $*cursor/53))
      (br $join:69))
     (br $outer/794))
    (local.set $tag_1_1/63
     (local.get $tag_1_2/64))
    (local.set $tag_1/62
     (local.get $*cursor/53))
    (local.set $tag_2/66
     (local.get $tag_2_1/67))
    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
     (i32.lt_s
      (local.get $*cursor/53)
      (local.get $*end/52))
     (then
      (block $outer/817 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
       (block $join:92
        (local.set $*p/595
         (local.get $*cursor/53))
        (local.set $next_char/94
         (array.get_u $moonbit.string
          (local.get $*data/50)
          (local.get $*p/595)))
        (local.set $*cursor/53
         (i32.add
          (local.get $*cursor/53)
          (i32.const 1)))
        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
         (i32.lt_s
          (local.get $next_char/94)
          (i32.const 55296))
         (then
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $next_char/94)
            (i32.const 58))
           (then
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $next_char/94)
              (i32.const 48))
             (then
              (br $join:92))
             (else
              (i32.const 4)
              (br $loop:93))))
           (else
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.gt_s
              (local.get $next_char/94)
              (i32.const 58))
             (then
              (br $join:92))
             (else
              (i32.const 1)
              (br $loop:93))))))
         (else
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.gt_s
            (local.get $next_char/94)
            (i32.const 56318))
           (then
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $next_char/94)
              (i32.const 57344))
             (then
              (i32.const 8)
              (br $loop:93))
             (else
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.gt_s
                (local.get $next_char/94)
                (i32.const 65535))
               (then
                (br $join:69))
               (else
                (br $join:92))))))
           (else
            (i32.const 7)
            (br $loop:93)))))
        (br $outer/817))
       (i32.const 0)
       (br $loop:93)))
     (else
      (br $join:69)))))
  (return))
 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
  (i32.eq
   (local.get $accept_state/54)
   (i32.const 0))
  (then
   (block $outer/828 (result (ref $StringView))
    (block $join:71 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/829
        (struct.get $moonbit.enum 0
         (local.tee $*bind/775
          (call $String::sub
           (local.get $*data/50)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_1/57)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_2/58))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/775))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/775)))
       (br $join:71)))
     (br $outer/828))
    (local.set $*try_err/72)
    (unreachable))
   (local.set $start_line/70)
   (block $outer/826 (result (ref $StringView))
    (block $join:74 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/827
        (struct.get $moonbit.enum 0
         (local.tee $*bind/774
          (call $String::sub
           (local.get $*data/50)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_2/58)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_3/59))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/774))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/774)))
       (br $join:74)))
     (br $outer/826))
    (local.set $*try_err/75)
    (unreachable))
   (local.set $start_column/73)
   (block $outer/824 (result (ref $StringView))
    (block $join:77 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/825
        (struct.get $moonbit.enum 0
         (local.tee $*bind/773
          (call $String::sub
           (local.get $*data/50)
           (i64.extend_i32_s
            (i32.add
             (local.get $*start/51)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_0/56))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/773))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/773)))
       (br $join:77)))
     (br $outer/824))
    (local.set $*try_err/78)
    (unreachable))
   (local.set $pkg/76)
   (block $outer/822 (result (ref $StringView))
    (block $join:80 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/823
        (struct.get $moonbit.enum 0
         (local.tee $*bind/772
          (call $String::sub
           (local.get $*data/50)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_0/56)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_1/57))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/772))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/772)))
       (br $join:80)))
     (br $outer/822))
    (local.set $*try_err/81)
    (unreachable))
   (local.set $filename/79)
   (block $outer/820 (result (ref $StringView))
    (block $join:83 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/821
        (struct.get $moonbit.enum 0
         (local.tee $*bind/771
          (call $String::sub
           (local.get $*data/50)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_3/59)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_4/60))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/771))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/771)))
       (br $join:83)))
     (br $outer/820))
    (local.set $*try_err/84)
    (unreachable))
   (local.set $end_line/82)
   (block $outer/818 (result (ref $StringView))
    (block $join:86 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/819
        (struct.get $moonbit.enum 0
         (local.tee $*bind/770
          (call $String::sub
           (local.get $*data/50)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_4/60)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_end/55))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/770))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/770)))
       (br $join:86)))
     (br $outer/818))
    (local.set $*try_err/87)
    (unreachable))
   (local.set $end_column/85)
   (struct.new $@moonbitlang/core/builtin.SourceLocRepr
    (local.get $pkg/76)
    (local.get $filename/79)
    (local.get $start_line/70)
    (local.get $start_column/73)
    (local.get $end_line/82)
    (local.get $end_column/85)))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/42 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $ch/44 i32) (result i32)
 (local $inc/43 i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/42)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/42))
    (i32.const 4))))
 (local.set $inc/43
  (call $FixedArray::set_utf16le_char
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/42))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/42))
   (local.get $ch/44)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/42)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/42))
   (local.get $inc/43)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/37 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $required/38 i32) (result i32)
 (local $current_len/36 i32)
 (local $new_data/41 (ref $moonbit.bytes))
 (local $enough_space/39 i32)
 (local.set $current_len/36
  (array.len
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/37))))
 (if
  (i32.le_s
   (local.get $required/38)
   (local.get $current_len/36))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/39
  (local.get $current_len/36))
 (loop $loop:40
  (if
   (i32.lt_s
    (local.get $enough_space/39)
    (local.get $required/38))
   (then
    (local.set $enough_space/39
     (i32.mul
      (local.get $enough_space/39)
      (i32.const 2)))
    (br $loop:40))
   (else)))
 (array.copy $moonbit.bytes $moonbit.bytes
  (local.tee $new_data/41
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $enough_space/39)))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/37))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 1
   (local.get $self/37)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 0
  (local.get $self/37)
  (local.get $new_data/41))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/31 (ref $moonbit.bytes)) (param $offset/32 i32) (param $value/30 i32) (result i32)
 (local $code/29 i32)
 (local $hi/33 i32)
 (local $lo/34 i32)
 (local $hi/35 i32)
 (local $*p/518 i32)
 (local $*p/521 i32)
 (local $*p/524 i32)
 (local $*p/527 i32)
 (local $*p/530 i32)
 (local $*p/533 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/29
    (local.get $value/30))
   (i32.const 65536))
  (then
   (array.set $moonbit.bytes
    (local.get $self/31)
    (local.get $offset/32)
    (i32.and
     (local.tee $*p/518
      (i32.and
       (local.get $code/29)
       (i32.const 255)))
     (i32.const 255)))
   (array.set $moonbit.bytes
    (local.get $self/31)
    (i32.add
     (local.get $offset/32)
     (i32.const 1))
    (i32.and
     (local.tee $*p/521
      (i32.shr_u
       (local.get $code/29)
       (i32.const 8)))
     (i32.const 255)))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/29)
     (i32.const 1114112))
    (then
     (local.set $lo/34
      (i32.or
       (i32.shr_u
        (local.tee $hi/33
         (i32.sub
          (local.get $code/29)
          (i32.const 65536)))
        (i32.const 10))
       (i32.const 55296)))
     (local.set $hi/35
      (i32.or
       (i32.and
        (local.get $hi/33)
        (i32.const 1023))
       (i32.const 56320)))
     (array.set $moonbit.bytes
      (local.get $self/31)
      (local.get $offset/32)
      (i32.and
       (local.tee $*p/524
        (i32.and
         (local.get $lo/34)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/31)
      (i32.add
       (local.get $offset/32)
       (i32.const 1))
      (i32.and
       (local.tee $*p/527
        (i32.shr_u
         (local.get $lo/34)
         (i32.const 8)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/31)
      (i32.add
       (local.get $offset/32)
       (i32.const 2))
      (i32.and
       (local.tee $*p/530
        (i32.and
         (local.get $hi/35)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/31)
      (i32.add
       (local.get $offset/32)
       (i32.const 3))
      (i32.and
       (local.tee $*p/533
        (i32.shr_u
         (local.get $hi/35)
         (i32.const 8)))
       (i32.const 255)))
     (i32.const 4))
    (else
     (call $moonbitlang/core/builtin.abort|Int|
      (call $moonbit.string_literal
       (i32.const 11)
       (i32.const 530)
       (i32.const 17))
      (call $moonbit.string_literal
       (i32.const 10)
       (i32.const 434)
       (i32.const 48))))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/26 (ref $@moonbitlang/core/builtin.StringBuilder)) (result (ref $moonbit.string))
 (call $Bytes::to_unchecked_string.inner
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/26))
  (i32.const 0)
  (i64.extend_i32_s
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/26)))))
(func $Bytes::to_unchecked_string.inner (param $self/21 (ref $moonbit.bytes)) (param $offset/25 i32) (param $length/23 i64) (result (ref $moonbit.string))
 (local $len/20 i32)
 (local $length/22 i32)
 (local $*Some/24 i64)
 (local.set $len/20
  (array.len
   (local.get $self/21)))
 (local.set $length/22
  (if (result i32)
   (i64.eq
    (local.get $length/23)
    (i64.const 4294967296))
   (then
    (i32.sub
     (local.get $len/20)
     (local.get $offset/25)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/24
      (local.get $length/23))))))
 (if (result (ref $moonbit.string))
  (if (result i32)
   (i32.ge_s
    (local.get $offset/25)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $length/22)
      (i32.const 0))
     (then
      (i32.le_s
       (i32.add
        (local.get $offset/25)
        (local.get $length/22))
       (local.get $len/20)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (call $moonbitlang/core/builtin.unsafe_sub_string
    (local.get $self/21)
    (local.get $offset/25)
    (local.get $length/22)))
  (else
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/753 (ref $moonbit.bytes)) (param $*param/754 i32) (param $*param/755 i32) (result (ref $moonbit.string))
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/753)
  (local.get $*param/754)
  (local.get $*param/755)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/18 i32) (result (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $initial/17 i32)
 (local $data/19 (ref $moonbit.bytes))
 (local.set $initial/17
  (if (result i32)
   (i32.lt_s
    (local.get $size_hint/18)
    (i32.const 1))
   (then
    (i32.const 1))
   (else
    (local.get $size_hint/18))))
 (struct.new $@moonbitlang/core/builtin.StringBuilder
  (local.tee $data/19
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $initial/17)))
  (i32.const 0)))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/5 (ref $moonbit.string)) (param $loc/6 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Unit|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/5)
     (call $moonbit.string_literal
      (i32.const 13)
      (i32.const 566)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/6)))
   (call $moonbit.string_literal
    (i32.const 12)
    (i32.const 564)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/3 (ref $moonbit.string)) (param $loc/4 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/3)
     (call $moonbit.string_literal
      (i32.const 13)
      (i32.const 566)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/4)))
   (call $moonbit.string_literal
    (i32.const 12)
    (i32.const 564)
    (i32.const 1)))))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/2 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/1 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_3) (param $*obj/769 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/768 i32) (result i32)
 (local $*self/767 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/767
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/769))))
  (local.get $*param/768)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_2) (param $*obj/766 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/765 (ref $StringView)) (result i32)
 (local $*self/764 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/764
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/766))))
  (local.get $*param/765)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (type $@moonbitlang/core/builtin.Logger.method_1) (param $*obj/763 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/760 (ref $moonbit.string)) (param $*param/761 i32) (param $*param/762 i32) (result i32)
 (local $*self/759 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/759
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/763))))
  (local.get $*param/760)
  (local.get $*param/761)
  (local.get $*param/762)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_0) (param $*obj/758 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/757 (ref $moonbit.string)) (result i32)
 (local $*self/756 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/756
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/758))))
  (local.get $*param/757)))
(start $*init*/2)
(func $*init*/2
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
 (global.set $moonbitlang/core/double/internal/ryu.ryu_to_string.record/487
  (struct.new $@moonbitlang/core/double/internal/ryu.FloatingDecimal64
   (i64.const 0)
   (i32.const 0)))
 (global.set $username/moonbit_examples/cmd/enums.*main.c/510
  (struct.new $Shape.Circle
   (i32.const 0)
   (f64.const 0x1.4p+2)))
 (global.set $username/moonbit_examples/cmd/enums.*main.r/511
  (struct.new $Shape.Rectangle
   (i32.const 1)
   (f64.const 0x1p+2)
   (f64.const 0x1.8p+2))))
(func $*main*/1
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 15)
     (i32.const 616)
     (i32.const 16))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double|
     (call $username/moonbit_examples/cmd/enums.area
      (ref.as_non_null
       (global.get $username/moonbit_examples/cmd/enums.*main.c/510)))))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 14)
     (i32.const 578)
     (i32.const 19))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double|
     (call $username/moonbit_examples/cmd/enums.area
      (ref.as_non_null
       (global.get $username/moonbit_examples/cmd/enums.*main.r/511))))))))
(export "_start" (func $*main*/1))