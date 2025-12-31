(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data "@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\003\006\006\00:\005\00-\003\006\006\00:\003\003\00I\00n\00v\00a\00l\00i\00d\00 \00s\00t\00a\00r\00t\00 \00i\00n\00d\00e\00x\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\004\009\001\00:\009\00-\004\009\001\00:\004\000\00i\00n\00v\00a\00l\00i\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00 \00p\00a\00i\00r\000\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00r\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00v\00i\00e\00w\00.\00m\00b\00t\00:\001\001\001\00:\005\00-\001\001\001\00:\003\006\00I\00n\00v\00a\00l\00i\00d\00 \00i\00n\00d\00e\00x\00 \00f\00o\00r\00 \00V\00i\00e\00w\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\000\00:\005\00-\002\009\000\00:\003\001\00C\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\0A\00\0A\00 \00 \00a\00t\00 \00C\00a\00n\00n\00o\00t\00 \00d\00i\00v\00i\00d\00e\00 \00b\00y\00 \00z\00e\00r\00o\00 \00=\00 \00 \00/\00 \00/\00:\00-\00")
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
(type $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok
 (sub final
  $moonbit.enum
  (struct
   (field  i32)
   (field  (ref $StringView)))))
(type $@moonbitlang/core/builtin.SourceLocRepr
 (struct
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))))
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
(global $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/builtin.brute_force_find.constr/69
 (mut i64)
 (i64.const 0)
)
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 20)
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
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/313 (ref $moonbit.string)) (param $logger/314 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (call $@moonbitlang/core/builtin.SourceLocRepr::parse
   (local.get $self/313))
  (local.get $logger/314)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/299 (ref $@moonbitlang/core/builtin.SourceLocRepr)) (param $logger/312 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (local $pkg/298 (ref $StringView))
 (local $*bind/300 i64)
 (local $*bind/301 (ref $<StringView*Option<StringView>>))
 (local $*Some/302 i64)
 (local $*first_slash/303 i32)
 (local $*bind/304 i64)
 (local $*Some/305 i64)
 (local $*second_slash/306 i32)
 (local $module_name_end/307 i32)
 (local $*module_name/308 (ref $StringView))
 (local $*package_name/309 (ref null $StringView))
 (local $*Some/310 (ref null $StringView))
 (local $*pkg_name/311 (ref $StringView))
 (local $*bind/483 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/484 (ref $@moonbitlang/core/builtin.Logger))
 (local.set $*module_name/308
  (struct.get $<StringView*Option<StringView>> 0
   (local.tee $*bind/301
    (if (result (ref $<StringView*Option<StringView>>))
     (i64.eq
      (local.tee $*bind/300
       (call $StringView::find
        (local.tee $pkg/298
         (struct.get $@moonbitlang/core/builtin.SourceLocRepr 0
          (local.get $self/299)))
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
       (local.get $pkg/298)
       (ref.null none)))
     (else
      (local.set $*first_slash/303
       (i32.wrap_i64
        (local.tee $*Some/302
         (local.get $*bind/300))))
      (if (result (ref $<StringView*Option<StringView>>))
       (i64.eq
        (local.tee $*bind/304
         (call $StringView::find
          (call $StringView::view.inner
           (local.get $pkg/298)
           (i32.add
            (local.get $*first_slash/303)
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
         (local.get $pkg/298)
         (ref.null none)))
       (else
        (local.set $*second_slash/306
         (i32.wrap_i64
          (local.tee $*Some/305
           (local.get $*bind/304))))
        (local.set $module_name_end/307
         (i32.add
          (i32.add
           (local.get $*first_slash/303)
           (i32.const 1))
          (local.get $*second_slash/306)))
        (struct.new $<StringView*Option<StringView>>
         (call $StringView::view.inner
          (local.get $pkg/298)
          (i32.const 0)
          (i64.extend_i32_s
           (local.get $module_name_end/307)))
         (call $StringView::view.inner
          (local.get $pkg/298)
          (i32.add
           (local.get $module_name_end/307)
           (i32.const 1))
          (i64.const 4294967296))))))))))
 (if
  (ref.is_null
   (local.tee $*package_name/309
    (struct.get $<StringView*Option<StringView>> 1
     (local.get $*bind/301))))
  (then)
  (else
   (local.set $*pkg_name/311
    (ref.as_non_null
     (local.tee $*Some/310
      (local.get $*package_name/309))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_2
     (local.get $logger/312)
     (local.get $*pkg_name/311)
     (struct.get $@moonbitlang/core/builtin.Logger 2
      (local.get $logger/312))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_3
     (local.tee $*bind/483
      (local.get $logger/312))
     (i32.const 47)
     (struct.get $@moonbitlang/core/builtin.Logger 3
      (local.get $*bind/483))))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/312)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 1
    (local.get $self/299))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/312)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/312)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 2
    (local.get $self/299))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/312)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/312)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 3
    (local.get $self/299))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/312)
   (i32.const 45)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/312)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 4
    (local.get $self/299))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/312)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/312)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 5
    (local.get $self/299))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/312))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/312)
   (i32.const 64)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/312))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_2
  (local.tee $*bind/484
   (local.get $logger/312))
  (local.get $*module_name/308)
  (struct.get $@moonbitlang/core/builtin.Logger 2
   (local.get $*bind/484))))
(func $moonbitlang/core/builtin.println|String| (param $input/297 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/297))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/295 i32) (param $logger/294 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/294)
  (call $Int::to_string.inner
   (local.get $self/295)
   (i32.const 10))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/294))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/292 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/293 (ref $StringView)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/292)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/292))
    (i32.mul
     (i32.sub
      (struct.get $StringView 2
       (local.get $str/293))
      (struct.get $StringView 1
       (local.get $str/293)))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/292))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/292))
   (struct.get $StringView 0
    (local.get $str/293))
   (struct.get $StringView 1
    (local.get $str/293))
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/293))
    (struct.get $StringView 1
     (local.get $str/293)))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/292)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/292))
   (i32.mul
    (i32.sub
     (struct.get $StringView 2
      (local.get $str/293))
     (struct.get $StringView 1
      (local.get $str/293)))
    (i32.const 2))))
 (i32.const 0))
(func $String::offset_of_nth_char.inner (param $self/289 (ref $moonbit.string)) (param $i/290 i32) (param $start_offset/291 i32) (param $end_offset/287 i64) (result i64)
 (local $end_offset/286 i32)
 (local $*Some/288 i64)
 (local.set $end_offset/286
  (if (result i32)
   (i64.eq
    (local.get $end_offset/287)
    (i64.const 4294967296))
   (then
    (array.len
     (local.get $self/289)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/288
      (local.get $end_offset/287))))))
 (if (result i64)
  (i32.ge_s
   (local.get $i/290)
   (i32.const 0))
  (then
   (call $String::offset_of_nth_char_forward
    (local.get $self/289)
    (local.get $i/290)
    (local.get $start_offset/291)
    (local.get $end_offset/286)))
  (else
   (call $String::offset_of_nth_char_backward
    (local.get $self/289)
    (i32.sub
     (i32.const 0)
     (local.get $i/290))
    (local.get $start_offset/291)
    (local.get $end_offset/286)))))
(func $String::offset_of_nth_char_forward (param $self/284 (ref $moonbit.string)) (param $n/282 i32) (param $start_offset/278 i32) (param $end_offset/279 i32) (result i64)
 (local $c/283 i32)
 (local $utf16_offset/280 i32)
 (local $char_count/281 i32)
 (if (result i64)
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/278)
    (i32.const 0))
   (then
    (i32.le_s
     (local.get $start_offset/278)
     (local.get $end_offset/279)))
   (else
    (i32.const 0)))
  (then
   (local.set $utf16_offset/280
    (local.get $start_offset/278))
   (local.set $char_count/281
    (i32.const 0))
   (loop $loop:285
    (if
     (if (result i32)
      (i32.lt_s
       (local.get $utf16_offset/280)
       (local.get $end_offset/279))
      (then
       (i32.lt_s
        (local.get $char_count/281)
        (local.get $n/282)))
      (else
       (i32.const 0)))
     (then
      (local.set $c/283
       (array.get_u $moonbit.string
        (local.get $self/284)
        (local.get $utf16_offset/280)))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 55296)
         (local.get $c/283))
        (then
         (i32.le_s
          (local.get $c/283)
          (i32.const 56319)))
        (else
         (i32.const 0)))
       (then
        (local.set $utf16_offset/280
         (i32.add
          (local.get $utf16_offset/280)
          (i32.const 2))))
       (else
        (local.set $utf16_offset/280
         (i32.add
          (local.get $utf16_offset/280)
          (i32.const 1)))))
      (local.set $char_count/281
       (i32.add
        (local.get $char_count/281)
        (i32.const 1)))
      (br $loop:285))
     (else)))
   (if (result i64)
    (if (result i32)
     (i32.lt_s
      (local.get $char_count/281)
      (local.get $n/282))
     (then
      (i32.const 1))
     (else
      (i32.ge_s
       (local.get $utf16_offset/280)
       (local.get $end_offset/279))))
    (then
     (i64.const 4294967296))
    (else
     (i64.extend_i32_s
      (local.get $utf16_offset/280)))))
  (else
   (call $moonbitlang/core/builtin.abort|Option<Int>|
    (call $moonbit.string_literal
     (i32.const 1)
     (i32.const 98)
     (i32.const 19))
    (call $moonbit.string_literal
     (i32.const 0)
     (i32.const 0)
     (i32.const 49))))))
