(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data ",\00 \00]\00[\000\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00r\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\008\00:\005\00-\002\009\008\00:\003\001\00C\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\0A\00\0A\00 \00 \00a\00t\00 \00D\00o\00u\00b\00l\00e\00d\00 \00a\00r\00r\00a\00y\00:\00 \00S\00u\00m\00 \00o\00f\00 \00a\00r\00r\00a\00y\00 \00e\00l\00e\00m\00e\00n\00t\00s\00:\00 \00O\00r\00i\00g\00i\00n\00a\00l\00 \00a\00r\00r\00a\00y\00:\00 \00\01\00\00\00\02\00\00\00\03\00\00\00\04\00\00\00\05\00\00\00")
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
(type $ArrayView::iter|Int|.*p.fn/1-cap
 (sub
  $<>=>Option<Int>
  (struct
   (field  (mut (ref null $<>=>Option<Int>-sig)))
   (field  (mut (ref null $@moonbitlang/core/builtin.ArrayView<Int>)))
   (field  (mut (ref null $Ref<Int>))))))
(type $<StringView*Option<StringView>>
 (struct
  (field  (ref $StringView))
  (field  (ref null $StringView))))
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
(type $@moonbitlang/core/builtin.SourceLocRepr
 (struct
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
  (field  (ref $StringView))
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
 $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|
 $ArrayView::iter|Int|.*p.fn/1)
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 14)
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
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/342 (ref $moonbit.string)) (param $logger/343 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (call $@moonbitlang/core/builtin.SourceLocRepr::parse
   (local.get $self/342))
  (local.get $logger/343)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/305 (ref $@moonbitlang/core/builtin.SourceLocRepr)) (param $logger/341 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (local $pkg/304 (ref $StringView))
 (local $*data/306 (ref $moonbit.string))
 (local $*start/307 i32)
 (local $*end/308 i32)
 (local $*bind/314 (ref $<StringView*Option<StringView>>))
 (local $package_name/316 (ref $StringView))
 (local $*try_err/318 (ref $moonbit.enum))
 (local $module_name/319 (ref $StringView))
 (local $*try_err/321 (ref $moonbit.enum))
 (local $next_char/324 i32)
 (local $next_char/327 i32)
 (local $next_char/330 i32)
 (local $next_char/331 i32)
 (local $next_char/332 i32)
 (local $next_char/333 i32)
 (local $next_char/334 i32)
 (local $next_char/335 i32)
 (local $next_char/336 i32)
 (local $*module_name/337 (ref $StringView))
 (local $*package_name/338 (ref null $StringView))
 (local $*Some/339 (ref null $StringView))
 (local $*pkg_name/340 (ref $StringView))
 (local $*p/478 i32)
 (local $*p/481 i32)
 (local $*p/484 i32)
 (local $*p/487 i32)
 (local $*p/490 i32)
 (local $*p/493 i32)
 (local $*p/496 i32)
 (local $*p/499 i32)
 (local $*p/502 i32)
 (local $*bind/531 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/532 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/533 (ref $moonbit.enum))
 (local $*bind/534 (ref $moonbit.enum))
 (local $tag/540 i32)
 (local $tag/542 i32)
 (local $*cursor/309 i32)
 (local $accept_state/310 i32)
 (local $match_end/311 i32)
 (local $match_tag_saver_0/312 i32)
 (local $tag_0/313 i32)
 (local.set $*data/306
  (struct.get $StringView 0
   (local.tee $pkg/304
    (struct.get $@moonbitlang/core/builtin.SourceLocRepr 0
     (local.get $self/305)))))
 (local.set $*end/308
  (i32.add
   (local.tee $*start/307
    (struct.get $StringView 1
     (local.get $pkg/304)))
   (i32.sub
    (struct.get $StringView 2
     (local.get $pkg/304))
    (struct.get $StringView 1
     (local.get $pkg/304)))))
 (local.set $*cursor/309
  (local.get $*start/307))
 (local.set $accept_state/310
  (i32.const -1))
 (local.set $match_end/311
  (i32.const -1))
 (local.set $match_tag_saver_0/312
  (i32.const -1))
 (local.set $tag_0/313
  (i32.const -1))
 (block $outer/535 (result (ref $<StringView*Option<StringView>>))
  (block $join:315
   (loop $loop:323 (result (ref $<StringView*Option<StringView>>))
    (if (result (ref $<StringView*Option<StringView>>))
     (i32.lt_s
      (local.get $*cursor/309)
      (local.get $*end/308))
     (then
      (block $outer/536 (result (ref $<StringView*Option<StringView>>))
       (block $join:322
        (local.set $*p/478
         (local.get $*cursor/309))
        (local.set $next_char/324
         (array.get_u $moonbit.string
          (local.get $*data/306)
          (local.get $*p/478)))
        (local.set $*cursor/309
         (i32.add
          (local.get $*cursor/309)
          (i32.const 1)))
        (if (result (ref $<StringView*Option<StringView>>))
         (i32.lt_s
          (local.get $next_char/324)
          (i32.const 55296))
         (then
          (if (result (ref $<StringView*Option<StringView>>))
           (i32.lt_s
            (local.get $next_char/324)
            (i32.const 47))
           (then
            (br $join:322))
           (else
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.gt_s
              (local.get $next_char/324)
              (i32.const 47))
             (then
              (br $join:322))
             (else
              (loop $loop:326 (result (ref $<StringView*Option<StringView>>))
               (local.set $tag_0/313
                (local.get $*cursor/309))
               (if (result (ref $<StringView*Option<StringView>>))
                (i32.lt_s
                 (local.get $*cursor/309)
                 (local.get $*end/308))
                (then
                 (block $outer/537 (result (ref $<StringView*Option<StringView>>))
                  (block $join:325
                   (local.set $*p/481
                    (local.get $*cursor/309))
                   (local.set $next_char/327
                    (array.get_u $moonbit.string
                     (local.get $*data/306)
                     (local.get $*p/481)))
                   (local.set $*cursor/309
                    (i32.add
                     (local.get $*cursor/309)
                     (i32.const 1)))
                   (if (result (ref $<StringView*Option<StringView>>))
                    (i32.lt_s
                     (local.get $next_char/327)
                     (i32.const 55296))
                    (then
                     (if (result (ref $<StringView*Option<StringView>>))
                      (i32.lt_s
                       (local.get $next_char/327)
                       (i32.const 47))
                      (then
                       (br $join:325))
                      (else
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.gt_s
                         (local.get $next_char/327)
                         (i32.const 47))
                        (then
                         (br $join:325))
                        (else
                         (loop $loop:329 (result (ref $<StringView*Option<StringView>>))
                          (if (result (ref $<StringView*Option<StringView>>))
                           (i32.lt_s
                            (local.get $*cursor/309)
                            (local.get $*end/308))
                           (then
                            (block $outer/538 (result (ref $<StringView*Option<StringView>>))
                             (block $join:328
                              (local.set $*p/484
                               (local.get $*cursor/309))
                              (local.set $next_char/330
                               (array.get_u $moonbit.string
                                (local.get $*data/306)
                                (local.get $*p/484)))
                              (local.set $*cursor/309
                               (i32.add
                                (local.get $*cursor/309)
                                (i32.const 1)))
                              (if (result (ref $<StringView*Option<StringView>>))
                               (i32.lt_s
                                (local.get $next_char/330)
                                (i32.const 56319))
                               (then
                                (if (result (ref $<StringView*Option<StringView>>))
                                 (i32.lt_s
                                  (local.get $next_char/330)
                                  (i32.const 55296))
                                 (then
                                  (br $join:328))
                                 (else
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $*cursor/309)
                                    (local.get $*end/308))
                                   (then
                                    (local.set $*p/487
                                     (local.get $*cursor/309))
                                    (local.set $next_char/331
                                     (array.get_u $moonbit.string
                                      (local.get $*data/306)
                                      (local.get $*p/487)))
                                    (local.set $*cursor/309
                                     (i32.add
                                      (local.get $*cursor/309)
                                      (i32.const 1)))
                                    (if (result (ref $<StringView*Option<StringView>>))
                                     (i32.lt_s
                                      (local.get $next_char/331)
                                      (i32.const 56320))
                                     (then
                                      (br $join:315))
                                     (else
                                      (if (result (ref $<StringView*Option<StringView>>))
                                       (i32.gt_s
                                        (local.get $next_char/331)
                                        (i32.const 65535))
                                       (then
                                        (br $join:315))
                                       (else
                                        (br $loop:329))))))
                                   (else
                                    (br $join:315))))))
                               (else
                                (if (result (ref $<StringView*Option<StringView>>))
                                 (i32.gt_s
                                  (local.get $next_char/330)
                                  (i32.const 56319))
                                 (then
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $next_char/330)
                                    (i32.const 65536))
                                   (then
                                    (br $join:328))
                                   (else
                                    (br $join:315))))
                                 (else
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $*cursor/309)
                                    (local.get $*end/308))
                                   (then
                                    (local.set $*p/490
                                     (local.get $*cursor/309))
                                    (local.set $next_char/332
                                     (array.get_u $moonbit.string
                                      (local.get $*data/306)
                                      (local.get $*p/490)))
                                    (local.set $*cursor/309
                                     (i32.add
                                      (local.get $*cursor/309)
                                      (i32.const 1)))
                                    (if (result (ref $<StringView*Option<StringView>>))
                                     (i32.lt_s
                                      (local.get $next_char/332)
                                      (i32.const 56320))
                                     (then
                                      (br $join:315))
                                     (else
                                      (if (result (ref $<StringView*Option<StringView>>))
                                       (i32.gt_s
                                        (local.get $next_char/332)
                                        (i32.const 57343))
                                       (then
                                        (br $join:315))
                                       (else
                                        (br $loop:329))))))
                                   (else
                                    (br $join:315)))))))
                              (br $outer/538))
                             (br $loop:329)))
                           (else
                            (local.set $match_tag_saver_0/312
                             (local.get $tag_0/313))
                            (local.set $accept_state/310
                             (i32.const 0))
                            (local.set $match_end/311
                             (local.get $*cursor/309))
                            (br $join:315)))))))))
                    (else
                     (if (result (ref $<StringView*Option<StringView>>))
                      (i32.gt_s
                       (local.get $next_char/327)
                       (i32.const 56318))
                      (then
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.lt_s
                         (local.get $next_char/327)
                         (i32.const 57344))
                        (then
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.lt_s
                           (local.get $*cursor/309)
                           (local.get $*end/308))
                          (then
                           (local.set $*p/493
                            (local.get $*cursor/309))
                           (local.set $next_char/333
                            (array.get_u $moonbit.string
                             (local.get $*data/306)
                             (local.get $*p/493)))
                           (local.set $*cursor/309
                            (i32.add
                             (local.get $*cursor/309)
                             (i32.const 1)))
                           (if (result (ref $<StringView*Option<StringView>>))
                            (i32.lt_s
                             (local.get $next_char/333)
                             (i32.const 56320))
                            (then
                             (br $join:315))
                            (else
                             (if (result (ref $<StringView*Option<StringView>>))
                              (i32.gt_s
                               (local.get $next_char/333)
                               (i32.const 57343))
                              (then
                               (br $join:315))
                              (else
                               (br $loop:326))))))
                          (else
                           (br $join:315))))
                        (else
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.gt_s
                           (local.get $next_char/327)
                           (i32.const 65535))
                          (then
                           (br $join:315))
                          (else
                           (br $join:325))))))
                      (else
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.lt_s
                         (local.get $*cursor/309)
                         (local.get $*end/308))
                        (then
                         (local.set $*p/496
                          (local.get $*cursor/309))
                         (local.set $next_char/334
                          (array.get_u $moonbit.string
                           (local.get $*data/306)
                           (local.get $*p/496)))
                         (local.set $*cursor/309
                          (i32.add
                           (local.get $*cursor/309)
                           (i32.const 1)))
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.lt_s
                           (local.get $next_char/334)
                           (i32.const 56320))
                          (then
                           (br $join:315))
                          (else
                           (if (result (ref $<StringView*Option<StringView>>))
                            (i32.gt_s
                             (local.get $next_char/334)
                             (i32.const 65535))
                            (then
                             (br $join:315))
                            (else
                             (br $loop:326))))))
                        (else
                         (br $join:315)))))))
                   (br $outer/537))
                  (br $loop:326)))
                (else
                 (br $join:315)))))))))
         (else
          (if (result (ref $<StringView*Option<StringView>>))
           (i32.gt_s
            (local.get $next_char/324)
            (i32.const 56318))
           (then
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.lt_s
              (local.get $next_char/324)
              (i32.const 57344))
             (then
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.lt_s
                (local.get $*cursor/309)
                (local.get $*end/308))
               (then
                (local.set $*p/499
                 (local.get $*cursor/309))
                (local.set $next_char/335
                 (array.get_u $moonbit.string
                  (local.get $*data/306)
                  (local.get $*p/499)))
                (local.set $*cursor/309
                 (i32.add
                  (local.get $*cursor/309)
                  (i32.const 1)))
                (if (result (ref $<StringView*Option<StringView>>))
                 (i32.lt_s
                  (local.get $next_char/335)
                  (i32.const 56320))
                 (then
                  (br $join:315))
                 (else
                  (if (result (ref $<StringView*Option<StringView>>))
                   (i32.gt_s
                    (local.get $next_char/335)
                    (i32.const 57343))
                   (then
                    (br $join:315))
                   (else
                    (br $loop:323))))))
               (else
                (br $join:315))))
             (else
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.gt_s
                (local.get $next_char/324)
                (i32.const 65535))
               (then
                (br $join:315))
               (else
                (br $join:322))))))
           (else
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.lt_s
              (local.get $*cursor/309)
              (local.get $*end/308))
             (then
              (local.set $*p/502
               (local.get $*cursor/309))
              (local.set $next_char/336
               (array.get_u $moonbit.string
                (local.get $*data/306)
                (local.get $*p/502)))
              (local.set $*cursor/309
               (i32.add
                (local.get $*cursor/309)
                (i32.const 1)))
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.lt_s
                (local.get $next_char/336)
                (i32.const 56320))
               (then
                (br $join:315))
               (else
                (if (result (ref $<StringView*Option<StringView>>))
                 (i32.gt_s
                  (local.get $next_char/336)
                  (i32.const 65535))
                 (then
                  (br $join:315))
                 (else
                  (br $loop:323))))))
             (else
              (br $join:315)))))))
        (br $outer/536))
       (br $loop:323)))
     (else
      (br $join:315))))
   (br $outer/535))
  (if (result (ref $<StringView*Option<StringView>>))
   (i32.eq
    (local.get $accept_state/310)
    (i32.const 0))
   (then
    (block $outer/541 (result (ref $StringView))
     (block $join:317 (result (ref $moonbit.enum))
      (if (result (ref $StringView))
       (i32.eq
        (local.tee $tag/542
         (struct.get $moonbit.enum 0
          (local.tee $*bind/534
           (call $String::sub
            (local.get $*data/306)
            (i64.extend_i32_s
             (i32.add
              (local.get $match_tag_saver_0/312)
              (i32.const 1)))
            (i64.extend_i32_s
             (local.get $match_end/311))))))
        (i32.const 1))
       (then
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
          (local.get $*bind/534))))
       (else
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
          (local.get $*bind/534)))
        (br $join:317)))
      (br $outer/541))
     (local.set $*try_err/318)
     (unreachable))
    (local.set $package_name/316)
    (block $outer/539 (result (ref $StringView))
     (block $join:320 (result (ref $moonbit.enum))
      (if (result (ref $StringView))
       (i32.eq
        (local.tee $tag/540
         (struct.get $moonbit.enum 0
          (local.tee $*bind/533
           (call $String::sub
            (local.get $*data/306)
            (i64.extend_i32_s
             (local.get $*start/307))
            (i64.extend_i32_s
             (local.get $match_tag_saver_0/312))))))
        (i32.const 1))
       (then
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
          (local.get $*bind/533))))
       (else
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
          (local.get $*bind/533)))
        (br $join:320)))
      (br $outer/539))
     (local.set $*try_err/321)
     (unreachable))
    (local.tee $module_name/319)
    (local.get $package_name/316)
    (struct.new $<StringView*Option<StringView>>))
   (else
    (struct.new $<StringView*Option<StringView>>
     (local.get $pkg/304)
     (ref.null none)))))
 (local.tee $*bind/314)
 (struct.get $<StringView*Option<StringView>> 0)
 (local.set $*module_name/337)
 (if
  (ref.is_null
   (local.tee $*package_name/338
    (struct.get $<StringView*Option<StringView>> 1
     (local.get $*bind/314))))
  (then)
  (else
   (local.set $*pkg_name/340
    (ref.as_non_null
     (local.tee $*Some/339
      (local.get $*package_name/338))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_2
     (local.get $logger/341)
     (local.get $*pkg_name/340)
     (struct.get $@moonbitlang/core/builtin.Logger 2
      (local.get $logger/341))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_3
     (local.tee $*bind/531
      (local.get $logger/341))
     (i32.const 47)
     (struct.get $@moonbitlang/core/builtin.Logger 3
      (local.get $*bind/531))))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/341)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 1
    (local.get $self/305))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/341)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/341)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 2
    (local.get $self/305))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/341)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/341)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 3
    (local.get $self/305))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/341)
   (i32.const 45)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/341)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 4
    (local.get $self/305))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/341)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/341)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 5
    (local.get $self/305))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/341))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/341)
   (i32.const 64)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/341))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_2
  (local.tee $*bind/532
   (local.get $logger/341))
  (local.get $*module_name/337)
  (struct.get $@moonbitlang/core/builtin.Logger 2
   (local.get $*bind/532))))
