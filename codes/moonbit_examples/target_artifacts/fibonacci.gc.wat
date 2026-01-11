(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data $moonbit.const_data "0\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00r\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\008\00:\005\00-\002\009\008\00:\003\001\00C\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\0A\00\0A\00 \00 \00a\00t\00 \00 \00i\00s\00 \00F\00i\00b\00o\00n\00a\00c\00c\00i\00 \00o\00f\00 \00")
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
(global $moonbit.string_pool
 (ref $moonbit.string_pool_type)
 (i32.const 10)
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
(func $username/moonbit_examples/cmd/fibonacci.fib (param $n/288 i32) (result i32)
 (if (result i32)
  (i32.le_s
   (local.get $n/288)
   (i32.const 1))
  (then
   (local.get $n/288))
  (else
   (i32.add
    (call $username/moonbit_examples/cmd/fibonacci.fib
     (i32.sub
      (local.get $n/288)
      (i32.const 1)))
    (call $username/moonbit_examples/cmd/fibonacci.fib
     (i32.sub
      (local.get $n/288)
      (i32.const 2)))))))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/286 (ref $moonbit.string)) (param $logger/287 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (call $@moonbitlang/core/builtin.SourceLocRepr::parse
   (local.get $self/286))
  (local.get $logger/287)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/249 (ref $@moonbitlang/core/builtin.SourceLocRepr)) (param $logger/285 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (local $pkg/248 (ref $StringView))
 (local $*data/250 (ref $moonbit.string))
 (local $*start/251 i32)
 (local $*end/252 i32)
 (local $*bind/258 (ref $<StringView*Option<StringView>>))
 (local $package_name/260 (ref $StringView))
 (local $*try_err/262 (ref $moonbit.enum))
 (local $module_name/263 (ref $StringView))
 (local $*try_err/265 (ref $moonbit.enum))
 (local $next_char/268 i32)
 (local $next_char/271 i32)
 (local $next_char/274 i32)
 (local $next_char/275 i32)
 (local $next_char/276 i32)
 (local $next_char/277 i32)
 (local $next_char/278 i32)
 (local $next_char/279 i32)
 (local $next_char/280 i32)
 (local $*module_name/281 (ref $StringView))
 (local $*package_name/282 (ref null $StringView))
 (local $*Some/283 (ref null $StringView))
 (local $*pkg_name/284 (ref $StringView))
 (local $*p/405 i32)
 (local $*p/408 i32)
 (local $*p/411 i32)
 (local $*p/414 i32)
 (local $*p/417 i32)
 (local $*p/420 i32)
 (local $*p/423 i32)
 (local $*p/426 i32)
 (local $*p/429 i32)
 (local $*bind/456 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/457 (ref $@moonbitlang/core/builtin.Logger))
 (local $*bind/458 (ref $moonbit.enum))
 (local $*bind/459 (ref $moonbit.enum))
 (local $tag/465 i32)
 (local $tag/467 i32)
 (local $*cursor/253 i32)
 (local $accept_state/254 i32)
 (local $match_end/255 i32)
 (local $match_tag_saver_0/256 i32)
 (local $tag_0/257 i32)
 (local.set $*data/250
  (struct.get $StringView 0
   (local.tee $pkg/248
    (struct.get $@moonbitlang/core/builtin.SourceLocRepr 0
     (local.get $self/249)))))
 (local.set $*end/252
  (i32.add
   (local.tee $*start/251
    (struct.get $StringView 1
     (local.get $pkg/248)))
   (i32.sub
    (struct.get $StringView 2
     (local.get $pkg/248))
    (struct.get $StringView 1
     (local.get $pkg/248)))))
 (local.set $*cursor/253
  (local.get $*start/251))
 (local.set $accept_state/254
  (i32.const -1))
 (local.set $match_end/255
  (i32.const -1))
 (local.set $match_tag_saver_0/256
  (i32.const -1))
 (local.set $tag_0/257
  (i32.const -1))
 (block $outer/460 (result (ref $<StringView*Option<StringView>>))
  (block $join:259
   (loop $loop:267 (result (ref $<StringView*Option<StringView>>))
    (if (result (ref $<StringView*Option<StringView>>))
     (i32.lt_s
      (local.get $*cursor/253)
      (local.get $*end/252))
     (then
      (block $outer/461 (result (ref $<StringView*Option<StringView>>))
       (block $join:266
        (local.set $*p/405
         (local.get $*cursor/253))
        (local.set $next_char/268
         (array.get_u $moonbit.string
          (local.get $*data/250)
          (local.get $*p/405)))
        (local.set $*cursor/253
         (i32.add
          (local.get $*cursor/253)
          (i32.const 1)))
        (if (result (ref $<StringView*Option<StringView>>))
         (i32.lt_s
          (local.get $next_char/268)
          (i32.const 55296))
         (then
          (if (result (ref $<StringView*Option<StringView>>))
           (i32.lt_s
            (local.get $next_char/268)
            (i32.const 47))
           (then
            (br $join:266))
           (else
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.gt_s
              (local.get $next_char/268)
              (i32.const 47))
             (then
              (br $join:266))
             (else
              (loop $loop:270 (result (ref $<StringView*Option<StringView>>))
               (local.set $tag_0/257
                (local.get $*cursor/253))
               (if (result (ref $<StringView*Option<StringView>>))
                (i32.lt_s
                 (local.get $*cursor/253)
                 (local.get $*end/252))
                (then
                 (block $outer/462 (result (ref $<StringView*Option<StringView>>))
                  (block $join:269
                   (local.set $*p/408
                    (local.get $*cursor/253))
                   (local.set $next_char/271
                    (array.get_u $moonbit.string
                     (local.get $*data/250)
                     (local.get $*p/408)))
                   (local.set $*cursor/253
                    (i32.add
                     (local.get $*cursor/253)
                     (i32.const 1)))
                   (if (result (ref $<StringView*Option<StringView>>))
                    (i32.lt_s
                     (local.get $next_char/271)
                     (i32.const 55296))
                    (then
                     (if (result (ref $<StringView*Option<StringView>>))
                      (i32.lt_s
                       (local.get $next_char/271)
                       (i32.const 47))
                      (then
                       (br $join:269))
                      (else
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.gt_s
                         (local.get $next_char/271)
                         (i32.const 47))
                        (then
                         (br $join:269))
                        (else
                         (loop $loop:273 (result (ref $<StringView*Option<StringView>>))
                          (if (result (ref $<StringView*Option<StringView>>))
                           (i32.lt_s
                            (local.get $*cursor/253)
                            (local.get $*end/252))
                           (then
                            (block $outer/463 (result (ref $<StringView*Option<StringView>>))
                             (block $join:272
                              (local.set $*p/411
                               (local.get $*cursor/253))
                              (local.set $next_char/274
                               (array.get_u $moonbit.string
                                (local.get $*data/250)
                                (local.get $*p/411)))
                              (local.set $*cursor/253
                               (i32.add
                                (local.get $*cursor/253)
                                (i32.const 1)))
                              (if (result (ref $<StringView*Option<StringView>>))
                               (i32.lt_s
                                (local.get $next_char/274)
                                (i32.const 56319))
                               (then
                                (if (result (ref $<StringView*Option<StringView>>))
                                 (i32.lt_s
                                  (local.get $next_char/274)
                                  (i32.const 55296))
                                 (then
                                  (br $join:272))
                                 (else
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $*cursor/253)
                                    (local.get $*end/252))
                                   (then
                                    (local.set $*p/414
                                     (local.get $*cursor/253))
                                    (local.set $next_char/275
                                     (array.get_u $moonbit.string
                                      (local.get $*data/250)
                                      (local.get $*p/414)))
                                    (local.set $*cursor/253
                                     (i32.add
                                      (local.get $*cursor/253)
                                      (i32.const 1)))
                                    (if (result (ref $<StringView*Option<StringView>>))
                                     (i32.lt_s
                                      (local.get $next_char/275)
                                      (i32.const 56320))
                                     (then
                                      (br $join:259))
                                     (else
                                      (if (result (ref $<StringView*Option<StringView>>))
                                       (i32.gt_s
                                        (local.get $next_char/275)
                                        (i32.const 65535))
                                       (then
                                        (br $join:259))
                                       (else
                                        (br $loop:273))))))
                                   (else
                                    (br $join:259))))))
                               (else
                                (if (result (ref $<StringView*Option<StringView>>))
                                 (i32.gt_s
                                  (local.get $next_char/274)
                                  (i32.const 56319))
                                 (then
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $next_char/274)
                                    (i32.const 65536))
                                   (then
                                    (br $join:272))
                                   (else
                                    (br $join:259))))
                                 (else
                                  (if (result (ref $<StringView*Option<StringView>>))
                                   (i32.lt_s
                                    (local.get $*cursor/253)
                                    (local.get $*end/252))
                                   (then
                                    (local.set $*p/417
                                     (local.get $*cursor/253))
                                    (local.set $next_char/276
                                     (array.get_u $moonbit.string
                                      (local.get $*data/250)
                                      (local.get $*p/417)))
                                    (local.set $*cursor/253
                                     (i32.add
                                      (local.get $*cursor/253)
                                      (i32.const 1)))
                                    (if (result (ref $<StringView*Option<StringView>>))
                                     (i32.lt_s
                                      (local.get $next_char/276)
                                      (i32.const 56320))
                                     (then
                                      (br $join:259))
                                     (else
                                      (if (result (ref $<StringView*Option<StringView>>))
                                       (i32.gt_s
                                        (local.get $next_char/276)
                                        (i32.const 57343))
                                       (then
                                        (br $join:259))
                                       (else
                                        (br $loop:273))))))
                                   (else
                                    (br $join:259)))))))
                              (br $outer/463))
                             (br $loop:273)))
                           (else
                            (local.set $match_tag_saver_0/256
                             (local.get $tag_0/257))
                            (local.set $accept_state/254
                             (i32.const 0))
                            (local.set $match_end/255
                             (local.get $*cursor/253))
                            (br $join:259)))))))))
                    (else
                     (if (result (ref $<StringView*Option<StringView>>))
                      (i32.gt_s
                       (local.get $next_char/271)
                       (i32.const 56318))
                      (then
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.lt_s
                         (local.get $next_char/271)
                         (i32.const 57344))
                        (then
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.lt_s
                           (local.get $*cursor/253)
                           (local.get $*end/252))
                          (then
                           (local.set $*p/420
                            (local.get $*cursor/253))
                           (local.set $next_char/277
                            (array.get_u $moonbit.string
                             (local.get $*data/250)
                             (local.get $*p/420)))
                           (local.set $*cursor/253
                            (i32.add
                             (local.get $*cursor/253)
                             (i32.const 1)))
                           (if (result (ref $<StringView*Option<StringView>>))
                            (i32.lt_s
                             (local.get $next_char/277)
                             (i32.const 56320))
                            (then
                             (br $join:259))
                            (else
                             (if (result (ref $<StringView*Option<StringView>>))
                              (i32.gt_s
                               (local.get $next_char/277)
                               (i32.const 57343))
                              (then
                               (br $join:259))
                              (else
                               (br $loop:270))))))
                          (else
                           (br $join:259))))
                        (else
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.gt_s
                           (local.get $next_char/271)
                           (i32.const 65535))
                          (then
                           (br $join:259))
                          (else
                           (br $join:269))))))
                      (else
                       (if (result (ref $<StringView*Option<StringView>>))
                        (i32.lt_s
                         (local.get $*cursor/253)
                         (local.get $*end/252))
                        (then
                         (local.set $*p/423
                          (local.get $*cursor/253))
                         (local.set $next_char/278
                          (array.get_u $moonbit.string
                           (local.get $*data/250)
                           (local.get $*p/423)))
                         (local.set $*cursor/253
                          (i32.add
                           (local.get $*cursor/253)
                           (i32.const 1)))
                         (if (result (ref $<StringView*Option<StringView>>))
                          (i32.lt_s
                           (local.get $next_char/278)
                           (i32.const 56320))
                          (then
                           (br $join:259))
                          (else
                           (if (result (ref $<StringView*Option<StringView>>))
                            (i32.gt_s
                             (local.get $next_char/278)
                             (i32.const 65535))
                            (then
                             (br $join:259))
                            (else
                             (br $loop:270))))))
                        (else
                         (br $join:259)))))))
                   (br $outer/462))
                  (br $loop:270)))
                (else
                 (br $join:259)))))))))
         (else
          (if (result (ref $<StringView*Option<StringView>>))
           (i32.gt_s
            (local.get $next_char/268)
            (i32.const 56318))
           (then
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.lt_s
              (local.get $next_char/268)
              (i32.const 57344))
             (then
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.lt_s
                (local.get $*cursor/253)
                (local.get $*end/252))
               (then
                (local.set $*p/426
                 (local.get $*cursor/253))
                (local.set $next_char/279
                 (array.get_u $moonbit.string
                  (local.get $*data/250)
                  (local.get $*p/426)))
                (local.set $*cursor/253
                 (i32.add
                  (local.get $*cursor/253)
                  (i32.const 1)))
                (if (result (ref $<StringView*Option<StringView>>))
                 (i32.lt_s
                  (local.get $next_char/279)
                  (i32.const 56320))
                 (then
                  (br $join:259))
                 (else
                  (if (result (ref $<StringView*Option<StringView>>))
                   (i32.gt_s
                    (local.get $next_char/279)
                    (i32.const 57343))
                   (then
                    (br $join:259))
                   (else
                    (br $loop:267))))))
               (else
                (br $join:259))))
             (else
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.gt_s
                (local.get $next_char/268)
                (i32.const 65535))
               (then
                (br $join:259))
               (else
                (br $join:266))))))
           (else
            (if (result (ref $<StringView*Option<StringView>>))
             (i32.lt_s
              (local.get $*cursor/253)
              (local.get $*end/252))
             (then
              (local.set $*p/429
               (local.get $*cursor/253))
              (local.set $next_char/280
               (array.get_u $moonbit.string
                (local.get $*data/250)
                (local.get $*p/429)))
              (local.set $*cursor/253
               (i32.add
                (local.get $*cursor/253)
                (i32.const 1)))
              (if (result (ref $<StringView*Option<StringView>>))
               (i32.lt_s
                (local.get $next_char/280)
                (i32.const 56320))
               (then
                (br $join:259))
               (else
                (if (result (ref $<StringView*Option<StringView>>))
                 (i32.gt_s
                  (local.get $next_char/280)
                  (i32.const 65535))
                 (then
                  (br $join:259))
                 (else
                  (br $loop:267))))))
             (else
              (br $join:259)))))))
        (br $outer/461))
       (br $loop:267)))
     (else
      (br $join:259))))
   (br $outer/460))
  (if (result (ref $<StringView*Option<StringView>>))
   (i32.eq
    (local.get $accept_state/254)
    (i32.const 0))
   (then
    (block $outer/466 (result (ref $StringView))
     (block $join:261 (result (ref $moonbit.enum))
      (if (result (ref $StringView))
       (i32.eq
        (local.tee $tag/467
         (struct.get $moonbit.enum 0
          (local.tee $*bind/459
           (call $String::sub
            (local.get $*data/250)
            (i64.extend_i32_s
             (i32.add
              (local.get $match_tag_saver_0/256)
              (i32.const 1)))
            (i64.extend_i32_s
             (local.get $match_end/255))))))
        (i32.const 1))
       (then
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
          (local.get $*bind/459))))
       (else
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
          (local.get $*bind/459)))
        (br $join:261)))
      (br $outer/466))
     (local.set $*try_err/262)
     (unreachable))
    (local.set $package_name/260)
    (block $outer/464 (result (ref $StringView))
     (block $join:264 (result (ref $moonbit.enum))
      (if (result (ref $StringView))
       (i32.eq
        (local.tee $tag/465
         (struct.get $moonbit.enum 0
          (local.tee $*bind/458
           (call $String::sub
            (local.get $*data/250)
            (i64.extend_i32_s
             (local.get $*start/251))
            (i64.extend_i32_s
             (local.get $match_tag_saver_0/256))))))
        (i32.const 1))
       (then
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
          (local.get $*bind/458))))
       (else
        (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
         (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
          (local.get $*bind/458)))
        (br $join:264)))
      (br $outer/464))
     (local.set $*try_err/265)
     (unreachable))
    (local.tee $module_name/263)
    (local.get $package_name/260)
    (struct.new $<StringView*Option<StringView>>))
   (else
    (struct.new $<StringView*Option<StringView>>
     (local.get $pkg/248)
     (ref.null none)))))
 (local.tee $*bind/258)
 (struct.get $<StringView*Option<StringView>> 0)
 (local.set $*module_name/281)
 (if
  (ref.is_null
   (local.tee $*package_name/282
    (struct.get $<StringView*Option<StringView>> 1
     (local.get $*bind/258))))
  (then)
  (else
   (local.set $*pkg_name/284
    (ref.as_non_null
     (local.tee $*Some/283
      (local.get $*package_name/282))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_2
     (local.get $logger/285)
     (local.get $*pkg_name/284)
     (struct.get $@moonbitlang/core/builtin.Logger 2
      (local.get $logger/285))))
   (drop
    (call_ref $@moonbitlang/core/builtin.Logger.method_3
     (local.tee $*bind/456
      (local.get $logger/285))
     (i32.const 47)
     (struct.get $@moonbitlang/core/builtin.Logger 3
      (local.get $*bind/456))))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/285)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 1
    (local.get $self/249))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/285)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/285)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 2
    (local.get $self/249))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/285)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/285)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 3
    (local.get $self/249))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/285)
   (i32.const 45)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/285)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 4
    (local.get $self/249))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/285)
   (i32.const 58)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_2
   (local.get $logger/285)
   (struct.get $@moonbitlang/core/builtin.SourceLocRepr 5
    (local.get $self/249))
   (struct.get $@moonbitlang/core/builtin.Logger 2
    (local.get $logger/285))))
 (drop
  (call_ref $@moonbitlang/core/builtin.Logger.method_3
   (local.get $logger/285)
   (i32.const 64)
   (struct.get $@moonbitlang/core/builtin.Logger 3
    (local.get $logger/285))))
 (call_ref $@moonbitlang/core/builtin.Logger.method_2
  (local.tee $*bind/457
   (local.get $logger/285))
  (local.get $*module_name/281)
  (struct.get $@moonbitlang/core/builtin.Logger 2
   (local.get $*bind/457))))