(func $String::offset_of_nth_char_backward (param $self/276 (ref $moonbit.string)) (param $n/274 i32) (param $start_offset/273 i32) (param $end_offset/272 i32) (result i64)
 (local $c/275 i32)
 (local $char_count/270 i32)
 (local $utf16_offset/271 i32)
 (local.set $char_count/270
  (i32.const 0))
 (local.set $utf16_offset/271
  (local.get $end_offset/272))
 (loop $loop:277
  (if
   (if (result i32)
    (i32.ge_s
     (i32.sub
      (local.get $utf16_offset/271)
      (i32.const 1))
     (local.get $start_offset/273))
    (then
     (i32.lt_s
      (local.get $char_count/270)
      (local.get $n/274)))
    (else
     (i32.const 0)))
   (then
    (local.set $c/275
     (array.get_u $moonbit.string
      (local.get $self/276)
      (i32.sub
       (local.get $utf16_offset/271)
       (i32.const 1))))
    (if
     (if (result i32)
      (i32.le_s
       (i32.const 56320)
       (local.get $c/275))
      (then
       (i32.le_s
        (local.get $c/275)
        (i32.const 57343)))
      (else
       (i32.const 0)))
     (then
      (local.set $utf16_offset/271
       (i32.sub
        (local.get $utf16_offset/271)
        (i32.const 2))))
     (else
      (local.set $utf16_offset/271
       (i32.sub
        (local.get $utf16_offset/271)
        (i32.const 1)))))
    (local.set $char_count/270
     (i32.add
      (local.get $char_count/270)
      (i32.const 1)))
    (br $loop:277))
   (else)))
 (if (result i64)
  (if (result i32)
   (i32.lt_s
    (local.get $char_count/270)
    (local.get $n/274))
   (then
    (i32.const 1))
   (else
    (i32.lt_s
     (local.get $utf16_offset/271)
     (local.get $start_offset/273))))
  (then
   (i64.const 4294967296))
  (else
   (i64.extend_i32_s
    (local.get $utf16_offset/271)))))
(func $String::char_length_ge.inner (param $self/262 (ref $moonbit.string)) (param $len/265 i32) (param $start_offset/269 i32) (param $end_offset/260 i64) (result i32)
 (local $end_offset/259 i32)
 (local $*Some/261 i64)
 (local $index/263 i32)
 (local $count/264 i32)
 (local $c1/266 i32)
 (local $c2/267 i32)
 (local.set $end_offset/259
  (if (result i32)
   (i64.eq
    (local.get $end_offset/260)
    (i64.const 4294967296))
   (then
    (array.len
     (local.get $self/262)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/261
      (local.get $end_offset/260))))))
 (local.get $start_offset/269)
 (i32.const 0)
 (loop $loop:268 (param i32) (param i32) (result i32)
  (local.set $count/264)
  (local.tee $index/263)
  (local.get $end_offset/259)
  (i32.lt_s)
  (if (result i32)
   (then
    (i32.lt_s
     (local.get $count/264)
     (local.get $len/265)))
   (else
    (i32.const 0)))
  (if (result i32)
   (then
    (local.set $c1/266
     (array.get_u $moonbit.string
      (local.get $self/262)
      (local.get $index/263)))
    (if
     (if (result i32)
      (if (result i32)
       (i32.le_s
        (i32.const 55296)
        (local.get $c1/266))
       (then
        (i32.le_s
         (local.get $c1/266)
         (i32.const 56319)))
       (else
        (i32.const 0)))
      (then
       (i32.lt_s
        (i32.add
         (local.get $index/263)
         (i32.const 1))
        (local.get $end_offset/259)))
      (else
       (i32.const 0)))
     (then
      (local.set $c2/267
       (array.get_u $moonbit.string
        (local.get $self/262)
        (i32.add
         (local.get $index/263)
         (i32.const 1))))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 56320)
         (local.get $c2/267))
        (then
         (i32.le_s
          (local.get $c2/267)
          (i32.const 57343)))
        (else
         (i32.const 0)))
       (then
        (i32.add
         (local.get $index/263)
         (i32.const 2))
        (i32.add
         (local.get $count/264)
         (i32.const 1))
        (br $loop:268))
       (else
        (drop
         (call $moonbitlang/core/builtin.abort|Unit|
          (call $moonbit.string_literal
           (i32.const 3)
           (i32.const 234)
           (i32.const 22))
          (call $moonbit.string_literal
           (i32.const 2)
           (i32.const 136)
           (i32.const 49)))))))
     (else))
    (i32.add
     (local.get $index/263)
     (i32.const 1))
    (i32.add
     (local.get $count/264)
     (i32.const 1))
    (br $loop:268))
   (else
    (i32.ge_s
     (local.get $count/264)
     (local.get $len/265))))))
(func $Int::to_string.inner (param $self/243 i32) (param $radix/242 i32) (result (ref $moonbit.string))
 (local $is_negative/244 i32)
 (local $num/245 i32)
 (local $buffer/246 (ref $FixedArray<UInt16>))
 (local $digit_len/247 i32)
 (local $total_len/248 i32)
 (local $buffer/249 (ref $FixedArray<UInt16>))
 (local $digit_start/250 i32)
 (local $digit_len/251 i32)
 (local $total_len/252 i32)
 (local $buffer/253 (ref $FixedArray<UInt16>))
 (local $digit_start/254 i32)
 (local $digit_len/255 i32)
 (local $total_len/256 i32)
 (local $buffer/257 (ref $FixedArray<UInt16>))
 (local $digit_start/258 i32)
 (if
  (if (result i32)
   (i32.lt_s
    (local.get $radix/242)
    (i32.const 2))
   (then
    (i32.const 1))
   (else
    (i32.gt_s
     (local.get $radix/242)
     (i32.const 36))))
  (then
   (drop
    (call $moonbitlang/core/builtin.abort|Unit|
     (call $moonbit.string_literal
      (i32.const 6)
      (i32.const 384)
      (i32.const 30))
     (call $moonbit.string_literal
      (i32.const 5)
      (i32.const 280)
      (i32.const 52)))))
  (else))
 (if
  (i32.eq
   (local.get $self/243)
   (i32.const 0))
  (then
   (call $moonbit.string_literal
    (i32.const 4)
    (i32.const 278)
    (i32.const 1))
   (return))
  (else))
 (local.set $num/245
  (if (result i32)
   (local.tee $is_negative/244
    (i32.lt_s
     (local.get $self/243)
     (i32.const 0)))
   (then
    (i32.sub
     (i32.const 0)
     (local.get $self/243)))
   (else
    (local.get $self/243))))
 (local.set $buffer/246
  (if (result (ref $FixedArray<UInt16>))
   (i32.eq
    (local.get $radix/242)
    (i32.const 10))
   (then
    (local.set $total_len/248
     (i32.add
      (local.tee $digit_len/247
       (call $moonbitlang/core/builtin.dec_count32
        (local.get $num/245)))
      (if (result i32)
       (local.get $is_negative/244)
       (then
        (i32.const 1))
       (else
        (i32.const 0)))))
    (local.set $buffer/249
     (array.new $FixedArray<UInt16>
      (i32.const 0)
      (local.get $total_len/248)))
    (local.set $digit_start/250
     (if (result i32)
      (local.get $is_negative/244)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/249)
      (local.get $num/245)
      (local.get $digit_start/250)
      (local.get $total_len/248)))
    (local.get $buffer/249))
   (else
    (if (result (ref $FixedArray<UInt16>))
     (i32.eq
      (local.get $radix/242)
      (i32.const 16))
     (then
      (local.set $total_len/252
       (i32.add
        (local.tee $digit_len/251
         (call $moonbitlang/core/builtin.hex_count32
          (local.get $num/245)))
        (if (result i32)
         (local.get $is_negative/244)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/253
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/252)))
      (local.set $digit_start/254
       (if (result i32)
        (local.get $is_negative/244)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/253)
        (local.get $num/245)
        (local.get $digit_start/254)
        (local.get $total_len/252)))
      (local.get $buffer/253))
     (else
      (local.set $total_len/256
       (i32.add
        (local.tee $digit_len/255
         (call $moonbitlang/core/builtin.radix_count32
          (local.get $num/245)
          (local.get $radix/242)))
        (if (result i32)
         (local.get $is_negative/244)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/257
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/256)))
      (local.set $digit_start/258
       (if (result i32)
        (local.get $is_negative/244)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_generic
        (local.get $buffer/257)
        (local.get $num/245)
        (local.get $digit_start/258)
        (local.get $total_len/256)
        (local.get $radix/242)))
      (local.get $buffer/257))))))
 (if
  (local.get $is_negative/244)
  (then
   (array.set $FixedArray<UInt16>
    (local.get $buffer/246)
    (i32.const 0)
    (i32.const 45)))
  (else))
 (local.get $buffer/246))