(func $moonbitlang/core/builtin.println|String| (param $input/303 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/303))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int| (param $self/302 (ref $@moonbitlang/core/builtin.Array<Int>)) (param $logger/301 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Logger::write_iter.inner|Int|
  (local.get $logger/301)
  (call $@moonbitlang/core/builtin.Array::iter|Int|
   (local.get $self/302))
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
(func $@moonbitlang/core/builtin.Array::iter|Int| (param $self/300 (ref $@moonbitlang/core/builtin.Array<Int>)) (result (ref $<>=>Option<Int>))
 (call $@moonbitlang/core/builtin.ArrayView::iter|Int|
  (struct.new $@moonbitlang/core/builtin.ArrayView<Int>
   (struct.get $@moonbitlang/core/builtin.Array<Int> 0
    (local.get $self/300))
   (i32.const 0)
   (struct.get $@moonbitlang/core/builtin.Array<Int> 1
    (local.get $self/300)))))
(func $@moonbitlang/core/builtin.ArrayView::iter|Int| (param $self/298 (ref $@moonbitlang/core/builtin.ArrayView<Int>)) (result (ref $<>=>Option<Int>))
 (local $i/297 (ref $Ref<Int>))
 (local $*p/467 (ref $<>=>Option<Int>))
 (local.set $i/297
  (struct.new $Ref<Int>
   (i32.const 0)))
 (local.tee $*p/467
  (struct.new $ArrayView::iter|Int|.*p.fn/1-cap
   (ref.func $ArrayView::iter|Int|.*p.fn/1)
   (local.get $self/298)
   (local.get $i/297))))
(func $ArrayView::iter|Int|.*p.fn/1 (type $<>=>Option<Int>-sig) (param $*env/529 (ref $<>=>Option<Int>)) (result i64)
 (local $i/297 (ref $Ref<Int>))
 (local $self/298 (ref $@moonbitlang/core/builtin.ArrayView<Int>))
 (local $elem/299 i32)
 (local $*casted_env/530 (ref $ArrayView::iter|Int|.*p.fn/1-cap))
 (local.set $i/297
  (ref.as_non_null
   (struct.get $ArrayView::iter|Int|.*p.fn/1-cap 2
    (local.tee $*casted_env/530
     (ref.cast (ref $ArrayView::iter|Int|.*p.fn/1-cap)
      (local.get $*env/529))))))
 (local.set $self/298
  (ref.as_non_null
   (struct.get $ArrayView::iter|Int|.*p.fn/1-cap 1
    (local.get $*casted_env/530))))
 (if (result i64)
  (i32.lt_s
   (struct.get $Ref<Int> 0
    (local.get $i/297))
   (i32.sub
    (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 2
     (local.get $self/298))
    (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 1
     (local.get $self/298))))
  (then
   (local.set $elem/299
    (array.get $moonbit.array_i32
     (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 0
      (local.get $self/298))
     (i32.add
      (struct.get $@moonbitlang/core/builtin.ArrayView<Int> 1
       (local.get $self/298))
      (struct.get $Ref<Int> 0
       (local.get $i/297)))))
   (struct.set $Ref<Int> 0
    (local.get $i/297)
    (i32.add
     (struct.get $Ref<Int> 0
      (local.get $i/297))
     (i32.const 1)))
   (i64.extend_i32_s
    (local.get $elem/299)))
  (else
   (i64.const 4294967296))))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/295 i32) (param $logger/294 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/294)
  (call $Int::to_string.inner
   (local.get $self/295)
   (i32.const 10))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/294))))
(func $@moonbitlang/core/builtin.Iter::next|Int| (param $self/293 (ref $<>=>Option<Int>)) (result i64)
 (local $*func/292 (ref $<>=>Option<Int>))
 (call_ref $<>=>Option<Int>-sig
  (local.tee $*func/292
   (local.get $self/293))
  (struct.get $<>=>Option<Int> 0
   (local.get $*func/292))))
(func $@moonbitlang/core/builtin.Array::push|Int| (param $self/289 (ref $@moonbitlang/core/builtin.Array<Int>)) (param $value/291 i32) (result i32)
 (local $length/290 i32)
 (if
  (i32.eq
   (struct.get $@moonbitlang/core/builtin.Array<Int> 1
    (local.get $self/289))
   (array.len
    (struct.get $@moonbitlang/core/builtin.Array<Int> 0
     (local.get $self/289))))
  (then
   (drop
    (call $@moonbitlang/core/builtin.Array::realloc|Int|
     (local.get $self/289))))
  (else))
 (local.set $length/290
  (struct.get $@moonbitlang/core/builtin.Array<Int> 1
   (local.get $self/289)))
 (array.set $moonbit.array_i32
  (struct.get $@moonbitlang/core/builtin.Array<Int> 0
   (local.get $self/289))
  (local.get $length/290)
  (local.get $value/291))
 (struct.set $@moonbitlang/core/builtin.Array<Int> 1
  (local.get $self/289)
  (i32.add
   (local.get $length/290)
   (i32.const 1)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Array::realloc|Int| (param $self/287 (ref $@moonbitlang/core/builtin.Array<Int>)) (result i32)
 (local $old_cap/286 i32)
 (local $new_cap/288 i32)
 (local.set $new_cap/288
  (if (result i32)
   (i32.eq
    (local.tee $old_cap/286
     (struct.get $@moonbitlang/core/builtin.Array<Int> 1
      (local.get $self/287)))
    (i32.const 0))
   (then
    (i32.const 8))
   (else
    (i32.mul
     (local.get $old_cap/286)
     (i32.const 2)))))
 (call $@moonbitlang/core/builtin.Array::resize_buffer|Int|
  (local.get $self/287)
  (local.get $new_cap/288)))
(func $@moonbitlang/core/builtin.Array::resize_buffer|Int| (param $self/283 (ref $@moonbitlang/core/builtin.Array<Int>)) (param $new_capacity/281 i32) (result i32)
 (local $new_buf/280 (ref $moonbit.array_i32))
 (local $old_buf/282 (ref $moonbit.array_i32))
 (local $old_cap/284 i32)
 (local $copy_len/285 i32)
 (local.set $new_buf/280
  (array.new_default $moonbit.array_i32
   (local.get $new_capacity/281)))
 (local.set $copy_len/285
  (if (result i32)
   (i32.lt_s
    (local.tee $old_cap/284
     (array.len
      (local.tee $old_buf/282
       (struct.get $@moonbitlang/core/builtin.Array<Int> 0
        (local.get $self/283)))))
    (local.get $new_capacity/281))
   (then
    (local.get $old_cap/284))
   (else
    (local.get $new_capacity/281))))
 (drop
  (call $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int|
   (local.get $new_buf/280)
   (i32.const 0)
   (local.get $old_buf/282)
   (i32.const 0)
   (local.get $copy_len/285)))
 (struct.set $@moonbitlang/core/builtin.Array<Int> 0
  (local.get $self/283)
  (local.get $new_buf/280))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/278 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/279 (ref $StringView)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/278)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/278))
    (i32.mul
     (i32.sub
      (struct.get $StringView 2
       (local.get $str/279))
      (struct.get $StringView 1
       (local.get $str/279)))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/278))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/278))
   (struct.get $StringView 0
    (local.get $str/279))
   (struct.get $StringView 1
    (local.get $str/279))
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/279))
    (struct.get $StringView 1
     (local.get $str/279)))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/278)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/278))
   (i32.mul
    (i32.sub
     (struct.get $StringView 2
      (local.get $str/279))
     (struct.get $StringView 1
      (local.get $str/279)))
    (i32.const 2))))
 (i32.const 0))