(func $moonbitlang/core/builtin.println|String| (param $input/247 (ref $moonbit.string)) (result i32)
 (call $moonbit.println
  (local.get $input/247))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/245 i32) (param $logger/244 (ref $@moonbitlang/core/builtin.Logger)) (result i32)
 (call_ref $@moonbitlang/core/builtin.Logger.method_0
  (local.get $logger/244)
  (call $Int::to_string.inner
   (local.get $self/245)
   (i32.const 10))
  (struct.get $@moonbitlang/core/builtin.Logger 0
   (local.get $logger/244))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/242 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/243 (ref $StringView)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/242)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/242))
    (i32.mul
     (i32.sub
      (struct.get $StringView 2
       (local.get $str/243))
      (struct.get $StringView 1
       (local.get $str/243)))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/242))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/242))
   (struct.get $StringView 0
    (local.get $str/243))
   (struct.get $StringView 1
    (local.get $str/243))
   (i32.sub
    (struct.get $StringView 2
     (local.get $str/243))
    (struct.get $StringView 1
     (local.get $str/243)))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/242)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/242))
   (i32.mul
    (i32.sub
     (struct.get $StringView 2
      (local.get $str/243))
     (struct.get $StringView 1
      (local.get $str/243)))
    (i32.const 2))))
 (i32.const 0))
(func $Int::to_string.inner (param $self/226 i32) (param $radix/225 i32) (result (ref $moonbit.string))
 (local $is_negative/227 i32)
 (local $num/228 i32)
 (local $buffer/229 (ref $FixedArray<UInt16>))
 (local $digit_len/230 i32)
 (local $total_len/231 i32)
 (local $buffer/232 (ref $FixedArray<UInt16>))
 (local $digit_start/233 i32)
 (local $digit_len/234 i32)
 (local $total_len/235 i32)
 (local $buffer/236 (ref $FixedArray<UInt16>))
 (local $digit_start/237 i32)
 (local $digit_len/238 i32)
 (local $total_len/239 i32)
 (local $buffer/240 (ref $FixedArray<UInt16>))
 (local $digit_start/241 i32)
 (if
  (if (result i32)
   (i32.lt_s
    (local.get $radix/225)
    (i32.const 2))
   (then
    (i32.const 1))
   (else
    (i32.gt_s
     (local.get $radix/225)
     (i32.const 36))))
  (then
   (drop
    (call $moonbitlang/core/builtin.abort|Unit|
     (call $moonbit.string_literal
      (i32.const 2)
      (i32.const 106)
      (i32.const 30))
     (call $moonbit.string_literal
      (i32.const 1)
      (i32.const 2)
      (i32.const 52)))))
  (else))
 (if
  (i32.eq
   (local.get $self/226)
   (i32.const 0))
  (then
   (call $moonbit.string_literal
    (i32.const 0)
    (i32.const 0)
    (i32.const 1))
   (return))
  (else))
 (local.set $num/228
  (if (result i32)
   (local.tee $is_negative/227
    (i32.lt_s
     (local.get $self/226)
     (i32.const 0)))
   (then
    (i32.sub
     (i32.const 0)
     (local.get $self/226)))
   (else
    (local.get $self/226))))
 (local.set $buffer/229
  (if (result (ref $FixedArray<UInt16>))
   (i32.eq
    (local.get $radix/225)
    (i32.const 10))
   (then
    (local.set $total_len/231
     (i32.add
      (local.tee $digit_len/230
       (call $moonbitlang/core/builtin.dec_count32
        (local.get $num/228)))
      (if (result i32)
       (local.get $is_negative/227)
       (then
        (i32.const 1))
       (else
        (i32.const 0)))))
    (local.set $buffer/232
     (array.new $FixedArray<UInt16>
      (i32.const 0)
      (local.get $total_len/231)))
    (local.set $digit_start/233
     (if (result i32)
      (local.get $is_negative/227)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/232)
      (local.get $num/228)
      (local.get $digit_start/233)
      (local.get $total_len/231)))
    (local.get $buffer/232))
   (else
    (if (result (ref $FixedArray<UInt16>))
     (i32.eq
      (local.get $radix/225)
      (i32.const 16))
     (then
      (local.set $total_len/235
       (i32.add
        (local.tee $digit_len/234
         (call $moonbitlang/core/builtin.hex_count32
          (local.get $num/228)))
        (if (result i32)
         (local.get $is_negative/227)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/236
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/235)))
      (local.set $digit_start/237
       (if (result i32)
        (local.get $is_negative/227)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/236)
        (local.get $num/228)
        (local.get $digit_start/237)
        (local.get $total_len/235)))
      (local.get $buffer/236))
     (else
      (local.set $total_len/239
       (i32.add
        (local.tee $digit_len/238
         (call $moonbitlang/core/builtin.radix_count32
          (local.get $num/228)
          (local.get $radix/225)))
        (if (result i32)
         (local.get $is_negative/227)
         (then
          (i32.const 1))
         (else
          (i32.const 0)))))
      (local.set $buffer/240
       (array.new $FixedArray<UInt16>
        (i32.const 0)
        (local.get $total_len/239)))
      (local.set $digit_start/241
       (if (result i32)
        (local.get $is_negative/227)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_generic
        (local.get $buffer/240)
        (local.get $num/228)
        (local.get $digit_start/241)
        (local.get $total_len/239)
        (local.get $radix/225)))
      (local.get $buffer/240))))))
 (if
  (local.get $is_negative/227)
  (then
   (array.set $FixedArray<UInt16>
    (local.get $buffer/229)
    (i32.const 0)
    (i32.const 45)))
  (else))
 (local.get $buffer/229))