(func $moonbitlang/core/builtin.radix_count32 (param $value/236 i32) (param $radix/239 i32) (result i32)
 (local $base/238 i32)
 (local $num/237 i32)
 (local $count/240 i32)
 (if
  (i32.eq
   (local.get $value/236)
   (i32.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.set $num/237
  (local.get $value/236))
 (local.set $base/238
  (local.get $radix/239))
 (local.set $count/240
  (i32.const 0))
 (loop $loop:241
  (if
   (i32.gt_u
    (local.get $num/237)
    (i32.const 0))
   (then
    (local.set $count/240
     (i32.add
      (local.get $count/240)
      (i32.const 1)))
    (local.set $num/237
     (i32.div_u
      (local.get $num/237)
      (local.get $base/238)))
    (br $loop:241))
   (else)))
 (local.get $count/240))
(func $moonbitlang/core/builtin.hex_count32 (param $value/234 i32) (result i32)
 (local $leading_zeros/235 i32)
 (if (result i32)
  (i32.eq
   (local.get $value/234)
   (i32.const 0))
  (then
   (i32.const 1))
  (else
   (local.set $leading_zeros/235
    (i32.clz
     (local.get $value/234)))
   (i32.add
    (i32.div_s
     (i32.sub
      (i32.const 31)
      (local.get $leading_zeros/235))
     (i32.const 4))
    (i32.const 1)))))
(func $moonbitlang/core/builtin.dec_count32 (param $value/233 i32) (result i32)
 (if (result i32)
  (i32.ge_u
   (local.get $value/233)
   (i32.const 100000))
  (then
   (if (result i32)
    (i32.ge_u
     (local.get $value/233)
     (i32.const 10000000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/233)
       (i32.const 1000000000))
      (then
       (i32.const 10))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/233)
         (i32.const 100000000))
        (then
         (i32.const 9))
        (else
         (i32.const 8))))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/233)
       (i32.const 1000000))
      (then
       (i32.const 7))
      (else
       (i32.const 6))))))
  (else
   (if (result i32)
    (i32.ge_u
     (local.get $value/233)
     (i32.const 1000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/233)
       (i32.const 10000))
      (then
       (i32.const 5))
      (else
       (i32.const 4))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/233)
       (i32.const 100))
      (then
       (i32.const 3))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/233)
         (i32.const 10))
        (then
         (i32.const 2))
        (else
         (i32.const 1))))))))))
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/223 (ref $FixedArray<UInt16>)) (param $num/211 i32) (param $digit_start/214 i32) (param $total_len/213 i32) (result i32)
 (local $t/215 i32)
 (local $r/216 i32)
 (local $d1/217 i32)
 (local $d2/218 i32)
 (local $d1_hi/219 i32)
 (local $d1_lo/220 i32)
 (local $d2_hi/221 i32)
 (local $d2_lo/222 i32)
 (local $t/226 i32)
 (local $d/227 i32)
 (local $d_hi/228 i32)
 (local $d_lo/229 i32)
 (local $d_hi/231 i32)
 (local $d_lo/232 i32)
 (local $num/210 i32)
 (local $offset/212 i32)
 (local $remaining/225 i32)
 (local.set $num/210
  (local.get $num/211))
 (local.set $offset/212
  (i32.sub
   (local.get $total_len/213)
   (local.get $digit_start/214)))
 (loop $loop:224
  (if
   (i32.ge_u
    (local.get $num/210)
    (i32.const 10000))
   (then
    (local.set $t/215
     (i32.div_u
      (local.get $num/210)
      (i32.const 10000)))
    (local.set $r/216
     (i32.rem_u
      (local.get $num/210)
      (i32.const 10000)))
    (local.set $num/210
     (local.get $t/215))
    (local.set $d1/217
     (i32.div_s
      (local.get $r/216)
      (i32.const 100)))
    (local.set $d2/218
     (i32.rem_s
      (local.get $r/216)
      (i32.const 100)))
    (local.set $offset/212
     (i32.sub
      (local.get $offset/212)
      (i32.const 4)))
    (local.set $d1_hi/219
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d1/217)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d1_lo/220
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d1/217)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_hi/221
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d2/218)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_lo/222
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d2/218)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/223)
     (i32.add
      (local.get $digit_start/214)
      (local.get $offset/212))
     (local.get $d1_hi/219))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/223)
     (i32.add
      (i32.add
       (local.get $digit_start/214)
       (local.get $offset/212))
      (i32.const 1))
     (local.get $d1_lo/220))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/223)
     (i32.add
      (i32.add
       (local.get $digit_start/214)
       (local.get $offset/212))
      (i32.const 2))
     (local.get $d2_hi/221))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/223)
     (i32.add
      (i32.add
       (local.get $digit_start/214)
       (local.get $offset/212))
      (i32.const 3))
     (local.get $d2_lo/222))
    (br $loop:224))
   (else)))
 (local.set $remaining/225
  (local.get $num/210))
 (loop $loop:230
  (if
   (i32.ge_s
    (local.get $remaining/225)
    (i32.const 100))
   (then
    (local.set $t/226
     (i32.div_s
      (local.get $remaining/225)
      (i32.const 100)))
    (local.set $d/227
     (i32.rem_s
      (local.get $remaining/225)
      (i32.const 100)))
    (local.set $remaining/225
     (local.get $t/226))
    (local.set $offset/212
     (i32.sub
      (local.get $offset/212)
      (i32.const 2)))
    (local.set $d_hi/228
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d/227)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d_lo/229
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d/227)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/223)
     (i32.add
      (local.get $digit_start/214)
      (local.get $offset/212))
     (local.get $d_hi/228))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/223)
     (i32.add
      (i32.add
       (local.get $digit_start/214)
       (local.get $offset/212))
      (i32.const 1))
     (local.get $d_lo/229))
    (br $loop:230))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.get $remaining/225)
   (i32.const 10))
  (then
   (local.set $offset/212
    (i32.sub
     (local.get $offset/212)
     (i32.const 2)))
   (local.set $d_hi/231
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.div_s
       (local.get $remaining/225)
       (i32.const 10)))
     (i32.const 65535)))
   (local.set $d_lo/232
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (local.get $remaining/225)
       (i32.const 10)))
     (i32.const 65535)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/223)
    (i32.add
     (local.get $digit_start/214)
     (local.get $offset/212))
    (local.get $d_hi/231))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/223)
    (i32.add
     (i32.add
      (local.get $digit_start/214)
      (local.get $offset/212))
     (i32.const 1))
    (local.get $d_lo/232))
   (i32.const 0))
  (else
   (local.set $offset/212
    (i32.sub
     (local.get $offset/212)
     (i32.const 1)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/223)
    (i32.add
     (local.get $digit_start/214)
     (local.get $offset/212))
    (i32.and
     (i32.add
      (i32.const 48)
      (local.get $remaining/225))
     (i32.const 65535)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/205 (ref $FixedArray<UInt16>)) (param $num/199 i32) (param $digit_start/197 i32) (param $total_len/196 i32) (param $radix/201 i32) (result i32)
 (local $base/200 i32)
 (local $shift/202 i32)
 (local $mask/203 i32)
 (local $digit/204 i32)
 (local $q/207 i32)
 (local $digit/208 i32)
 (local $offset/195 i32)
 (local $n/198 i32)
 (local.set $offset/195
  (i32.sub
   (local.get $total_len/196)
   (local.get $digit_start/197)))
 (local.set $n/198
  (local.get $num/199))
 (local.set $base/200
  (local.get $radix/201))
 (if (result i32)
  (i32.eq
   (i32.and
    (local.get $radix/201)
    (i32.sub
     (local.get $radix/201)
     (i32.const 1)))
   (i32.const 0))
  (then
   (local.set $shift/202
    (i32.ctz
     (local.get $radix/201)))
   (local.set $mask/203
    (i32.sub
     (local.get $base/200)
     (i32.const 1)))
   (loop $loop:206
    (if
     (i32.gt_u
      (local.get $n/198)
      (i32.const 0))
     (then
      (local.set $offset/195
       (i32.sub
        (local.get $offset/195)
        (i32.const 1)))
      (local.set $digit/204
       (i32.and
        (local.get $n/198)
        (local.get $mask/203)))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/205)
       (i32.add
        (local.get $digit_start/197)
        (local.get $offset/195))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 7)
          (i32.const 444)
          (i32.const 36))
         (local.get $digit/204))
        (i32.const 65535)))
      (local.set $n/198
       (i32.shr_u
        (local.get $n/198)
        (local.get $shift/202)))
      (br $loop:206))
     (else)))
   (i32.const 0))
  (else
   (loop $loop:209
    (if
     (i32.gt_u
      (local.get $n/198)
      (i32.const 0))
     (then
      (local.set $offset/195
       (i32.sub
        (local.get $offset/195)
        (i32.const 1)))
      (local.set $q/207
       (i32.div_u
        (local.get $n/198)
        (local.get $base/200)))
      (local.set $digit/208
       (i32.sub
        (local.get $n/198)
        (i32.mul
         (local.get $q/207)
         (local.get $base/200))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/205)
       (i32.add
        (local.get $digit_start/197)
        (local.get $offset/195))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 7)
          (i32.const 444)
          (i32.const 36))
         (local.get $digit/208))
        (i32.const 65535)))
      (local.set $n/198
       (local.get $q/207))
      (br $loop:209))
     (else)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/192 (ref $FixedArray<UInt16>)) (param $num/188 i32) (param $digit_start/186 i32) (param $total_len/185 i32) (result i32)
 (local $byte_val/189 i32)
 (local $hi/190 i32)
 (local $lo/191 i32)
 (local $nibble/194 i32)
 (local $offset/184 i32)
 (local $n/187 i32)
 (local.set $offset/184
  (i32.sub
   (local.get $total_len/185)
   (local.get $digit_start/186)))
 (local.set $n/187
  (local.get $num/188))
 (loop $loop:193
  (if
   (i32.ge_s
    (local.get $offset/184)
    (i32.const 2))
   (then
    (local.set $offset/184
     (i32.sub
      (local.get $offset/184)
      (i32.const 2)))
    (local.set $hi/190
     (i32.div_s
      (local.tee $byte_val/189
       (i32.and
        (local.get $n/187)
        (i32.const 255)))
      (i32.const 16)))
    (local.set $lo/191
     (i32.rem_s
      (local.get $byte_val/189)
      (i32.const 16)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/192)
     (i32.add
      (local.get $digit_start/186)
      (local.get $offset/184))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 7)
        (i32.const 444)
        (i32.const 36))
       (local.get $hi/190))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/192)
     (i32.add
      (i32.add
       (local.get $digit_start/186)
       (local.get $offset/184))
      (i32.const 1))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 7)
        (i32.const 444)
        (i32.const 36))
       (local.get $lo/191))
      (i32.const 65535)))
    (local.set $n/187
     (i32.shr_u
      (local.get $n/187)
      (i32.const 8)))
    (br $loop:193))
   (else)))
 (if (result i32)
  (i32.eq
   (local.get $offset/184)
   (i32.const 1))
  (then
   (local.set $nibble/194
    (i32.and
     (local.get $n/187)
     (i32.const 15)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/192)
    (local.get $digit_start/186)
    (i32.and
     (array.get_u $moonbit.string
      (call $moonbit.string_literal
       (i32.const 7)
       (i32.const 444)
       (i32.const 36))
      (local.get $nibble/194))
     (i32.const 65535)))
   (i32.const 0))
  (else
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/183 (ref $moonbit.string)) (result (ref $moonbit.string))
 (local $logger/182 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/182
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/183)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/182))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/182)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/181 i32) (result (ref $moonbit.string))
 (local $logger/180 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/180
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/181)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/180))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/180)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/172 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $value/175 (ref $moonbit.string)) (param $start/176 i32) (param $len/177 i32) (result i32)
 (local $*try_err/174 (ref $moonbit.enum))
 (local $*bind/482 (ref $moonbit.enum))
 (local $tag/486 i32)
 (local.get $self/172)
 (block $outer/485 (result (ref $StringView))
  (block $join:173 (result (ref $moonbit.enum))
   (if (result (ref $StringView))
    (i32.eq
     (local.tee $tag/486
      (struct.get $moonbit.enum 0
       (local.tee $*bind/482
        (call $String::sub.inner
         (local.get $value/175)
         (local.get $start/176)
         (i64.extend_i32_s
          (i32.add
           (local.get $start/176)
           (local.get $len/177)))))))
     (i32.const 1))
    (then
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
       (local.get $*bind/482))))
    (else
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
       (local.get $*bind/482)))
     (br $join:173)))
   (br $outer/485))
  (local.set $*try_err/174)
  (unreachable))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view))