(func $Int::to_string.inner (param $self/260 i32) (param $radix/259 i32) (result (ref $moonbit.string))
 (local $is_negative/261 i32)
 (local $num/262 i32)
 (local $buffer/263 (ref $FixedArray<UInt16>))
 (local $digit_len/264 i32)
 (local $total_len/265 i32)
 (local $buffer/266 (ref $FixedArray<UInt16>))
 (local $digit_start/267 i32)
 (local $digit_len/268 i32)
 (local $total_len/269 i32)
 (local $buffer/270 (ref $FixedArray<UInt16>))
 (local $digit_start/271 i32)
 (local $digit_len/272 i32)
 (local $total_len/273 i32)
 (local $buffer/274 (ref $FixedArray<UInt16>))
 (local $digit_start/275 i32)
 (if
  (if (result i32)
   (i32.lt_s
    (local.get $radix/259)
    (i32.const 2))
   (then
    (i32.const 1))
   (else
    (i32.gt_s
     (local.get $radix/259)
     (i32.const 36))))
  (then
   (drop
    (call $moonbitlang/core/builtin.abort|Unit|
     (call $moonbit.string_literal
      (i32.const 5)
      (i32.const 114)
      (i32.const 30))
     (call $moonbit.string_literal
      (i32.const 4)
      (i32.const 10)
      (i32.const 52)))))
  (else))
 (if
  (i32.eq
   (local.get $self/260)
   (i32.const 0))
  (then
   (call $moonbit.string_literal
    (i32.const 3)
    (i32.const 8)
    (i32.const 1))
   (return))
  (else))
 (local.set $num/262
  (if (result i32)
   (local.tee $is_negative/261
    (i32.lt_s
     (local.get $self/260)
     (i32.const 0)))
   (then
    (i32.sub
     (i32.const 0)
     (local.get $self/260)))
   (else
    (local.get $self/260))))
 (local.set $buffer/263
  (if (result (ref $FixedArray<UInt16>))
   (i32.eq
    (local.get $radix/259)
    (i32.const 10))
   (then
    (local.set $total_len/265
     (i32.add
      (local.tee $digit_len/264
       (call $moonbitlang/core/builtin.dec_count32
        (local.get $num/262)))
      (if (result i32)
       (local.get $is_negative/261)
       (then
        (i32.const 1))
       (else
        (i32.const 0)))))
    (local.set $buffer/266
     (array.new $FixedArray<UInt16>
      (i32.const 0)
      (local.get $total_len/265)))
    (local.set $digit_start/267
     (if (result i32)
      (local.get $is_negative/261)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/266)
      (local.get $num/262)
      (local.get $digit_start/267)
      (local.get $total_len/265)))
    (local.get $buffer/266))
   (else
    (if (result (ref $FixedArray<UInt16>))
     (i32.eq
      (local.get $radix/259)
      (i32.const 16))
     (then
      (local.set $total_len/269
       (i32.add
        (local.tee $digit_len/268
         (call $moonbitlang/core/builtin.hex_count32
          (local.get $num/262)))
        (if (result i32)
         (local.get $is_negative/261)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/270
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/269)))
      (local.set $digit_start/271
       (if (result i32)
        (local.get $is_negative/261)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/270)
        (local.get $num/262)
        (local.get $digit_start/271)
        (local.get $total_len/269)))
      (local.get $buffer/270))
     (else
      (local.set $total_len/273
       (i32.add
        (local.tee $digit_len/272
         (call $moonbitlang/core/builtin.radix_count32
          (local.get $num/262)
          (local.get $radix/259)))
        (if (result i32)
         (local.get $is_negative/261)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/274
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/273)))
      (local.set $digit_start/275
       (if (result i32)
        (local.get $is_negative/261)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_generic
        (local.get $buffer/274)
        (local.get $num/262)
        (local.get $digit_start/275)
        (local.get $total_len/273)
        (local.get $radix/259)))
      (local.get $buffer/274))))))
 (if
  (local.get $is_negative/261)
  (then
   (array.set $FixedArray<UInt16>
    (local.get $buffer/263)
    (i32.const 0)
    (i32.const 45)))
  (else))
 (local.get $buffer/263))