(func $moonbitlang/core/builtin.radix_count32 (param $value/219 i32) (param $radix/222 i32) (result i32)
 (local $base/221 i32)
 (local $num/220 i32)
 (local $count/223 i32)
 (if
  (i32.eq
   (local.get $value/219)
   (i32.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.set $num/220
  (local.get $value/219))
 (local.set $base/221
  (local.get $radix/222))
 (local.set $count/223
  (i32.const 0))
 (loop $loop:224
  (if
   (i32.gt_u
    (local.get $num/220)
    (i32.const 0))
   (then
    (local.set $count/223
     (i32.add
      (local.get $count/223)
      (i32.const 1)))
    (local.set $num/220
     (i32.div_u
      (local.get $num/220)
      (local.get $base/221)))
    (br $loop:224))
   (else)))
 (local.get $count/223))
(func $moonbitlang/core/builtin.hex_count32 (param $value/217 i32) (result i32)
 (local $leading_zeros/218 i32)
 (if (result i32)
  (i32.eq
   (local.get $value/217)
   (i32.const 0))
  (then
   (i32.const 1))
  (else
   (local.set $leading_zeros/218
    (i32.clz
     (local.get $value/217)))
   (i32.add
    (i32.div_s
     (i32.sub
      (i32.const 31)
      (local.get $leading_zeros/218))
     (i32.const 4))
    (i32.const 1)))))
(func $moonbitlang/core/builtin.dec_count32 (param $value/216 i32) (result i32)
 (if (result i32)
  (i32.ge_u
   (local.get $value/216)
   (i32.const 100000))
  (then
   (if (result i32)
    (i32.ge_u
     (local.get $value/216)
     (i32.const 10000000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/216)
       (i32.const 1000000000))
      (then
       (i32.const 10))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/216)
         (i32.const 100000000))
        (then
         (i32.const 9))
        (else
         (i32.const 8))))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/216)
       (i32.const 1000000))
      (then
       (i32.const 7))
      (else
       (i32.const 6))))))
  (else
   (if (result i32)
    (i32.ge_u
     (local.get $value/216)
     (i32.const 1000))
    (then
     (if (result i32)
      (i32.ge_u
       (local.get $value/216)
       (i32.const 10000))
      (then
       (i32.const 5))
      (else
       (i32.const 4))))
    (else
     (if (result i32)
      (i32.ge_u
       (local.get $value/216)
       (i32.const 100))
      (then
       (i32.const 3))
      (else
       (if (result i32)
        (i32.ge_u
         (local.get $value/216)
         (i32.const 10))
        (then
         (i32.const 2))
        (else
         (i32.const 1))))))))))
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/206 (ref $FixedArray<UInt16>)) (param $num/194 i32) (param $digit_start/197 i32) (param $total_len/196 i32) (result i32)
 (local $t/198 i32)
 (local $r/199 i32)
 (local $d1/200 i32)
 (local $d2/201 i32)
 (local $d1_hi/202 i32)
 (local $d1_lo/203 i32)
 (local $d2_hi/204 i32)
 (local $d2_lo/205 i32)
 (local $t/209 i32)
 (local $d/210 i32)
 (local $d_hi/211 i32)
 (local $d_lo/212 i32)
 (local $d_hi/214 i32)
 (local $d_lo/215 i32)
 (local $num/193 i32)
 (local $offset/195 i32)
 (local $remaining/208 i32)
 (local.set $num/193
  (local.get $num/194))
 (local.set $offset/195
  (i32.sub
   (local.get $total_len/196)
   (local.get $digit_start/197)))
 (loop $loop:207
  (if
   (i32.ge_u
    (local.get $num/193)
    (i32.const 10000))
   (then
    (local.set $t/198
     (i32.div_u
      (local.get $num/193)
      (i32.const 10000)))
    (local.set $r/199
     (i32.rem_u
      (local.get $num/193)
      (i32.const 10000)))
    (local.set $num/193
     (local.get $t/198))
    (local.set $d1/200
     (i32.div_s
      (local.get $r/199)
      (i32.const 100)))
    (local.set $d2/201
     (i32.rem_s
      (local.get $r/199)
      (i32.const 100)))
    (local.set $offset/195
     (i32.sub
      (local.get $offset/195)
      (i32.const 4)))
    (local.set $d1_hi/202
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d1/200)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d1_lo/203
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d1/200)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_hi/204
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d2/201)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d2_lo/205
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d2/201)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/206)
     (i32.add
      (local.get $digit_start/197)
      (local.get $offset/195))
     (local.get $d1_hi/202))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/206)
     (i32.add
      (i32.add
       (local.get $digit_start/197)
       (local.get $offset/195))
      (i32.const 1))
     (local.get $d1_lo/203))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/206)
     (i32.add
      (i32.add
       (local.get $digit_start/197)
       (local.get $offset/195))
      (i32.const 2))
     (local.get $d2_hi/204))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/206)
     (i32.add
      (i32.add
       (local.get $digit_start/197)
       (local.get $offset/195))
      (i32.const 3))
     (local.get $d2_lo/205))
    (br $loop:207))
   (else)))
 (local.set $remaining/208
  (local.get $num/193))
 (loop $loop:213
  (if
   (i32.ge_s
    (local.get $remaining/208)
    (i32.const 100))
   (then
    (local.set $t/209
     (i32.div_s
      (local.get $remaining/208)
      (i32.const 100)))
    (local.set $d/210
     (i32.rem_s
      (local.get $remaining/208)
      (i32.const 100)))
    (local.set $remaining/208
     (local.get $t/209))
    (local.set $offset/195
     (i32.sub
      (local.get $offset/195)
      (i32.const 2)))
    (local.set $d_hi/211
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.div_s
        (local.get $d/210)
        (i32.const 10)))
      (i32.const 65535)))
    (local.set $d_lo/212
     (i32.and
      (i32.add
       (i32.const 48)
       (i32.rem_s
        (local.get $d/210)
        (i32.const 10)))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/206)
     (i32.add
      (local.get $digit_start/197)
      (local.get $offset/195))
     (local.get $d_hi/211))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/206)
     (i32.add
      (i32.add
       (local.get $digit_start/197)
       (local.get $offset/195))
      (i32.const 1))
     (local.get $d_lo/212))
    (br $loop:213))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.get $remaining/208)
   (i32.const 10))
  (then
   (local.set $offset/195
    (i32.sub
     (local.get $offset/195)
     (i32.const 2)))
   (local.set $d_hi/214
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.div_s
       (local.get $remaining/208)
       (i32.const 10)))
     (i32.const 65535)))
   (local.set $d_lo/215
    (i32.and
     (i32.add
      (i32.const 48)
      (i32.rem_s
       (local.get $remaining/208)
       (i32.const 10)))
     (i32.const 65535)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/206)
    (i32.add
     (local.get $digit_start/197)
     (local.get $offset/195))
    (local.get $d_hi/214))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/206)
    (i32.add
     (i32.add
      (local.get $digit_start/197)
      (local.get $offset/195))
     (i32.const 1))
    (local.get $d_lo/215))
   (i32.const 0))
  (else
   (local.set $offset/195
    (i32.sub
     (local.get $offset/195)
     (i32.const 1)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/206)
    (i32.add
     (local.get $digit_start/197)
     (local.get $offset/195))
    (i32.and
     (i32.add
      (i32.const 48)
      (local.get $remaining/208))
     (i32.const 65535)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/188 (ref $FixedArray<UInt16>)) (param $num/182 i32) (param $digit_start/180 i32) (param $total_len/179 i32) (param $radix/184 i32) (result i32)
 (local $base/183 i32)
 (local $shift/185 i32)
 (local $mask/186 i32)
 (local $digit/187 i32)
 (local $q/190 i32)
 (local $digit/191 i32)
 (local $offset/178 i32)
 (local $n/181 i32)
 (local.set $offset/178
  (i32.sub
   (local.get $total_len/179)
   (local.get $digit_start/180)))
 (local.set $n/181
  (local.get $num/182))
 (local.set $base/183
  (local.get $radix/184))
 (if (result i32)
  (i32.eq
   (i32.and
    (local.get $radix/184)
    (i32.sub
     (local.get $radix/184)
     (i32.const 1)))
   (i32.const 0))
  (then
   (local.set $shift/185
    (i32.ctz
     (local.get $radix/184)))
   (local.set $mask/186
    (i32.sub
     (local.get $base/183)
     (i32.const 1)))
   (loop $loop:189
    (if
     (i32.gt_u
      (local.get $n/181)
      (i32.const 0))
     (then
      (local.set $offset/178
       (i32.sub
        (local.get $offset/178)
        (i32.const 1)))
      (local.set $digit/187
       (i32.and
        (local.get $n/181)
        (local.get $mask/186)))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/188)
       (i32.add
        (local.get $digit_start/180)
        (local.get $offset/178))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 3)
          (i32.const 166)
          (i32.const 36))
         (local.get $digit/187))
        (i32.const 65535)))
      (local.set $n/181
       (i32.shr_u
        (local.get $n/181)
        (local.get $shift/185)))
      (br $loop:189))
     (else)))
   (i32.const 0))
  (else
   (loop $loop:192
    (if
     (i32.gt_u
      (local.get $n/181)
      (i32.const 0))
     (then
      (local.set $offset/178
       (i32.sub
        (local.get $offset/178)
        (i32.const 1)))
      (local.set $q/190
       (i32.div_u
        (local.get $n/181)
        (local.get $base/183)))
      (local.set $digit/191
       (i32.sub
        (local.get $n/181)
        (i32.mul
         (local.get $q/190)
         (local.get $base/183))))
      (array.set $FixedArray<UInt16>
       (local.get $buffer/188)
       (i32.add
        (local.get $digit_start/180)
        (local.get $offset/178))
       (i32.and
        (array.get_u $moonbit.string
         (call $moonbit.string_literal
          (i32.const 3)
          (i32.const 166)
          (i32.const 36))
         (local.get $digit/191))
        (i32.const 65535)))
      (local.set $n/181
       (local.get $q/190))
      (br $loop:192))
     (else)))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/175 (ref $FixedArray<UInt16>)) (param $num/171 i32) (param $digit_start/169 i32) (param $total_len/168 i32) (result i32)
 (local $byte_val/172 i32)
 (local $hi/173 i32)
 (local $lo/174 i32)
 (local $nibble/177 i32)
 (local $offset/167 i32)
 (local $n/170 i32)
 (local.set $offset/167
  (i32.sub
   (local.get $total_len/168)
   (local.get $digit_start/169)))
 (local.set $n/170
  (local.get $num/171))
 (loop $loop:176
  (if
   (i32.ge_s
    (local.get $offset/167)
    (i32.const 2))
   (then
    (local.set $offset/167
     (i32.sub
      (local.get $offset/167)
      (i32.const 2)))
    (local.set $hi/173
     (i32.div_s
      (local.tee $byte_val/172
       (i32.and
        (local.get $n/170)
        (i32.const 255)))
      (i32.const 16)))
    (local.set $lo/174
     (i32.rem_s
      (local.get $byte_val/172)
      (i32.const 16)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/175)
     (i32.add
      (local.get $digit_start/169)
      (local.get $offset/167))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 3)
        (i32.const 166)
        (i32.const 36))
       (local.get $hi/173))
      (i32.const 65535)))
    (array.set $FixedArray<UInt16>
     (local.get $buffer/175)
     (i32.add
      (i32.add
       (local.get $digit_start/169)
       (local.get $offset/167))
      (i32.const 1))
     (i32.and
      (array.get_u $moonbit.string
       (call $moonbit.string_literal
        (i32.const 3)
        (i32.const 166)
        (i32.const 36))
       (local.get $lo/174))
      (i32.const 65535)))
    (local.set $n/170
     (i32.shr_u
      (local.get $n/170)
      (i32.const 8)))
    (br $loop:176))
   (else)))
 (if (result i32)
  (i32.eq
   (local.get $offset/167)
   (i32.const 1))
  (then
   (local.set $nibble/177
    (i32.and
     (local.get $n/170)
     (i32.const 15)))
   (array.set $FixedArray<UInt16>
    (local.get $buffer/175)
    (local.get $digit_start/169)
    (i32.and
     (array.get_u $moonbit.string
      (call $moonbit.string_literal
       (i32.const 3)
       (i32.const 166)
       (i32.const 36))
      (local.get $nibble/177))
     (i32.const 65535)))
   (i32.const 0))
  (else
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/166 (ref $moonbit.string)) (result (ref $moonbit.string))
 (local $logger/165 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/165
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/166)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/165))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/165)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/164 i32) (result (ref $moonbit.string))
 (local $logger/163 (ref $@moonbitlang/core/builtin.StringBuilder))
 (local.set $logger/163
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (i32.const 0)))
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/164)
   (struct.new $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
    (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
    (local.get $logger/163))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/163)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/154 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $value/157 (ref $moonbit.string)) (param $start/158 i32) (param $len/159 i32) (result i32)
 (local $*try_err/156 (ref $moonbit.enum))
 (local $*bind/455 (ref $moonbit.enum))
 (local $tag/469 i32)
 (local.get $self/154)
 (block $outer/468 (result (ref $StringView))
  (block $join:155 (result (ref $moonbit.enum))
   (if (result (ref $StringView))
    (i32.eq
     (local.tee $tag/469
      (struct.get $moonbit.enum 0
       (local.tee $*bind/455
        (call $String::sub.inner
         (local.get $value/157)
         (local.get $start/158)
         (i64.extend_i32_s
          (i32.add
           (local.get $start/158)
           (local.get $len/159)))))))
     (i32.const 1))
    (then
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
       (local.get $*bind/455))))
    (else
     (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
      (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
       (local.get $*bind/455)))
     (br $join:155)))
   (br $outer/468))
  (local.set $*try_err/156)
  (unreachable))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view))