(func $String::sub.inner (param $self/165 (ref $moonbit.string)) (param $start/171 i32) (param $end/167 i64) (result (ref $moonbit.enum))
 (local $len/164 i32)
 (local $end/166 i32)
 (local $*Some/168 i64)
 (local $*end/169 i32)
 (local $start/170 i32)
 (local $*p/431 i32)
 (local $*p/434 i32)
 (local.set $len/164
  (array.len
   (local.get $self/165)))
 (local.set $end/166
  (if (result i32)
   (i64.eq
    (local.get $end/167)
    (i64.const 4294967296))
   (then
    (local.get $len/164))
   (else
    (if (result i32)
     (i32.lt_s
      (local.tee $*end/169
       (i32.wrap_i64
        (local.tee $*Some/168
         (local.get $end/167))))
      (i32.const 0))
     (then
      (i32.add
       (local.get $len/164)
       (local.get $*end/169)))
     (else
      (local.get $*end/169))))))
 (if (result (ref $moonbit.enum))
  (if (result i32)
   (i32.ge_s
    (local.tee $start/170
     (if (result i32)
      (i32.lt_s
       (local.get $start/171)
       (i32.const 0))
      (then
       (i32.add
        (local.get $len/164)
        (local.get $start/171)))
      (else
       (local.get $start/171))))
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start/170)
      (local.get $end/166))
     (then
      (i32.le_s
       (local.get $end/166)
       (local.get $len/164)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $start/170)
      (local.get $len/164))
     (then
      (local.set $*p/431
       (array.get_u $moonbit.string
        (local.get $self/165)
        (local.get $start/170)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/431))
       (then
        (i32.le_s
         (local.get $*p/431)
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
      (local.get $end/166)
      (local.get $len/164))
     (then
      (local.set $*p/434
       (array.get_u $moonbit.string
        (local.get $self/165)
        (local.get $end/166)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/434))
       (then
        (i32.le_s
         (local.get $*p/434)
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
     (local.get $self/165)
     (local.get $start/170)
     (local.get $end/166))))
  (else
   (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
    (i32.const 0)
    (global.get $moonbit.constr/1)))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/162 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/163 (ref $moonbit.string)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/162)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/162))
    (i32.mul
     (array.len
      (local.get $str/163))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/162))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/162))
   (local.get $str/163)
   (i32.const 0)
   (array.len
    (local.get $str/163))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/162)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/162))
   (i32.mul
    (array.len
     (local.get $str/163))
    (i32.const 2))))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/154 (ref $moonbit.bytes)) (param $bytes_offset/149 i32) (param $str/156 (ref $moonbit.string)) (param $str_offset/152 i32) (param $length/150 i32) (result i32)
 (local $e1/148 i32)
 (local $e2/151 i32)
 (local $len1/153 i32)
 (local $len2/155 i32)
 (local $end_str_offset/157 i32)
 (local $i/158 i32)
 (local $j/159 i32)
 (local $c/160 i32)
 (local $*p/425 i32)
 (local $*p/428 i32)
 (local.set $e1/148
  (i32.sub
   (i32.add
    (local.get $bytes_offset/149)
    (i32.mul
     (local.get $length/150)
     (i32.const 2)))
   (i32.const 1)))
 (local.set $e2/151
  (i32.sub
   (i32.add
    (local.get $str_offset/152)
    (local.get $length/150))
   (i32.const 1)))
 (local.set $len1/153
  (array.len
   (local.get $self/154)))
 (local.set $len2/155
  (array.len
   (local.get $str/156)))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $length/150)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $bytes_offset/149)
      (i32.const 0))
     (then
      (if (result i32)
       (i32.lt_s
        (local.get $e1/148)
        (local.get $len1/153))
       (then
        (if (result i32)
         (i32.ge_s
          (local.get $str_offset/152)
          (i32.const 0))
         (then
          (i32.lt_s
           (local.get $e2/151)
           (local.get $len2/155)))
         (else
          (i32.const 0))))
       (else
        (i32.const 0))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $end_str_offset/157
    (i32.add
     (local.get $str_offset/152)
     (local.get $length/150)))
   (local.get $str_offset/152)
   (local.get $bytes_offset/149)
   (loop $loop:161 (param i32) (param i32)
    (local.set $j/159)
    (local.tee $i/158)
    (local.get $end_str_offset/157)
    (i32.lt_s)
    (if
     (then
      (local.set $c/160
       (array.get_u $moonbit.string
        (local.get $str/156)
        (local.get $i/158)))
      (array.set $moonbit.bytes
       (local.get $self/154)
       (local.get $j/159)
       (i32.and
        (local.tee $*p/425
         (i32.and
          (local.get $c/160)
          (i32.const 255)))
        (i32.const 255)))
      (array.set $moonbit.bytes
       (local.get $self/154)
       (i32.add
        (local.get $j/159)
        (i32.const 1))
       (i32.and
        (local.tee $*p/428
         (i32.shr_u
          (local.get $c/160)
          (i32.const 8)))
        (i32.const 255)))
      (i32.add
       (local.get $i/158)
       (i32.const 1))
      (i32.add
       (local.get $j/159)
       (i32.const 2))
      (br $loop:161))
     (else)))
   (i32.const 0))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/116 (ref $moonbit.string)) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
 (local $*x/117 i32)
 (local $*x/118 (ref $StringView))
 (local $*Some/119 i64)
 (local $*bind/120 i64)
 (local $*Some/121 i64)
 (local $*pkg_end/122 i32)
 (local $pkg/123 (ref $StringView))
 (local $*bind/124 i64)
 (local $*Some/125 i64)
 (local $*start_loc_end/126 i32)
 (local $end_loc/127 (ref $StringView))
 (local $*bind/128 (ref null $<StringView*StringView>))
 (local $*Some/129 (ref null $<StringView*StringView>))
 (local $*x/130 (ref $<StringView*StringView>))
 (local $*end_line/131 (ref $StringView))
 (local $*end_column/132 (ref $StringView))
 (local $rest/133 (ref $StringView))
 (local $*bind/135 i64)
 (local $*Some/136 i64)
 (local $*start_line_end/137 i32)
 (local $*bind/138 i64)
 (local $*Some/139 i64)
 (local $*filename_end/140 i32)
 (local $start_loc/141 (ref $StringView))
 (local $*bind/142 (ref null $<StringView*StringView>))
 (local $*Some/143 (ref null $<StringView*StringView>))
 (local $*x/144 (ref $<StringView*StringView>))
 (local $*start_line/145 (ref $StringView))
 (local $*start_column/146 (ref $StringView))
 (local $filename/147 (ref $StringView))
 (local $*bind/323 i64)
 (block $join:115
  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
   (call $String::char_length_ge.inner
    (local.get $repr/116)
    (i32.const 1)
    (i32.const 0)
    (i64.extend_i32_s
     (array.len
      (local.get $repr/116))))
   (then
    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
     (i32.eq
      (local.tee $*x/117
       (array.get_u $moonbit.string
        (local.get $repr/116)
        (i32.const 0)))
      (i32.const 64))
     (then
      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
       (i64.eq
        (local.tee $*bind/120
         (call $StringView::find
          (local.tee $*x/118
           (struct.new $StringView
            (local.get $repr/116)
            (if (result i32)
             (i64.eq
              (local.tee $*bind/323
               (call $String::offset_of_nth_char.inner
                (local.get $repr/116)
                (i32.const 1)
                (i32.const 0)
                (i64.extend_i32_s
                 (array.len
                  (local.get $repr/116)))))
              (i64.const 4294967296))
             (then
              (array.len
               (local.get $repr/116)))
             (else
              (i32.wrap_i64
               (local.tee $*Some/119
                (local.get $*bind/323)))))
            (array.len
             (local.get $repr/116))))
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
        (local.set $*pkg_end/122
         (i32.wrap_i64
          (local.tee $*Some/121
           (local.get $*bind/120))))
        (local.set $pkg/123
         (call $StringView::view.inner
          (local.get $*x/118)
          (i32.const 0)
          (i64.extend_i32_s
           (local.get $*pkg_end/122))))
        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
         (i64.eq
          (local.tee $*bind/124
           (call $StringView::rev_find
            (local.get $*x/118)
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
             (local.tee $*start_loc_end/126
              (i32.wrap_i64
               (local.tee $*Some/125
                (local.get $*bind/124))))
             (i32.const 1))
            (i32.sub
             (struct.get $StringView 2
              (local.get $*x/118))
             (struct.get $StringView 1
              (local.get $*x/118))))
           (then
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (ref.is_null
              (local.tee $*bind/128
               (call $moonbitlang/core/builtin.parse.parse_loc|1101
                (local.tee $end_loc/127
                 (call $StringView::view.inner
                  (local.get $*x/118)
                  (i32.add
                   (local.get $*start_loc_end/126)
                   (i32.const 1))
                  (i64.const 4294967296))))))
             (then
              (unreachable))
             (else
              (local.set $*end_line/131
               (struct.get $<StringView*StringView> 0
                (local.tee $*x/130
                 (ref.as_non_null
                  (local.tee $*Some/129
                   (local.get $*bind/128))))))
              (local.set $*end_column/132
               (struct.get $<StringView*StringView> 1
                (local.get $*x/130)))
              (local.set $rest/133
               (call $StringView::view.inner
                (local.get $*x/118)
                (i32.const 0)
                (i64.extend_i32_s
                 (local.get $*start_loc_end/126))))
              (block $join:134
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i64.eq
                 (local.tee $*bind/135
                  (call $StringView::rev_find
                   (local.get $rest/133)
                   (struct.new $StringView
                    (ref.as_non_null
                     (global.get $moonbitlang/core/builtin.parse.*bind|5421))
                    (i32.const 0)
                    (array.len
                     (ref.as_non_null
                      (global.get $moonbitlang/core/builtin.parse.*bind|5421))))))
                 (i64.const 4294967296))
                (then
                 (br $join:134))
                (else
                 (local.set $*start_line_end/137
                  (i32.wrap_i64
                   (local.tee $*Some/136
                    (local.get $*bind/135))))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i64.eq
                   (local.tee $*bind/138
                    (call $StringView::rev_find
                     (call $StringView::view.inner
                      (local.get $rest/133)
                      (i32.const 0)
                      (i64.extend_i32_s
                       (local.get $*start_line_end/137)))
                     (struct.new $StringView
                      (ref.as_non_null
                       (global.get $moonbitlang/core/builtin.parse.*bind|5415))
                      (i32.const 0)
                      (array.len
                       (ref.as_non_null
                        (global.get $moonbitlang/core/builtin.parse.*bind|5415))))))
                   (i64.const 4294967296))
                  (then
                   (br $join:134))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (i32.add
                      (local.tee $*filename_end/140
                       (i32.wrap_i64
                        (local.tee $*Some/139
                         (local.get $*bind/138))))
                      (i32.const 1))
                     (i32.sub
                      (struct.get $StringView 2
                       (local.get $rest/133))
                      (struct.get $StringView 1
                       (local.get $rest/133))))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (ref.is_null
                       (local.tee $*bind/142
                        (call $moonbitlang/core/builtin.parse.parse_loc|1101
                         (local.tee $start_loc/141
                          (call $StringView::view.inner
                           (local.get $rest/133)
                           (i32.add
                            (local.get $*filename_end/140)
                            (i32.const 1))
                           (i64.const 4294967296))))))
                      (then
                       (unreachable))
                      (else
                       (local.set $*start_line/145
                        (struct.get $<StringView*StringView> 0
                         (local.tee $*x/144
                          (ref.as_non_null
                           (local.tee $*Some/143
                            (local.get $*bind/142))))))
                       (local.set $*start_column/146
                        (struct.get $<StringView*StringView> 1
                         (local.get $*x/144)))
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $*filename_end/140)
                         (i32.add
                          (local.get $*pkg_end/122)
                          (i32.const 1)))
                        (then
                         (local.set $filename/147
                          (call $StringView::view.inner
                           (local.get $rest/133)
                           (i32.add
                            (local.get $*pkg_end/122)
                            (i32.const 1))
                           (i64.extend_i32_s
                            (local.get $*filename_end/140))))
                         (struct.new $@moonbitlang/core/builtin.SourceLocRepr
                          (local.get $pkg/123)
                          (local.get $filename/147)
                          (local.get $*start_line/145)
                          (local.get $*start_column/146)
                          (local.get $*end_line/131)
                          (local.get $*end_column/132)))
                        (else
                         (unreachable))))))
                    (else
                     (unreachable)))))))
               (return))
              (unreachable))))
           (else
            (unreachable))))))))
     (else
      (br $join:115))))
   (else
    (br $join:115)))
  (return))
 (unreachable))