(func $moonbitlang/core/builtin.radix_count32 (param $value/253 i32) (param $radix/256 i32) (result i32)
 (local $base/255 i32)
 (local $num/254 i32)
 (local $count/257 i32)
 (if
  (i32.eq
   (local.get $value/253)
   (i32.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.set $num/254
  (local.get $value/253))
 (local.set $base/255
  (local.get $radix/256))
 (local.set $count/257
  (i32.const 0))
 (loop $loop:258
  (if
   (i32.gt_u
    (local.get $num/254)
    (i32.const 0))
   (then
    (local.set $count/257
     (i32.add
      (local.get $count/257)
      (i32.const 1)))
    (local.set $num/254
     (i32.div_u
      (local.get $num/254)
      (local.get $base/255)))
    (br $loop:258))
   (else)))
 (local.get $count/257))
(func $moonbitlang/core/builtin.hex_count32 (param $value/251 i32) (result i32)
 (local $leading_zeros/252 i32)
 (if (result i32)
  (i32.eq
   (local.get $value/251)
   (i32.const 0))
  (then
   (i32.const 1))
  (else
   (local.set $leading_zeros/252
    (i32.clz
     (local.get $value/251)))
   (i32.add
    (i32.div_s
     (i32.sub
      (i32.const 31)
      (local.get $leading_zeros/252))
     (i32.const 4))
    (i32.const 1)))))
(func $moonbitlang/core/builtin.dec_count32 (param $value/250 i32) (result i32)
 (if (result i32)
  (i32.ge_u
   (local.get $value/250)
   (i32.const 100000))
  (then
   (if (result i32)
    (i32.ge_u
     (local.get $value/250)
     (i32.const 10000000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/250)
       (i32.const 1000000000))
      (then
       (i32.const 10))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/250)
         (i32.const 100000000))
        (then
         (i32.const 9))
        (else
         (i32.const 8))))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/250)
       (i32.const 1000000))
      (then
       (i32.const 7))
      (else
       (i32.const 6))))))
  (else
   (if (result i32)
    (i32.ge_u
     (local.get $value/250)
     (i32.const 1000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/250)
       (i32.const 10000))
      (then
       (i32.const 5))
      (else
       (i32.const 4))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/250)
       (i32.const 100))
      (then
       (i32.const 3))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/250)
         (i32.const 10))
        (then
         (i32.const 2))
        (else
         (i32.const 1))))))))))
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/240 (ref $FixedArray<UInt16>)) (param $num/228 i32) (param $digit_start/231 i32) (param $total_len/230 i32) (result i32)
 (local $t/232 i32)
 (local $r/233 i32)
 (local $d1/234 i32)
 (local $d2/235 i32)
 (local $d1_hi/236 i32)
 (local $d1_lo/237 i32)
 (local $d2_hi/238 i32)
 (local $d2_lo/239 i32)
 (local $t/243 i32)
 (local $d/244 i32)
 (local $d_hi/245 i32)
 (local $d_lo/246 i32)
 (local $d_hi/248 i32)
 (local $d_lo/249 i32)
 (local $num/227 i32)
 (local $offset/229 i32)
 (local $remaining/242 i32)
 (local.set $num/227
  (local.get $num/228))
 (local.set $offset/229
  (i32.sub
   (local.get $total_len/230)
   (local.get $digit_start/231)))
 (loop $loop:241
  (if
   (i32.ge_u
    (local.get $num/227)
    (i32.const 10000))
   (then
    (local.set $t/232
     (i32.div_u
      (local.get $num/227)
      (i32.const 10000)))
    (local.set $r/233
     (i32.rem_u
      (local.get $num/227)
      (i32.const 10000)))
    (local.set $num/227
     (local.get $t/232))
    (local.set $d1/234
     (i32.div_s
      (local.get $r/233)
      (i32.const 100)))
    (local.set $d2/235
     (i32.rem_s
      (local.get $r/233)
      (i32.const 100)))
    (local.set $offset/229
     (i32.sub
      (local.get $offset/229)
      (i32.const 4)))
    (local.set $d1_hi/236
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d1/234)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d1_lo/237
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d1/234)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_hi/238
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d2/235)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_lo/239
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d2/235)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/240)
     (i32.add
      (local.get $digit_start/231)
      (local.get $offset/229))
     (local.get $d1_hi/236))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/240)
     (i32.add
      (i32.add
       (local.get $digit_start/231)
       (local.get $offset/229))
      (i32.const 1))
     (local.get $d1_lo/237))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/240)
     (i32.add
      (i32.add
       (local.get $digit_start/231)
       (local.get $offset/229))
      (i32.const 2))
     (local.get $d2_hi/238))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/240)
     (i32.add
      (i32.add
       (local.get $digit_start/231)
       (local.get $offset/229))
      (i32.const 3))
     (local.get $d2_lo/239))
    (br $loop:241))
   (else)))
 (local.set $remaining/242
  (local.get $num/227))
 (loop $loop:247
  (if
   (i32.ge_s
    (local.get $remaining/242)
    (i32.const 100))
   (then
    (local.set $t/243
     (i32.div_s
      (local.get $remaining/242)
      (i32.const 100)))
    (local.set $d/244
     (i32.rem_s
      (local.get $remaining/242)
      (i32.const 100)))
    (local.set $remaining/242
     (local.get $t/243))
    (local.set $offset/229
     (i32.sub
      (local.get $offset/229)
      (i32.const 2)))
    (local.set $d_hi/245
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d/244)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d_lo/246
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d/244)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/240)
     (i32.add
      (local.get $digit_start/231)
      (local.get $offset/229))
     (local.get $d_hi/245))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/240)
     (i32.add
      (i32.add
       (local.get $digit_start/231)
       (local.get $offset/229))
      (i32.const 1))
     (local.get $d_lo/246))
    (br $loop:247))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.get $remaining/242)
   (i32.const 10))
  (then
   (local.set $offset/229
    (i32.sub
     (local.get $offset/229)
     (i32.const 2)))
   (local.set $d_hi/248
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.div_s
       (local.get $remaining/242)
       (i32.const 10)))
     (i32.const 65535)))
   (local.set $d_lo/249
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (local.get $remaining/242)
       (i32.const 10)))
     (i32.const 65535)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/240)
    (i32.add
     (local.get $digit_start/231)
     (local.get $offset/229))
    (local.get $d_hi/248))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/240)
    (i32.add
     (i32.add
      (local.get $digit_start/231)
      (local.get $offset/229))
     (i32.const 1))
    (local.get $d_lo/249))
   (i32.const 0))
  (else
   (local.set $offset/229
    (i32.sub
     (local.get $offset/229)
     (i32.const 1)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/240)
    (i32.add
     (local.get $digit_start/231)
     (local.get $offset/229))
    (i32.and
     (i32.add
      (i32.const 48)
      (local.get $remaining/242))
     (i32.const 65535)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/222 (ref $FixedArray<UInt16>)) (param $num/216 i32) (param $digit_start/214 i32) (param $total_len/213 i32) (param $radix/218 i32) (result i32)
 (local $base/217 i32)
 (local $shift/219 i32)
 (local $mask/220 i32)
 (local $digit/221 i32)
 (local $q/224 i32)
 (local $digit/225 i32)
 (local $offset/212 i32)
 (local $n/215 i32)
 (local.set $offset/212
  (i32.sub
   (local.get $total_len/213)
   (local.get $digit_start/214)))
 (local.set $n/215
  (local.get $num/216))
 (local.set $base/217
  (local.get $radix/218))
 (if (result i32)
  (i32.eq
   (i32.and
    (local.get $radix/218)
    (i32.sub
     (local.get $radix/218)
     (i32.const 1)))
   (i32.const 0))
  (then
   (local.set $shift/219
    (i32.ctz
     (local.get $radix/218)))
   (local.set $mask/220
    (i32.sub
     (local.get $base/217)
     (i32.const 1)))
   (loop $loop:223
    (if
     (i32.gt_u
      (local.get $n/215)
      (i32.const 0))
     (then
      (local.set $offset/212
       (i32.sub
        (local.get $offset/212)
        (i32.const 1)))
      (local.set $digit/221
       (i32.and
        (local.get $n/215)
        (local.get $mask/220)))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/222)
       (i32.add
        (local.get $digit_start/214)
        (local.get $offset/212))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 6)
          (i32.const 174)
          (i32.const 36))
         (local.get $digit/221))
        (i32.const 65535)))
      (local.set $n/215
       (i32.shr_u
        (local.get $n/215)
        (local.get $shift/219)))
      (br $loop:223))
     (else)))
   (i32.const 0))
  (else
   (loop $loop:226
    (if
     (i32.gt_u
      (local.get $n/215)
      (i32.const 0))
     (then
      (local.set $offset/212
       (i32.sub
        (local.get $offset/212)
        (i32.const 1)))
      (local.set $q/224
       (i32.div_u
        (local.get $n/215)
        (local.get $base/217)))
      (local.set $digit/225
       (i32.sub
        (local.get $n/215)
        (i32.mul
         (local.get $q/224)
         (local.get $base/217))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/222)
       (i32.add
        (local.get $digit_start/214)
        (local.get $offset/212))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 6)
          (i32.const 174)
          (i32.const 36))
         (local.get $digit/225))
        (i32.const 65535)))
      (local.set $n/215
       (local.get $q/224))
      (br $loop:226))
     (else)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/209 (ref $FixedArray<UInt16>)) (param $num/205 i32) (param $digit_start/203 i32) (param $total_len/202 i32) (result i32)
 (local $byte_val/206 i32)
 (local $hi/207 i32)
 (local $lo/208 i32)
 (local $nibble/211 i32)
 (local $offset/201 i32)
 (local $n/204 i32)
 (local.set $offset/201
  (i32.sub
   (local.get $total_len/202)
   (local.get $digit_start/203)))
 (local.set $n/204
  (local.get $num/205))
 (loop $loop:210
  (if
   (i32.ge_s
    (local.get $offset/201)
    (i32.const 2))
   (then
    (local.set $offset/201
     (i32.sub
      (local.get $offset/201)
      (i32.const 2)))
    (local.set $hi/207
     (i32.div_s
      (local.tee $byte_val/206
       (i32.and
        (local.get $n/204)
        (i32.const 255)))
      (i32.const 16)))
    (local.set $lo/208
     (i32.rem_s
      (local.get $byte_val/206)
      (i32.const 16)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/209)
     (i32.add
      (local.get $digit_start/203)
      (local.get $offset/201))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 6)
        (i32.const 174)
        (i32.const 36))
       (local.get $hi/207))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/209)
     (i32.add
      (i32.add
       (local.get $digit_start/203)
       (local.get $offset/201))
      (i32.const 1))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 6)
        (i32.const 174)
        (i32.const 36))
       (local.get $lo/208))
      (i32.const 65535)))
    (local.set $n/204
     (i32.shr_u
      (local.get $n/204)
      (i32.const 8)))
    (br $loop:210))
   (else)))
 (if (result i32)
  (i32.eq
   (local.get $offset/201)
   (i32.const 1))
  (then
   (local.set $nibble/211
    (i32.and
     (local.get $n/204)
     (i32.const 15)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/209)
    (local.get $digit_start/203)
    (i32.and
     (array.get_u $moonbit.string
      (call $moonbit.string_literal
       (i32.const 6)
       (i32.const 174)
       (i32.const 36))
      (local.get $nibble/211))
     (i32.const 65535)))
   (i32.const 0))
  (else
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::write_iter.inner|Int| (param $self/186 (ref $@moonbitlang/core/builtin.Logger)) (param $iter/190 (ref $<>=>Option<Int>)) (param $prefix/187 (ref $moonbit.string)) (param $suffix/200 (ref $moonbit.string)) (param $sep/193 (ref $moonbit.string)) (param $trailing/188 i32) (result i32)
 (local $*bind/189 i64)
 (local $*Some/191 i64)
 (local $*x/192 i32)
 (local $*bind/196 i64)
 (local $*Some/197 i64)
 (local $*x/198 i32)
 (local $first/195 i32)
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_0
   (local.get $self/186)
   (local.get $prefix/187)
   (struct.get $@moonbitlang/core/builtin.Logger 0
    (local.get $self/186))))
 (if
  (local.get $trailing/188)
  (then
   (loop $loop:194
    (if
     (i64.eq
      (local.tee $*bind/189
       (call $@moonbitlang/core/builtin.Iter::next|Int|
        (local.get $iter/190)))
      (i64.const 4294967296))
     (then)
     (else
      (local.set $*x/192
       (i32.wrap_i64
        (local.tee $*Some/191
         (local.get $*bind/189))))
      (drop
       (call $@moonbitlang/core/builtin.Logger::write_object|Int|
        (local.get $self/186)
        (local.get $*x/192)))
      (drop
       (call_ref $@moonbitlang/core/builtin.Logger.method_0
        (local.get $self/186)
        (local.get $sep/193)
        (struct.get $@moonbitlang/core/builtin.Logger 0
         (local.get $self/186))))
      (br $loop:194)))))
  (else
   (local.set $first/195
    (i32.const 1))
   (loop $loop:199
    (if
     (i64.eq
      (local.tee $*bind/196
       (call $@moonbitlang/core/builtin.Iter::next|Int|
        (local.get $iter/190)))
      (i64.const 4294967296))
     (then)
     (else
      (local.set $*x/198
       (i32.wrap_i64
        (local.tee $*Some/197
         (local.get $*bind/196))))
      (if
       (local.get $first/195)
       (then
        (local.set $first/195
         (i32.const 0)))
       (else
        (drop
         (call_ref $@moonbitlang/core/builtin.Logger.method_0
          (local.get $self/186)
          (local.get $sep/193)
          (struct.get $@moonbitlang/core/builtin.Logger 0
           (local.get $self/186))))))
      (drop
       (call $@moonbitlang/core/builtin.Logger::write_object|Int|
        (local.get $self/186)
        (local.get $*x/198)))
      (br $loop:199))))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $self/186)
  (local.get $suffix/200)
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $self/186))))
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
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/183 i32) (result (ref $moonbit.string))
 (local $logger/182 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/182
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/183)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/182))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/182)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>| (param $self/181 (ref $@moonbitlang/core/builtin.Array<Int>)) (result (ref $moonbit.string))
 (local $logger/180 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/180
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int|
   (local.get $self/181)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/180))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/180)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/171 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $value/174 (ref $moonbit.string)) (param $start/175 i32) (param $len/176 i32) (result i32)
 (local $*try_err/173 (ref $moonbit.enum))
 (local $*bind/528 (ref $moonbit.enum))
 (local $tag/544 i32)
 (local.get $self/171)
 (block $outer/543 (result (ref $StringView))
  (block $join:172 (result (ref $moonbit.enum))
   (if (result (ref $StringView))
    (i32.eq
     (local.tee $tag/544
      (struct.get $moonbit.enum 0
       (local.tee $*bind/528
        (call $String::sub.inner
         (local.get $value/174)
         (local.get $start/175)
         (i64.extend_i32_s
          (i32.add
           (local.get $start/175)
           (local.get $len/176)))))))
     (i32.const 1))
    (then
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
       (local.get $*bind/528))))
    (else
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
       (local.get $*bind/528)))
     (br $join:172)))
   (br $outer/543))
  (local.set $*try_err/173)
  (unreachable))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view))
(func $String::sub (param $self/169 (ref $moonbit.string)) (param $start.opt/167 i64) (param $end/170 i64) (result (ref $moonbit.enum))
 (local $start/166 i32)
 (local $*Some/168 i64)
 (local.set $start/166
  (if (result i32)
   (i64.eq
    (local.get $start.opt/167)
    (i64.const 4294967296))
   (then
    (i32.const 0))
   (else
    (i32.wrap_i64
     (local.tee $*Some/168
      (local.get $start.opt/167))))))
 (call $String::sub.inner
  (local.get $self/169)
  (local.get $start/166)
  (local.get $end/170)))