(func $String::sub (param $self/152 (ref $moonbit.string)) (param $start.opt/150 i64) (param $end/153 i64) (result (ref $moonbit.enum))
 (local $start/149 i32)
 (local $*Some/151 i64)
 (local.set $start/149
  (if (result i32)
   (i64.eq
    (local.get $start.opt/150)
    (i64.const 4294967296))
   (then
    (i32.const 0))
   (else
    (i32.wrap_i64
     (local.tee $*Some/151
      (local.get $start.opt/150))))))
 (call $String::sub.inner
  (local.get $self/152)
  (local.get $start/149)
  (local.get $end/153)))
(func $String::sub.inner (param $self/142 (ref $moonbit.string)) (param $start/148 i32) (param $end/144 i64) (result (ref $moonbit.enum))
 (local $len/141 i32)
 (local $end/143 i32)
 (local $*Some/145 i64)
 (local $*end/146 i32)
 (local $start/147 i32)
 (local $*p/381 i32)
 (local $*p/384 i32)
 (local.set $len/141
  (array.len
   (local.get $self/142)))
 (local.set $end/143
  (if (result i32)
   (i64.eq
    (local.get $end/144)
    (i64.const 4294967296))
   (then
    (local.get $len/141))
   (else
    (if (result i32)
     (i32.lt_s
      (local.tee $*end/146
       (i32.wrap_i64
        (local.tee $*Some/145
         (local.get $end/144))))
      (i32.const 0))
     (then
      (i32.add
       (local.get $len/141)
       (local.get $*end/146)))
     (else
      (local.get $*end/146))))))
 (if (result (ref $moonbit.enum))
  (if (result i32)
   (i32.ge_s
    (local.tee $start/147
     (if (result i32)
      (i32.lt_s
       (local.get $start/148)
       (i32.const 0))
      (then
       (i32.add
        (local.get $len/141)
        (local.get $start/148)))
      (else
       (local.get $start/148))))
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start/147)
      (local.get $end/143))
     (then
      (i32.le_s
       (local.get $end/143)
       (local.get $len/141)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $start/147)
      (local.get $len/141))
     (then
      (local.set $*p/381
       (array.get_u $moonbit.string
        (local.get $self/142)
        (local.get $start/147)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/381))
       (then
        (i32.le_s
         (local.get $*p/381)
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
      (local.get $end/143)
      (local.get $len/141))
     (then
      (local.set $*p/384
       (array.get_u $moonbit.string
        (local.get $self/142)
        (local.get $end/143)))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/384))
       (then
        (i32.le_s
         (local.get $*p/384)
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
     (local.get $self/142)
     (local.get $start/147)
     (local.get $end/143))))
  (else
   (struct.new $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err
    (i32.const 0)
    (global.get $moonbit.constr/1)))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/139 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $str/140 (ref $moonbit.string)) (result i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/139)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/139))
    (i32.mul
     (array.len
      (local.get $str/140))
     (i32.const 2)))))
 (drop
  (call $FixedArray::blit_from_string
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/139))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/139))
   (local.get $str/140)
   (i32.const 0)
   (array.len
    (local.get $str/140))))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/139)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/139))
   (i32.mul
    (array.len
     (local.get $str/140))
    (i32.const 2))))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/131 (ref $moonbit.bytes)) (param $bytes_offset/126 i32) (param $str/133 (ref $moonbit.string)) (param $str_offset/129 i32) (param $length/127 i32) (result i32)
 (local $e1/125 i32)
 (local $e2/128 i32)
 (local $len1/130 i32)
 (local $len2/132 i32)
 (local $end_str_offset/134 i32)
 (local $i/135 i32)
 (local $j/136 i32)
 (local $c/137 i32)
 (local $*p/375 i32)
 (local $*p/378 i32)
 (local.set $e1/125
  (i32.sub
   (i32.add
    (local.get $bytes_offset/126)
    (i32.mul
     (local.get $length/127)
     (i32.const 2)))
   (i32.const 1)))
 (local.set $e2/128
  (i32.sub
   (i32.add
    (local.get $str_offset/129)
    (local.get $length/127))
   (i32.const 1)))
 (local.set $len1/130
  (array.len
   (local.get $self/131)))
 (local.set $len2/132
  (array.len
   (local.get $str/133)))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $length/127)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $bytes_offset/126)
      (i32.const 0))
     (then
      (if (result i32)
       (i32.lt_s
        (local.get $e1/125)
        (local.get $len1/130))
       (then
        (if (result i32)
         (i32.ge_s
          (local.get $str_offset/129)
          (i32.const 0))
         (then
          (i32.lt_s
           (local.get $e2/128)
           (local.get $len2/132)))
         (else
          (i32.const 0))))
       (else
        (i32.const 0))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $end_str_offset/134
    (i32.add
     (local.get $str_offset/129)
     (local.get $length/127)))
   (local.get $str_offset/129)
   (local.get $bytes_offset/126)
   (loop $loop:138 (param i32) (param i32)
    (local.set $j/136)
    (local.tee $i/135)
    (local.get $end_str_offset/134)
    (i32.lt_s)
    (if
     (then
      (local.set $c/137
       (array.get_u $moonbit.string
        (local.get $str/133)
        (local.get $i/135)))
      (array.set $moonbit.bytes
       (local.get $self/131)
       (local.get $j/136)
       (i32.and
        (local.tee $*p/375
         (i32.and
          (local.get $c/137)
          (i32.const 255)))
        (i32.const 255)))
      (array.set $moonbit.bytes
       (local.get $self/131)
       (i32.add
        (local.get $j/136)
        (i32.const 1))
       (i32.and
        (local.tee $*p/378
         (i32.shr_u
          (local.get $c/137)
          (i32.const 8)))
        (i32.const 255)))
      (i32.add
       (local.get $i/135)
       (i32.const 1))
      (i32.add
       (local.get $j/136)
       (i32.const 2))
      (br $loop:138))
     (else)))
   (i32.const 0))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/48 (ref $moonbit.string)) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
 (local $*bind/47 (ref $StringView))
 (local $*data/49 (ref $moonbit.string))
 (local $*start/50 i32)
 (local $*end/51 i32)
 (local $start_line/69 (ref $StringView))
 (local $*try_err/71 (ref $moonbit.enum))
 (local $start_column/72 (ref $StringView))
 (local $*try_err/74 (ref $moonbit.enum))
 (local $pkg/75 (ref $StringView))
 (local $*try_err/77 (ref $moonbit.enum))
 (local $filename/78 (ref $StringView))
 (local $*try_err/80 (ref $moonbit.enum))
 (local $end_line/81 (ref $StringView))
 (local $*try_err/83 (ref $moonbit.enum))
 (local $end_column/84 (ref $StringView))
 (local $*try_err/86 (ref $moonbit.enum))
 (local $join_dispatch_19/88 i32)
 (local $dispatch_19/89 i32)
 (local $next_char/93 i32)
 (local $next_char/96 i32)
 (local $next_char/98 i32)
 (local $next_char/100 i32)
 (local $next_char/102 i32)
 (local $next_char/103 i32)
 (local $next_char/105 i32)
 (local $next_char/107 i32)
 (local $next_char/109 i32)
 (local $next_char/111 i32)
 (local $next_char/113 i32)
 (local $next_char/114 i32)
 (local $next_char/116 i32)
 (local $next_char/117 i32)
 (local $next_char/120 i32)
 (local $next_char/122 i32)
 (local $next_char/123 i32)
 (local $next_char/124 i32)
 (local $*p/321 i32)
 (local $*p/324 i32)
 (local $*p/327 i32)
 (local $*p/330 i32)
 (local $*p/333 i32)
 (local $*p/336 i32)
 (local $*p/339 i32)
 (local $*p/342 i32)
 (local $*p/345 i32)
 (local $*p/348 i32)
 (local $*p/351 i32)
 (local $*p/354 i32)
 (local $*p/357 i32)
 (local $*p/360 i32)
 (local $*p/363 i32)
 (local $*p/366 i32)
 (local $*p/369 i32)
 (local $*p/372 i32)
 (local $*bind/449 (ref $moonbit.enum))
 (local $*bind/450 (ref $moonbit.enum))
 (local $*bind/451 (ref $moonbit.enum))
 (local $*bind/452 (ref $moonbit.enum))
 (local $*bind/453 (ref $moonbit.enum))
 (local $*bind/454 (ref $moonbit.enum))
 (local $tag/497 i32)
 (local $tag/499 i32)
 (local $tag/501 i32)
 (local $tag/503 i32)
 (local $tag/505 i32)
 (local $tag/507 i32)
 (local $*cursor/52 i32)
 (local $accept_state/53 i32)
 (local $match_end/54 i32)
 (local $match_tag_saver_0/55 i32)
 (local $match_tag_saver_1/56 i32)
 (local $match_tag_saver_2/57 i32)
 (local $match_tag_saver_3/58 i32)
 (local $match_tag_saver_4/59 i32)
 (local $tag_0/60 i32)
 (local $tag_1/61 i32)
 (local $tag_1_1/62 i32)
 (local $tag_1_2/63 i32)
 (local $tag_3/64 i32)
 (local $tag_2/65 i32)
 (local $tag_2_1/66 i32)
 (local $tag_4/67 i32)
 (local.set $*data/49
  (struct.get $StringView 0
   (local.tee $*bind/47
    (struct.new $StringView
     (local.get $repr/48)
     (i32.const 0)
     (array.len
      (local.get $repr/48))))))
 (local.set $*end/51
  (i32.add
   (local.tee $*start/50
    (struct.get $StringView 1
     (local.get $*bind/47)))
   (i32.sub
    (struct.get $StringView 2
     (local.get $*bind/47))
    (struct.get $StringView 1
     (local.get $*bind/47)))))
 (local.set $*cursor/52
  (local.get $*start/50))
 (local.set $accept_state/53
  (i32.const -1))
 (local.set $match_end/54
  (i32.const -1))
 (local.set $match_tag_saver_0/55
  (i32.const -1))
 (local.set $match_tag_saver_1/56
  (i32.const -1))
 (local.set $match_tag_saver_2/57
  (i32.const -1))
 (local.set $match_tag_saver_3/58
  (i32.const -1))
 (local.set $match_tag_saver_4/59
  (i32.const -1))
 (local.set $tag_0/60
  (i32.const -1))
 (local.set $tag_1/61
  (i32.const -1))
 (local.set $tag_1_1/62
  (i32.const -1))
 (local.set $tag_1_2/63
  (i32.const -1))
 (local.set $tag_3/64
  (i32.const -1))
 (local.set $tag_2/65
  (i32.const -1))
 (local.set $tag_2_1/66
  (i32.const -1))
 (local.set $tag_4/67
  (i32.const -1))
 (block $join:68
  (block $join:87 (result i32)
   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
    (i32.lt_s
     (local.get $*cursor/52)
     (local.get $*end/51))
    (then
     (local.set $*p/321
      (local.get $*cursor/52))
     (local.set $next_char/117
      (array.get_u $moonbit.string
       (local.get $*data/49)
       (local.get $*p/321)))
     (local.set $*cursor/52
      (i32.add
       (local.get $*cursor/52)
       (i32.const 1)))
     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
      (i32.lt_s
       (local.get $next_char/117)
       (i32.const 65))
      (then
       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
        (i32.lt_s
         (local.get $next_char/117)
         (i32.const 64))
        (then
         (br $join:68))
        (else
         (loop $loop:119 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
          (local.set $tag_0/60
           (local.get $*cursor/52))
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $*cursor/52)
            (local.get $*end/51))
           (then
            (block $outer/470 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (block $join:118
              (local.set $*p/324
               (local.get $*cursor/52))
              (local.set $next_char/120
               (array.get_u $moonbit.string
                (local.get $*data/49)
                (local.get $*p/324)))
              (local.set $*cursor/52
               (i32.add
                (local.get $*cursor/52)
                (i32.const 1)))
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.lt_s
                (local.get $next_char/120)
                (i32.const 55296))
               (then
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/120)
                  (i32.const 58))
                 (then
                  (br $join:118))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/120)
                    (i32.const 58))
                   (then
                    (br $join:118))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $*cursor/52)
                      (local.get $*end/51))
                     (then
                      (block $outer/471 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (block $join:121
                        (local.set $*p/327
                         (local.get $*cursor/52))
                        (local.set $next_char/122
                         (array.get_u $moonbit.string
                          (local.get $*data/49)
                          (local.get $*p/327)))
                        (local.set $*cursor/52
                         (i32.add
                          (local.get $*cursor/52)
                          (i32.const 1)))
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.lt_s
                          (local.get $next_char/122)
                          (i32.const 56319))
                         (then
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.lt_s
                            (local.get $next_char/122)
                            (i32.const 55296))
                           (then
                            (br $join:121))
                           (else
                            (i32.const 7)
                            (br $join:87))))
                         (else
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.gt_s
                            (local.get $next_char/122)
                            (i32.const 56319))
                           (then
                            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                             (i32.lt_s
                              (local.get $next_char/122)
                              (i32.const 65536))
                             (then
                              (br $join:121))
                             (else
                              (br $join:68))))
                           (else
                            (i32.const 8)
                            (br $join:87)))))
                        (br $outer/471))
                       (i32.const 0)
                       (br $join:87)))
                     (else
                      (br $join:68))))))))
               (else
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.gt_s
                  (local.get $next_char/120)
                  (i32.const 56318))
                 (then
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $next_char/120)
                    (i32.const 57344))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $*cursor/52)
                      (local.get $*end/51))
                     (then
                      (local.set $*p/330
                       (local.get $*cursor/52))
                      (local.set $next_char/123
                       (array.get_u $moonbit.string
                        (local.get $*data/49)
                        (local.get $*p/330)))
                      (local.set $*cursor/52
                       (i32.add
                        (local.get $*cursor/52)
                        (i32.const 1)))
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.lt_s
                        (local.get $next_char/123)
                        (i32.const 56320))
                       (then
                        (br $join:68))
                       (else
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.gt_s
                          (local.get $next_char/123)
                          (i32.const 57343))
                         (then
                          (br $join:68))
                         (else
                          (br $loop:119))))))
                     (else
                      (br $join:68))))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.gt_s
                      (local.get $next_char/120)
                      (i32.const 65535))
                     (then
                      (br $join:68))
                     (else
                      (br $join:118))))))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $*cursor/52)
                    (local.get $*end/51))
                   (then
                    (local.set $*p/333
                     (local.get $*cursor/52))
                    (local.set $next_char/124
                     (array.get_u $moonbit.string
                      (local.get $*data/49)
                      (local.get $*p/333)))
                    (local.set $*cursor/52
                     (i32.add
                      (local.get $*cursor/52)
                      (i32.const 1)))
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/124)
                      (i32.const 56320))
                     (then
                      (br $join:68))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/124)
                        (i32.const 65535))
                       (then
                        (br $join:68))
                       (else
                        (br $loop:119))))))
                   (else
                    (br $join:68)))))))
              (br $outer/470))
             (br $loop:119)))
           (else
            (br $join:68)))))))
      (else
       (br $join:68))))
    (else
     (br $join:68)))
   (return))
  (local.tee $join_dispatch_19/88)
  (loop $loop:92 (param i32) (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
   (local.set $dispatch_19/89)
   (block $outer/472 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
    (block $join:90
     (block $outer/473 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
      (block $join:94
       (block $switch_int/484 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
        (block $switch_default/485
         (block $switch_int_1/487
          (block $switch_int_7/493
           (block $switch_int_6/492
            (block $switch_int_5/491
             (block $switch_int_4/490
              (block $switch_int_8/494
               (block $switch_int_0/486
                (block $switch_int_2/488
                 (block $switch_int_3/489
                  (local.get $dispatch_19/89)
                  (br_table
                   $switch_int_0/486
                   $switch_int_1/487
                   $switch_int_2/488
                   $switch_int_3/489
                   $switch_int_4/490
                   $switch_int_5/491
                   $switch_int_6/492
                   $switch_int_7/493
                   $switch_int_8/494
                   $switch_default/485
                   ))
                 (local.set $tag_1_2/63
                  (local.get $tag_1_1/62))
                 (local.set $tag_1_1/62
                  (local.get $tag_1/61))
                 (local.set $tag_1/61
                  (local.get $*cursor/52))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $*cursor/52)
                   (local.get $*end/51))
                  (then
                   (block $outer/474 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (block $join:95
                     (local.set $*p/336
                      (local.get $*cursor/52))
                     (local.set $next_char/96
                      (array.get_u $moonbit.string
                       (local.get $*data/49)
                       (local.get $*p/336)))
                     (local.set $*cursor/52
                      (i32.add
                       (local.get $*cursor/52)
                       (i32.const 1)))
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/96)
                       (i32.const 55296))
                      (then
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $next_char/96)
                         (i32.const 58))
                        (then
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.lt_s
                           (local.get $next_char/96)
                           (i32.const 48))
                          (then
                           (br $join:95))
                          (else
                           (local.set $tag_1/61
                            (local.get $*cursor/52))
                           (local.set $tag_2_1/66
                            (local.get $tag_2/65))
                           (local.set $tag_2/65
                            (local.get $*cursor/52))
                           (local.set $tag_3/64
                            (local.get $*cursor/52))
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.lt_s
                             (local.get $*cursor/52)
                             (local.get $*end/51))
                            (then
                             (block $outer/475 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (block $join:97
                               (local.set $*p/339
                                (local.get $*cursor/52))
                               (local.set $next_char/98
                                (array.get_u $moonbit.string
                                 (local.get $*data/49)
                                 (local.get $*p/339)))
                               (local.set $*cursor/52
                                (i32.add
                                 (local.get $*cursor/52)
                                 (i32.const 1)))
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/98)
                                 (i32.const 59))
                                (then
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.lt_s
                                   (local.get $next_char/98)
                                   (i32.const 46))
                                  (then
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.lt_s
                                     (local.get $next_char/98)
                                     (i32.const 45))
                                    (then
                                     (br $join:97))
                                    (else
                                     (br $join:90))))
                                  (else
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.gt_s
                                     (local.get $next_char/98)
                                     (i32.const 47))
                                    (then
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/98)
                                       (i32.const 58))
                                      (then
                                       (i32.const 6)
                                       (br $loop:92))
                                      (else
                                       (i32.const 3)
                                       (br $loop:92))))
                                    (else
                                     (br $join:97))))))
                                (else
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.gt_s
                                   (local.get $next_char/98)
                                   (i32.const 55295))
                                  (then
                                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (i32.lt_s
                                     (local.get $next_char/98)
                                     (i32.const 57344))
                                    (then
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/98)
                                       (i32.const 56319))
                                      (then
                                       (i32.const 7)
                                       (br $loop:92))
                                      (else
                                       (i32.const 8)
                                       (br $loop:92))))
                                    (else
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.gt_s
                                       (local.get $next_char/98)
                                       (i32.const 65535))
                                      (then
                                       (br $join:68))
                                      (else
                                       (br $join:97))))))
                                  (else
                                   (br $join:97)))))
                               (br $outer/475))
                              (i32.const 0)
                              (br $loop:92)))
                            (else
                             (br $join:68))))))
                        (else
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.gt_s
                           (local.get $next_char/96)
                           (i32.const 58))
                          (then
                           (br $join:95))
                          (else
                           (i32.const 1)
                           (br $loop:92))))))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/96)
                         (i32.const 56318))
                        (then
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.lt_s
                           (local.get $next_char/96)
                           (i32.const 57344))
                          (then
                           (i32.const 8)
                           (br $loop:92))
                          (else
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.gt_s
                             (local.get $next_char/96)
                             (i32.const 65535))
                            (then
                             (br $join:68))
                            (else
                             (br $join:95))))))
                        (else
                         (i32.const 7)
                         (br $loop:92)))))
                     (br $outer/474))
                    (i32.const 0)
                    (br $loop:92)))
                  (else
                   (br $join:68)))
                 (br $switch_int/484))
                (local.set $tag_1/61
                 (local.get $*cursor/52))
                (local.set $tag_2/65
                 (local.get $*cursor/52))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $*cursor/52)
                  (local.get $*end/51))
                 (then
                  (block $outer/476 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (block $join:99
                    (local.set $*p/342
                     (local.get $*cursor/52))
                    (local.set $next_char/100
                     (array.get_u $moonbit.string
                      (local.get $*data/49)
                      (local.get $*p/342)))
                    (local.set $*cursor/52
                     (i32.add
                      (local.get $*cursor/52)
                      (i32.const 1)))
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/100)
                      (i32.const 55296))
                     (then
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.lt_s
                        (local.get $next_char/100)
                        (i32.const 58))
                       (then
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.lt_s
                          (local.get $next_char/100)
                          (i32.const 48))
                         (then
                          (br $join:99))
                         (else
                          (i32.const 2)
                          (br $loop:92))))
                       (else
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.gt_s
                          (local.get $next_char/100)
                          (i32.const 58))
                         (then
                          (br $join:99))
                         (else
                          (i32.const 3)
                          (br $loop:92))))))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/100)
                        (i32.const 56318))
                       (then
                        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                         (i32.lt_s
                          (local.get $next_char/100)
                          (i32.const 57344))
                         (then
                          (i32.const 8)
                          (br $loop:92))
                         (else
                          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                           (i32.gt_s
                            (local.get $next_char/100)
                            (i32.const 65535))
                           (then
                            (br $join:68))
                           (else
                            (br $join:99))))))
                       (else
                        (i32.const 7)
                        (br $loop:92)))))
                    (br $outer/476))
                   (i32.const 0)
                   (br $loop:92)))
                 (else
                  (br $join:68)))
                (br $switch_int/484))
               (local.set $tag_1/61
                (local.get $*cursor/52))
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $*cursor/52)
                 (local.get $*end/51))
                (then
                 (block $outer/477 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (block $join:101
                   (local.set $*p/345
                    (local.get $*cursor/52))
                   (local.set $next_char/102
                    (array.get_u $moonbit.string
                     (local.get $*data/49)
                     (local.get $*p/345)))
                   (local.set $*cursor/52
                    (i32.add
                     (local.get $*cursor/52)
                     (i32.const 1)))
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/102)
                     (i32.const 55296))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/102)
                       (i32.const 58))
                      (then
                       (br $join:101))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/102)
                         (i32.const 58))
                        (then
                         (br $join:101))
                        (else
                         (i32.const 1)
                         (br $loop:92))))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/102)
                       (i32.const 56318))
                      (then
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $next_char/102)
                         (i32.const 57344))
                        (then
                         (i32.const 8)
                         (br $loop:92))
                        (else
                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (i32.gt_s
                           (local.get $next_char/102)
                           (i32.const 65535))
                          (then
                           (br $join:68))
                          (else
                           (br $join:101))))))
                      (else
                       (i32.const 7)
                       (br $loop:92)))))
                   (br $outer/477))
                  (i32.const 0)
                  (br $loop:92)))
                (else
                 (br $join:68)))
               (br $switch_int/484))
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.lt_s
                (local.get $*cursor/52)
                (local.get $*end/51))
               (then
                (local.set $*p/348
                 (local.get $*cursor/52))
                (local.set $next_char/103
                 (array.get_u $moonbit.string
                  (local.get $*data/49)
                  (local.get $*p/348)))
                (local.set $*cursor/52
                 (i32.add
                  (local.get $*cursor/52)
                  (i32.const 1)))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/103)
                  (i32.const 56320))
                 (then
                  (br $join:68))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/103)
                    (i32.const 57343))
                   (then
                    (br $join:68))
                   (else
                    (i32.const 0)
                    (br $loop:92))))))
               (else
                (br $join:68)))
              (br $switch_int/484))
             (local.set $tag_1/61
              (local.get $*cursor/52))
             (local.set $tag_4/67
              (local.get $*cursor/52))
             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (i32.lt_s
               (local.get $*cursor/52)
               (local.get $*end/51))
              (then
               (block $outer/478 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (block $join:104
                 (local.set $*p/351
                  (local.get $*cursor/52))
                 (local.set $next_char/105
                  (array.get_u $moonbit.string
                   (local.get $*data/49)
                   (local.get $*p/351)))
                 (local.set $*cursor/52
                  (i32.add
                   (local.get $*cursor/52)
                   (i32.const 1)))
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/105)
                   (i32.const 55296))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/105)
                     (i32.const 58))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/105)
                       (i32.const 48))
                      (then
                       (br $join:104))
                      (else
                       (i32.const 4)
                       (br $loop:92))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/105)
                       (i32.const 58))
                      (then
                       (br $join:104))
                      (else
                       (local.set $tag_1_2/63
                        (local.get $tag_1_1/62))
                       (local.set $tag_1_1/62
                        (local.get $tag_1/61))
                       (local.set $tag_1/61
                        (local.get $*cursor/52))
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.lt_s
                         (local.get $*cursor/52)
                         (local.get $*end/51))
                        (then
                         (block $outer/479 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                          (block $join:106
                           (local.set $*p/354
                            (local.get $*cursor/52))
                           (local.set $next_char/107
                            (array.get_u $moonbit.string
                             (local.get $*data/49)
                             (local.get $*p/354)))
                           (local.set $*cursor/52
                            (i32.add
                             (local.get $*cursor/52)
                             (i32.const 1)))
                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                            (i32.lt_s
                             (local.get $next_char/107)
                             (i32.const 55296))
                            (then
                             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (i32.lt_s
                               (local.get $next_char/107)
                               (i32.const 58))
                              (then
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/107)
                                 (i32.const 48))
                                (then
                                 (br $join:106))
                                (else
                                 (local.set $tag_1/61
                                  (local.get $*cursor/52))
                                 (local.set $tag_2_1/66
                                  (local.get $tag_2/65))
                                 (local.set $tag_2/65
                                  (local.get $*cursor/52))
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.lt_s
                                   (local.get $*cursor/52)
                                   (local.get $*end/51))
                                  (then
                                   (block $outer/480 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                    (block $join:108
                                     (local.set $*p/357
                                      (local.get $*cursor/52))
                                     (local.set $next_char/109
                                      (array.get_u $moonbit.string
                                       (local.get $*data/49)
                                       (local.get $*p/357)))
                                     (local.set $*cursor/52
                                      (i32.add
                                       (local.get $*cursor/52)
                                       (i32.const 1)))
                                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                      (i32.lt_s
                                       (local.get $next_char/109)
                                       (i32.const 55296))
                                      (then
                                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                        (i32.lt_s
                                         (local.get $next_char/109)
                                         (i32.const 58))
                                        (then
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.lt_s
                                           (local.get $next_char/109)
                                           (i32.const 48))
                                          (then
                                           (br $join:108))
                                          (else
                                           (i32.const 5)
                                           (br $loop:92))))
                                        (else
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.gt_s
                                           (local.get $next_char/109)
                                           (i32.const 58))
                                          (then
                                           (br $join:108))
                                          (else
                                           (i32.const 3)
                                           (br $loop:92))))))
                                      (else
                                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                        (i32.gt_s
                                         (local.get $next_char/109)
                                         (i32.const 56318))
                                        (then
                                         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                          (i32.lt_s
                                           (local.get $next_char/109)
                                           (i32.const 57344))
                                          (then
                                           (i32.const 8)
                                           (br $loop:92))
                                          (else
                                           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                            (i32.gt_s
                                             (local.get $next_char/109)
                                             (i32.const 65535))
                                            (then
                                             (br $join:68))
                                            (else
                                             (br $join:108))))))
                                        (else
                                         (i32.const 7)
                                         (br $loop:92)))))
                                     (br $outer/480))
                                    (i32.const 0)
                                    (br $loop:92)))
                                  (else
                                   (br $join:94))))))
                              (else
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.gt_s
                                 (local.get $next_char/107)
                                 (i32.const 58))
                                (then
                                 (br $join:106))
                                (else
                                 (i32.const 1)
                                 (br $loop:92))))))
                            (else
                             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                              (i32.gt_s
                               (local.get $next_char/107)
                               (i32.const 56318))
                              (then
                               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                (i32.lt_s
                                 (local.get $next_char/107)
                                 (i32.const 57344))
                                (then
                                 (i32.const 8)
                                 (br $loop:92))
                                (else
                                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                                  (i32.gt_s
                                   (local.get $next_char/107)
                                   (i32.const 65535))
                                  (then
                                   (br $join:68))
                                  (else
                                   (br $join:106))))))
                              (else
                               (i32.const 7)
                               (br $loop:92)))))
                           (br $outer/479))
                          (i32.const 0)
                          (br $loop:92)))
                        (else
                         (br $join:68))))))))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/105)
                     (i32.const 56318))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/105)
                       (i32.const 57344))
                      (then
                       (i32.const 8)
                       (br $loop:92))
                      (else
                       (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                        (i32.gt_s
                         (local.get $next_char/105)
                         (i32.const 65535))
                        (then
                         (br $join:68))
                        (else
                         (br $join:104))))))
                    (else
                     (i32.const 7)
                     (br $loop:92)))))
                 (br $outer/478))
                (i32.const 0)
                (br $loop:92)))
              (else
               (br $join:68)))
             (br $switch_int/484))
            (local.set $tag_1/61
             (local.get $*cursor/52))
            (local.set $tag_2/65
             (local.get $*cursor/52))
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $*cursor/52)
              (local.get $*end/51))
             (then
              (block $outer/481 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (block $join:110
                (local.set $*p/360
                 (local.get $*cursor/52))
                (local.set $next_char/111
                 (array.get_u $moonbit.string
                  (local.get $*data/49)
                  (local.get $*p/360)))
                (local.set $*cursor/52
                 (i32.add
                  (local.get $*cursor/52)
                  (i32.const 1)))
                (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                 (i32.lt_s
                  (local.get $next_char/111)
                  (i32.const 55296))
                 (then
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.lt_s
                    (local.get $next_char/111)
                    (i32.const 58))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/111)
                      (i32.const 48))
                     (then
                      (br $join:110))
                     (else
                      (i32.const 5)
                      (br $loop:92))))
                   (else
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.gt_s
                      (local.get $next_char/111)
                      (i32.const 58))
                     (then
                      (br $join:110))
                     (else
                      (i32.const 3)
                      (br $loop:92))))))
                 (else
                  (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                   (i32.gt_s
                    (local.get $next_char/111)
                    (i32.const 56318))
                   (then
                    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                     (i32.lt_s
                      (local.get $next_char/111)
                      (i32.const 57344))
                     (then
                      (i32.const 8)
                      (br $loop:92))
                     (else
                      (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                       (i32.gt_s
                        (local.get $next_char/111)
                        (i32.const 65535))
                       (then
                        (br $join:68))
                       (else
                        (br $join:110))))))
                   (else
                    (i32.const 7)
                    (br $loop:92)))))
                (br $outer/481))
               (i32.const 0)
               (br $loop:92)))
             (else
              (br $join:94)))
            (br $switch_int/484))
           (local.set $tag_1/61
            (local.get $*cursor/52))
           (local.set $tag_2/65
            (local.get $*cursor/52))
           (local.set $tag_3/64
            (local.get $*cursor/52))
           (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
            (i32.lt_s
             (local.get $*cursor/52)
             (local.get $*end/51))
            (then
             (block $outer/482 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (block $join:112
               (local.set $*p/363
                (local.get $*cursor/52))
               (local.set $next_char/113
                (array.get_u $moonbit.string
                 (local.get $*data/49)
                 (local.get $*p/363)))
               (local.set $*cursor/52
                (i32.add
                 (local.get $*cursor/52)
                 (i32.const 1)))
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $next_char/113)
                 (i32.const 59))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/113)
                   (i32.const 46))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/113)
                     (i32.const 45))
                    (then
                     (br $join:112))
                    (else
                     (br $join:90))))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/113)
                     (i32.const 47))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/113)
                       (i32.const 58))
                      (then
                       (i32.const 6)
                       (br $loop:92))
                      (else
                       (i32.const 3)
                       (br $loop:92))))
                    (else
                     (br $join:112))))))
                (else
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.gt_s
                   (local.get $next_char/113)
                   (i32.const 55295))
                  (then
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.lt_s
                     (local.get $next_char/113)
                     (i32.const 57344))
                    (then
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.lt_s
                       (local.get $next_char/113)
                       (i32.const 56319))
                      (then
                       (i32.const 7)
                       (br $loop:92))
                      (else
                       (i32.const 8)
                       (br $loop:92))))
                    (else
                     (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                      (i32.gt_s
                       (local.get $next_char/113)
                       (i32.const 65535))
                      (then
                       (br $join:68))
                      (else
                       (br $join:112))))))
                  (else
                   (br $join:112)))))
               (br $outer/482))
              (i32.const 0)
              (br $loop:92)))
            (else
             (br $join:68)))
           (br $switch_int/484))
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $*cursor/52)
            (local.get $*end/51))
           (then
            (local.set $*p/366
             (local.get $*cursor/52))
            (local.set $next_char/114
             (array.get_u $moonbit.string
              (local.get $*data/49)
              (local.get $*p/366)))
            (local.set $*cursor/52
             (i32.add
              (local.get $*cursor/52)
              (i32.const 1)))
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $next_char/114)
              (i32.const 56320))
             (then
              (br $join:68))
             (else
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.gt_s
                (local.get $next_char/114)
                (i32.const 65535))
               (then
                (br $join:68))
               (else
                (i32.const 0)
                (br $loop:92))))))
           (else
            (br $join:68)))
          (br $switch_int/484))
         (local.set $tag_1_1/62
          (local.get $tag_1/61))
         (local.set $tag_1/61
          (local.get $*cursor/52))
         (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
          (i32.lt_s
           (local.get $*cursor/52)
           (local.get $*end/51))
          (then
           (block $outer/483 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
            (block $join:115
             (local.set $*p/369
              (local.get $*cursor/52))
             (local.set $next_char/116
              (array.get_u $moonbit.string
               (local.get $*data/49)
               (local.get $*p/369)))
             (local.set $*cursor/52
              (i32.add
               (local.get $*cursor/52)
               (i32.const 1)))
             (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
              (i32.lt_s
               (local.get $next_char/116)
               (i32.const 55296))
              (then
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.lt_s
                 (local.get $next_char/116)
                 (i32.const 58))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/116)
                   (i32.const 48))
                  (then
                   (br $join:115))
                  (else
                   (i32.const 2)
                   (br $loop:92))))
                (else
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.gt_s
                   (local.get $next_char/116)
                   (i32.const 58))
                  (then
                   (br $join:115))
                  (else
                   (i32.const 1)
                   (br $loop:92))))))
              (else
               (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                (i32.gt_s
                 (local.get $next_char/116)
                 (i32.const 56318))
                (then
                 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                  (i32.lt_s
                   (local.get $next_char/116)
                   (i32.const 57344))
                  (then
                   (i32.const 8)
                   (br $loop:92))
                  (else
                   (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
                    (i32.gt_s
                     (local.get $next_char/116)
                     (i32.const 65535))
                    (then
                     (br $join:68))
                    (else
                     (br $join:115))))))
                (else
                 (i32.const 7)
                 (br $loop:92)))))
             (br $outer/483))
            (i32.const 0)
            (br $loop:92)))
          (else
           (br $join:68)))
         (br $switch_int/484))
        (br $join:68))
       (br $outer/473))
      (local.set $tag_1/61
       (local.get $tag_1_2/63))
      (local.set $tag_2/65
       (local.get $tag_2_1/66))
      (local.set $match_tag_saver_0/55
       (local.get $tag_0/60))
      (local.set $match_tag_saver_1/56
       (local.get $tag_1/61))
      (local.set $match_tag_saver_2/57
       (local.get $tag_2/65))
      (local.set $match_tag_saver_3/58
       (local.get $tag_3/64))
      (local.set $match_tag_saver_4/59
       (local.get $tag_4/67))
      (local.set $accept_state/53
       (i32.const 0))
      (local.set $match_end/54
       (local.get $*cursor/52))
      (br $join:68))
     (br $outer/472))
    (local.set $tag_1_1/62
     (local.get $tag_1_2/63))
    (local.set $tag_1/61
     (local.get $*cursor/52))
    (local.set $tag_2/65
     (local.get $tag_2_1/66))
    (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
     (i32.lt_s
      (local.get $*cursor/52)
      (local.get $*end/51))
     (then
      (block $outer/495 (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
       (block $join:91
        (local.set $*p/372
         (local.get $*cursor/52))
        (local.set $next_char/93
         (array.get_u $moonbit.string
          (local.get $*data/49)
          (local.get $*p/372)))
        (local.set $*cursor/52
         (i32.add
          (local.get $*cursor/52)
          (i32.const 1)))
        (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
         (i32.lt_s
          (local.get $next_char/93)
          (i32.const 55296))
         (then
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.lt_s
            (local.get $next_char/93)
            (i32.const 58))
           (then
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $next_char/93)
              (i32.const 48))
             (then
              (br $join:91))
             (else
              (i32.const 4)
              (br $loop:92))))
           (else
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.gt_s
              (local.get $next_char/93)
              (i32.const 58))
             (then
              (br $join:91))
             (else
              (i32.const 1)
              (br $loop:92))))))
         (else
          (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
           (i32.gt_s
            (local.get $next_char/93)
            (i32.const 56318))
           (then
            (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
             (i32.lt_s
              (local.get $next_char/93)
              (i32.const 57344))
             (then
              (i32.const 8)
              (br $loop:92))
             (else
              (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
               (i32.gt_s
                (local.get $next_char/93)
                (i32.const 65535))
               (then
                (br $join:68))
               (else
                (br $join:91))))))
           (else
            (i32.const 7)
            (br $loop:92)))))
        (br $outer/495))
       (i32.const 0)
       (br $loop:92)))
     (else
      (br $join:68)))))
  (return))
 (if (result (ref $@moonbitlang/core/builtin.SourceLocRepr))
  (i32.eq
   (local.get $accept_state/53)
   (i32.const 0))
  (then
   (block $outer/506 (result (ref $StringView))
    (block $join:70 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/507
        (struct.get $moonbit.enum 0
         (local.tee $*bind/454
          (call $String::sub
           (local.get $*data/49)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_1/56)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_2/57))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/454))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/454)))
       (br $join:70)))
     (br $outer/506))
    (local.set $*try_err/71)
    (unreachable))
   (local.set $start_line/69)
   (block $outer/504 (result (ref $StringView))
    (block $join:73 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/505
        (struct.get $moonbit.enum 0
         (local.tee $*bind/453
          (call $String::sub
           (local.get $*data/49)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_2/57)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_3/58))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/453))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/453)))
       (br $join:73)))
     (br $outer/504))
    (local.set $*try_err/74)
    (unreachable))
   (local.set $start_column/72)
   (block $outer/502 (result (ref $StringView))
    (block $join:76 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/503
        (struct.get $moonbit.enum 0
         (local.tee $*bind/452
          (call $String::sub
           (local.get $*data/49)
           (i64.extend_i32_s
            (i32.add
             (local.get $*start/50)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_0/55))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/452))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/452)))
       (br $join:76)))
     (br $outer/502))
    (local.set $*try_err/77)
    (unreachable))
   (local.set $pkg/75)
   (block $outer/500 (result (ref $StringView))
    (block $join:79 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/501
        (struct.get $moonbit.enum 0
         (local.tee $*bind/451
          (call $String::sub
           (local.get $*data/49)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_0/55)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_1/56))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/451))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/451)))
       (br $join:79)))
     (br $outer/500))
    (local.set $*try_err/80)
    (unreachable))
   (local.set $filename/78)
   (block $outer/498 (result (ref $StringView))
    (block $join:82 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/499
        (struct.get $moonbit.enum 0
         (local.tee $*bind/450
          (call $String::sub
           (local.get $*data/49)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_3/58)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_tag_saver_4/59))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/450))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/450)))
       (br $join:82)))
     (br $outer/498))
    (local.set $*try_err/83)
    (unreachable))
   (local.set $end_line/81)
   (block $outer/496 (result (ref $StringView))
    (block $join:85 (result (ref $moonbit.enum))
     (if (result (ref $StringView))
      (i32.eq
       (local.tee $tag/497
        (struct.get $moonbit.enum 0
         (local.tee $*bind/449
          (call $String::sub
           (local.get $*data/49)
           (i64.extend_i32_s
            (i32.add
             (local.get $match_tag_saver_4/59)
             (i32.const 1)))
           (i64.extend_i32_s
            (local.get $match_end/54))))))
       (i32.const 1))
      (then
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Ok)
         (local.get $*bind/449))))
      (else
       (struct.get $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err 1
        (ref.cast (ref $Result<StringView*@moonbitlang/core/builtin.CreatingViewError>.Err)
         (local.get $*bind/449)))
       (br $join:85)))
     (br $outer/496))
    (local.set $*try_err/86)
    (unreachable))
   (local.set $end_column/84)
   (struct.new $@moonbitlang/core/builtin.SourceLocRepr
    (local.get $pkg/75)
    (local.get $filename/78)
    (local.get $start_line/69)
    (local.get $start_column/72)
    (local.get $end_line/81)
    (local.get $end_column/84)))
  (else
   (unreachable))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/41 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $ch/43 i32) (result i32)
 (local $inc/42 i32)
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/41)
   (i32.add
    (struct.get $@moonbitlang/core/builtin.StringBuilder 1
     (local.get $self/41))
    (i32.const 4))))
 (local.set $inc/42
  (call $FixedArray::set_utf16le_char
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/41))
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/41))
   (local.get $ch/43)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 1
  (local.get $self/41)
  (i32.add
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/41))
   (local.get $inc/42)))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/36 (ref $@moonbitlang/core/builtin.StringBuilder)) (param $required/37 i32) (result i32)
 (local $current_len/35 i32)
 (local $new_data/40 (ref $moonbit.bytes))
 (local $enough_space/38 i32)
 (local.set $current_len/35
  (array.len
   (struct.get $@moonbitlang/core/builtin.StringBuilder 0
    (local.get $self/36))))
 (if
  (i32.le_s
   (local.get $required/37)
   (local.get $current_len/35))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/38
  (local.get $current_len/35))
 (loop $loop:39
  (if
   (i32.lt_s
    (local.get $enough_space/38)
    (local.get $required/37))
   (then
    (local.set $enough_space/38
     (i32.mul
      (local.get $enough_space/38)
      (i32.const 2)))
    (br $loop:39))
   (else)))
 (array.copy $moonbit.bytes $moonbit.bytes
  (local.tee $new_data/40
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $enough_space/38)))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/36))
  (i32.const 0)
  (struct.get $@moonbitlang/core/builtin.StringBuilder 1
   (local.get $self/36)))
 (struct.set $@moonbitlang/core/builtin.StringBuilder 0
  (local.get $self/36)
  (local.get $new_data/40))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/30 (ref $moonbit.bytes)) (param $offset/31 i32) (param $value/29 i32) (result i32)
 (local $code/28 i32)
 (local $hi/32 i32)
 (local $lo/33 i32)
 (local $hi/34 i32)
 (local $*p/295 i32)
 (local $*p/298 i32)
 (local $*p/301 i32)
 (local $*p/304 i32)
 (local $*p/307 i32)
 (local $*p/310 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/28
    (local.get $value/29))
   (i32.const 65536))
  (then
   (array.set $moonbit.bytes
    (local.get $self/30)
    (local.get $offset/31)
    (i32.and
     (local.tee $*p/295
      (i32.and
       (local.get $code/28)
       (i32.const 255)))
     (i32.const 255)))
   (array.set $moonbit.bytes
    (local.get $self/30)
    (i32.add
     (local.get $offset/31)
     (i32.const 1))
    (i32.and
     (local.tee $*p/298
      (i32.shr_u
       (local.get $code/28)
       (i32.const 8)))
     (i32.const 255)))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/28)
     (i32.const 1114112))
    (then
     (local.set $lo/33
      (i32.or
       (i32.shr_u
        (local.tee $hi/32
         (i32.sub
          (local.get $code/28)
          (i32.const 65536)))
        (i32.const 10))
       (i32.const 55296)))
     (local.set $hi/34
      (i32.or
       (i32.and
        (local.get $hi/32)
        (i32.const 1023))
       (i32.const 56320)))
     (array.set $moonbit.bytes
      (local.get $self/30)
      (local.get $offset/31)
      (i32.and
       (local.tee $*p/301
        (i32.and
         (local.get $lo/33)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/30)
      (i32.add
       (local.get $offset/31)
       (i32.const 1))
      (i32.and
       (local.tee $*p/304
        (i32.shr_u
         (local.get $lo/33)
         (i32.const 8)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/30)
      (i32.add
       (local.get $offset/31)
       (i32.const 2))
      (i32.and
       (local.tee $*p/307
        (i32.and
         (local.get $hi/34)
         (i32.const 255)))
       (i32.const 255)))
     (array.set $moonbit.bytes
      (local.get $self/30)
      (i32.add
       (local.get $offset/31)
       (i32.const 3))
      (i32.and
       (local.tee $*p/310
        (i32.shr_u
         (local.get $hi/34)
         (i32.const 8)))
       (i32.const 255)))
     (i32.const 4))
    (else
     (call $moonbitlang/core/builtin.abort|Int|
      (call $moonbit.string_literal
       (i32.const 5)
       (i32.const 334)
       (i32.const 17))
      (call $moonbit.string_literal
       (i32.const 4)
       (i32.const 238)
       (i32.const 48))))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/25 (ref $@moonbitlang/core/builtin.StringBuilder)) (result (ref $moonbit.string))
 (call $Bytes::to_unchecked_string.inner
  (struct.get $@moonbitlang/core/builtin.StringBuilder 0
   (local.get $self/25))
  (i32.const 0)
  (i64.extend_i32_s
   (struct.get $@moonbitlang/core/builtin.StringBuilder 1
    (local.get $self/25)))))
(func $Bytes::to_unchecked_string.inner (param $self/20 (ref $moonbit.bytes)) (param $offset/24 i32) (param $length/22 i64) (result (ref $moonbit.string))
 (local $len/19 i32)
 (local $length/21 i32)
 (local $*Some/23 i64)
 (local.set $len/19
  (array.len
   (local.get $self/20)))
 (local.set $length/21
  (if (result i32)
   (i64.eq
    (local.get $length/22)
    (i64.const 4294967296))
   (then
    (i32.sub
     (local.get $len/19)
     (local.get $offset/24)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/23
      (local.get $length/22))))))
 (if (result (ref $moonbit.string))
  (if (result i32)
   (i32.ge_s
    (local.get $offset/24)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $length/21)
      (i32.const 0))
     (then
      (i32.le_s
       (i32.add
        (local.get $offset/24)
        (local.get $length/21))
       (local.get $len/19)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (call $moonbitlang/core/builtin.unsafe_sub_string
    (local.get $self/20)
    (local.get $offset/24)
    (local.get $length/21)))
  (else
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/432 (ref $moonbit.bytes)) (param $*param/433 i32) (param $*param/434 i32) (result (ref $moonbit.string))
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/432)
  (local.get $*param/433)
  (local.get $*param/434)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/17 i32) (result (ref $@moonbitlang/core/builtin.StringBuilder))
 (local $initial/16 i32)
 (local $data/18 (ref $moonbit.bytes))
 (local.set $initial/16
  (if (result i32)
   (i32.lt_s
    (local.get $size_hint/17)
    (i32.const 1))
   (then
    (i32.const 1))
   (else
    (local.get $size_hint/17))))
 (struct.new $@moonbitlang/core/builtin.StringBuilder
  (local.tee $data/18
   (array.new $moonbit.bytes
    (i32.const 0)
    (local.get $initial/16)))
  (i32.const 0)))
(func $moonbitlang/core/builtin.abort|Int| (param $string/5 (ref $moonbit.string)) (param $loc/6 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Int|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/5)
     (call $moonbit.string_literal
      (i32.const 7)
      (i32.const 370)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/6)))
   (call $moonbit.string_literal
    (i32.const 6)
    (i32.const 368)
    (i32.const 1)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/3 (ref $moonbit.string)) (param $loc/4 (ref $moonbit.string)) (result i32)
 (call $moonbitlang/core/abort.abort|Unit|
  (call $moonbit.add_string
   (call $moonbit.add_string
    (call $moonbit.add_string
     (local.get $string/3)
     (call $moonbit.string_literal
      (i32.const 7)
      (i32.const 370)
      (i32.const 6)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
     (local.get $loc/4)))
   (call $moonbit.string_literal
    (i32.const 6)
    (i32.const 368)
    (i32.const 1)))))