(func $moonbitlang/core/builtin.parse.parse_loc|1101 (param $view/112 (ref $StringView)) (result (ref null $<StringView*StringView>))
 (local $*bind/111 i64)
 (local $*Some/113 i64)
 (local $*i/114 i32)
 (if (result (ref null $<StringView*StringView>))
  (i64.eq
   (local.tee $*bind/111
    (call $StringView::find
     (local.get $view/112)
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
      (local.tee $*i/114
       (i32.wrap_i64
        (local.tee $*Some/113
         (local.get $*bind/111))))
      (i32.const 0))
     (then
      (i32.lt_s
       (i32.add
        (local.get $*i/114)
        (i32.const 1))
       (i32.sub
        (struct.get $StringView 2
         (local.get $view/112))
        (struct.get $StringView 1
         (local.get $view/112)))))
     (else
      (i32.const 0)))
    (then
     (struct.new $<StringView*StringView>
      (call $StringView::view.inner
       (local.get $view/112)
       (i32.const 0)
       (i64.extend_i32_s
        (local.get $*i/114)))
      (call $StringView::view.inner
       (local.get $view/112)
       (i32.add
        (local.get $*i/114)
        (i32.const 1))
       (i64.const 4294967296))))
    (else
     (ref.null none))))))
(func $StringView::view.inner (param $self/109 (ref $StringView)) (param $start_offset/110 i32) (param $end_offset/107 i64) (result (ref $StringView))
 (local $end_offset/106 i32)
 (local $*Some/108 i64)
 (local.set $end_offset/106
  (if (result i32)
   (i64.eq
    (local.get $end_offset/107)
    (i64.const 4294967296))
   (then
    (i32.sub
     (struct.get $StringView 2
      (local.get $self/109))
     (struct.get $StringView 1
      (local.get $self/109))))
   (else
    (i32.wrap_i64
     (local.tee $*Some/108
      (local.get $end_offset/107))))))
 (if (result (ref $StringView))
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/110)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start_offset/110)
      (local.get $end_offset/106))
     (then
      (i32.le_s
       (local.get $end_offset/106)
       (i32.sub
        (struct.get $StringView 2
         (local.get $self/109))
        (struct.get $StringView 1
         (local.get $self/109)))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (struct.new $StringView
    (struct.get $StringView 0
     (local.get $self/109))
    (i32.add
     (struct.get $StringView 1
      (local.get $self/109))
     (local.get $start_offset/110))
    (i32.add
     (struct.get $StringView 1
      (local.get $self/109))
     (local.get $end_offset/106))))
  (else
   (call $moonbitlang/core/builtin.abort|StringView|
    (call $moonbit.string_literal
     (i32.const 9)
     (i32.const 622)
     (i32.const 22))
    (call $moonbit.string_literal
     (i32.const 8)
     (i32.const 516)
     (i32.const 53))))))