(func $String::sub.inner (param $self/159 (ref $moonbit.string)) (param $start/165 i32) (param $end/161 i64) (result (ref $moonbit.enum))
 (local $len/158 i32)
 (local $end/160 i32)
 (local $*Some/162 i64)
 (local $*end/163 i32)
 (local $start/164 i32)
 (local $*p/447 i32)
 (local $*p/450 i32)
 (local.set $len/158
  (array.len
   (local.get $self/159)))
 (local.set $end/160
  (if (result i32)
   (i64.eq
    (local.get $end/161)
    (i64.const 4294967296))
   (then
    (local.get $len/158))
   (else
    (if (result i32)
     (i32.lt_s
      (local.tee $*end/163
       (i32.wrap_i64
        (local.tee $*Some/162
         (local.get $end/161))))
      (i32.const 0))
     (then
      (i32.add
       (local.get $len/158)
       (local.get $*end/163)))
     (else
      (local.get $*end/163))))))
 (if (result (ref $moonbit.enum))
  (if (result i32)
   (i32.ge_s
    (local.tee $start/164
     (if (result i32)
      (i32.lt_s
       (local.get $start/165)
       (i32.const 0))
      (then
       (i32.add
        (local.get $len/158)
        (local.get $start/165)))
      (else
       (local.get $start/165))))
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start/164)
      (local.get $end/160))
     (then
      (i32.le_s
       (local.get $end/160)
       (local.get $len/158)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $start/164)
      (local.get $len/158))
     (then
      (local.set $*p/447
       (array.get_u $moonbit.string
        (local.get $self/159)
        (local.get $start/164)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/447))
       (then
        (i32.le_s
         (local.get $*p/447)
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
      (local.get $end/160)
      (local.get $len/158))
     (then
      (local.set $*p/450
       (array.get_u $moonbit.string
        (local.get $self/159)
        (local.get $end/160)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/450))
       (then
        (i32.le_s
         (local.get $*p/450)
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
     (local.get $self/159)
     (local.get $start/164)
     (local.get $end/160))))
  (else
   (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
    (i32.const 0)
    (global.get $moonbit.constr/1)))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/156 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/157 (ref $moonbit.string)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/156)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/156))
    (i32.mul
     (array.len
      (local.get $str/157))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/156))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/156))
   (local.get $str/157)
   (i32.const 0)
   (array.len
    (local.get $str/157))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/156)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/156))
   (i32.mul
    (array.len
     (local.get $str/157))
    (i32.const 2))))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/148 (ref $moonbit.bytes)) (param $bytes_offset/143 i32) (param $str/150 (ref $moonbit.string)) (param $str_offset/146 i32) (param $length/144 i32) (result i32)
 (local $e1/142 i32)
 (local $e2/145 i32)
 (local $len1/147 i32)
 (local $len2/149 i32)
 (local $end_str_offset/151 i32)
 (local $i/152 i32)
 (local $j/153 i32)
 (local $c/154 i32)
 (local $*p/441 i32)
 (local $*p/444 i32)
 (local.set $e1/142
  (i32.sub
   (i32.add
    (local.get $bytes_offset/143)
    (i32.mul
     (local.get $length/144)
     (i32.const 2)))
   (i32.const 1)))
 (local.set $e2/145
  (i32.sub
   (i32.add
    (local.get $str_offset/146)
    (local.get $length/144))
   (i32.const 1)))
 (local.set $len1/147
  (array.len
   (local.get $self/148)))
 (local.set $len2/149
  (array.len
   (local.get $str/150)))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $length/144)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $bytes_offset/143)
      (i32.const 0))
     (then
      (if (result i32)
       (i32.lt_s
        (local.get $e1/142)
        (local.get $len1/147))
       (then
        (if (result i32)
         (i32.ge_s
          (local.get $str_offset/146)
          (i32.const 0))
         (then
          (i32.lt_s
           (local.get $e2/145)
           (local.get $len2/149)))
         (else
          (i32.const 0))))
       (else
        (i32.const 0))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $end_str_offset/151
    (i32.add
     (local.get $str_offset/146)
     (local.get $length/144)))
   (local.get $str_offset/146)
   (local.get $bytes_offset/143)
   (loop $loop:155 (param i32) (param i32)
    (local.set $j/153)
    (local.tee $i/152)
    (local.get $end_str_offset/151)
    (i32.lt_s)
    (if
     (then
      (local.set $c/154
       (array.get_u $moonbit.string
        (local.get $str/150)
        (local.get $i/152)))
      (array.set $moonbit.bytes
       (local.get $self/148)
       (local.get $j/153)
       (i32.and
        (local.tee $*p/441
         (i32.and
          (local.get $c/154)
          (i32.const 255)))
        (i32.const 255)))
      (array.set $moonbit.bytes
       (local.get $self/148)
       (i32.add
        (local.get $j/153)
        (i32.const 1))
       (i32.and
        (local.tee $*p/444
         (i32.shr_u
          (local.get $c/154)
          (i32.const 8)))
        (i32.const 255)))
      (i32.add
       (local.get $i/152)
       (i32.const 1))
      (i32.add
       (local.get $j/153)
       (i32.const 2))
      (br $loop:155))
     (else)))
   (i32.const 0))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/65 (ref $moonbit.string)) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
 (local $*bind/64 (ref $StringView))
 (local $*data/66 (ref $moonbit.string))
 (local $*start/67 i32)
 (local $*end/68 i32)
 (local $start_line/86 (ref $StringView))
 (local $*try_err/88 (ref $moonbit.enum))
 (local $start_column/89 (ref $StringView))
 (local $*try_err/91 (ref $moonbit.enum))
 (local $pkg/92 (ref $StringView))
 (local $*try_err/94 (ref $moonbit.enum))
 (local $filename/95 (ref $StringView))
 (local $*try_err/97 (ref $moonbit.enum))
 (local $end_line/98 (ref $StringView))
 (local $*try_err/100 (ref $moonbit.enum))
 (local $end_column/101 (ref $StringView))
 (local $*try_err/103 (ref $moonbit.enum))
 (local $join_dispatch_19/105 i32)
 (local $dispatch_19/106 i32)
 (local $next_char/110 i32)
 (local $next_char/113 i32)
 (local $next_char/115 i32)
 (local $next_char/117 i32)
 (local $next_char/119 i32)
 (local $next_char/120 i32)
 (local $next_char/122 i32)
 (local $next_char/124 i32)
 (local $next_char/126 i32)
 (local $next_char/128 i32)
 (local $next_char/130 i32)
 (local $next_char/131 i32)
 (local $next_char/133 i32)
 (local $next_char/134 i32)
 (local $next_char/137 i32)
 (local $next_char/139 i32)
 (local $next_char/140 i32)
 (local $next_char/141 i32)
 (local $*p/387 i32)
 (local $*p/390 i32)
 (local $*p/393 i32)
 (local $*p/396 i32)
 (local $*p/399 i32)
 (local $*p/402 i32)
 (local $*p/405 i32)
 (local $*p/408 i32)
 (local $*p/411 i32)
 (local $*p/414 i32)
 (local $*p/417 i32)
 (local $*p/420 i32)
 (local $*p/423 i32)
 (local $*p/426 i32)
 (local $*p/429 i32)
 (local $*p/432 i32)
 (local $*p/435 i32)
 (local $*p/438 i32)
 (local $*bind/522 (ref $moonbit.enum))
 (local $*bind/523 (ref $moonbit.enum))
 (local $*bind/524 (ref $moonbit.enum))
 (local $*bind/525 (ref $moonbit.enum))
 (local $*bind/526 (ref $moonbit.enum))
 (local $*bind/527 (ref $moonbit.enum))
 (local $tag/572 i32)
 (local $tag/574 i32)
 (local $tag/576 i32)
 (local $tag/578 i32)
 (local $tag/580 i32)
 (local $tag/582 i32)
 (local $*cursor/69 i32)
 (local $accept_state/70 i32)
 (local $match_end/71 i32)
 (local $match_tag_saver_0/72 i32)
 (local $match_tag_saver_1/73 i32)
 (local $match_tag_saver_2/74 i32)
 (local $match_tag_saver_3/75 i32)
 (local $match_tag_saver_4/76 i32)
 (local $tag_0/77 i32)
 (local $tag_1/78 i32)
 (local $tag_1_1/79 i32)
 (local $tag_1_2/80 i32)
 (local $tag_3/81 i32)
 (local $tag_2/82 i32)
 (local $tag_2_1/83 i32)
 (local $tag_4/84 i32)
 (local.set $*data/66
  (struct.get $StringView 0
   (local.tee $*bind/64
    (struct.new $StringView
     (local.get $repr/65)
     (i32.const 0)
     (array.len
      (local.get $repr/65))))))
 (local.set $*end/68
  (i32.add
   (local.tee $*start/67
    (struct.get $StringView 1
     (local.get $*bind/64)))
   (i32.sub
    (struct.get $StringView 2
     (local.get $*bind/64))
    (struct.get $StringView 1
     (local.get $*bind/64)))))
 (local.set $*cursor/69
  (local.get $*start/67))
 (local.set $accept_state/70
  (i32.const -1))
 (local.set $match_end/71
  (i32.const -1))
 (local.set $match_tag_saver_0/72
  (i32.const -1))
 (local.set $match_tag_saver_1/73
  (i32.const -1))
 (local.set $match_tag_saver_2/74
  (i32.const -1))
 (local.set $match_tag_saver_3/75
  (i32.const -1))
 (local.set $match_tag_saver_4/76
  (i32.const -1))
 (local.set $tag_0/77
  (i32.const -1))
 (local.set $tag_1/78
  (i32.const -1))
 (local.set $tag_1_1/79
  (i32.const -1))
 (local.set $tag_1_2/80
  (i32.const -1))
 (local.set $tag_3/81
  (i32.const -1))
 (local.set $tag_2/82
  (i32.const -1))
 (local.set $tag_2_1/83
  (i32.const -1))
 (local.set $tag_4/84
  (i32.const -1))
 (block $join:85
  (block $join:104 (result i32)
   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
    (i32.lt_s
     (local.get $*cursor/69)
     (local.get $*end/68))
    (then
     (local.set $*p/387
      (local.get $*cursor/69))
     (local.set $next_char/134
      (array.get_u $moonbit.string
       (local.get $*data/66)
       (local.get $*p/387)))
     (local.set $*cursor/69
      (i32.add
       (local.get $*cursor/69)
       (i32.const 1)))
     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
      (i32.lt_s
       (local.get $next_char/134)
       (i32.const 65))
      (then
       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
        (i32.lt_s
         (local.get $next_char/134)
         (i32.const 64))
        (then
         (br $join:85))
        (else
         (loop $loop:136 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
          (local.set $tag_0/77
           (local.get $*cursor/69))
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $*cursor/69)
            (local.get $*end/68))
           (then
            (block $outer/545 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (block $join:135
              (local.set $*p/390
               (local.get $*cursor/69))
              (local.set $next_char/137
               (array.get_u $moonbit.string
                (local.get $*data/66)
                (local.get $*p/390)))
              (local.set $*cursor/69
               (i32.add
                (local.get $*cursor/69)
                (i32.const 1)))
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.lt_s
                (local.get $next_char/137)
                (i32.const 55296))
               (then
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/137)
                  (i32.const 58))
                 (then
                  (br $join:135))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/137)
                    (i32.const 58))
                   (then
                    (br $join:135))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $*cursor/69)
                      (local.get $*end/68))
                     (then
                      (block $outer/546 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (block $join:138
                        (local.set $*p/393
                         (local.get $*cursor/69))
                        (local.set $next_char/139
                         (array.get_u $moonbit.string
                          (local.get $*data/66)
                          (local.get $*p/393)))
                        (local.set $*cursor/69
                         (i32.add
                          (local.get $*cursor/69)
                          (i32.const 1)))
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.lt_s
                          (local.get $next_char/139)
                          (i32.const 56319))
                         (then
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.lt_s
                            (local.get $next_char/139)
                            (i32.const 55296))
                           (then
                            (br $join:138))
                           (else
                            (i32.const 7)
                            (br $join:104))))
                         (else
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.gt_s
                            (local.get $next_char/139)
                            (i32.const 56319))
                           (then
                            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                             (i32.lt_s
                              (local.get $next_char/139)
                              (i32.const 65536))
                             (then
                              (br $join:138))
                             (else
                              (br $join:85))))
                           (else
                            (i32.const 8)
                            (br $join:104)))))
                        (br $outer/546))
                       (i32.const 0)
                       (br $join:104)))
                     (else
                      (br $join:85))))))))
               (else
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.gt_s
                  (local.get $next_char/137)
                  (i32.const 56318))
                 (then
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $next_char/137)
                    (i32.const 57344))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $*cursor/69)
                      (local.get $*end/68))
                     (then
                      (local.set $*p/396
                       (local.get $*cursor/69))
                      (local.set $next_char/140
                       (array.get_u $moonbit.string
                        (local.get $*data/66)
                        (local.get $*p/396)))
                      (local.set $*cursor/69
                       (i32.add
                        (local.get $*cursor/69)
                        (i32.const 1)))
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.lt_s
                        (local.get $next_char/140)
                        (i32.const 56320))
                       (then
                        (br $join:85))
                       (else
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.gt_s
                          (local.get $next_char/140)
                          (i32.const 57343))
                         (then
                          (br $join:85))
                         (else
                          (br $loop:136))))))
                     (else
                      (br $join:85))))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.gt_s
                      (local.get $next_char/137)
                      (i32.const 65535))
                     (then
                      (br $join:85))
                     (else
                      (br $join:135))))))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $*cursor/69)
                    (local.get $*end/68))
                   (then
                    (local.set $*p/399
                     (local.get $*cursor/69))
                    (local.set $next_char/141
                     (array.get_u $moonbit.string
                      (local.get $*data/66)
                      (local.get $*p/399)))
                    (local.set $*cursor/69
                     (i32.add
                      (local.get $*cursor/69)
                      (i32.const 1)))
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/141)
                      (i32.const 56320))
                     (then
                      (br $join:85))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/141)
                        (i32.const 65535))
                       (then
                        (br $join:85))
                       (else
                        (br $loop:136))))))
                   (else
                    (br $join:85)))))))
              (br $outer/545))
             (br $loop:136)))
           (else
            (br $join:85)))))))
      (else
       (br $join:85))))
    (else
     (br $join:85)))
   (return))
  (local.tee $join_dispatch_19/105)
  (loop $loop:109 (param i32) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
   (local.set $dispatch_19/106)
   (block $outer/547 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
    (block $join:107
     (block $outer/548 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
      (block $join:111
       (block $switch_int/559 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
        (block $switch_default/560
         (block $switch_int_1/562
          (block $switch_int_7/568
           (block $switch_int_6/567
            (block $switch_int_5/566
             (block $switch_int_4/565
              (block $switch_int_8/569
               (block $switch_int_0/561
                (block $switch_int_2/563
                 (block $switch_int_3/564
                  (local.get $dispatch_19/106)
                  (br_table
                   $switch_int_0/561
                   $switch_int_1/562
                   $switch_int_2/563
                   $switch_int_3/564
                   $switch_int_4/565
                   $switch_int_5/566
                   $switch_int_6/567
                   $switch_int_7/568
                   $switch_int_8/569
                   $switch_default/560
                   ))
                 (local.set $tag_1_2/80
                  (local.get $tag_1_1/79))
                 (local.set $tag_1_1/79
                  (local.get $tag_1/78))
                 (local.set $tag_1/78
                  (local.get $*cursor/69))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $*cursor/69)
                   (local.get $*end/68))
                  (then
                   (block $outer/549 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (block $join:112
                     (local.set $*p/402
                      (local.get $*cursor/69))
                     (local.set $next_char/113
                      (array.get_u $moonbit.string
                       (local.get $*data/66)
                       (local.get $*p/402)))
                     (local.set $*cursor/69
                      (i32.add
                       (local.get $*cursor/69)
                       (i32.const 1)))
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/113)
                       (i32.const 55296))
                      (then
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $next_char/113)
                         (i32.const 58))
                        (then
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.lt_s
                           (local.get $next_char/113)
                           (i32.const 48))
                          (then
                           (br $join:112))
                          (else
                           (local.set $tag_1/78
                            (local.get $*cursor/69))
                           (local.set $tag_2_1/83
                            (local.get $tag_2/82))
                           (local.set $tag_2/82
                            (local.get $*cursor/69))
                           (local.set $tag_3/81
                            (local.get $*cursor/69))
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.lt_s
                             (local.get $*cursor/69)
                             (local.get $*end/68))
                            (then
                             (block $outer/550 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (block $join:114
                               (local.set $*p/405
                                (local.get $*cursor/69))
                               (local.set $next_char/115
                                (array.get_u $moonbit.string
                                 (local.get $*data/66)
                                 (local.get $*p/405)))
                               (local.set $*cursor/69
                                (i32.add
                                 (local.get $*cursor/69)
                                 (i32.const 1)))
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/115)
                                 (i32.const 59))
                                (then
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.lt_s
                                   (local.get $next_char/115)
                                   (i32.const 46))
                                  (then
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.lt_s
                                     (local.get $next_char/115)
                                     (i32.const 45))
                                    (then
                                     (br $join:114))
                                    (else
                                     (br $join:107))))
                                  (else
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.gt_s
                                     (local.get $next_char/115)
                                     (i32.const 47))
                                    (then
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/115)
                                       (i32.const 58))
                                      (then
                                       (i32.const 6)
                                       (br $loop:109))
                                      (else
                                       (i32.const 3)
                                       (br $loop:109))))
                                    (else
                                     (br $join:114))))))
                                (else
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.gt_s
                                   (local.get $next_char/115)
                                   (i32.const 55295))
                                  (then
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.lt_s
                                     (local.get $next_char/115)
                                     (i32.const 57344))
                                    (then
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/115)
                                       (i32.const 56319))
                                      (then
                                       (i32.const 7)
                                       (br $loop:109))
                                      (else
                                       (i32.const 8)
                                       (br $loop:109))))
                                    (else
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.gt_s
                                       (local.get $next_char/115)
                                       (i32.const 65535))
                                      (then
                                       (br $join:85))
                                      (else
                                       (br $join:114))))))
                                  (else
                                   (br $join:114)))))
                               (br $outer/550))
                              (i32.const 0)
                              (br $loop:109)))
                            (else
                             (br $join:85))))))
                        (else
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.gt_s
                           (local.get $next_char/113)
                           (i32.const 58))
                          (then
                           (br $join:112))
                          (else
                           (i32.const 1)
                           (br $loop:109))))))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/113)
                         (i32.const 56318))
                        (then
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.lt_s
                           (local.get $next_char/113)
                           (i32.const 57344))
                          (then
                           (i32.const 8)
                           (br $loop:109))
                          (else
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.gt_s
                             (local.get $next_char/113)
                             (i32.const 65535))
                            (then
                             (br $join:85))
                            (else
                             (br $join:112))))))
                        (else
                         (i32.const 7)
                         (br $loop:109)))))
                     (br $outer/549))
                    (i32.const 0)
                    (br $loop:109)))
                  (else
                   (br $join:85)))
                 (br $switch_int/559))
                (local.set $tag_1/78
                 (local.get $*cursor/69))
                (local.set $tag_2/82
                 (local.get $*cursor/69))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $*cursor/69)
                  (local.get $*end/68))
                 (then
                  (block $outer/551 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (block $join:116
                    (local.set $*p/408
                     (local.get $*cursor/69))
                    (local.set $next_char/117
                     (array.get_u $moonbit.string
                      (local.get $*data/66)
                      (local.get $*p/408)))
                    (local.set $*cursor/69
                     (i32.add
                      (local.get $*cursor/69)
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
                          (br $loop:109))))
                       (else
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.gt_s
                          (local.get $next_char/117)
                          (i32.const 58))
                         (then
                          (br $join:116))
                         (else
                          (i32.const 3)
                          (br $loop:109))))))
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
                          (br $loop:109))
                         (else
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.gt_s
                            (local.get $next_char/117)
                            (i32.const 65535))
                           (then
                            (br $join:85))
                           (else
                            (br $join:116))))))
                       (else
                        (i32.const 7)
                        (br $loop:109)))))
                    (br $outer/551))
                   (i32.const 0)
                   (br $loop:109)))
                 (else
                  (br $join:85)))
                (br $switch_int/559))
               (local.set $tag_1/78
                (local.get $*cursor/69))
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $*cursor/69)
                 (local.get $*end/68))
                (then
                 (block $outer/552 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (block $join:118
                   (local.set $*p/411
                    (local.get $*cursor/69))
                   (local.set $next_char/119
                    (array.get_u $moonbit.string
                     (local.get $*data/66)
                     (local.get $*p/411)))
                   (local.set $*cursor/69
                    (i32.add
                     (local.get $*cursor/69)
                     (i32.const 1)))
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/119)
                     (i32.const 55296))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/119)
                       (i32.const 58))
                      (then
                       (br $join:118))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/119)
                         (i32.const 58))
                        (then
                         (br $join:118))
                        (else
                         (i32.const 1)
                         (br $loop:109))))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/119)
                       (i32.const 56318))
                      (then
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $next_char/119)
                         (i32.const 57344))
                        (then
                         (i32.const 8)
                         (br $loop:109))
                        (else
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.gt_s
                           (local.get $next_char/119)
                           (i32.const 65535))
                          (then
                           (br $join:85))
                          (else
                           (br $join:118))))))
                      (else
                       (i32.const 7)
                       (br $loop:109)))))
                   (br $outer/552))
                  (i32.const 0)
                  (br $loop:109)))
                (else
                 (br $join:85)))
               (br $switch_int/559))
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.lt_s
                (local.get $*cursor/69)
                (local.get $*end/68))
               (then
                (local.set $*p/414
                 (local.get $*cursor/69))
                (local.set $next_char/120
                 (array.get_u $moonbit.string
                  (local.get $*data/66)
                  (local.get $*p/414)))
                (local.set $*cursor/69
                 (i32.add
                  (local.get $*cursor/69)
                  (i32.const 1)))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/120)
                  (i32.const 56320))
                 (then
                  (br $join:85))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/120)
                    (i32.const 57343))
                   (then
                    (br $join:85))
                   (else
                    (i32.const 0)
                    (br $loop:109))))))
               (else
                (br $join:85)))
              (br $switch_int/559))
             (local.set $tag_1/78
              (local.get $*cursor/69))
             (local.set $tag_4/84
              (local.get $*cursor/69))
             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (i32.lt_s
               (local.get $*cursor/69)
               (local.get $*end/68))
              (then
               (block $outer/553 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (block $join:121
                 (local.set $*p/417
                  (local.get $*cursor/69))
                 (local.set $next_char/122
                  (array.get_u $moonbit.string
                   (local.get $*data/66)
                   (local.get $*p/417)))
                 (local.set $*cursor/69
                  (i32.add
                   (local.get $*cursor/69)
                   (i32.const 1)))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/122)
                   (i32.const 55296))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/122)
                     (i32.const 58))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/122)
                       (i32.const 48))
                      (then
                       (br $join:121))
                      (else
                       (i32.const 4)
                       (br $loop:109))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/122)
                       (i32.const 58))
                      (then
                       (br $join:121))
                      (else
                       (local.set $tag_1_2/80
                        (local.get $tag_1_1/79))
                       (local.set $tag_1_1/79
                        (local.get $tag_1/78))
                       (local.set $tag_1/78
                        (local.get $*cursor/69))
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $*cursor/69)
                         (local.get $*end/68))
                        (then
                         (block $outer/554 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (block $join:123
                           (local.set $*p/420
                            (local.get $*cursor/69))
                           (local.set $next_char/124
                            (array.get_u $moonbit.string
                             (local.get $*data/66)
                             (local.get $*p/420)))
                           (local.set $*cursor/69
                            (i32.add
                             (local.get $*cursor/69)
                             (i32.const 1)))
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.lt_s
                             (local.get $next_char/124)
                             (i32.const 55296))
                            (then
                             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (i32.lt_s
                               (local.get $next_char/124)
                               (i32.const 58))
                              (then
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/124)
                                 (i32.const 48))
                                (then
                                 (br $join:123))
                                (else
                                 (local.set $tag_1/78
                                  (local.get $*cursor/69))
                                 (local.set $tag_2_1/83
                                  (local.get $tag_2/82))
                                 (local.set $tag_2/82
                                  (local.get $*cursor/69))
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.lt_s
                                   (local.get $*cursor/69)
                                   (local.get $*end/68))
                                  (then
                                   (block $outer/555 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (block $join:125
                                     (local.set $*p/423
                                      (local.get $*cursor/69))
                                     (local.set $next_char/126
                                      (array.get_u $moonbit.string
                                       (local.get $*data/66)
                                       (local.get $*p/423)))
                                     (local.set $*cursor/69
                                      (i32.add
                                       (local.get $*cursor/69)
                                       (i32.const 1)))
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/126)
                                       (i32.const 55296))
                                      (then
                                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                        (i32.lt_s
                                         (local.get $next_char/126)
                                         (i32.const 58))
                                        (then
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.lt_s
                                           (local.get $next_char/126)
                                           (i32.const 48))
                                          (then
                                           (br $join:125))
                                          (else
                                           (i32.const 5)
                                           (br $loop:109))))
                                        (else
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.gt_s
                                           (local.get $next_char/126)
                                           (i32.const 58))
                                          (then
                                           (br $join:125))
                                          (else
                                           (i32.const 3)
                                           (br $loop:109))))))
                                      (else
                                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                        (i32.gt_s
                                         (local.get $next_char/126)
                                         (i32.const 56318))
                                        (then
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.lt_s
                                           (local.get $next_char/126)
                                           (i32.const 57344))
                                          (then
                                           (i32.const 8)
                                           (br $loop:109))
                                          (else
                                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                            (i32.gt_s
                                             (local.get $next_char/126)
                                             (i32.const 65535))
                                            (then
                                             (br $join:85))
                                            (else
                                             (br $join:125))))))
                                        (else
                                         (i32.const 7)
                                         (br $loop:109)))))
                                     (br $outer/555))
                                    (i32.const 0)
                                    (br $loop:109)))
                                  (else
                                   (br $join:111))))))
                              (else
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.gt_s
                                 (local.get $next_char/124)
                                 (i32.const 58))
                                (then
                                 (br $join:123))
                                (else
                                 (i32.const 1)
                                 (br $loop:109))))))
                            (else
                             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (i32.gt_s
                               (local.get $next_char/124)
                               (i32.const 56318))
                              (then
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/124)
                                 (i32.const 57344))
                                (then
                                 (i32.const 8)
                                 (br $loop:109))
                                (else
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.gt_s
                                   (local.get $next_char/124)
                                   (i32.const 65535))
                                  (then
                                   (br $join:85))
                                  (else
                                   (br $join:123))))))
                              (else
                               (i32.const 7)
                               (br $loop:109)))))
                           (br $outer/554))
                          (i32.const 0)
                          (br $loop:109)))
                        (else
                         (br $join:85))))))))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/122)
                     (i32.const 56318))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/122)
                       (i32.const 57344))
                      (then
                       (i32.const 8)
                       (br $loop:109))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/122)
                         (i32.const 65535))
                        (then
                         (br $join:85))
                        (else
                         (br $join:121))))))
                    (else
                     (i32.const 7)
                     (br $loop:109)))))
                 (br $outer/553))
                (i32.const 0)
                (br $loop:109)))
              (else
               (br $join:85)))
             (br $switch_int/559))
            (local.set $tag_1/78
             (local.get $*cursor/69))
            (local.set $tag_2/82
             (local.get $*cursor/69))
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $*cursor/69)
              (local.get $*end/68))
             (then
              (block $outer/556 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (block $join:127
                (local.set $*p/426
                 (local.get $*cursor/69))
                (local.set $next_char/128
                 (array.get_u $moonbit.string
                  (local.get $*data/66)
                  (local.get $*p/426)))
                (local.set $*cursor/69
                 (i32.add
                  (local.get $*cursor/69)
                  (i32.const 1)))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/128)
                  (i32.const 55296))
                 (then
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $next_char/128)
                    (i32.const 58))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/128)
                      (i32.const 48))
                     (then
                      (br $join:127))
                     (else
                      (i32.const 5)
                      (br $loop:109))))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.gt_s
                      (local.get $next_char/128)
                      (i32.const 58))
                     (then
                      (br $join:127))
                     (else
                      (i32.const 3)
                      (br $loop:109))))))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/128)
                    (i32.const 56318))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/128)
                      (i32.const 57344))
                     (then
                      (i32.const 8)
                      (br $loop:109))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/128)
                        (i32.const 65535))
                       (then
                        (br $join:85))
                       (else
                        (br $join:127))))))
                   (else
                    (i32.const 7)
                    (br $loop:109)))))
                (br $outer/556))
               (i32.const 0)
               (br $loop:109)))
             (else
              (br $join:111)))
            (br $switch_int/559))
           (local.set $tag_1/78
            (local.get $*cursor/69))
           (local.set $tag_2/82
            (local.get $*cursor/69))
           (local.set $tag_3/81
            (local.get $*cursor/69))
           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
            (i32.lt_s
             (local.get $*cursor/69)
             (local.get $*end/68))
            (then
             (block $outer/557 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (block $join:129
               (local.set $*p/429
                (local.get $*cursor/69))
               (local.set $next_char/130
                (array.get_u $moonbit.string
                 (local.get $*data/66)
                 (local.get $*p/429)))
               (local.set $*cursor/69
                (i32.add
                 (local.get $*cursor/69)
                 (i32.const 1)))
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $next_char/130)
                 (i32.const 59))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/130)
                   (i32.const 46))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/130)
                     (i32.const 45))
                    (then
                     (br $join:129))
                    (else
                     (br $join:107))))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/130)
                     (i32.const 47))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/130)
                       (i32.const 58))
                      (then
                       (i32.const 6)
                       (br $loop:109))
                      (else
                       (i32.const 3)
                       (br $loop:109))))
                    (else
                     (br $join:129))))))
                (else
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.gt_s
                   (local.get $next_char/130)
                   (i32.const 55295))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/130)
                     (i32.const 57344))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/130)
                       (i32.const 56319))
                      (then
                       (i32.const 7)
                       (br $loop:109))
                      (else
                       (i32.const 8)
                       (br $loop:109))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/130)
                       (i32.const 65535))
                      (then
                       (br $join:85))
                      (else
                       (br $join:129))))))
                  (else
                   (br $join:129)))))
               (br $outer/557))
              (i32.const 0)
              (br $loop:109)))
            (else
             (br $join:85)))
           (br $switch_int/559))
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $*cursor/69)
            (local.get $*end/68))
           (then
            (local.set $*p/432
             (local.get $*cursor/69))
            (local.set $next_char/131
             (array.get_u $moonbit.string
              (local.get $*data/66)
              (local.get $*p/432)))
            (local.set $*cursor/69
             (i32.add
              (local.get $*cursor/69)
              (i32.const 1)))
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $next_char/131)
              (i32.const 56320))
             (then
              (br $join:85))
             (else
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.gt_s
                (local.get $next_char/131)
                (i32.const 65535))
               (then
                (br $join:85))
               (else
                (i32.const 0)
                (br $loop:109))))))
           (else
            (br $join:85)))
          (br $switch_int/559))
         (local.set $tag_1_1/79
          (local.get $tag_1/78))
         (local.set $tag_1/78
          (local.get $*cursor/69))
         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
          (i32.lt_s
           (local.get $*cursor/69)
           (local.get $*end/68))
          (then
           (block $outer/558 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
            (block $join:132
             (local.set $*p/435
              (local.get $*cursor/69))
             (local.set $next_char/133
              (array.get_u $moonbit.string
               (local.get $*data/66)
               (local.get $*p/435)))
             (local.set $*cursor/69
              (i32.add
               (local.get $*cursor/69)
               (i32.const 1)))
             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (i32.lt_s
               (local.get $next_char/133)
               (i32.const 55296))
              (then
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $next_char/133)
                 (i32.const 58))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/133)
                   (i32.const 48))
                  (then
                   (br $join:132))
                  (else
                   (i32.const 2)
                   (br $loop:109))))
                (else
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.gt_s
                   (local.get $next_char/133)
                   (i32.const 58))
                  (then
                   (br $join:132))
                  (else
                   (i32.const 1)
                   (br $loop:109))))))
              (else
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.gt_s
                 (local.get $next_char/133)
                 (i32.const 56318))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/133)
                   (i32.const 57344))
                  (then
                   (i32.const 8)
                   (br $loop:109))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/133)
                     (i32.const 65535))
                    (then
                     (br $join:85))
                    (else
                     (br $join:132))))))
                (else
                 (i32.const 7)
                 (br $loop:109)))))
             (br $outer/558))
            (i32.const 0)
            (br $loop:109)))
          (else
           (br $join:85)))
         (br $switch_int/559))
        (br $join:85))
       (br $outer/548))
      (local.set $tag_1/78
       (local.get $tag_1_2/80))
      (local.set $tag_2/82
       (local.get $tag_2_1/83))
      (local.set $match_tag_saver_0/72
       (local.get $tag_0/77))
      (local.set $match_tag_saver_1/73
       (local.get $tag_1/78))
      (local.set $match_tag_saver_2/74
       (local.get $tag_2/82))
      (local.set $match_tag_saver_3/75
       (local.get $tag_3/81))
      (local.set $match_tag_saver_4/76
       (local.get $tag_4/84))
      (local.set $accept_state/70
       (i32.const 0))
      (local.set $match_end/71
       (local.get $*cursor/69))
      (br $join:85))
     (br $outer/547))
    (local.set $tag_1_1/79
     (local.get $tag_1_2/80))
    (local.set $tag_1/78
     (local.get $*cursor/69))
    (local.set $tag_2/82
     (local.get $tag_2_1/83))
    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
     (i32.lt_s
      (local.get $*cursor/69)
      (local.get $*end/68))
     (then
      (block $outer/570 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
       (block $join:108
        (local.set $*p/438
         (local.get $*cursor/69))
        (local.set $next_char/110
         (array.get_u $moonbit.string
          (local.get $*data/66)
          (local.get $*p/438)))
        (local.set $*cursor/69
         (i32.add
          (local.get $*cursor/69)
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
              (br $join:108))
             (else
              (i32.const 4)
              (br $loop:109))))
           (else
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.gt_s
              (local.get $next_char/110)
              (i32.const 58))
             (then
              (br $join:108))
             (else
              (i32.const 1)
              (br $loop:109))))))
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
              (br $loop:109))
             (else
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.gt_s
                (local.get $next_char/110)
                (i32.const 65535))
               (then
                (br $join:85))
               (else
                (br $join:108))))))
           (else
            (i32.const 7)
            (br $loop:109)))))
        (br $outer/570))
       (i32.const 0)
       (br $loop:109)))
     (else
      (br $join:85)))))
  (return))
 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
  (i32.eq
   (local.get $accept_state/70)
   (i32.const 0))
  (then
   (block $outer/581 (result (ref $StringView))
    (block $join:87 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/582
        (struct.get $moonbit.enum 0
         (local.tee $*bind/527
          (call $String::sub
           (local.get $*data/66)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_1/73)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_2/74))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/527))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/527)))
       (br $join:87)))
     (br $outer/581))
    (local.set $*try_err/88)
    (unreachable))
   (local.set $start_line/86)
   (block $outer/579 (result (ref $StringView))
    (block $join:90 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/580
        (struct.get $moonbit.enum 0
         (local.tee $*bind/526
          (call $String::sub
           (local.get $*data/66)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_2/74)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_3/75))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/526))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/526)))
       (br $join:90)))
     (br $outer/579))
    (local.set $*try_err/91)
    (unreachable))
   (local.set $start_column/89)
   (block $outer/577 (result (ref $StringView))
    (block $join:93 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/578
        (struct.get $moonbit.enum 0
         (local.tee $*bind/525
          (call $String::sub
           (local.get $*data/66)
           (i64.extend_i32_s
            (i32.add
             (local.get $*start/67)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_0/72))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/525))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/525)))
       (br $join:93)))
     (br $outer/577))
    (local.set $*try_err/94)
    (unreachable))
   (local.set $pkg/92)
   (block $outer/575 (result (ref $StringView))
    (block $join:96 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/576
        (struct.get $moonbit.enum 0
         (local.tee $*bind/524
          (call $String::sub
           (local.get $*data/66)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_0/72)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_1/73))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/524))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/524)))
       (br $join:96)))
     (br $outer/575))
    (local.set $*try_err/97)
    (unreachable))
   (local.set $filename/95)
   (block $outer/573 (result (ref $StringView))
    (block $join:99 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/574
        (struct.get $moonbit.enum 0
         (local.tee $*bind/523
          (call $String::sub
           (local.get $*data/66)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_3/75)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_4/76))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/523))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/523)))
       (br $join:99)))
     (br $outer/573))
    (local.set $*try_err/100)
    (unreachable))
   (local.set $end_line/98)
   (block $outer/571 (result (ref $StringView))
    (block $join:102 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/572
        (struct.get $moonbit.enum 0
         (local.tee $*bind/522
          (call $String::sub
           (local.get $*data/66)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_4/76)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_end/71))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/522))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/522)))
       (br $join:102)))
     (br $outer/571))
    (local.set $*try_err/103)
    (unreachable))
   (local.set $end_column/101)
   (struct.new $@moonbitlang/core/builtin.SourceLocRepr
    (local.get $pkg/92)
    (local.get $filename/95)
    (local.get $start_line/86)
    (local.get $start_column/89)
    (local.get $end_line/98)
    (local.get $end_column/101)))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/57 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $ch/59 i32) (result i32)
 (local $inc/58 i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/57)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/57))
    (i32.const 4))))
 (local.set $inc/58
  (call $FixedArray::set_utf16le_char
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/57))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/57))
   (local.get $ch/59)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/57)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/57))
   (local.get $inc/58)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/52 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $required/53 i32) (result i32)
 (local $current_len/51 i32)
 (local $new_data/56 (ref $moonbit.bytes))
 (local $enough_space/54 i32)
 (local.set $current_len/51
  (array.len
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/52))))
 (if
  (i32.le_s
   (local.get $required/53)
   (local.get $current_len/51))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/54
  (local.get $current_len/51))
 (loop $loop:55
  (if
   (i32.lt_s
    (local.get $enough_space/54)
    (local.get $required/53))
   (then
    (local.set $enough_space/54
     (i32.mul
      (local.get $enough_space/54)
      (i32.const 2)))
    (br $loop:55))
   (else)))
 (array.copy $moonbit.bytes $moonbit.bytes
  (local.tee $new_data/56
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $enough_space/54)))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/52))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 1
   (local.get $self/52)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 0
  (local.get $self/52)
  (local.get $new_data/56))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/46 (ref $moonbit.bytes)) (param $offset/47 i32) (param $value/45 i32) (result i32)
 (local $code/44 i32)
 (local $hi/48 i32)
 (local $lo/49 i32)
 (local $hi/50 i32)
 (local $*p/361 i32)
 (local $*p/364 i32)
 (local $*p/367 i32)
 (local $*p/370 i32)
 (local $*p/373 i32)
 (local $*p/376 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/44
    (local.get $value/45))
   (i32.const 65536))
  (then
   (array.set $moonbit.bytes
    (local.get $self/46)
    (local.get $offset/47)
    (i32.and
     (local.tee $*p/361
      (i32.and
       (local.get $code/44)
       (i32.const 255)))
     (i32.const 255)))
   (array.set $moonbit.bytes
    (local.get $self/46)
    (i32.add
     (local.get $offset/47)
     (i32.const 1))
    (i32.and
     (local.tee $*p/364
      (i32.shr_u
       (local.get $code/44)
       (i32.const 8)))
     (i32.const 255)))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/44)
     (i32.const 1114112))
    (then
     (local.set $lo/49
      (i32.or
       (i32.shr_u
        (local.tee $hi/48
         (i32.sub
          (local.get $code/44)
          (i32.const 65536)))
        (i32.const 10))
       (i32.const 55296)))
     (local.set $hi/50
      (i32.or
       (i32.and
        (local.get $hi/48)
        (i32.const 1023))
       (i32.const 56320)))
     (array.set $moonbit.bytes
      (local.get $self/46)
      (local.get $offset/47)
      (i32.and
       (local.tee $*p/367
        (i32.and
         (local.get $lo/49)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/46)
      (i32.add
       (local.get $offset/47)
       (i32.const 1))
      (i32.and
       (local.tee $*p/370
        (i32.shr_u
         (local.get $lo/49)
         (i32.const 8)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/46)
      (i32.add
       (local.get $offset/47)
       (i32.const 2))
      (i32.and
       (local.tee $*p/373
        (i32.and
         (local.get $hi/50)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/46)
      (i32.add
       (local.get $offset/47)
       (i32.const 3))
      (i32.and
       (local.tee $*p/376
        (i32.shr_u
         (local.get $hi/50)
         (i32.const 8)))
       (i32.const 255)))
     (i32.const 4))
    (else
     (call $moonbitlang/core/builtin.abort|Int|
      (call $moonbit.string_literal
       (i32.const 8)
       (i32.const 342)
       (i32.const 17))
      (call $moonbit.string_literal
       (i32.const 7)
       (i32.const 246)
       (i32.const 48))))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/41 (ref $@moonbitlang/core/builtin.StringBuilder)) (result (ref $moonbit.string))
 (call $Bytes::to_unchecked_string.inner
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/41))
  (i32.const 0)
  (i64.extend_i32_s
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/41)))))
(func $Bytes::to_unchecked_string.inner (param $self/36 (ref $moonbit.bytes)) (param $offset/40 i32) (param $length/38 i64) (result (ref $moonbit.string))
 (local $len/35 i32)
 (local $length/37 i32)
 (local $*Some/39 i64)
 (local.set $len/35
  (array.len
   (local.get $self/36)))
 (local.set $length/37
  (if (result i32)
   (i64.eq
    (local.get $length/38)
    (i64.const 4294967296))
   (then
    (i32.sub
     (local.get $len/35)
     (local.get $offset/40)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/39
      (local.get $length/38))))))
 (if (result (ref $moonbit.string))
  (if (result i32)
   (i32.ge_s
    (local.get $offset/40)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $length/37)
      (i32.const 0))
     (then
      (i32.le_s
       (i32.add
        (local.get $offset/40)
        (local.get $length/37))
       (local.get $len/35)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (call $moonbitlang/core/builtin.unsafe_sub_string
    (local.get $self/36)
    (local.get $offset/40)
    (local.get $length/37)))
  (else
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/505 (ref $moonbit.bytes)) (param $*param/506 i32) (param $*param/507 i32) (result (ref $moonbit.string))
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/505)
  (local.get $*param/506)
  (local.get $*param/507)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/33 i32) (result (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $initial/32 i32)
 (local $data/34 (ref $moonbit.bytes))
 (local.set $initial/32
  (if (result i32)
   (i32.lt_s
    (local.get $size_hint/33)
    (i32.const 1))
   (then
    (i32.const 1))
   (else
    (local.get $size_hint/33))))
 (struct.new $@moonbitlang/core/builtin.StringBuilder
  (local.tee $data/34
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $initial/32)))
  (i32.const 0)))