(func $moonbitlang/core/abort.abort|Int| (param $msg/2 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/1 (ref $moonbit.string)) (result i32)
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_3) (param $*obj/448 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/447 i32) (result i32)
 (local $*self/446 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/446
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/448))))
  (local.get $*param/447)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_2) (param $*obj/445 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/444 (ref $StringView)) (result i32)
 (local $*self/443 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/443
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/445))))
  (local.get $*param/444)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (type $@moonbitlang/core/builtin.Logger.method_1) (param $*obj/442 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/439 (ref $moonbit.string)) (param $*param/440 i32) (param $*param/441 i32) (result i32)
 (local $*self/438 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/438
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/442))))
  (local.get $*param/439)
  (local.get $*param/440)
  (local.get $*param/441)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (type $@moonbitlang/core/builtin.Logger.method_0) (param $*obj/437 (ref $@moonbitlang/core/builtin.Logger)) (param $*param/436 (ref $moonbit.string)) (result i32)
 (local $*self/435 (ref $@moonbitlang/core/builtin.StringBuilder))
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/435
   (struct.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger 4
    (ref.cast (ref $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger)
     (local.get $*obj/437))))
  (local.get $*param/436)))
(func $*main*/1
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (call $moonbit.add_string
    (call $moonbit.add_string
     (call $moonbit.add_string
      (call $moonbit.string_literal
       (i32.const 9)
       (i32.const 390)
       (i32.const 13))
      (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
       (i32.const 10)))
     (call $moonbit.string_literal
      (i32.const 8)
      (i32.const 382)
      (i32.const 4)))
    (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
     (call $username/moonbit_examples/cmd/fibonacci.fib
      (i32.const 10)))))))
(export "_start" (func $*main*/1))