(func $StringView::rev_find (param $self/105 (ref $StringView)) (param $str/104 (ref $StringView)) (result i64)
 (if (result i64)
  (i32.le_s
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/104))
    (struct.get $StringView 1
     (local.get $str/104)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_rev_find
    (local.get $self/105)
    (local.get $str/104)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_rev_find
    (local.get $self/105)
    (local.get $str/104)))))
(func $moonbitlang/core/builtin.brute_force_rev_find (param $haystack/95 (ref $StringView)) (param $needle/97 (ref $StringView)) (result i64)
 (local $haystack_len/94 i32)
 (local $needle_len/96 i32)
 (local $needle_first/98 i32)
 (local $j/101 i32)
 (local $*p/402 i32)
 (local $*p/405 i32)
 (local $*p/408 i32)
 (local $i/99 i32)
 (local.set $haystack_len/94
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/95))
   (struct.get $StringView 1
    (local.get $haystack/95))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/96
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/97))
     (struct.get $StringView 1
      (local.get $needle/97))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/94)
     (local.get $needle_len/96))
    (then
     (local.set $*p/402
      (i32.const 0))
     (local.set $needle_first/98
      (array.get_u $moonbit.string
       (struct.get $StringView 0
        (local.get $needle/97))
       (i32.add
        (struct.get $StringView 1
         (local.get $needle/97))
        (local.get $*p/402))))
     (local.set $i/99
      (i32.sub
       (local.get $haystack_len/94)
       (local.get $needle_len/96)))
     (loop $loop:103
      (if
       (i32.ge_s
        (local.get $i/99)
        (i32.const 0))
       (then
        (loop $loop:100
         (if
          (if (result i32)
           (i32.ge_s
            (local.get $i/99)
            (i32.const 0))
           (then
            (local.set $*p/405
             (local.get $i/99))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/95))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/95))
              (local.get $*p/405)))
            (i32.ne
             (local.get $needle_first/98)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/99
            (i32.sub
             (local.get $i/99)
             (i32.const 1)))
           (br $loop:100))
          (else)))
        (if
         (i32.ge_s
          (local.get $i/99)
          (i32.const 0))
         (then
          (block $break:102
           (i32.const 1)
           (loop $loop:102 (param i32)
            (local.tee $j/101)
            (local.get $needle_len/96)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/408
               (i32.add
                (local.get $i/99)
                (local.get $j/101)))
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $haystack/95))
               (i32.add
                (struct.get $StringView 1
                 (local.get $haystack/95))
                (local.get $*p/408)))
              (if
               (i32.ne
                (array.get_u $moonbit.string
                 (struct.get $StringView 0
                  (local.get $needle/97))
                 (i32.add
                  (struct.get $StringView 1
                   (local.get $needle/97))
                  (local.get $j/101))))
               (then
                (br $break:102))
               (else))
              (i32.add
               (local.get $j/101)
               (i32.const 1))
              (br $loop:102))
             (else
              (i64.extend_i32_s
               (local.get $i/99))
              (return)))))
          (local.set $i/99
           (i32.sub
            (local.get $i/99)
            (i32.const 1))))
         (else))
        (br $loop:103))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (i64.extend_i32_s
    (local.get $haystack_len/94)))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_rev_find (param $haystack/84 (ref $StringView)) (param $needle/86 (ref $StringView)) (result i64)
 (local $haystack_len/83 i32)
 (local $needle_len/85 i32)
 (local $skip_table/87 (ref $moonbit.array_i32))
 (local $i/88 i32)
 (local $i/90 i32)
 (local $j/91 i32)
 (local $*p/391 i32)
 (local.set $haystack_len/83
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/84))
   (struct.get $StringView 1
    (local.get $haystack/84))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/85
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/86))
     (struct.get $StringView 1
      (local.get $needle/86))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/83)
     (local.get $needle_len/85))
    (then
     (local.set $skip_table/87
      (array.new $moonbit.array_i32
       (local.get $needle_len/85)
       (i32.const 256)))
     (i32.sub
      (local.get $needle_len/85)
      (i32.const 1))
     (loop $loop:89 (param i32)
      (local.tee $i/88)
      (i32.const 0)
      (i32.gt_s)
      (if
       (then
        (array.set $moonbit.array_i32
         (local.get $skip_table/87)
         (i32.and
          (array.get_u $moonbit.string
           (struct.get $StringView 0
            (local.get $needle/86))
           (i32.add
            (struct.get $StringView 1
             (local.get $needle/86))
            (local.get $i/88)))
          (i32.const 255))
         (local.get $i/88))
        (i32.sub
         (local.get $i/88)
         (i32.const 1))
        (br $loop:89))
       (else)))
     (i32.sub
      (local.get $haystack_len/83)
      (local.get $needle_len/85))
     (loop $loop:93 (param i32)
      (local.tee $i/90)
      (i32.const 0)
      (i32.ge_s)
      (if
       (then
        (block $break:92
         (i32.const 0)
         (loop $loop:92 (param i32)
          (local.tee $j/91)
          (local.get $needle_len/85)
          (i32.lt_s)
          (if
           (then
            (local.set $*p/391
             (i32.add
              (local.get $i/90)
              (local.get $j/91)))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/84))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/84))
              (local.get $*p/391)))
            (if
             (i32.ne
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $needle/86))
               (i32.add
                (struct.get $StringView 1
                 (local.get $needle/86))
                (local.get $j/91))))
             (then
              (br $break:92))
             (else))
            (i32.add
             (local.get $j/91)
             (i32.const 1))
            (br $loop:92))
           (else
            (i64.extend_i32_s
             (local.get $i/90))
            (return)))))
        (i32.sub
         (local.get $i/90)
         (array.get $moonbit.array_i32
          (local.get $skip_table/87)
          (i32.and
           (array.get_u $moonbit.string
            (struct.get $StringView 0
             (local.get $haystack/84))
            (i32.add
             (struct.get $StringView 1
              (local.get $haystack/84))
             (local.get $i/90)))
           (i32.const 255))))
        (br $loop:93))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (i64.extend_i32_s
    (local.get $haystack_len/83)))))
(func $StringView::find (param $self/82 (ref $StringView)) (param $str/81 (ref $StringView)) (result i64)
 (if (result i64)
  (i32.le_s
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/81))
    (struct.get $StringView 1
     (local.get $str/81)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_find
    (local.get $self/82)
    (local.get $str/81)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_find
    (local.get $self/82)
    (local.get $str/81)))))