(func $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int| (param $dst/27 (ref $moonbit.array_i32)) (param $dst_offset/28 i32) (param $src/29 (ref $moonbit.array_i32)) (param $src_offset/30 i32) (param $len/31 i32) (result i32)
 (array.copy $moonbit.array_i32 $moonbit.array_i32
  (local.get $dst/27)
  (local.get $dst_offset/28)
  (local.get $src/29)
  (local.get $src_offset/30)
  (local.get $len/31))
 (i32.const 0))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/7 (ref $moonbit.string)) (param $loc/8 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Unit|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/7)
     (call $moonbit.string_literal
      (i32.const 10)
      (i32.const 378)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/8)))
   (call $moonbit.string_literal
    (i32.const 9)
    (i32.const 376)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/5 (ref $moonbit.string)) (param $loc/6 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/5)
     (call $moonbit.string_literal
      (i32.const 10)
      (i32.const 378)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/6)))
   (call $moonbit.string_literal
    (i32.const 9)
    (i32.const 376)
    (i32.const 1)))))
(func $@moonbitlang/core/builtin.Logger::write_object|Int| (param $self/4 (ref $@moonbitlang/core/builtin.Logger)) (param $obj/3 i32) (result i32)
 (call $@moonbitlang/core/builtin.Show::Int::output
  (local.get $obj/3)
  (local.get $self/4)))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/2 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/1 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_3) (param $*obj/521 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/520 i32) (result i32)
 (local $*self/519 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/519
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/521))))
  (local.get $*param/520)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_2) (param $*obj/518 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/517 (ref $StringView)) (result i32)
 (local $*self/516 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/516
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/518))))
  (local.get $*param/517)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (type $@moonbitlang/core/builtin.Logger.method_1) (param $*obj/515 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/512 (ref $moonbit.string)) (param $*param/513 i32) (param $*param/514 i32) (result i32)
 (local $*self/511 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/511
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/515))))
  (local.get $*param/512)
  (local.get $*param/513)
  (local.get $*param/514)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_0) (param $*obj/510 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/509 (ref $moonbit.string)) (result i32)
 (local $*self/508 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/508
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/510))))
  (local.get $*param/509)))