(func $moonbitlang/core/builtin.brute_force_find (param $haystack/71 (ref $StringView)) (param $needle/73 (ref $StringView)) (result i64)
 (local $haystack_len/70 i32)
 (local $needle_len/72 i32)
 (local $needle_first/74 i32)
 (local $forward_len/75 i32)
 (local $j/78 i32)
 (local $*p/372 i32)
 (local $*p/375 i32)
 (local $*p/378 i32)
 (local $i/76 i32)
 (local.set $haystack_len/70
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/71))
   (struct.get $StringView 1
    (local.get $haystack/71))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/72
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/73))
     (struct.get $StringView 1
      (local.get $needle/73))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/70)
     (local.get $needle_len/72))
    (then
     (local.set $*p/372
      (i32.const 0))
     (local.set $needle_first/74
      (array.get_u $moonbit.string
       (struct.get $StringView 0
        (local.get $needle/73))
       (i32.add
        (struct.get $StringView 1
         (local.get $needle/73))
        (local.get $*p/372))))
     (local.set $forward_len/75
      (i32.sub
       (local.get $haystack_len/70)
       (local.get $needle_len/72)))
     (local.set $i/76
      (i32.const 0))
     (loop $loop:80
      (if
       (i32.le_s
        (local.get $i/76)
        (local.get $forward_len/75))
       (then
        (loop $loop:77
         (if
          (if (result i32)
           (i32.le_s
            (local.get $i/76)
            (local.get $forward_len/75))
           (then
            (local.set $*p/375
             (local.get $i/76))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/71))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/71))
              (local.get $*p/375)))
            (i32.ne
             (local.get $needle_first/74)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/76
            (i32.add
             (local.get $i/76)
             (i32.const 1)))
           (br $loop:77))
          (else)))
        (if
         (i32.le_s
          (local.get $i/76)
          (local.get $forward_len/75))
         (then
          (block $break:79
           (i32.const 1)
           (loop $loop:79 (param i32)
            (local.tee $j/78)
            (local.get $needle_len/72)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/378
               (i32.add
                (local.get $i/76)
                (local.get $j/78)))
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $haystack/71))
               (i32.add
                (struct.get $StringView 1
                 (local.get $haystack/71))
                (local.get $*p/378)))
              (if
               (i32.ne
                (array.get_u $moonbit.string
                 (struct.get $StringView 0
                  (local.get $needle/73))
                 (i32.add
                  (struct.get $StringView 1
                   (local.get $needle/73))
                  (local.get $j/78))))
               (then
                (br $break:79))
               (else))
              (i32.add
               (local.get $j/78)
               (i32.const 1))
              (br $loop:79))
             (else
              (i64.extend_i32_s
               (local.get $i/76))
              (return)))))
          (local.set $i/76
           (i32.add
            (local.get $i/76)
            (i32.const 1))))
         (else))
        (br $loop:80))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (global.get $moonbitlang/core/builtin.brute_force_find.constr/69))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_find (param $haystack/57 (ref $StringView)) (param $needle/59 (ref $StringView)) (result i64)
 (local $haystack_len/56 i32)
 (local $needle_len/58 i32)
 (local $skip_table/60 (ref $moonbit.array_i32))
 (local $*end4298/61 i32)
 (local $i/62 i32)
 (local $i/64 i32)
 (local $*end4304/65 i32)
 (local $j/66 i32)
 (local $*p/360 i32)
 (local $*p/365 i32)
 (local.set $haystack_len/56
  (i32.sub
   (struct.get $StringView 2
    (local.get $haystack/57))
   (struct.get $StringView 1
    (local.get $haystack/57))))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/58
    (i32.sub
     (struct.get $StringView 2
      (local.get $needle/59))
     (struct.get $StringView 1
      (local.get $needle/59))))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/56)
     (local.get $needle_len/58))
    (then
     (local.set $skip_table/60
      (array.new $moonbit.array_i32
       (local.get $needle_len/58)
       (i32.const 256)))
     (local.set $*end4298/61
      (i32.sub
       (local.get $needle_len/58)
       (i32.const 1)))
     (i32.const 0)
     (loop $loop:63 (param i32)
      (local.tee $i/62)
      (local.get $*end4298/61)
      (i32.lt_s)
      (if
       (then
        (array.set $moonbit.array_i32
         (local.get $skip_table/60)
         (i32.and
          (array.get_u $moonbit.string
           (struct.get $StringView 0
            (local.get $needle/59))
           (i32.add
            (struct.get $StringView 1
             (local.get $needle/59))
            (local.get $i/62)))
          (i32.const 255))
         (i32.sub
          (i32.sub
           (local.get $needle_len/58)
           (i32.const 1))
          (local.get $i/62)))
        (i32.add
         (local.get $i/62)
         (i32.const 1))
        (br $loop:63))
       (else)))
     (i32.const 0)
     (loop $loop:68 (param i32)
      (local.tee $i/64)
      (i32.sub
       (local.get $haystack_len/56)
       (local.get $needle_len/58))
      (i32.le_s)
      (if
       (then
        (local.set $*end4304/65
         (i32.sub
          (local.get $needle_len/58)
          (i32.const 1)))
        (block $break:67
         (i32.const 0)
         (loop $loop:67 (param i32)
          (local.tee $j/66)
          (local.get $*end4304/65)
          (i32.le_s)
          (if
           (then
            (local.set $*p/360
             (i32.add
              (local.get $i/64)
              (local.get $j/66)))
            (array.get_u $moonbit.string
             (struct.get $StringView 0
              (local.get $haystack/57))
             (i32.add
              (struct.get $StringView 1
               (local.get $haystack/57))
              (local.get $*p/360)))
            (if
             (i32.ne
              (array.get_u $moonbit.string
               (struct.get $StringView 0
                (local.get $needle/59))
               (i32.add
                (struct.get $StringView 1
                 (local.get $needle/59))
                (local.get $j/66))))
             (then
              (br $break:67))
             (else))
            (i32.add
             (local.get $j/66)
             (i32.const 1))
            (br $loop:67))
           (else
            (i64.extend_i32_s
             (local.get $i/64))
            (return)))))
        (local.get $i/64)
        (local.get $skip_table/60)
        (local.set $*p/365
         (i32.sub
          (i32.add
           (local.get $i/64)
           (local.get $needle_len/58))
          (i32.const 1)))
        (i32.and
         (array.get_u $moonbit.string
          (struct.get $StringView 0
           (local.get $haystack/57))
          (i32.add
           (struct.get $StringView 1
            (local.get $haystack/57))
           (local.get $*p/365)))
         (i32.const 255))
        (array.get $moonbit.array_i32)
        (i32.add)
        (br $loop:68))
       (else)))
     (i64.const 4294967296))
    (else
     (i64.const 4294967296))))
  (else
   (global.get $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/47 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $ch/49 i32) (result i32)
 (local $inc/48 i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/47)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/47))
    (i32.const 4))))
 (local.set $inc/48
  (call $FixedArray::set_utf16le_char
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/47))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/47))
   (local.get $ch/49)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/47)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/47))
   (local.get $inc/48)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/42 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $required/43 i32) (result i32)
 (local $current_len/41 i32)
 (local $new_data/46 (ref $moonbit.bytes))
 (local $enough_space/44 i32)
 (local.set $current_len/41
  (array.len
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/42))))
 (if
  (i32.le_s
   (local.get $required/43)
   (local.get $current_len/41))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/44
  (local.get $current_len/41))
 (loop $loop:45
  (if
   (i32.lt_s
    (local.get $enough_space/44)
    (local.get $required/43))
   (then
    (local.set $enough_space/44
     (i32.mul
      (local.get $enough_space/44)
      (i32.const 2)))
    (br $loop:45))
   (else)))
 (array.copy $moonbit.bytes $moonbit.bytes
  (local.tee $new_data/46
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $enough_space/44)))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/42))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 1
   (local.get $self/42)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 0
  (local.get $self/42)
  (local.get $new_data/46))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/36 (ref $moonbit.bytes)) (param $offset/37 i32) (param $value/35 i32) (result i32)
 (local $code/34 i32)
 (local $hi/38 i32)
 (local $lo/39 i32)
 (local $hi/40 i32)
 (local $*p/334 i32)
 (local $*p/337 i32)
 (local $*p/340 i32)
 (local $*p/343 i32)
 (local $*p/346 i32)
 (local $*p/349 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/34
    (local.get $value/35))
   (i32.const 65536))
  (then
   (array.set $moonbit.bytes
    (local.get $self/36)
    (local.get $offset/37)
    (i32.and
     (local.tee $*p/334
      (i32.and
       (local.get $code/34)
       (i32.const 255)))
     (i32.const 255)))
   (array.set $moonbit.bytes
    (local.get $self/36)
    (i32.add
     (local.get $offset/37)
     (i32.const 1))
    (i32.and
     (local.tee $*p/337
      (i32.shr_u
       (local.get $code/34)
       (i32.const 8)))
     (i32.const 255)))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/34)
     (i32.const 1114112))
    (then
     (local.set $lo/39
      (i32.or
       (i32.shr_u
        (local.tee $hi/38
         (i32.sub
          (local.get $code/34)
          (i32.const 65536)))
        (i32.const 10))
       (i32.const 55296)))
     (local.set $hi/40
      (i32.or
       (i32.and
        (local.get $hi/38)
        (i32.const 1023))
       (i32.const 56320)))
     (array.set $moonbit.bytes
      (local.get $self/36)
      (local.get $offset/37)
      (i32.and
       (local.tee $*p/340
        (i32.and
         (local.get $lo/39)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/36)
      (i32.add
       (local.get $offset/37)
       (i32.const 1))
      (i32.and
       (local.tee $*p/343
        (i32.shr_u
         (local.get $lo/39)
         (i32.const 8)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/36)
      (i32.add
       (local.get $offset/37)
       (i32.const 2))
      (i32.and
       (local.tee $*p/346
        (i32.and
         (local.get $hi/40)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/36)
      (i32.add
       (local.get $offset/37)
       (i32.const 3))
      (i32.and
       (local.tee $*p/349
        (i32.shr_u
         (local.get $hi/40)
         (i32.const 8)))
       (i32.const 255)))
     (i32.const 4))
    (else
     (call $moonbitlang/core/builtin.abort|Int|
      (call $moonbit.string_literal
       (i32.const 11)
       (i32.const 762)
       (i32.const 17))
      (call $moonbit.string_literal
       (i32.const 10)
       (i32.const 666)
       (i32.const 48))))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/31 (ref $@moonbitlang/core/builtin.StringBuilder)) (result (ref $moonbit.string))
 (call $Bytes::to_unchecked_string.inner
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/31))
  (i32.const 0)
  (i64.extend_i32_s
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/31)))))
(func $Bytes::to_unchecked_string.inner (param $self/26 (ref $moonbit.bytes)) (param $offset/30 i32) (param $length/28 i64) (result (ref $moonbit.string))
 (local $len/25 i32)
 (local $length/27 i32)
 (local $*Some/29 i64)
 (local.set $len/25
  (array.len
   (local.get $self/26)))
 (local.set $length/27
  (if (result i32)
   (i64.eq
    (local.get $length/28)
    (i64.const 4294967296))
   (then
    (i32.sub
     (local.get $len/25)
     (local.get $offset/30)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/29
      (local.get $length/28))))))
 (if (result (ref $moonbit.string))
  (if (result i32)
   (i32.ge_s
    (local.get $offset/30)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $length/27)
      (i32.const 0))
     (then
      (i32.le_s
       (i32.add
        (local.get $offset/30)
        (local.get $length/27))
       (local.get $len/25)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (call $moonbitlang/core/builtin.unsafe_sub_string
    (local.get $self/26)
    (local.get $offset/30)
    (local.get $length/27)))
  (else
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/465 (ref $moonbit.bytes)) (param $*param/466 i32) (param $*param/467 i32) (result (ref $moonbit.string))
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/465)
  (local.get $*param/466)
  (local.get $*param/467)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/23 i32) (result (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $initial/22 i32)
 (local $data/24 (ref $moonbit.bytes))
 (local.set $initial/22
  (if (result i32)
   (i32.lt_s
    (local.get $size_hint/23)
    (i32.const 1))
   (then
    (i32.const 1))
   (else
    (local.get $size_hint/23))))
 (struct.new $@moonbitlang/core/builtin.StringBuilder
  (local.tee $data/24
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $initial/22)))
  (i32.const 0)))
(func $moonbitlang/core/builtin.abort|Option<Int>| (param $string/11 (ref $moonbit.string)) (param $loc/12 (ref $moonbit.string)) (result i64)
 (call $moonbitlang/core/abort.abort|Option<Int>|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/11)
     (call $moonbit.string_literal
      (i32.const 13)
      (i32.const 798)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/12)))
   (call $moonbit.string_literal
    (i32.const 12)
    (i32.const 796)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|StringView| (param $string/9 (ref $moonbit.string)) (param $loc/10 (ref $moonbit.string)) (result (ref $StringView))
 (call $moonbitlang/core/abort.abort|StringView|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/9)
     (call $moonbit.string_literal
      (i32.const 13)
      (i32.const 798)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/10)))
   (call $moonbit.string_literal
    (i32.const 12)
    (i32.const 796)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/7 (ref $moonbit.string)) (param $loc/8 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/7)
     (call $moonbit.string_literal
      (i32.const 13)
      (i32.const 798)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/8)))
   (call $moonbit.string_literal
    (i32.const 12)
    (i32.const 796)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/5 (ref $moonbit.string)) (param $loc/6 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Unit|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/5)
     (call $moonbit.string_literal
      (i32.const 13)
      (i32.const 798)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/6)))
   (call $moonbit.string_literal
    (i32.const 12)
    (i32.const 796)
    (i32.const 1)))))
(func $moonbitlang/core/abort.abort|Option<Int>| (param $msg/4 (ref $moonbit.string)) (result i64)
 (unreachable))
(func $moonbitlang/core/abort.abort|StringView| (param $msg/3 (ref $moonbit.string)) (result (ref $StringView))
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/2 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/1 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_3) (param $*obj/481 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/480 i32) (result i32)
 (local $*self/479 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/479
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/481))))
  (local.get $*param/480)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_2) (param $*obj/478 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/477 (ref $StringView)) (result i32)
 (local $*self/476 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/476
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/478))))
  (local.get $*param/477)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (type $@moonbitlang/core/builtin.Logger.method_1) (param $*obj/475 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/472 (ref $moonbit.string)) (param $*param/473 i32) (param $*param/474 i32) (result i32)
 (local $*self/471 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/471
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/475))))
  (local.get $*param/472)
  (local.get $*param/473)
  (local.get $*param/474)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_0) (param $*obj/470 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/469 (ref $moonbit.string)) (result i32)
 (local $*self/468 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/468
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/470))))
  (local.get $*param/469)))
(start $*init*/2)
(func $*init*/2
 (global.set $moonbitlang/core/builtin.parse.*bind|5401
  (call $moonbit.string_literal
   (i32.const 18)
   (i32.const 866)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5440
  (call $moonbit.string_literal
   (i32.const 18)
   (i32.const 866)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5434
  (call $moonbit.string_literal
   (i32.const 19)
   (i32.const 868)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5421
  (call $moonbit.string_literal
   (i32.const 18)
   (i32.const 866)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.parse.*bind|5415
  (call $moonbit.string_literal
   (i32.const 18)
   (i32.const 866)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.output.*bind|8190
  (call $moonbit.string_literal
   (i32.const 17)
   (i32.const 864)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.output.*bind|8184
  (call $moonbit.string_literal
   (i32.const 17)
   (i32.const 864)
   (i32.const 1)))
 (global.set $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55
  (i64.extend_i32_s
   (i32.const 0)))
 (global.set $moonbitlang/core/builtin.brute_force_find.constr/69
  (i64.extend_i32_s
   (i32.const 0))))
(func $*main*/1
 (local $*bind/317 i64)
 (local $*Some/318 i64)
 (local $*v/319 i32)
 (local $*bind/320 i64)
 (local $*Some/321 i64)
 (local $*v/322 i32)
 (local $*p/457 i32)
 (local $*p/458 i32)
 (local $*p/461 i32)
 (local $*p/462 i32)
 (local.set $*p/457
  (i32.const 10))
 (if
  (i64.eq
   (local.tee $*bind/317
    (if (result i64)
     (i32.eq
      (local.tee $*p/458
       (i32.const 2))
      (i32.const 0))
     (then
      (i64.const 4294967296))
     (else
      (i64.extend_i32_s
       (i32.div_s
        (local.get $*p/457)
        (local.get $*p/458))))))
   (i64.const 4294967296))
  (then
   (drop
    (call $moonbitlang/core/builtin.println|String|
     (call $moonbit.string_literal
      (i32.const 14)
      (i32.const 810)
      (i32.const 21)))))
  (else
   (local.set $*v/319
    (i32.wrap_i64
     (local.tee $*Some/318
      (local.get $*bind/317))))
   (drop
    (call $moonbitlang/core/builtin.println|String|
     (call $moonbit.add_string
      (call $moonbit.add_string
       (call $moonbit.add_string
        (call $moonbit.add_string
         (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
          (i32.const 10))
         (call $moonbit.string_literal
          (i32.const 16)
          (i32.const 858)
          (i32.const 3)))
        (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
         (i32.const 2)))
       (call $moonbit.string_literal
        (i32.const 15)
        (i32.const 852)
        (i32.const 3)))
      (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
       (local.get $*v/319)))))))
 (local.set $*p/461
  (i32.const 10))
 (if
  (i64.eq
   (local.tee $*bind/320
    (if (result i64)
     (i32.eq
      (local.tee $*p/462
       (i32.const 0))
      (i32.const 0))
     (then
      (i64.const 4294967296))
     (else
      (i64.extend_i32_s
       (i32.div_s
        (local.get $*p/461)
        (local.get $*p/462))))))
   (i64.const 4294967296))
  (then
   (drop
    (call $moonbitlang/core/builtin.println|String|
     (call $moonbit.string_literal
      (i32.const 14)
      (i32.const 810)
      (i32.const 21)))))
  (else
   (local.set $*v/322
    (i32.wrap_i64
     (local.tee $*Some/321
      (local.get $*bind/320))))
   (drop
    (call $moonbitlang/core/builtin.println|String|
     (call $moonbit.add_string
      (call $moonbit.add_string
       (call $moonbit.add_string
        (call $moonbit.add_string
         (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
          (i32.const 10))
         (call $moonbit.string_literal
          (i32.const 16)
          (i32.const 858)
          (i32.const 3)))
        (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
         (i32.const 0)))
       (call $moonbit.string_literal
        (i32.const 15)
        (i32.const 852)
        (i32.const 3)))
      (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
       (local.get $*v/322))))))))
(export "_start" (func $*main*/1))