(func $*main*/2
 (local $arr/344 (ref $@moonbitlang/core/builtin.Array<Int>))
 (local $*len/346 i32)
 (local $*i/347 i32)
 (local $x/348 i32)
 (local $doubled/350 (ref $@moonbitlang/core/builtin.Array<Int>))
 (local $*len/351 i32)
 (local $*i/352 i32)
 (local $x/353 i32)
 (local $sum/345 i32)
 (local.set $arr/344
  (struct.new $@moonbitlang/core/builtin.Array<Int>
   (array.new_data $moonbit.array_i32 $moonbit.const_data
    (i32.const 498)
    (i32.const 5))
   (i32.const 5)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 13)
     (i32.const 466)
     (i32.const 16))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
     (local.get $arr/344)))))
 (local.set $sum/345
  (i32.const 0))
 (local.set $*len/346
  (struct.get $@moonbitlang/core/builtin.Array<Int> 1
   (local.get $arr/344)))
 (i32.const 0)
 (loop $loop:349 (param i32)
  (local.tee $*i/347)
  (local.get $*len/346)
  (i32.lt_s)
  (if
   (then
    (local.set $x/348
     (array.get $moonbit.array_i32
      (struct.get $@moonbitlang/core/builtin.Array<Int> 0
       (local.get $arr/344))
      (local.get $*i/347)))
    (local.set $sum/345
     (i32.add
      (local.get $sum/345)
      (local.get $x/348)))
    (i32.add
     (local.get $*i/347)
     (i32.const 1))
    (br $loop:349))
   (else)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 12)
     (i32.const 420)
     (i32.const 23))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
     (local.get $sum/345)))))
 (local.set $doubled/350
  (struct.new $@moonbitlang/core/builtin.Array<Int>
   (array.new_fixed $moonbit.array_i32 0)
   (i32.const 0)))
 (local.set $*len/351
  (struct.get $@moonbitlang/core/builtin.Array<Int> 1
   (local.get $arr/344)))
 (i32.const 0)
 (loop $loop:354 (param i32)
  (local.tee $*i/352)
  (local.get $*len/351)
  (i32.lt_s)
  (if
   (then
    (local.set $x/353
     (array.get $moonbit.array_i32
      (struct.get $@moonbitlang/core/builtin.Array<Int> 0
       (local.get $arr/344))
      (local.get $*i/352)))
    (drop
     (call $@moonbitlang/core/builtin.Array::push|Int|
      (local.get $doubled/350)
      (i32.mul
       (local.get $x/353)
       (i32.const 2))))
    (i32.add
     (local.get $*i/352)
     (i32.const 1))
    (br $loop:354))
   (else)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.string_literal
     (i32.const 11)
     (i32.const 390)
     (i32.const 15))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
     (local.get $doubled/350))))))
(export "_start" (func $*main*/2))