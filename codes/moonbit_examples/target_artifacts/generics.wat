(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data  (memory $moonbit.memory) (offset (i32.const 10000)) "\FF\FF\FF\FF\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\003\006\006\00:\005\00-\003\006\006\00:\003\003\00\00\00\00\00\00\00\FF\FF\FF\FF\13\00\00PI\00n\00v\00a\00l\00i\00d\00 \00s\00t\00a\00r\00t\00 \00i\00n\00d\00e\00x\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\004\009\001\00:\009\00-\004\009\001\00:\004\000\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00Pi\00n\00v\00a\00l\00i\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00 \00p\00a\00i\00r\00\00\00\00\00\FF\FF\FF\FF\01\00\00P0\00\00\00\00\00\00\00\FF\FF\FF\FF4\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00Pr\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\FF\FF\FF\FF$\00\00P0\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF5\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00v\00i\00e\00w\00.\00m\00b\00t\00:\001\001\001\00:\005\00-\001\001\001\00:\003\006\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00PI\00n\00v\00a\00l\00i\00d\00 \00i\00n\00d\00e\00x\00 \00f\00o\00r\00 \00V\00i\00e\00w\00\00\00\00\00\FF\FF\FF\FF0\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\000\00:\005\00-\002\009\000\00:\003\001\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\11\00\00PC\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P\0A\00\00\00\00\00\00\00\FF\FF\FF\FF\06\00\00P\0A\00 \00 \00a\00t\00 \00\00\00\00\00\FF\FF\FF\FF\15\00\00PS\00t\00r\00i\00n\00g\00 \00b\00o\00x\00 \00c\00o\00n\00t\00a\00i\00n\00s\00:\00 \00\00\00\00\00\00\00\FF\FF\FF\FF\12\00\00PI\00n\00t\00 \00b\00o\00x\00 \00c\00o\00n\00t\00a\00i\00n\00s\00:\00 \00\00\00\00\00\FF\FF\FF\FF\0E\00\00PH\00e\00l\00l\00o\00 \00G\00e\00n\00e\00r\00i\00c\00s\00\00\00\00\00\FF\FF\FF\FF\00\04\10\00\00\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\FF\FF\FF\FF\01\00\00P:\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P-\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P/\00\00\00\00\00\00\00")
(memory $moonbit.memory 1)
(global $tlsf/ROOT
 (mut i32)
 (i32.const 0)
)
(func $tlsf/searchBlock (param $0 i32) (param $1 i32) (result i32)
 (local $2 i32)
 (if (result i32)
  (local.tee $1
   (i32.and
    (i32.load offset=4
     (i32.add
      (local.get $0)
      (i32.shl
       (local.tee $2
        (if (result i32)
         (i32.lt_u
          (local.get $1)
          (i32.const 256))
         (then
          (local.set $1
           (i32.shr_u
            (local.get $1)
            (i32.const 4)))
          (i32.const 0))
         (else
          (if
           (i32.lt_u
            (local.get $1)
            (i32.const 536870910))
           (then
            (local.set $1
             (i32.sub
              (i32.add
               (local.get $1)
               (i32.shl
                (i32.const 1)
                (i32.sub
                 (i32.const 27)
                 (i32.clz
                  (local.get $1)))))
              (i32.const 1))))
           (else))
          (local.set $2
           (i32.sub
            (i32.const 31)
            (i32.clz
             (local.get $1))))
          (local.set $1
           (i32.xor
            (i32.shr_u
             (local.get $1)
             (i32.sub
              (local.get $2)
              (i32.const 4)))
            (i32.const 16)))
          (i32.sub
           (local.get $2)
           (i32.const 7)))))
       (i32.const 2))))
    (i32.shl
     (i32.const -1)
     (local.get $1))))
  (then
   (i32.load offset=96
    (i32.add
     (local.get $0)
     (i32.shl
      (i32.add
       (i32.ctz
        (local.get $1))
       (i32.shl
        (local.get $2)
        (i32.const 4)))
      (i32.const 2)))))
  (else
   (if (result i32)
    (local.tee $1
     (i32.and
      (i32.load
       (local.get $0))
      (i32.shl
       (i32.const -1)
       (i32.add
        (local.get $2)
        (i32.const 1)))))
    (then
     (i32.load offset=96
      (i32.add
       (local.get $0)
       (i32.shl
        (i32.add
         (i32.ctz
          (i32.load offset=4
           (i32.add
            (local.get $0)
            (i32.shl
             (local.tee $1
              (i32.ctz
               (local.get $1)))
             (i32.const 2)))))
         (i32.shl
          (local.get $1)
          (i32.const 4)))
        (i32.const 2)))))
    (else
     (i32.const 0))))))
(func $tlsf/removeBlock (param $0 i32) (param $1 i32)
 (local $2 i32)
 (local $3 i32)
 (local $4 i32)
 (local $5 i32)
 (local.set $5
  (if (result i32)
   (i32.lt_u
    (local.tee $2
     (i32.and
      (i32.load
       (local.get $1))
      (i32.const -4)))
    (i32.const 256))
   (then
    (local.set $3
     (i32.shr_u
      (local.get $2)
      (i32.const 4)))
    (i32.const 0))
   (else
    (local.set $2
     (i32.sub
      (i32.const 31)
      (i32.clz
       (local.tee $3
        (select
         (i32.const 1073741820)
         (local.get $2)
         (i32.ge_u
          (local.get $2)
          (i32.const 1073741820)))))))
    (local.set $3
     (i32.xor
      (i32.shr_u
       (local.get $3)
       (i32.sub
        (local.get $2)
        (i32.const 4)))
      (i32.const 16)))
    (i32.sub
     (local.get $2)
     (i32.const 7)))))
 (local.set $2
  (i32.load offset=8
   (local.get $1)))
 (if
  (local.tee $4
   (i32.load offset=4
    (local.get $1)))
  (then
   (i32.store offset=8
    (local.get $4)
    (local.get $2)))
  (else))
 (if
  (local.get $2)
  (then
   (i32.store offset=4
    (local.get $2)
    (local.get $4)))
  (else))
 (if
  (i32.eq
   (local.get $1)
   (i32.load offset=96
    (local.tee $4
     (i32.add
      (local.get $0)
      (i32.shl
       (i32.add
        (i32.shl
         (local.get $5)
         (i32.const 4))
        (local.get $3))
       (i32.const 2))))))
  (then
   (i32.store offset=96
    (local.get $4)
    (local.get $2))
   (if
    (i32.eqz
     (local.get $2))
    (then
     (i32.store offset=4
      (local.tee $1
       (i32.add
        (local.get $0)
        (i32.shl
         (local.get $5)
         (i32.const 2))))
      (local.tee $1
       (i32.and
        (i32.load offset=4
         (local.get $1))
        (i32.rotl
         (i32.const -2)
         (local.get $3)))))
     (if
      (i32.eqz
       (local.get $1))
      (then
       (i32.store
        (local.get $0)
        (i32.and
         (i32.load
          (local.get $0))
         (i32.rotl
          (i32.const -2)
          (local.get $5)))))
      (else)))
    (else)))
  (else)))
(func $tlsf/insertBlock (param $0 i32) (param $1 i32)
 (local $2 i32)
 (local $3 i32)
 (local $4 i32)
 (local $5 i32)
 (local.set $3
  (local.tee $4
   (i32.load
    (local.get $1))))
 (if
  (i32.and
   (local.tee $4
    (i32.load
     (local.tee $2
      (i32.add
       (local.tee $5
        (i32.add
         (local.get $1)
         (i32.const 4)))
       (i32.and
        (local.get $4)
        (i32.const -4))))))
   (i32.const 1))
  (then
   (call $tlsf/removeBlock
    (local.get $0)
    (local.get $2))
   (i32.store
    (local.get $1)
    (local.tee $3
     (i32.add
      (i32.add
       (local.get $3)
       (i32.const 4))
      (i32.and
       (local.get $4)
       (i32.const -4)))))
   (local.set $4
    (i32.load
     (local.tee $2
      (i32.add
       (i32.and
        (i32.load
         (local.get $1))
        (i32.const -4))
       (local.get $5))))))
  (else))
 (if
  (i32.and
   (local.get $3)
   (i32.const 2))
  (then
   (local.set $5
    (i32.load
     (local.tee $1
      (i32.load
       (i32.sub
        (local.get $1)
        (i32.const 4))))))
   (call $tlsf/removeBlock
    (local.get $0)
    (local.get $1))
   (i32.store
    (local.get $1)
    (local.tee $3
     (i32.add
      (i32.add
       (local.get $5)
       (i32.const 4))
      (i32.and
       (local.get $3)
       (i32.const -4))))))
  (else))
 (i32.store
  (local.get $2)
  (i32.or
   (local.get $4)
   (i32.const 2)))
 (i32.store
  (i32.sub
   (local.get $2)
   (i32.const 4))
  (local.get $1))
 (local.set $3
  (if (result i32)
   (i32.lt_u
    (local.tee $2
     (i32.and
      (local.get $3)
      (i32.const -4)))
    (i32.const 256))
   (then
    (local.set $2
     (i32.shr_u
      (local.get $2)
      (i32.const 4)))
    (i32.const 0))
   (else
    (local.set $3
     (i32.sub
      (i32.const 31)
      (i32.clz
       (local.tee $2
        (select
         (i32.const 1073741820)
         (local.get $2)
         (i32.ge_u
          (local.get $2)
          (i32.const 1073741820)))))))
    (local.set $2
     (i32.xor
      (i32.shr_u
       (local.get $2)
       (i32.sub
        (local.get $3)
        (i32.const 4)))
      (i32.const 16)))
    (i32.sub
     (local.get $3)
     (i32.const 7)))))
 (local.set $4
  (i32.load offset=96
   (i32.add
    (local.get $0)
    (i32.shl
     (i32.add
      (i32.shl
       (local.get $3)
       (i32.const 4))
      (local.get $2))
     (i32.const 2)))))
 (i32.store offset=4
  (local.get $1)
  (i32.const 0))
 (i32.store offset=8
  (local.get $1)
  (local.get $4))
 (if
  (local.get $4)
  (then
   (i32.store offset=4
    (local.get $4)
    (local.get $1)))
  (else))
 (i32.store offset=96
  (i32.add
   (local.get $0)
   (i32.shl
    (i32.add
     (i32.shl
      (local.get $3)
      (i32.const 4))
     (local.get $2))
    (i32.const 2)))
  (local.get $1))
 (i32.store
  (local.get $0)
  (i32.or
   (i32.load
    (local.get $0))
   (i32.shl
    (i32.const 1)
    (local.get $3))))
 (i32.store offset=4
  (local.tee $0
   (i32.add
    (local.get $0)
    (i32.shl
     (local.get $3)
     (i32.const 2))))
  (i32.or
   (i32.load offset=4
    (local.get $0))
   (i32.shl
    (i32.const 1)
    (local.get $2)))))
(func $tlsf/addMemory (param $0 i32) (param $1 i32) (param $2 i64)
 (local $3 i32)
 (local $4 i32)
 (local $5 i32)
 (if
  (select
   (local.tee $4
    (i32.load offset=1568
     (local.get $0)))
   (i32.const 0)
   (i32.eq
    (local.tee $3
     (i32.sub
      (local.tee $1
       (i32.sub
        (i32.and
         (i32.add
          (local.get $1)
          (i32.const 19))
         (i32.const -16))
        (i32.const 4)))
      (i32.const 16)))
    (local.get $4)))
  (then
   (local.set $5
    (i32.load
     (local.get $4)))
   (local.set $1
    (local.get $3)))
  (else))
 (if
  (i32.lt_u
   (local.tee $3
    (i32.sub
     (i32.and
      (i32.wrap_i64
       (local.get $2))
      (i32.const -16))
     (local.get $1)))
   (i32.const 20))
  (then
   (return))
  (else))
 (i32.store
  (local.get $1)
  (i32.or
   (i32.and
    (local.get $5)
    (i32.const 2))
   (i32.or
    (local.tee $3
     (i32.sub
      (local.get $3)
      (i32.const 8)))
    (i32.const 1))))
 (i32.store offset=4
  (local.get $1)
  (i32.const 0))
 (i32.store offset=8
  (local.get $1)
  (i32.const 0))
 (i32.store
  (local.tee $3
   (i32.add
    (i32.add
     (local.get $1)
     (i32.const 4))
    (local.get $3)))
  (i32.const 2))
 (i32.store offset=1568
  (local.get $0)
  (local.get $3))
 (call $tlsf/insertBlock
  (local.get $0)
  (local.get $1)))
(func $tlsf/initialize
 (local $0 i32)
 (local $1 i32)
 (local $2 i32)
 (local.set $0
  (i32.and
   (i32.add
    (i32.const 11248)
    (i32.const 15))
   (i32.const -16)))
 (if
  (if (result i32)
   (i32.lt_s
    (local.tee $1
     (memory.size))
    (local.tee $2
     (i32.shr_u
      (i32.and
       (i32.add
        (local.get $0)
        (i32.const 67107))
       (i32.const -65536))
      (i32.const 16))))
   (then
    (i32.lt_s
     (memory.grow
      (i32.sub
       (local.get $2)
       (local.get $1)))
     (i32.const 0)))
   (else
    (i32.const 0)))
  (then
   (unreachable))
  (else))
 (i32.store
  (local.get $0)
  (i32.const 0))
 (i32.store offset=1568
  (local.get $0)
  (i32.const 0))
 (local.set $1
  (i32.const 0))
 (loop $label1
  (if
   (i32.lt_u
    (local.get $1)
    (i32.const 23))
   (then
    (i32.store offset=4
     (i32.add
      (local.get $0)
      (i32.shl
       (local.get $1)
       (i32.const 2)))
     (i32.const 0))
    (local.set $2
     (i32.const 0))
    (loop $label
     (if
      (i32.lt_u
       (local.get $2)
       (i32.const 16))
      (then
       (i32.store offset=96
        (i32.add
         (local.get $0)
         (i32.shl
          (i32.add
           (i32.shl
            (local.get $1)
            (i32.const 4))
           (local.get $2))
          (i32.const 2)))
        (i32.const 0))
       (local.set $2
        (i32.add
         (local.get $2)
         (i32.const 1)))
       (br $label))
      (else)))
    (local.set $1
     (i32.add
      (local.get $1)
      (i32.const 1)))
    (br $label1))
   (else)))
 (call $tlsf/addMemory
  (local.get $0)
  (i32.add
   (local.get $0)
   (i32.const 1572))
  (i64.shl
   (i64.extend_i32_s
    (memory.size))
   (i64.const 16)))
 (global.set $tlsf/ROOT
  (local.get $0)))
(func $moonbit.malloc (param $0 i32) (result i32)
 (local $1 i32)
 (local $2 i32)
 (local $3 i32)
 (local $4 i32)
 (if
  (i32.eqz
   (global.get $tlsf/ROOT))
  (then
   (call $tlsf/initialize))
  (else))
 (if
  (i32.gt_u
   (local.get $0)
   (i32.const 1073741820))
  (then
   (unreachable))
  (else))
 (if
  (i32.eqz
   (local.tee $0
    (call $tlsf/searchBlock
     (local.tee $2
      (global.get $tlsf/ROOT))
     (local.tee $1
      (if (result i32)
       (i32.le_u
        (local.get $0)
        (i32.const 12))
       (then
        (i32.const 12))
       (else
        (i32.sub
         (i32.and
          (i32.add
           (local.get $0)
           (i32.const 19))
          (i32.const -16))
         (i32.const 4))))))))
  (then
   (local.tee $0
    (memory.size))
   (if
    (i32.lt_s
     (memory.grow
      (select
       (if (result i32)
        (i32.ge_u
         (local.get $1)
         (i32.const 256))
        (then
         (if (result i32)
          (i32.lt_u
           (local.get $1)
           (i32.const 536870910))
          (then
           (i32.sub
            (i32.add
             (local.get $1)
             (i32.shl
              (i32.const 1)
              (i32.sub
               (i32.const 27)
               (i32.clz
                (local.get $1)))))
            (i32.const 1)))
          (else
           (local.get $1))))
        (else
         (local.get $1)))
       (local.tee $3
        (i32.shr_u
         (i32.and
          (i32.add
           (i32.add
            (i32.const 4)
            (i32.shl
             (i32.load offset=1568
              (local.get $2))
             (i32.ne
              (i32.sub
               (i32.shl
                (local.get $0)
                (i32.const 16))
               (i32.const 4)))))
           (i32.const 65535))
          (i32.const -65536))
         (i32.const 16)))
       (i32.gt_s
        (local.get $0)
        (local.get $3))))
     (i32.const 0))
    (then
     (if
      (i32.lt_s
       (memory.grow
        (local.get $3))
       (i32.const 0))
      (then
       (unreachable))
      (else)))
    (else))
   (call $tlsf/addMemory
    (local.get $2)
    (i32.shl
     (local.get $0)
     (i32.const 16))
    (i64.shl
     (i64.extend_i32_s
      (memory.size))
     (i64.const 16)))
   (local.set $0
    (call $tlsf/searchBlock
     (local.get $2)
     (local.get $1))))
  (else))
 (call $tlsf/removeBlock
  (local.get $2)
  (local.get $0))
 (if
  (i32.ge_u
   (local.tee $4
    (i32.sub
     (i32.and
      (local.tee $3
       (i32.load
        (local.get $0)))
      (i32.const -4))
     (local.get $1)))
   (i32.const 16))
  (then
   (i32.store
    (local.get $0)
    (i32.or
     (local.get $1)
     (i32.and
      (local.get $3)
      (i32.const 2))))
   (i32.store
    (local.tee $1
     (i32.add
      (i32.add
       (local.get $0)
       (i32.const 4))
      (local.get $1)))
    (i32.or
     (i32.sub
      (local.get $4)
      (i32.const 4))
     (i32.const 1)))
   (call $tlsf/insertBlock
    (local.get $2)
    (local.get $1)))
  (else
   (i32.store
    (local.get $0)
    (i32.and
     (local.get $3)
     (i32.const -2)))
   (i32.store
    (i32.add
     (local.tee $1
      (i32.add
       (local.get $0)
       (i32.const 4)))
     (local.tee $2
      (i32.and
       (i32.load
        (local.get $0))
       (i32.const -4))))
    (i32.and
     (i32.load
      (i32.add
       (local.get $1)
       (local.get $2)))
     (i32.const -3)))))
 (i32.add
  (local.get $0)
  (i32.const 4)))
(func $moonbit.free (param $0 i32)
 (local $1 i32)
 (local $2 i32)
 (if
  (i32.gt_u
   (i32.const 11248)
   (local.get $0))
  (then
   (return))
  (else))
 (if
  (i32.eqz
   (global.get $tlsf/ROOT))
  (then
   (call $tlsf/initialize))
  (else))
 (local.set $2
  (global.get $tlsf/ROOT))
 (local.set $1
  (i32.sub
   (local.get $0)
   (i32.const 4)))
 (if
  (if (result i32)
   (select
    (i32.and
     (local.get $0)
     (i32.const 15))
    (i32.const 1)
    (local.get $0))
   (then
    (i32.const 1))
   (else
    (i32.and
     (i32.load
      (local.get $1))
     (i32.const 1))))
  (then
   (unreachable))
  (else))
 (i32.store
  (local.get $1)
  (i32.or
   (i32.load
    (local.get $1))
   (i32.const 1)))
 (call $tlsf/insertBlock
  (local.get $2)
  (local.get $1)))
(func $moonbit.gc.malloc (param $n i32) (result i32)
 (local $result i32)
 (i32.store
  (local.tee $result
   (call $moonbit.malloc
    (i32.add
     (i32.const 8)
     (local.get $n))))
  (i32.const 1))
 (local.get $result))
(func $moonbit.get_tag (param $p i32) (result i32)
 (i32.and
  (i32.load offset=4
   (local.get $p))
  (i32.const 255)))
(func $moonbit.array_length (param $arr i32) (result i32)
 (i32.and
  (i32.load offset=4
   (local.get $arr))
  (i32.const 268435455)))
(func $moonbit.println (param $str i32)
 (local $counter i32)
 (loop $loop
  (if
   (i32.lt_s
    (local.get $counter)
    (call $moonbit.array_length
     (local.get $str)))
   (then
    (call $printc
     (i32.load16_u offset=8
      (i32.add
       (local.get $str)
       (i32.shl
        (local.get $counter)
        (i32.const 1)))))
    (local.set $counter
     (i32.add
      (local.get $counter)
      (i32.const 1)))
    (br $loop))
   (else)))
 (call $printc
  (i32.const 10)))
(func $moonbit.check_range (param $index i32) (param $lo i32) (param $hi i32)
 (if
  (i32.le_s
   (local.get $index)
   (local.get $hi))
  (then
   (if
    (i32.ge_s
     (local.get $index)
     (local.get $lo))
    (then)
    (else
     (unreachable))))
  (else
   (unreachable))))
(func $moonbit.make_array_header (param $kind i32) (param $elem_size_shift i32) (param $len i32) (result i32)
 (i32.or
  (i32.or
   (i32.shl
    (local.get $kind)
    (i32.const 30))
   (i32.shl
    (local.get $elem_size_shift)
    (i32.const 28)))
  (local.get $len)))
(func $moonbit.i32_array_make_raw (param $size i32) (result i32)
 (local $arr i32)
 (if
  (i32.lt_s
   (local.get $size)
   (i32.const 0))
  (then
   (unreachable))
  (else))
 (i32.store offset=4
  (local.tee $arr
   (call $moonbit.gc.malloc
    (i32.mul
     (local.get $size)
     (i32.const 4))))
  (call $moonbit.make_array_header
   (i32.const 1)
   (i32.const 2)
   (local.get $size)))
 (local.get $arr))
(func $moonbit.i32_array_make (param $size i32) (param $val i32) (result i32)
 (local $arr i32)
 (local $counter i32)
 (local.set $arr
  (call $moonbit.i32_array_make_raw
   (local.get $size)))
 (loop $loop
  (if
   (i32.lt_s
    (local.get $counter)
    (local.get $size))
   (then
    (i32.store offset=8
     (i32.add
      (local.get $arr)
      (i32.mul
       (local.get $counter)
       (i32.const 4)))
     (local.get $val))
    (local.set $counter
     (i32.add
      (local.get $counter)
      (i32.const 1)))
    (br $loop))
   (else)))
 (local.get $arr))
(func $moonbit.bytes_make_raw (param $size i32) (result i32)
 (local $ptr i32)
 (i32.store offset=4
  (local.tee $ptr
   (call $moonbit.gc.malloc
    (i32.and
     (i32.add
      (local.get $size)
      (i32.const 3))
     (i32.const -4))))
  (call $moonbit.make_array_header
   (i32.const 1)
   (i32.const 0)
   (local.get $size)))
 (local.get $ptr))
(func $moonbit.bytes_make (param $size i32) (param $val i32) (result i32)
 (local $ptr i32)
 (local $counter i32)
 (local.set $ptr
  (call $moonbit.bytes_make_raw
   (local.get $size)))
 (loop $loop
  (if
   (i32.lt_s
    (local.get $counter)
    (local.get $size))
   (then
    (i32.store8 offset=8
     (i32.add
      (local.get $ptr)
      (local.get $counter))
     (local.get $val))
    (local.set $counter
     (i32.add
      (local.get $counter)
      (i32.const 1)))
    (br $loop))
   (else)))
 (local.get $ptr))
(func $moonbit.unsafe_make_string_raw (param $len i32) (result i32)
 (local $ptr i32)
 (i32.store offset=4
  (local.tee $ptr
   (call $moonbit.gc.malloc
    (i32.shl
     (i32.and
      (i32.add
       (local.get $len)
       (i32.const 1))
      (i32.const -2))
     (i32.const 1))))
  (call $moonbit.make_array_header
   (i32.const 1)
   (i32.const 1)
   (local.get $len)))
 (local.get $ptr))
(func $moonbit.unsafe_make_string (param $len i32) (param $val i32) (result i32)
 (local $ptr i32)
 (local $counter i32)
 (local.set $ptr
  (local.tee $ptr
   (call $moonbit.unsafe_make_string_raw
    (local.get $len))))
 (loop $loop
  (if
   (i32.lt_s
    (local.get $counter)
    (local.get $len))
   (then
    (i32.store16 offset=8
     (i32.add
      (local.get $ptr)
      (i32.shl
       (local.get $counter)
       (i32.const 1)))
     (local.get $val))
    (local.set $counter
     (i32.add
      (local.get $counter)
      (i32.const 1)))
    (br $loop))
   (else)))
 (local.get $ptr))
(func $moonbit.int16_array_make (param $size i32) (param $val i32) (result i32)
 (call $moonbit.unsafe_make_string
  (local.get $size)
  (local.get $val)))
(func $moonbit.add_string (param $x i32) (param $y i32) (result i32)
 (local $lenx i32)
 (local $leny i32)
 (local $len i32)
 (local $words i32)
 (local $ptr i32)
 (local $payload i32)
 (local $zeros i32)
 (local.set $lenx
  (i32.shl
   (call $moonbit.array_length
    (local.get $x))
   (i32.const 1)))
 (local.set $leny
  (i32.shl
   (call $moonbit.array_length
    (local.get $y))
   (i32.const 1)))
 (local.set $len
  (i32.add
   (local.get $lenx)
   (local.get $leny)))
 (i32.store offset=4
  (local.tee $ptr
   (call $moonbit.gc.malloc
    (i32.and
     (i32.add
      (local.get $len)
      (i32.const 3))
     (i32.const -4))))
  (call $moonbit.make_array_header
   (i32.const 1)
   (i32.const 1)
   (i32.shr_u
    (local.get $len)
    (i32.const 1))))
 (local.set $payload
  (i32.add
   (local.get $ptr)
   (i32.const 8)))
 (memory.copy
  (local.get $payload)
  (i32.add
   (local.get $x)
   (i32.const 8))
  (local.get $lenx))
 (call $moonbit.decref
  (local.get $x))
 (memory.copy
  (i32.add
   (local.get $payload)
   (local.get $lenx))
  (i32.add
   (local.get $y)
   (i32.const 8))
  (local.get $leny))
 (call $moonbit.decref
  (local.get $y))
 (local.get $ptr))
(func $moonbit.unsafe_bytes_sub_string (param $bytes i32) (param $offset i32) (param $len i32) (result i32)
 (local $ptr i32)
 (i32.store offset=4
  (local.tee $ptr
   (call $moonbit.gc.malloc
    (i32.and
     (i32.add
      (local.get $len)
      (i32.const 3))
     (i32.const -4))))
  (call $moonbit.make_array_header
   (i32.const 1)
   (i32.const 1)
   (i32.shr_u
    (local.get $len)
    (i32.const 1))))
 (memory.copy
  (i32.add
   (i32.add
    (i32.const 8)
    (local.get $ptr))
   (i32.const 0))
  (i32.add
   (i32.add
    (i32.const 8)
    (local.get $bytes))
   (local.get $offset))
  (local.get $len))
 (call $moonbit.decref
  (local.get $bytes))
 (local.get $ptr))
(func $moonbit.incref (param $ptr i32)
 (local $count i32)
 (if
  (i32.ge_s
   (local.tee $count
    (i32.load
     (local.get $ptr)))
   (i32.const 0))
  (then
   (i32.store
    (local.get $ptr)
    (i32.add
     (local.get $count)
     (i32.const 1))))
  (else)))
(func $moonbit.decref (param $ptr i32)
 (local $count i32)
 (if
  (i32.gt_s
   (local.tee $count
    (i32.load
     (local.get $ptr)))
   (i32.const 1))
  (then
   (i32.store
    (local.get $ptr)
    (i32.sub
     (local.get $count)
     (i32.const 1))))
  (else
   (if
    (i32.eq
     (local.get $count)
     (i32.const 1))
    (then
     (call $moonbit.gc.free
      (local.get $ptr)))
    (else)))))
(func $moonbit.gc.free (param $ptr i32)
 (local $parent i32)
 (local $curr_child_offset i32)
 (local $remaining_children_count i32)
 (local $n_ptr_fields i32)
 (local $ptr_fields_offset i32)
 (local $kind i32)
 (local $ref_array_kind i32)
 (local $vt_ptr i32)
 (local $vt_ptr_index i32)
 (local $vt_ptr_fields_offset i32)
 (local $vt_n_ptr_fields i32)
 (local $vt_header i32)
 (local $meta i32)
 (local $next i32)
 (local $addr_of_next i32)
 (local $len i32)
 (local $count i32)
 (loop $handle_new_object
  (local.set $kind
   (i32.shr_u
    (local.tee $meta
     (i32.load offset=4
      (local.get $ptr)))
    (i32.const 30)))
  (block $cond_has_children
   (if
    (i32.eq
     (i32.const 0)
     (local.get $kind))
    (then
     (if
      (i32.eqz
       (local.tee $n_ptr_fields
        (i32.and
         (i32.shr_u
          (local.get $meta)
          (i32.const 8))
         (i32.const 2047))))
      (then)
      (else
       (local.set $ptr_fields_offset
        (i32.and
         (i32.shr_u
          (local.get $meta)
          (i32.const 19))
         (i32.const 2047)))
       (local.set $curr_child_offset
        (local.get $ptr_fields_offset))
       (local.set $remaining_children_count
        (local.get $n_ptr_fields))
       (br $cond_has_children))))
    (else
     (if
      (i32.eq
       (i32.const 2)
       (local.get $kind))
      (then
       (local.set $ref_array_kind
        (i32.and
         (i32.const 3)
         (i32.shr_u
          (local.get $meta)
          (i32.const 28))))
       (if
        (i32.eq
         (i32.const 1)
         (local.get $ref_array_kind))
        (then
         (local.set $len
          (i32.and
           (local.get $meta)
           (i32.const 268435455)))
         (local.set $vt_ptr
          (i32.add
           (local.get $ptr)
           (i32.const 8)))
         (local.set $vt_header
          (i32.load
           (local.get $vt_ptr)))
         (local.set $vt_n_ptr_fields
          (i32.and
           (i32.const 2047)
           (i32.shr_u
            (local.get $vt_header)
            (i32.const 8))))
         (local.set $vt_ptr_fields_offset
          (i32.and
           (i32.const 2047)
           (i32.shr_u
            (local.get $vt_header)
            (i32.const 19))))
         (local.set $vt_ptr
          (i32.add
           (local.get $vt_ptr)
           (i32.const 4)))
         (loop $vt_elems_loop
          (if
           (i32.gt_s
            (local.get $len)
            (i32.const 0))
           (then
            (local.set $len
             (i32.sub
              (local.get $len)
              (i32.const 1)))
            (local.set $vt_ptr_index
             (i32.const 0))
            (local.set $vt_ptr
             (i32.add
              (local.get $vt_ptr)
              (i32.mul
               (local.get $vt_ptr_fields_offset)
               (i32.const 4))))
            (loop $vt_ptrs_loop
             (if
              (i32.lt_s
               (local.get $vt_ptr_index)
               (local.get $vt_n_ptr_fields))
              (then
               (i32.load
                (local.get $vt_ptr))
               (if
                (i32.ne
                 (i32.const 0))
                (then
                 (call $moonbit.decref
                  (i32.load
                   (local.get $vt_ptr))))
                (else))
               (local.set $vt_ptr_index
                (i32.add
                 (local.get $vt_ptr_index)
                 (i32.const 1)))
               (local.set $vt_ptr
                (i32.add
                 (local.get $vt_ptr)
                 (i32.const 4)))
               (br $vt_ptrs_loop))
              (else)))
            (br $vt_elems_loop))
           (else))))
        (else
         (local.set $len
          (i32.and
           (local.get $meta)
           (i32.const 268435455)))
         (if
          (i32.gt_s
           (local.get $len)
           (i32.const 0))
          (then
           (local.set $curr_child_offset
            (i32.shr_u
             (i32.const 8)
             (i32.const 2)))
           (local.set $remaining_children_count
            (local.get $len))
           (br $cond_has_children))
          (else)))))
      (else
       (if
        (i32.eq
         (i32.const 1)
         (local.get $kind))
        (then)
        (else
         (unreachable)))))))
   (call $moonbit.free
    (local.get $ptr))
   (if
    (i32.eqz
     (local.get $parent))
    (then
     (return))
    (else))
   (local.set $curr_child_offset
    (i32.load
     (local.get $parent)))
   (local.set $remaining_children_count
    (i32.load offset=4
     (local.get $parent)))
   (local.set $ptr
    (local.get $parent))
   (local.set $parent
    (i32.load
     (i32.add
      (local.get $ptr)
      (i32.mul
       (local.get $curr_child_offset)
       (i32.const 4)))))
   (local.set $curr_child_offset
    (i32.add
     (local.get $curr_child_offset)
     (i32.const 1))))
  (loop $process_children
   (loop $process_children_loop
    (if
     (i32.gt_s
      (local.get $remaining_children_count)
      (i32.const 0))
     (then
      (local.set $remaining_children_count
       (i32.sub
        (local.get $remaining_children_count)
        (i32.const 1)))
      (if
       (i32.eqz
        (local.tee $next
         (i32.load
          (local.tee $addr_of_next
           (i32.add
            (local.get $ptr)
            (i32.mul
             (local.get $curr_child_offset)
             (i32.const 4)))))))
       (then
        (local.set $curr_child_offset
         (i32.add
          (local.get $curr_child_offset)
          (i32.const 1)))
        (br $process_children_loop))
       (else))
      (if
       (i32.gt_s
        (local.tee $count
         (i32.load
          (local.get $next)))
        (i32.const 1))
       (then
        (i32.store
         (local.get $next)
         (i32.sub
          (local.get $count)
          (i32.const 1))))
       (else
        (if
         (i32.eq
          (local.get $count)
          (i32.const 1))
         (then
          (if
           (i32.eq
            (local.get $remaining_children_count)
            (i32.const 0))
           (then
            (call $moonbit.free
             (local.get $ptr)))
           (else
            (i32.store
             (local.get $ptr)
             (local.get $curr_child_offset))
            (i32.store offset=4
             (local.get $ptr)
             (local.get $remaining_children_count))
            (i32.store
             (local.get $addr_of_next)
             (local.get $parent))
            (local.set $parent
             (local.get $ptr))))
          (local.set $ptr
           (local.get $next))
          (br $handle_new_object))
         (else))))
      (local.set $curr_child_offset
       (i32.add
        (local.get $curr_child_offset)
        (i32.const 1)))
      (br $process_children_loop))
     (else)))
   (call $moonbit.free
    (local.get $ptr))
   (if
    (i32.eqz
     (local.get $parent))
    (then
     (return))
    (else))
   (local.set $curr_child_offset
    (i32.load
     (local.get $parent)))
   (local.set $remaining_children_count
    (i32.load offset=4
     (local.get $parent)))
   (local.set $ptr
    (local.get $parent))
   (local.set $parent
    (i32.load
     (i32.add
      (local.get $ptr)
      (i32.mul
       (local.get $curr_child_offset)
       (i32.const 4)))))
   (local.set $curr_child_offset
    (i32.add
     (local.get $curr_child_offset)
     (i32.const 1)))
   (br $process_children))
  (unreachable)))
(type $@moonbitlang/core/builtin.Logger.method_0
 (func
  (param i32) (param i32)
  (result i32)))
(type $@moonbitlang/core/builtin.Logger.method_2
 (func
  (param i32) (param i32) (param i32) (param i32)
  (result i32)))
(type $@moonbitlang/core/builtin.Logger.method_3
 (func
  (param i32) (param i32)
  (result i32)))
(table $moonbit.global 4 4 funcref )
(elem
 (table $moonbit.global) (offset (i32.const 0))
 funcref
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger))
(global $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id
 i32
 (i32.const 11176)
)
(global $moonbitlang/core/builtin.parse.*bind|5401
 i32
 (i32.const 11200)
)
(global $moonbitlang/core/builtin.parse.*bind|5440
 i32
 (i32.const 11200)
)
(global $moonbitlang/core/builtin.parse.*bind|5434
 i32
 (i32.const 11216)
)
(global $moonbitlang/core/builtin.parse.*bind|5421
 i32
 (i32.const 11200)
)
(global $moonbitlang/core/builtin.parse.*bind|5415
 i32
 (i32.const 11200)
)
(global $moonbitlang/core/builtin.output.*bind|8190
 i32
 (i32.const 11232)
)
(global $moonbitlang/core/builtin.output.*bind|8184
 i32
 (i32.const 11232)
)
(global $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/builtin.brute_force_find.constr/69
 (mut i64)
 (i64.const 0)
)
(func $@username/moonbit_examples/cmd/generics.Box::new|String| (param $value/316 i32) (result i32)
 (local $ptr/1020 i32)
 (i32.store offset=4
  (local.tee $ptr/1020
   (call $moonbit.gc.malloc
    (i32.const 4)))
  (i32.const 1048832))
 (i32.store offset=8
  (local.get $ptr/1020)
  (local.get $value/316))
 (local.get $ptr/1020))
(func $@username/moonbit_examples/cmd/generics.Box::new|Int| (param $value/315 i32) (result i32)
 (local $ptr/1021 i32)
 (i32.store offset=4
  (local.tee $ptr/1021
   (call $moonbit.gc.malloc
    (i32.const 4)))
  (i32.const 1572864))
 (i32.store offset=8
  (local.get $ptr/1021)
  (local.get $value/315))
 (local.get $ptr/1021))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/313 i32) (param $logger/0/314 i32) (param $logger/1/314 i32) (result i32)
 (local $*tmp/930 i32)
 (local $*tmp/931 i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (local.tee $*tmp/930
   (call $@moonbitlang/core/builtin.SourceLocRepr::parse
    (local.tee $*tmp/931
     (local.get $self/313))))
  (local.get $logger/0/314)
  (local.get $logger/1/314)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/299 i32) (param $logger/0/312 i32) (param $logger/1/312 i32) (result i32)
 (local $pkg/0/298 i32)
 (local $pkg/1/298 i32)
 (local $pkg/2/298 i32)
 (local $*bind/300 i64)
 (local $*bind/301 i32)
 (local $*Some/302 i64)
 (local $*first_slash/303 i32)
 (local $*bind/304 i64)
 (local $*Some/305 i64)
 (local $*second_slash/306 i32)
 (local $module_name_end/307 i32)
 (local $*module_name/0/308 i32)
 (local $*module_name/1/308 i32)
 (local $*module_name/2/308 i32)
 (local $*package_name/309 i32)
 (local $*Some/310 i32)
 (local $*pkg_name/0/311 i32)
 (local $*pkg_name/1/311 i32)
 (local $*pkg_name/2/311 i32)
 (local $*bind/0/909 i32)
 (local $*bind/1/909 i32)
 (local $*bind/0/910 i32)
 (local $*bind/1/910 i32)
 (local $filename/0/911 i32)
 (local $filename/1/911 i32)
 (local $filename/2/911 i32)
 (local $start_line/0/912 i32)
 (local $start_line/1/912 i32)
 (local $start_line/2/912 i32)
 (local $start_column/0/913 i32)
 (local $start_column/1/913 i32)
 (local $start_column/2/913 i32)
 (local $end_line/0/914 i32)
 (local $end_line/1/914 i32)
 (local $end_line/2/914 i32)
 (local $end_column/0/915 i32)
 (local $end_column/1/915 i32)
 (local $end_column/2/915 i32)
 (local $None/916 i32)
 (local $None/917 i32)
 (local $*tmp/0/918 i32)
 (local $*tmp/1/918 i32)
 (local $*tmp/2/918 i32)
 (local $Some/919 i32)
 (local $*tmp/0/920 i32)
 (local $*tmp/1/920 i32)
 (local $*tmp/2/920 i32)
 (local $*tmp/921 i32)
 (local $*tmp/922 i64)
 (local $*tmp/923 i32)
 (local $*tmp/0/924 i32)
 (local $*tmp/1/924 i32)
 (local $*tmp/2/924 i32)
 (local $*tmp/0/925 i32)
 (local $*tmp/1/925 i32)
 (local $*tmp/2/925 i32)
 (local $*tmp/926 i32)
 (local $*tmp/927 i32)
 (local $*tmp/0/928 i32)
 (local $*tmp/1/928 i32)
 (local $*tmp/2/928 i32)
 (local $*tmp/929 i32)
 (local $*field/0/934 i32)
 (local $*field/1/934 i32)
 (local $*field/2/934 i32)
 (local $*field/0/935 i32)
 (local $*field/1/935 i32)
 (local $*field/2/935 i32)
 (local $*field/0/936 i32)
 (local $*field/1/936 i32)
 (local $*field/2/936 i32)
 (local $*field/0/937 i32)
 (local $*field/1/937 i32)
 (local $*field/2/937 i32)
 (local $*field/0/938 i32)
 (local $*field/1/938 i32)
 (local $*field/2/938 i32)
 (local $*field/0/939 i32)
 (local $*field/1/939 i32)
 (local $*field/2/939 i32)
 (local $*field/940 i32)
 (local $*field/0/941 i32)
 (local $*field/1/941 i32)
 (local $*field/2/941 i32)
 (local $*field/0/942 i32)
 (local $*field/1/942 i32)
 (local $*field/2/942 i32)
 (local $*cnt/1003 i32)
 (local $*new_cnt/1004 i32)
 (local $*cnt/1005 i32)
 (local $*new_cnt/1006 i32)
 (local $*cnt/1007 i32)
 (local $*field/0/1008 i32)
 (local $*field/1/1008 i32)
 (local $*field/2/1008 i32)
 (local $*field/0/1009 i32)
 (local $*field/1/1009 i32)
 (local $*field/2/1009 i32)
 (local $*field/0/1010 i32)
 (local $*field/1/1010 i32)
 (local $*field/2/1010 i32)
 (local $*field/0/1011 i32)
 (local $*field/1/1011 i32)
 (local $*field/2/1011 i32)
 (local $*field/0/1012 i32)
 (local $*field/1/1012 i32)
 (local $*field/2/1012 i32)
 (local $*new_cnt/1013 i32)
 (local $*tag/1022 i32)
 (local $ptr/1023 i32)
 (local $ptr/1024 i32)
 (local $ptr/1025 i32)
 (local $ptr/1026 i32)
 (i32.load offset=56
  (local.get $self/299))
 (i32.load offset=8
  (local.get $self/299))
 (local.set $*field/2/942
  (i32.load offset=12
   (local.get $self/299)))
 (local.set $*field/1/942)
 (local.tee $*field/0/942)
 (local.get $*field/1/942)
 (local.set $pkg/2/298
  (local.get $*field/2/942))
 (local.set $pkg/1/298)
 (local.set $pkg/0/298)
 (local.set $*tmp/929
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.output.*bind|8190)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.output.*bind|8190))
 (global.get $moonbitlang/core/builtin.output.*bind|8190)
 (i32.const 0)
 (local.set $*tmp/2/928
  (local.get $*tmp/929))
 (local.set $*tmp/1/928)
 (local.set $*tmp/0/928)
 (call $moonbit.incref
  (local.get $pkg/0/298))
 (call $moonbit.incref
  (local.get $pkg/0/298))
 (i32.load offset=16
  (local.tee $*bind/301
   (if (result i32)
    (i64.eq
     (local.tee $*bind/300
      (call $StringView::find
       (local.get $pkg/0/298)
       (local.get $pkg/1/298)
       (local.get $pkg/2/298)
       (local.get $*tmp/0/928)
       (local.get $*tmp/1/928)
       (local.get $*tmp/2/928)))
     (i64.const 4294967296))
    (then
     (local.set $None/916
      (i32.const 10000))
     (i32.store offset=4
      (local.tee $ptr/1023
       (call $moonbit.gc.malloc
        (i32.const 16)))
      (i32.const 2097664))
     (i32.store offset=20
      (local.get $ptr/1023)
      (local.get $None/916))
     (i32.store offset=16
      (local.get $ptr/1023)
      (local.get $pkg/0/298))
     (i32.store offset=8
      (local.get $ptr/1023)
      (local.get $pkg/1/298))
     (i32.store offset=12
      (local.get $ptr/1023)
      (local.get $pkg/2/298))
     (local.get $ptr/1023))
    (else
     (local.set $*tmp/927
      (i32.add
       (local.tee $*first_slash/303
        (i32.wrap_i64
         (local.tee $*Some/302
          (local.get $*bind/300))))
       (i32.const 1)))
     (call $moonbit.incref
      (local.get $pkg/0/298))
     (call $StringView::view.inner
      (local.get $pkg/0/298)
      (local.get $pkg/1/298)
      (local.get $pkg/2/298)
      (local.get $*tmp/927)
      (i64.const 4294967296))
     (local.set $*tmp/2/924)
     (local.set $*tmp/1/924)
     (local.set $*tmp/0/924)
     (local.set $*tmp/926
      (call $moonbit.array_length
       (global.get $moonbitlang/core/builtin.output.*bind|8184)))
     (call $moonbit.incref
      (global.get $moonbitlang/core/builtin.output.*bind|8184))
     (global.get $moonbitlang/core/builtin.output.*bind|8184)
     (i32.const 0)
     (local.set $*tmp/2/925
      (local.get $*tmp/926))
     (local.set $*tmp/1/925)
     (local.set $*tmp/0/925)
     (if (result i32)
      (i64.eq
       (local.tee $*bind/304
        (call $StringView::find
         (local.get $*tmp/0/924)
         (local.get $*tmp/1/924)
         (local.get $*tmp/2/924)
         (local.get $*tmp/0/925)
         (local.get $*tmp/1/925)
         (local.get $*tmp/2/925)))
       (i64.const 4294967296))
      (then
       (local.set $None/917
        (i32.const 10000))
       (i32.store offset=4
        (local.tee $ptr/1024
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1024)
        (local.get $None/917))
       (i32.store offset=16
        (local.get $ptr/1024)
        (local.get $pkg/0/298))
       (i32.store offset=8
        (local.get $ptr/1024)
        (local.get $pkg/1/298))
       (i32.store offset=12
        (local.get $ptr/1024)
        (local.get $pkg/2/298))
       (local.get $ptr/1024))
      (else
       (local.set $*second_slash/306
        (i32.wrap_i64
         (local.tee $*Some/305
          (local.get $*bind/304))))
       (local.set $*tmp/922
        (i64.extend_i32_s
         (local.tee $module_name_end/307
          (i32.add
           (local.tee $*tmp/923
            (i32.add
             (local.get $*first_slash/303)
             (i32.const 1)))
           (local.get $*second_slash/306)))))
       (call $moonbit.incref
        (local.get $pkg/0/298))
       (call $StringView::view.inner
        (local.get $pkg/0/298)
        (local.get $pkg/1/298)
        (local.get $pkg/2/298)
        (i32.const 0)
        (local.get $*tmp/922))
       (local.set $*tmp/2/918)
       (local.set $*tmp/1/918)
       (local.set $*tmp/0/918)
       (local.set $*tmp/921
        (i32.add
         (local.get $module_name_end/307)
         (i32.const 1)))
       (call $StringView::view.inner
        (local.get $pkg/0/298)
        (local.get $pkg/1/298)
        (local.get $pkg/2/298)
        (local.get $*tmp/921)
        (i64.const 4294967296))
       (local.set $*tmp/2/920)
       (local.set $*tmp/1/920)
       (local.set $*tmp/0/920)
       (i32.store offset=4
        (local.tee $ptr/1026
         (call $moonbit.gc.malloc
          (i32.const 12)))
        (i32.const 2097409))
       (i32.store offset=16
        (local.get $ptr/1026)
        (local.get $*tmp/0/920))
       (i32.store offset=8
        (local.get $ptr/1026)
        (local.get $*tmp/1/920))
       (i32.store offset=12
        (local.get $ptr/1026)
        (local.get $*tmp/2/920))
       (local.set $Some/919
        (local.get $ptr/1026))
       (i32.store offset=4
        (local.tee $ptr/1025
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1025)
        (local.get $Some/919))
       (i32.store offset=16
        (local.get $ptr/1025)
        (local.get $*tmp/0/918))
       (i32.store offset=8
        (local.get $ptr/1025)
        (local.get $*tmp/1/918))
       (i32.store offset=12
        (local.get $ptr/1025)
        (local.get $*tmp/2/918))
       (local.get $ptr/1025)))))))
 (i32.load offset=8
  (local.get $*bind/301))
 (local.set $*field/2/941
  (i32.load offset=12
   (local.get $*bind/301)))
 (local.set $*field/1/941)
 (local.tee $*field/0/941)
 (local.get $*field/1/941)
 (local.set $*module_name/2/308
  (local.get $*field/2/941))
 (local.set $*module_name/1/308)
 (local.set $*module_name/0/308)
 (local.set $*field/940
  (i32.load offset=20
   (local.get $*bind/301)))
 (if
  (i32.gt_s
   (local.tee $*cnt/1003
    (i32.load
     (local.get $*bind/301)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/940))
   (call $moonbit.incref
    (local.get $*module_name/0/308))
   (local.set $*new_cnt/1004
    (i32.sub
     (local.get $*cnt/1003)
     (i32.const 1)))
   (i32.store
    (local.get $*bind/301)
    (local.get $*new_cnt/1004)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1003)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*bind/301)))
    (else))))
 (if
  (i32.eq
   (local.tee $*tag/1022
    (call $moonbit.get_tag
     (local.tee $*package_name/309
      (local.get $*field/940))))
   (i32.const 1))
  (then
   (i32.load offset=16
    (local.tee $*Some/310
     (local.get $*package_name/309)))
   (i32.load offset=8
    (local.get $*Some/310))
   (local.set $*field/2/939
    (i32.load offset=12
     (local.get $*Some/310)))
   (local.set $*field/1/939)
   (local.set $*field/0/939)
   (if
    (i32.gt_s
     (local.tee $*cnt/1005
      (i32.load
       (local.get $*Some/310)))
     (i32.const 1))
    (then
     (call $moonbit.incref
      (local.get $*field/0/939))
     (local.set $*new_cnt/1006
      (i32.sub
       (local.get $*cnt/1005)
       (i32.const 1)))
     (i32.store
      (local.get $*Some/310)
      (local.get $*new_cnt/1006)))
    (else
     (if
      (i32.eq
       (local.get $*cnt/1005)
       (i32.const 1))
      (then
       (call $moonbit.free
        (local.get $*Some/310)))
      (else))))
   (local.get $*field/0/939)
   (local.get $*field/1/939)
   (local.set $*pkg_name/2/311
    (local.get $*field/2/939))
   (local.set $*pkg_name/1/311)
   (local.set $*pkg_name/0/311)
   (if
    (local.get $logger/1/312)
    (then
     (call $moonbit.incref
      (local.get $logger/1/312)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
     (local.get $logger/1/312)
     (local.get $*pkg_name/0/311)
     (local.get $*pkg_name/1/311)
     (local.get $*pkg_name/2/311)
     (i32.load offset=16
      (local.get $logger/0/312))))
   (local.get $logger/0/312)
   (local.set $*bind/1/909
    (local.get $logger/1/312))
   (local.set $*bind/0/909)
   (if
    (local.get $*bind/1/909)
    (then
     (call $moonbit.incref
      (local.get $*bind/1/909)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
     (local.get $*bind/1/909)
     (i32.const 47)
     (i32.load offset=20
      (local.get $*bind/0/909)))))
  (else
   (call $moonbit.decref
    (local.get $*package_name/309))))
 (i32.load offset=60
  (local.get $self/299))
 (i32.load offset=16
  (local.get $self/299))
 (local.set $*field/2/938
  (i32.load offset=20
   (local.get $self/299)))
 (local.set $*field/1/938)
 (local.tee $*field/0/938)
 (local.get $*field/1/938)
 (local.set $filename/2/911
  (local.get $*field/2/938))
 (local.set $filename/1/911)
 (local.tee $filename/0/911)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/312)
   (local.get $filename/0/911)
   (local.get $filename/1/911)
   (local.get $filename/2/911)
   (i32.load offset=16
    (local.get $logger/0/312))))
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/312)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/312))))
 (i32.load offset=64
  (local.get $self/299))
 (i32.load offset=24
  (local.get $self/299))
 (local.set $*field/2/937
  (i32.load offset=28
   (local.get $self/299)))
 (local.set $*field/1/937)
 (local.tee $*field/0/937)
 (local.get $*field/1/937)
 (local.set $start_line/2/912
  (local.get $*field/2/937))
 (local.set $start_line/1/912)
 (local.tee $start_line/0/912)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/312)
   (local.get $start_line/0/912)
   (local.get $start_line/1/912)
   (local.get $start_line/2/912)
   (i32.load offset=16
    (local.get $logger/0/312))))
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/312)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/312))))
 (i32.load offset=68
  (local.get $self/299))
 (i32.load offset=32
  (local.get $self/299))
 (local.set $*field/2/936
  (i32.load offset=36
   (local.get $self/299)))
 (local.set $*field/1/936)
 (local.tee $*field/0/936)
 (local.get $*field/1/936)
 (local.set $start_column/2/913
  (local.get $*field/2/936))
 (local.set $start_column/1/913)
 (local.tee $start_column/0/913)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/312)
   (local.get $start_column/0/913)
   (local.get $start_column/1/913)
   (local.get $start_column/2/913)
   (i32.load offset=16
    (local.get $logger/0/312))))
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/312)
   (i32.const 45)
   (i32.load offset=20
    (local.get $logger/0/312))))
 (i32.load offset=72
  (local.get $self/299))
 (i32.load offset=40
  (local.get $self/299))
 (local.set $*field/2/935
  (i32.load offset=44
   (local.get $self/299)))
 (local.set $*field/1/935)
 (local.tee $*field/0/935)
 (local.get $*field/1/935)
 (local.set $end_line/2/914
  (local.get $*field/2/935))
 (local.set $end_line/1/914)
 (local.tee $end_line/0/914)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/312)
   (local.get $end_line/0/914)
   (local.get $end_line/1/914)
   (local.get $end_line/2/914)
   (i32.load offset=16
    (local.get $logger/0/312))))
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/312)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/312))))
 (i32.load offset=76
  (local.get $self/299))
 (i32.load offset=48
  (local.get $self/299))
 (local.set $*field/2/934
  (i32.load offset=52
   (local.get $self/299)))
 (local.set $*field/1/934)
 (local.set $*field/0/934)
 (if
  (i32.gt_s
   (local.tee $*cnt/1007
    (i32.load
     (local.get $self/299)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/0/934))
   (local.set $*new_cnt/1013
    (i32.sub
     (local.get $*cnt/1007)
     (i32.const 1)))
   (i32.store
    (local.get $self/299)
    (local.get $*new_cnt/1013)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1007)
     (i32.const 1))
    (then
     (i32.load offset=72
      (local.get $self/299))
     (i32.load offset=40
      (local.get $self/299))
     (local.set $*field/2/1012
      (i32.load offset=44
       (local.get $self/299)))
     (local.set $*field/1/1012)
     (local.tee $*field/0/1012)
     (call $moonbit.decref)
     (i32.load offset=68
      (local.get $self/299))
     (i32.load offset=32
      (local.get $self/299))
     (local.set $*field/2/1011
      (i32.load offset=36
       (local.get $self/299)))
     (local.set $*field/1/1011)
     (local.tee $*field/0/1011)
     (call $moonbit.decref)
     (i32.load offset=64
      (local.get $self/299))
     (i32.load offset=24
      (local.get $self/299))
     (local.set $*field/2/1010
      (i32.load offset=28
       (local.get $self/299)))
     (local.set $*field/1/1010)
     (local.tee $*field/0/1010)
     (call $moonbit.decref)
     (i32.load offset=60
      (local.get $self/299))
     (i32.load offset=16
      (local.get $self/299))
     (local.set $*field/2/1009
      (i32.load offset=20
       (local.get $self/299)))
     (local.set $*field/1/1009)
     (local.tee $*field/0/1009)
     (call $moonbit.decref)
     (i32.load offset=56
      (local.get $self/299))
     (i32.load offset=8
      (local.get $self/299))
     (local.set $*field/2/1008
      (i32.load offset=12
       (local.get $self/299)))
     (local.set $*field/1/1008)
     (local.tee $*field/0/1008)
     (call $moonbit.decref)
     (call $moonbit.free
      (local.get $self/299)))
    (else))))
 (local.get $*field/0/934)
 (local.get $*field/1/934)
 (local.set $end_column/2/915
  (local.get $*field/2/934))
 (local.set $end_column/1/915)
 (local.set $end_column/0/915)
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/312)
   (local.get $end_column/0/915)
   (local.get $end_column/1/915)
   (local.get $end_column/2/915)
   (i32.load offset=16
    (local.get $logger/0/312))))
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/312)
   (i32.const 64)
   (i32.load offset=20
    (local.get $logger/0/312))))
 (local.get $logger/0/312)
 (local.set $*bind/1/910
  (local.get $logger/1/312))
 (local.set $*bind/0/910)
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
  (local.get $*bind/1/910)
  (local.get $*module_name/0/308)
  (local.get $*module_name/1/308)
  (local.get $*module_name/2/308)
  (i32.load offset=16
   (local.get $*bind/0/910))))
(func $moonbitlang/core/builtin.println|String| (param $input/297 i32) (result i32)
 (call $moonbit.println
  (local.get $input/297))
 (call $moonbit.decref
  (local.get $input/297))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/295 i32) (param $logger/0/294 i32) (param $logger/1/294 i32) (result i32)
 (local $*tmp/908 i32)
 (local.set $*tmp/908
  (call $Int::to_string.inner
   (local.get $self/295)
   (i32.const 10)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/294)
  (local.get $*tmp/908)
  (i32.load offset=8
   (local.get $logger/0/294))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/292 i32) (param $str/0/293 i32) (param $str/1/293 i32) (param $str/2/293 i32) (result i32)
 (local $*tmp/889 i32)
 (local $len/890 i32)
 (local $*tmp/891 i32)
 (local $*tmp/892 i32)
 (local $end/893 i32)
 (local $start/894 i32)
 (local $data/895 i32)
 (local $len/896 i32)
 (local $str/897 i32)
 (local $start/898 i32)
 (local $*tmp/899 i32)
 (local $end/900 i32)
 (local $start/901 i32)
 (local $*tmp/902 i32)
 (local $len/903 i32)
 (local $*tmp/904 i32)
 (local $*tmp/905 i32)
 (local $end/906 i32)
 (local $start/907 i32)
 (local $*field/943 i32)
 (local $*field/944 i32)
 (local $*field/945 i32)
 (local.set $len/890
  (i32.load offset=8
   (local.get $self/292)))
 (local.set $end/893
  (local.get $str/2/293))
 (local.set $start/894
  (local.get $str/1/293))
 (local.set $*tmp/891
  (i32.mul
   (local.tee $*tmp/892
    (i32.sub
     (local.get $end/893)
     (local.get $start/894)))
   (i32.const 2)))
 (local.set $*tmp/889
  (i32.add
   (local.get $len/890)
   (local.get $*tmp/891)))
 (call $moonbit.incref
  (local.get $self/292))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/292)
   (local.get $*tmp/889)))
 (local.set $data/895
  (local.tee $*field/945
   (i32.load offset=12
    (local.get $self/292))))
 (local.set $len/896
  (i32.load offset=8
   (local.get $self/292)))
 (local.set $str/897
  (local.tee $*field/944
   (local.get $str/0/293)))
 (local.set $start/898
  (local.get $str/1/293))
 (local.set $end/900
  (local.get $str/2/293))
 (local.set $start/901
  (local.get $str/1/293))
 (local.set $*tmp/899
  (i32.sub
   (local.get $end/900)
   (local.get $start/901)))
 (call $moonbit.incref
  (local.get $str/897))
 (call $moonbit.incref
  (local.get $data/895))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/895)
   (local.get $len/896)
   (local.get $str/897)
   (local.get $start/898)
   (local.get $*tmp/899)))
 (local.set $len/903
  (i32.load offset=8
   (local.get $self/292)))
 (local.set $end/906
  (local.get $str/2/293))
 (local.set $*field/943
  (local.get $str/1/293))
 (call $moonbit.decref
  (local.get $str/0/293))
 (local.set $start/907
  (local.get $*field/943))
 (local.set $*tmp/904
  (i32.mul
   (local.tee $*tmp/905
    (i32.sub
     (local.get $end/906)
     (local.get $start/907)))
   (i32.const 2)))
 (local.set $*tmp/902
  (i32.add
   (local.get $len/903)
   (local.get $*tmp/904)))
 (i32.store offset=8
  (local.get $self/292)
  (local.get $*tmp/902))
 (call $moonbit.decref
  (local.get $self/292))
 (i32.const 0))
(func $String::offset_of_nth_char.inner (param $self/289 i32) (param $i/290 i32) (param $start_offset/291 i32) (param $end_offset/287 i64) (result i64)
 (local $end_offset/286 i32)
 (local $*Some/288 i64)
 (local $*tmp/888 i32)
 (local.set $end_offset/286
  (if (result i32)
   (i64.eq
    (local.get $end_offset/287)
    (i64.const 4294967296))
   (then
    (call $moonbit.array_length
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
   (local.set $*tmp/888
    (i32.sub
     (i32.const 0)
     (local.get $i/290)))
   (call $String::offset_of_nth_char_backward
    (local.get $self/289)
    (local.get $*tmp/888)
    (local.get $start_offset/291)
    (local.get $end_offset/286)))))
(func $String::offset_of_nth_char_forward (param $self/284 i32) (param $n/282 i32) (param $start_offset/278 i32) (param $end_offset/279 i32) (result i64)
 (local $c/283 i32)
 (local $*tmp/879 i32)
 (local $*tmp/880 i32)
 (local $*tmp/881 i32)
 (local $*tmp/882 i32)
 (local $*tmp/883 i32)
 (local $*tmp/884 i32)
 (local $*tmp/885 i32)
 (local $*tmp/886 i32)
 (local $*tmp/887 i32)
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
       (local.tee $*tmp/880
        (local.get $utf16_offset/280))
       (local.get $end_offset/279))
      (then
       (i32.lt_s
        (local.tee $*tmp/879
         (local.get $char_count/281))
        (local.get $n/282)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/884
       (local.get $utf16_offset/280))
      (local.set $c/283
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/284)
         (i32.shl
          (local.get $*tmp/884)
          (i32.const 1)))))
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
          (local.tee $*tmp/881
           (local.get $utf16_offset/280))
          (i32.const 2))))
       (else
        (local.set $utf16_offset/280
         (i32.add
          (local.tee $*tmp/882
           (local.get $utf16_offset/280))
          (i32.const 1)))))
      (local.set $char_count/281
       (i32.add
        (local.tee $*tmp/883
         (local.get $char_count/281))
        (i32.const 1)))
      (br $loop:285))
     (else
      (call $moonbit.decref
       (local.get $self/284)))))
   (if (result i64)
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/886
       (local.get $char_count/281))
      (local.get $n/282))
     (then
      (i32.const 1))
     (else
      (i32.ge_s
       (local.tee $*tmp/885
        (local.get $utf16_offset/280))
       (local.get $end_offset/279))))
    (then
     (i64.const 4294967296))
    (else
     (i64.extend_i32_s
      (local.tee $*tmp/887
       (local.get $utf16_offset/280))))))
  (else
   (call $moonbit.decref
    (local.get $self/284))
   (call $moonbitlang/core/builtin.abort|Option<Int>|
    (i32.const 10128)
    (i32.const 10016)))))
(func $String::offset_of_nth_char_backward (param $self/276 i32) (param $n/274 i32) (param $start_offset/273 i32) (param $end_offset/272 i32) (result i64)
 (local $c/275 i32)
 (local $*tmp/868 i32)
 (local $*tmp/869 i32)
 (local $*tmp/870 i32)
 (local $*tmp/871 i32)
 (local $*tmp/872 i32)
 (local $*tmp/873 i32)
 (local $*tmp/874 i32)
 (local $*tmp/875 i32)
 (local $*tmp/876 i32)
 (local $*tmp/877 i32)
 (local $*tmp/878 i32)
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
     (local.tee $*tmp/869
      (i32.sub
       (local.tee $*tmp/870
        (local.get $utf16_offset/271))
       (i32.const 1)))
     (local.get $start_offset/273))
    (then
     (i32.lt_s
      (local.tee $*tmp/868
       (local.get $char_count/270))
      (local.get $n/274)))
    (else
     (i32.const 0)))
   (then
    (local.set $*tmp/874
     (i32.sub
      (local.tee $*tmp/875
       (local.get $utf16_offset/271))
      (i32.const 1)))
    (local.set $c/275
     (i32.load16_u offset=8
      (i32.add
       (local.get $self/276)
       (i32.shl
        (local.get $*tmp/874)
        (i32.const 1)))))
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
        (local.tee $*tmp/871
         (local.get $utf16_offset/271))
        (i32.const 2))))
     (else
      (local.set $utf16_offset/271
       (i32.sub
        (local.tee $*tmp/872
         (local.get $utf16_offset/271))
        (i32.const 1)))))
    (local.set $char_count/270
     (i32.add
      (local.tee $*tmp/873
       (local.get $char_count/270))
      (i32.const 1)))
    (br $loop:277))
   (else
    (call $moonbit.decref
     (local.get $self/276)))))
 (if (result i64)
  (if (result i32)
   (i32.lt_s
    (local.tee $*tmp/877
     (local.get $char_count/270))
    (local.get $n/274))
   (then
    (i32.const 1))
   (else
    (i32.lt_s
     (local.tee $*tmp/876
      (local.get $utf16_offset/271))
     (local.get $start_offset/273))))
  (then
   (i64.const 4294967296))
  (else
   (i64.extend_i32_s
    (local.tee $*tmp/878
     (local.get $utf16_offset/271))))))
(func $String::char_length_ge.inner (param $self/262 i32) (param $len/265 i32) (param $start_offset/269 i32) (param $end_offset/260 i64) (result i32)
 (local $end_offset/259 i32)
 (local $*Some/261 i64)
 (local $index/263 i32)
 (local $count/264 i32)
 (local $c1/266 i32)
 (local $c2/267 i32)
 (local $*tmp/862 i32)
 (local $*tmp/863 i32)
 (local $*tmp/864 i32)
 (local $*tmp/865 i32)
 (local $*tmp/866 i32)
 (local $*tmp/867 i32)
 (local.set $end_offset/259
  (if (result i32)
   (i64.eq
    (local.get $end_offset/260)
    (i64.const 4294967296))
   (then
    (call $moonbit.array_length
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
     (i32.load16_u offset=8
      (i32.add
       (local.get $self/262)
       (i32.shl
        (local.get $index/263)
        (i32.const 1)))))
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
        (local.tee $*tmp/862
         (i32.add
          (local.get $index/263)
          (i32.const 1)))
        (local.get $end_offset/259)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/865
       (i32.add
        (local.get $index/263)
        (i32.const 1)))
      (local.set $c2/267
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/262)
         (i32.shl
          (local.get $*tmp/865)
          (i32.const 1)))))
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
        (local.set $*tmp/863
         (i32.add
          (local.get $index/263)
          (i32.const 2)))
        (local.set $*tmp/864
         (i32.add
          (local.get $count/264)
          (i32.const 1)))
        (local.get $*tmp/863)
        (local.get $*tmp/864)
        (br $loop:268))
       (else
        (drop
         (call $moonbitlang/core/builtin.abort|Unit|
          (i32.const 10288)
          (i32.const 10176))))))
     (else))
    (local.set $*tmp/866
     (i32.add
      (local.get $index/263)
      (i32.const 1)))
    (local.set $*tmp/867
     (i32.add
      (local.get $count/264)
      (i32.const 1)))
    (local.get $*tmp/866)
    (local.get $*tmp/867)
    (br $loop:268))
   (else
    (call $moonbit.decref
     (local.get $self/262))
    (i32.ge_s
     (local.get $count/264)
     (local.get $len/265))))))
(func $Int::to_string.inner (param $self/243 i32) (param $radix/242 i32) (result i32)
 (local $is_negative/244 i32)
 (local $num/245 i32)
 (local $buffer/246 i32)
 (local $digit_len/247 i32)
 (local $total_len/248 i32)
 (local $buffer/249 i32)
 (local $digit_start/250 i32)
 (local $digit_len/251 i32)
 (local $total_len/252 i32)
 (local $buffer/253 i32)
 (local $digit_start/254 i32)
 (local $digit_len/255 i32)
 (local $total_len/256 i32)
 (local $buffer/257 i32)
 (local $digit_start/258 i32)
 (local $*tmp/858 i32)
 (local $*tmp/859 i32)
 (local $*tmp/860 i32)
 (local $*tmp/861 i32)
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
     (i32.const 10480)
     (i32.const 10360))))
  (else))
 (if
  (i32.eq
   (local.get $self/243)
   (i32.const 0))
  (then
   (i32.const 10344)
   (return))
  (else))
 (local.set $num/245
  (if (result i32)
   (local.tee $is_negative/244
    (i32.lt_s
     (local.get $self/243)
     (i32.const 0)))
   (then
    (local.tee $*tmp/861
     (i32.sub
      (i32.const 0)
      (local.get $self/243))))
   (else
    (local.get $self/243))))
 (local.set $buffer/246
  (if (result i32)
   (i32.eq
    (local.get $radix/242)
    (i32.const 10))
   (then
    (local.set $digit_len/247
     (call $moonbitlang/core/builtin.dec_count32
      (local.get $num/245)))
    (local.set $*tmp/858
     (if (result i32)
      (local.get $is_negative/244)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (local.set $buffer/249
     (call $moonbit.int16_array_make
      (local.tee $total_len/248
       (i32.add
        (local.get $digit_len/247)
        (local.get $*tmp/858)))
      (i32.const 0)))
    (local.set $digit_start/250
     (if (result i32)
      (local.get $is_negative/244)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (call $moonbit.incref
     (local.get $buffer/249))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/249)
      (local.get $num/245)
      (local.get $digit_start/250)
      (local.get $total_len/248)))
    (local.get $buffer/249))
   (else
    (if (result i32)
     (i32.eq
      (local.get $radix/242)
      (i32.const 16))
     (then
      (local.set $digit_len/251
       (call $moonbitlang/core/builtin.hex_count32
        (local.get $num/245)))
      (local.set $*tmp/859
       (if (result i32)
        (local.get $is_negative/244)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/253
       (call $moonbit.int16_array_make
        (local.tee $total_len/252
         (i32.add
          (local.get $digit_len/251)
          (local.get $*tmp/859)))
        (i32.const 0)))
      (local.set $digit_start/254
       (if (result i32)
        (local.get $is_negative/244)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/253))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/253)
        (local.get $num/245)
        (local.get $digit_start/254)
        (local.get $total_len/252)))
      (local.get $buffer/253))
     (else
      (local.set $digit_len/255
       (call $moonbitlang/core/builtin.radix_count32
        (local.get $num/245)
        (local.get $radix/242)))
      (local.set $*tmp/860
       (if (result i32)
        (local.get $is_negative/244)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/257
       (call $moonbit.int16_array_make
        (local.tee $total_len/256
         (i32.add
          (local.get $digit_len/255)
          (local.get $*tmp/860)))
        (i32.const 0)))
      (local.set $digit_start/258
       (if (result i32)
        (local.get $is_negative/244)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/257))
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
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/246)
     (i32.shl
      (i32.const 0)
      (i32.const 1)))
    (i32.const 45)))
  (else))
 (local.get $buffer/246))
(func $moonbitlang/core/builtin.radix_count32 (param $value/236 i32) (param $radix/239 i32) (result i32)
 (local $base/238 i32)
 (local $*tmp/855 i32)
 (local $*tmp/856 i32)
 (local $*tmp/857 i32)
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
    (local.tee $*tmp/855
     (local.get $num/237))
    (i32.const 0))
   (then
    (local.set $count/240
     (i32.add
      (local.tee $*tmp/856
       (local.get $count/240))
      (i32.const 1)))
    (local.set $num/237
     (i32.div_u
      (local.tee $*tmp/857
       (local.get $num/237))
      (local.get $base/238)))
    (br $loop:241))
   (else)))
 (local.get $count/240))
(func $moonbitlang/core/builtin.hex_count32 (param $value/234 i32) (result i32)
 (local $leading_zeros/235 i32)
 (local $*tmp/853 i32)
 (local $*tmp/854 i32)
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
    (local.tee $*tmp/853
     (i32.div_s
      (local.tee $*tmp/854
       (i32.sub
        (i32.const 31)
        (local.get $leading_zeros/235)))
      (i32.const 4)))
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
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/223 i32) (param $num/211 i32) (param $digit_start/214 i32) (param $total_len/213 i32) (result i32)
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
 (local $*tmp/796 i32)
 (local $*tmp/797 i32)
 (local $*tmp/798 i32)
 (local $*tmp/799 i32)
 (local $*tmp/800 i32)
 (local $*tmp/801 i32)
 (local $*tmp/802 i32)
 (local $*tmp/803 i32)
 (local $*tmp/804 i32)
 (local $*tmp/805 i32)
 (local $*tmp/806 i32)
 (local $*tmp/807 i32)
 (local $*tmp/808 i32)
 (local $*tmp/809 i32)
 (local $*tmp/810 i32)
 (local $*tmp/811 i32)
 (local $*tmp/812 i32)
 (local $*tmp/813 i32)
 (local $*tmp/814 i32)
 (local $*tmp/815 i32)
 (local $*tmp/816 i32)
 (local $*tmp/817 i32)
 (local $*tmp/818 i32)
 (local $*tmp/819 i32)
 (local $*tmp/820 i32)
 (local $*tmp/821 i32)
 (local $*tmp/822 i32)
 (local $*tmp/823 i32)
 (local $*tmp/824 i32)
 (local $*tmp/825 i32)
 (local $*tmp/826 i32)
 (local $*tmp/827 i32)
 (local $*tmp/828 i32)
 (local $*tmp/829 i32)
 (local $*tmp/830 i32)
 (local $*tmp/831 i32)
 (local $*tmp/832 i32)
 (local $*tmp/833 i32)
 (local $*tmp/834 i32)
 (local $*tmp/835 i32)
 (local $*tmp/836 i32)
 (local $*tmp/837 i32)
 (local $*tmp/838 i32)
 (local $*tmp/839 i32)
 (local $*tmp/840 i32)
 (local $*tmp/841 i32)
 (local $*tmp/842 i32)
 (local $*tmp/843 i32)
 (local $*tmp/844 i32)
 (local $*tmp/845 i32)
 (local $*tmp/846 i32)
 (local $*tmp/847 i32)
 (local $*tmp/848 i32)
 (local $*tmp/849 i32)
 (local $*tmp/850 i32)
 (local $*tmp/851 i32)
 (local $*tmp/852 i32)
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
    (local.tee $*tmp/796
     (local.get $num/210))
    (i32.const 10000))
   (then
    (local.set $t/215
     (i32.div_u
      (local.tee $*tmp/819
       (local.get $num/210))
      (i32.const 10000)))
    (local.set $r/216
     (local.tee $*tmp/817
      (i32.rem_u
       (local.tee $*tmp/818
        (local.get $num/210))
       (i32.const 10000))))
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
      (local.tee $*tmp/797
       (local.get $offset/212))
      (i32.const 4)))
    (local.set $*tmp/816
     (i32.div_s
      (local.get $d1/217)
      (i32.const 10)))
    (local.set $d1_hi/219
     (i32.and
      (local.tee $*tmp/815
       (i32.add
        (i32.const 48)
        (local.get $*tmp/816)))
      (i32.const 65535)))
    (local.set $*tmp/814
     (i32.rem_s
      (local.get $d1/217)
      (i32.const 10)))
    (local.set $d1_lo/220
     (i32.and
      (local.tee $*tmp/813
       (i32.add
        (i32.const 48)
        (local.get $*tmp/814)))
      (i32.const 65535)))
    (local.set $*tmp/812
     (i32.div_s
      (local.get $d2/218)
      (i32.const 10)))
    (local.set $d2_hi/221
     (i32.and
      (local.tee $*tmp/811
       (i32.add
        (i32.const 48)
        (local.get $*tmp/812)))
      (i32.const 65535)))
    (local.set $*tmp/810
     (i32.rem_s
      (local.get $d2/218)
      (i32.const 10)))
    (local.set $d2_lo/222
     (i32.and
      (local.tee $*tmp/809
       (i32.add
        (i32.const 48)
        (local.get $*tmp/810)))
      (i32.const 65535)))
    (local.set $*tmp/799
     (local.get $offset/212))
    (local.set $*tmp/798
     (i32.add
      (local.get $digit_start/214)
      (local.get $*tmp/799)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/798)
       (i32.const 1)))
     (local.get $d1_hi/219))
    (local.set $*tmp/802
     (local.get $offset/212))
    (local.set $*tmp/800
     (i32.add
      (local.tee $*tmp/801
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/802)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/800)
       (i32.const 1)))
     (local.get $d1_lo/220))
    (local.set $*tmp/805
     (local.get $offset/212))
    (local.set $*tmp/803
     (i32.add
      (local.tee $*tmp/804
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/805)))
      (i32.const 2)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/803)
       (i32.const 1)))
     (local.get $d2_hi/221))
    (local.set $*tmp/808
     (local.get $offset/212))
    (local.set $*tmp/806
     (i32.add
      (local.tee $*tmp/807
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/808)))
      (i32.const 3)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/806)
       (i32.const 1)))
     (local.get $d2_lo/222))
    (br $loop:224))
   (else)))
 (local.set $remaining/225
  (local.tee $*tmp/852
   (local.get $num/210)))
 (loop $loop:230
  (if
   (i32.ge_s
    (local.tee $*tmp/820
     (local.get $remaining/225))
    (i32.const 100))
   (then
    (local.set $t/226
     (i32.div_s
      (local.tee $*tmp/832
       (local.get $remaining/225))
      (i32.const 100)))
    (local.set $d/227
     (i32.rem_s
      (local.tee $*tmp/831
       (local.get $remaining/225))
      (i32.const 100)))
    (local.set $remaining/225
     (local.get $t/226))
    (local.set $offset/212
     (i32.sub
      (local.tee $*tmp/821
       (local.get $offset/212))
      (i32.const 2)))
    (local.set $*tmp/830
     (i32.div_s
      (local.get $d/227)
      (i32.const 10)))
    (local.set $d_hi/228
     (i32.and
      (local.tee $*tmp/829
       (i32.add
        (i32.const 48)
        (local.get $*tmp/830)))
      (i32.const 65535)))
    (local.set $*tmp/828
     (i32.rem_s
      (local.get $d/227)
      (i32.const 10)))
    (local.set $d_lo/229
     (i32.and
      (local.tee $*tmp/827
       (i32.add
        (i32.const 48)
        (local.get $*tmp/828)))
      (i32.const 65535)))
    (local.set $*tmp/823
     (local.get $offset/212))
    (local.set $*tmp/822
     (i32.add
      (local.get $digit_start/214)
      (local.get $*tmp/823)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/822)
       (i32.const 1)))
     (local.get $d_hi/228))
    (local.set $*tmp/826
     (local.get $offset/212))
    (local.set $*tmp/824
     (i32.add
      (local.tee $*tmp/825
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/826)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/824)
       (i32.const 1)))
     (local.get $d_lo/229))
    (br $loop:230))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.tee $*tmp/833
    (local.get $remaining/225))
   (i32.const 10))
  (then
   (local.set $offset/212
    (i32.sub
     (local.tee $*tmp/834
      (local.get $offset/212))
     (i32.const 2)))
   (local.set $*tmp/844
    (i32.div_s
     (local.tee $*tmp/845
      (local.get $remaining/225))
     (i32.const 10)))
   (local.set $d_hi/231
    (i32.and
     (local.tee $*tmp/843
      (i32.add
       (i32.const 48)
       (local.get $*tmp/844)))
     (i32.const 65535)))
   (local.set $*tmp/841
    (i32.rem_s
     (local.tee $*tmp/842
      (local.get $remaining/225))
     (i32.const 10)))
   (local.set $d_lo/232
    (i32.and
     (local.tee $*tmp/840
      (i32.add
       (i32.const 48)
       (local.get $*tmp/841)))
     (i32.const 65535)))
   (local.set $*tmp/836
    (local.get $offset/212))
   (local.set $*tmp/835
    (i32.add
     (local.get $digit_start/214)
     (local.get $*tmp/836)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/223)
     (i32.shl
      (local.get $*tmp/835)
      (i32.const 1)))
    (local.get $d_hi/231))
   (local.set $*tmp/839
    (local.get $offset/212))
   (local.set $*tmp/837
    (i32.add
     (local.tee $*tmp/838
      (i32.add
       (local.get $digit_start/214)
       (local.get $*tmp/839)))
     (i32.const 1)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/223)
     (i32.shl
      (local.get $*tmp/837)
      (i32.const 1)))
    (local.get $d_lo/232))
   (call $moonbit.decref
    (local.get $buffer/223))
   (i32.const 0))
  (else
   (local.set $*tmp/851
    (local.tee $offset/212
     (i32.sub
      (local.tee $*tmp/846
       (local.get $offset/212))
      (i32.const 1))))
   (local.set $*tmp/847
    (i32.add
     (local.get $digit_start/214)
     (local.get $*tmp/851)))
   (local.set $*tmp/850
    (local.get $remaining/225))
   (local.set $*tmp/848
    (i32.and
     (local.tee $*tmp/849
      (i32.add
       (i32.const 48)
       (local.get $*tmp/850)))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/223)
     (i32.shl
      (local.get $*tmp/847)
      (i32.const 1)))
    (local.get $*tmp/848))
   (call $moonbit.decref
    (local.get $buffer/223))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/205 i32) (param $num/199 i32) (param $digit_start/197 i32) (param $total_len/196 i32) (param $radix/201 i32) (result i32)
 (local $base/200 i32)
 (local $shift/202 i32)
 (local $mask/203 i32)
 (local $digit/204 i32)
 (local $q/207 i32)
 (local $digit/208 i32)
 (local $*tmp/775 i32)
 (local $*tmp/776 i32)
 (local $*tmp/777 i32)
 (local $*tmp/778 i32)
 (local $*tmp/779 i32)
 (local $*tmp/780 i32)
 (local $*tmp/781 i32)
 (local $*tmp/782 i32)
 (local $*tmp/783 i32)
 (local $*tmp/784 i32)
 (local $*tmp/785 i32)
 (local $*tmp/786 i32)
 (local $*tmp/787 i32)
 (local $*tmp/788 i32)
 (local $*tmp/789 i32)
 (local $*tmp/790 i32)
 (local $*tmp/791 i32)
 (local $*tmp/792 i32)
 (local $*tmp/793 i32)
 (local $*tmp/794 i32)
 (local $*tmp/795 i32)
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
 (local.set $*tmp/776
  (i32.sub
   (local.get $radix/201)
   (i32.const 1)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/775
    (i32.and
     (local.get $radix/201)
     (local.get $*tmp/776)))
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
      (local.tee $*tmp/777
       (local.get $n/198))
      (i32.const 0))
     (then
      (local.set $offset/195
       (i32.sub
        (local.tee $*tmp/778
         (local.get $offset/195))
        (i32.const 1)))
      (local.set $digit/204
       (local.tee $*tmp/784
        (i32.and
         (local.tee $*tmp/785
          (local.get $n/198))
         (local.get $mask/203))))
      (local.set $*tmp/782
       (local.get $offset/195))
      (local.set $*tmp/779
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/782)))
      (local.set $*tmp/780
       (i32.and
        (local.tee $*tmp/781
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10552)
           (i32.shl
            (local.get $digit/204)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/205)
        (i32.shl
         (local.get $*tmp/779)
         (i32.const 1)))
       (local.get $*tmp/780))
      (local.set $n/198
       (i32.shr_u
        (local.tee $*tmp/783
         (local.get $n/198))
        (local.get $shift/202)))
      (br $loop:206))
     (else
      (call $moonbit.decref
       (local.get $buffer/205)))))
   (i32.const 0))
  (else
   (loop $loop:209
    (if
     (i32.gt_u
      (local.tee $*tmp/786
       (local.get $n/198))
      (i32.const 0))
     (then
      (local.set $offset/195
       (i32.sub
        (local.tee $*tmp/787
         (local.get $offset/195))
        (i32.const 1)))
      (local.set $q/207
       (i32.div_u
        (local.tee $*tmp/795
         (local.get $n/198))
        (local.get $base/200)))
      (local.set $*tmp/793
       (local.get $n/198))
      (local.set $*tmp/794
       (i32.mul
        (local.get $q/207)
        (local.get $base/200)))
      (local.set $digit/208
       (local.tee $*tmp/792
        (i32.sub
         (local.get $*tmp/793)
         (local.get $*tmp/794))))
      (local.set $*tmp/791
       (local.get $offset/195))
      (local.set $*tmp/788
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/791)))
      (local.set $*tmp/789
       (i32.and
        (local.tee $*tmp/790
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10552)
           (i32.shl
            (local.get $digit/208)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/205)
        (i32.shl
         (local.get $*tmp/788)
         (i32.const 1)))
       (local.get $*tmp/789))
      (local.set $n/198
       (local.get $q/207))
      (br $loop:209))
     (else
      (call $moonbit.decref
       (local.get $buffer/205)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/192 i32) (param $num/188 i32) (param $digit_start/186 i32) (param $total_len/185 i32) (result i32)
 (local $byte_val/189 i32)
 (local $hi/190 i32)
 (local $lo/191 i32)
 (local $nibble/194 i32)
 (local $*tmp/756 i32)
 (local $*tmp/757 i32)
 (local $*tmp/758 i32)
 (local $*tmp/759 i32)
 (local $*tmp/760 i32)
 (local $*tmp/761 i32)
 (local $*tmp/762 i32)
 (local $*tmp/763 i32)
 (local $*tmp/764 i32)
 (local $*tmp/765 i32)
 (local $*tmp/766 i32)
 (local $*tmp/767 i32)
 (local $*tmp/768 i32)
 (local $*tmp/769 i32)
 (local $*tmp/770 i32)
 (local $*tmp/771 i32)
 (local $*tmp/772 i32)
 (local $*tmp/773 i32)
 (local $*tmp/774 i32)
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
    (local.tee $*tmp/756
     (local.get $offset/184))
    (i32.const 2))
   (then
    (local.set $offset/184
     (i32.sub
      (local.tee $*tmp/757
       (local.get $offset/184))
      (i32.const 2)))
    (local.set $hi/190
     (i32.div_s
      (local.tee $byte_val/189
       (local.tee $*tmp/768
        (i32.and
         (local.tee $*tmp/769
          (local.get $n/187))
         (i32.const 255))))
      (i32.const 16)))
    (local.set $lo/191
     (i32.rem_s
      (local.get $byte_val/189)
      (i32.const 16)))
    (local.set $*tmp/761
     (local.get $offset/184))
    (local.set $*tmp/758
     (i32.add
      (local.get $digit_start/186)
      (local.get $*tmp/761)))
    (local.set $*tmp/759
     (i32.and
      (local.tee $*tmp/760
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10552)
         (i32.shl
          (local.get $hi/190)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/192)
      (i32.shl
       (local.get $*tmp/758)
       (i32.const 1)))
     (local.get $*tmp/759))
    (local.set $*tmp/766
     (local.get $offset/184))
    (local.set $*tmp/762
     (i32.add
      (local.tee $*tmp/765
       (i32.add
        (local.get $digit_start/186)
        (local.get $*tmp/766)))
      (i32.const 1)))
    (local.set $*tmp/763
     (i32.and
      (local.tee $*tmp/764
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10552)
         (i32.shl
          (local.get $lo/191)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/192)
      (i32.shl
       (local.get $*tmp/762)
       (i32.const 1)))
     (local.get $*tmp/763))
    (local.set $n/187
     (i32.shr_u
      (local.tee $*tmp/767
       (local.get $n/187))
      (i32.const 8)))
    (br $loop:193))
   (else)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/770
    (local.get $offset/184))
   (i32.const 1))
  (then
   (local.set $nibble/194
    (local.tee $*tmp/773
     (i32.and
      (local.tee $*tmp/774
       (local.get $n/187))
      (i32.const 15))))
   (local.set $*tmp/771
    (i32.and
     (local.tee $*tmp/772
      (i32.load16_u offset=8
       (i32.add
        (i32.const 10552)
        (i32.shl
         (local.get $nibble/194)
         (i32.const 1)))))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/192)
     (i32.shl
      (local.get $digit_start/186)
      (i32.const 1)))
    (local.get $*tmp/771))
   (call $moonbit.decref
    (local.get $buffer/192))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $buffer/192))
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/183 i32) (result i32)
 (local $logger/182 i32)
 (local $*tmp/0/755 i32)
 (local $*tmp/1/755 i32)
 (call $moonbit.incref
  (local.tee $logger/182
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/755
  (local.get $logger/182))
 (local.set $*tmp/0/755)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/183)
   (local.get $*tmp/0/755)
   (local.get $*tmp/1/755)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/182)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/181 i32) (result i32)
 (local $logger/180 i32)
 (local $*tmp/0/754 i32)
 (local $*tmp/1/754 i32)
 (call $moonbit.incref
  (local.tee $logger/180
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/754
  (local.get $logger/180))
 (local.set $*tmp/0/754)
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/181)
   (local.get $*tmp/0/754)
   (local.get $*tmp/1/754)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/180)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/172 i32) (param $value/175 i32) (param $start/176 i32) (param $len/177 i32) (result i32)
 (local $*try_err/174 i32)
 (local $*tmp/0/749 i32)
 (local $*tmp/1/749 i32)
 (local $*tmp/2/749 i32)
 (local $*tmp/750 i64)
 (local $*tmp/751 i32)
 (local $*ok/0/752 i32)
 (local $*ok/1/752 i32)
 (local $*ok/2/752 i32)
 (local $*err/753 i32)
 (local $*obj/0/1028 i32)
 (local $*obj/1/1028 i32)
 (local $*obj/2/1028 i32)
 (block $outer/1027 (result i32) (result i32) (result i32)
  (block $join:173
   (local.set $*tmp/750
    (i64.extend_i32_s
     (local.tee $*tmp/751
      (i32.add
       (local.get $start/176)
       (local.get $len/177)))))
   (call $String::sub.inner
    (local.get $value/175)
    (local.get $start/176)
    (local.get $*tmp/750))
   (local.set $*obj/2/1028)
   (local.set $*obj/1/1028)
   (local.set $*obj/0/1028)
   (if (result i32) (result i32) (result i32)
    (then
     (local.get $*obj/0/1028)
     (local.get $*obj/1/1028)
     (local.set $*ok/2/752
      (local.get $*obj/2/1028))
     (local.set $*ok/1/752)
     (local.tee $*ok/0/752)
     (local.get $*ok/1/752)
     (local.get $*ok/2/752))
    (else
     (local.set $*try_err/174
      (local.tee $*err/753
       (local.get $*obj/0/1028)))
     (br $join:173)))
   (br $outer/1027))
  (call $moonbit.decref
   (local.get $*try_err/174))
  (unreachable))
 (local.set $*tmp/2/749)
 (local.set $*tmp/1/749)
 (local.set $*tmp/0/749)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.get $self/172)
  (local.get $*tmp/0/749)
  (local.get $*tmp/1/749)
  (local.get $*tmp/2/749)))
(func $String::sub.inner (param $self/165 i32) (param $start/171 i32) (param $end/167 i64) (result i32) (result i32) (result i32) (result i32)
 (local $len/164 i32)
 (local $end/166 i32)
 (local $*Some/168 i64)
 (local $*end/169 i32)
 (local $start/170 i32)
 (local $*p/429 i32)
 (local $*p/432 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/745 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/746 i32)
 (local $*tmp/0/747 i32)
 (local $*tmp/1/747 i32)
 (local $*tmp/2/747 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/748 i32)
 (local.set $len/164
  (call $moonbit.array_length
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
 (if (result i32) (result i32) (result i32) (result i32)
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
      (local.set $*p/429
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/165)
         (i32.shl
          (local.get $start/170)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/429))
       (then
        (i32.le_s
         (local.get $*p/429)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/165))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/745
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/745)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $end/166)
      (local.get $len/164))
     (then
      (local.set $*p/432
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/165)
         (i32.shl
          (local.get $end/166)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/432))
       (then
        (i32.le_s
         (local.get $*p/432)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/165))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/746
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/746)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (local.get $self/165)
   (local.get $start/170)
   (local.set $*tmp/2/747
    (local.get $end/166))
   (local.set $*tmp/1/747)
   (local.set $*tmp/0/747)
   (i32.const 1)
   (local.get $*tmp/0/747)
   (local.get $*tmp/1/747)
   (local.get $*tmp/2/747))
  (else
   (call $moonbit.decref
    (local.get $self/165))
   (local.set $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/748
    (i32.const 10640))
   (i32.const 0)
   (local.get $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/748)
   (i32.const 0)
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/162 i32) (param $str/163 i32) (result i32)
 (local $*tmp/734 i32)
 (local $len/735 i32)
 (local $*tmp/736 i32)
 (local $*tmp/737 i32)
 (local $data/738 i32)
 (local $len/739 i32)
 (local $*tmp/740 i32)
 (local $*tmp/741 i32)
 (local $len/742 i32)
 (local $*tmp/743 i32)
 (local $*tmp/744 i32)
 (local $*tmp/948 i32)
 (local $*field/949 i32)
 (local.set $len/735
  (i32.load offset=8
   (local.get $self/162)))
 (local.set $*tmp/736
  (i32.mul
   (local.tee $*tmp/737
    (call $moonbit.array_length
     (local.get $str/163)))
   (i32.const 2)))
 (local.set $*tmp/734
  (i32.add
   (local.get $len/735)
   (local.get $*tmp/736)))
 (call $moonbit.incref
  (local.get $self/162))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/162)
   (local.get $*tmp/734)))
 (local.set $data/738
  (local.tee $*field/949
   (i32.load offset=12
    (local.get $self/162))))
 (local.set $len/739
  (i32.load offset=8
   (local.get $self/162)))
 (local.set $*tmp/740
  (call $moonbit.array_length
   (local.get $str/163)))
 (call $moonbit.incref
  (local.get $data/738))
 (call $moonbit.incref
  (local.get $str/163))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/738)
   (local.get $len/739)
   (local.get $str/163)
   (i32.const 0)
   (local.get $*tmp/740)))
 (local.set $len/742
  (i32.load offset=8
   (local.get $self/162)))
 (local.set $*tmp/948
  (call $moonbit.array_length
   (local.get $str/163)))
 (call $moonbit.decref
  (local.get $str/163))
 (local.set $*tmp/743
  (i32.mul
   (local.tee $*tmp/744
    (local.get $*tmp/948))
   (i32.const 2)))
 (local.set $*tmp/741
  (i32.add
   (local.get $len/742)
   (local.get $*tmp/743)))
 (i32.store offset=8
  (local.get $self/162)
  (local.get $*tmp/741))
 (call $moonbit.decref
  (local.get $self/162))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/154 i32) (param $bytes_offset/149 i32) (param $str/156 i32) (param $str_offset/152 i32) (param $length/150 i32) (result i32)
 (local $e1/148 i32)
 (local $e2/151 i32)
 (local $len1/153 i32)
 (local $len2/155 i32)
 (local $end_str_offset/157 i32)
 (local $i/158 i32)
 (local $j/159 i32)
 (local $c/160 i32)
 (local $*p/423 i32)
 (local $*p/426 i32)
 (local $*tmp/723 i32)
 (local $*tmp/724 i32)
 (local $*tmp/725 i32)
 (local $*tmp/726 i32)
 (local $*tmp/727 i32)
 (local $*tmp/728 i32)
 (local $*tmp/729 i32)
 (local $*tmp/730 i32)
 (local $*tmp/731 i32)
 (local $*tmp/732 i32)
 (local $*tmp/733 i32)
 (local $*arr/1029 i32)
 (local $*idx/1030 i32)
 (local $*arr/1031 i32)
 (local $*idx/1032 i32)
 (local.set $*tmp/733
  (i32.mul
   (local.get $length/150)
   (i32.const 2)))
 (local.set $e1/148
  (i32.sub
   (local.tee $*tmp/732
    (i32.add
     (local.get $bytes_offset/149)
     (local.get $*tmp/733)))
   (i32.const 1)))
 (local.set $e2/151
  (i32.sub
   (local.tee $*tmp/731
    (i32.add
     (local.get $str_offset/152)
     (local.get $length/150)))
   (i32.const 1)))
 (local.set $len1/153
  (call $moonbit.array_length
   (local.get $self/154)))
 (local.set $len2/155
  (call $moonbit.array_length
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
      (local.set $*tmp/723
       (i32.and
        (local.tee $*tmp/724
         (local.tee $*p/423
          (i32.and
           (local.tee $c/160
            (local.tee $*tmp/728
             (i32.load16_u offset=8
              (i32.add
               (local.get $str/156)
               (i32.shl
                (local.get $i/158)
                (i32.const 1))))))
           (i32.const 255))))
        (i32.const 255)))
      (local.get $self/154)
      (local.set $*idx/1032
       (local.get $j/159))
      (local.set $*arr/1031)
      (call $moonbit.check_range
       (local.get $*idx/1032)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1031))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1031)
        (local.get $*idx/1032))
       (local.get $*tmp/723))
      (local.set $*tmp/725
       (i32.add
        (local.get $j/159)
        (i32.const 1)))
      (local.set $*tmp/726
       (i32.and
        (local.tee $*tmp/727
         (local.tee $*p/426
          (i32.shr_u
           (local.get $c/160)
           (i32.const 8))))
        (i32.const 255)))
      (local.get $self/154)
      (local.set $*idx/1030
       (local.get $*tmp/725))
      (local.set $*arr/1029)
      (call $moonbit.check_range
       (local.get $*idx/1030)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1029))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1029)
        (local.get $*idx/1030))
       (local.get $*tmp/726))
      (local.set $*tmp/729
       (i32.add
        (local.get $i/158)
        (i32.const 1)))
      (local.set $*tmp/730
       (i32.add
        (local.get $j/159)
        (i32.const 2)))
      (local.get $*tmp/729)
      (local.get $*tmp/730)
      (br $loop:161))
     (else
      (call $moonbit.decref
       (local.get $str/156))
      (call $moonbit.decref
       (local.get $self/154)))))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $str/156))
   (call $moonbit.decref
    (local.get $self/154))
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/116 i32) (result i32)
 (local $*x/117 i32)
 (local $*x/0/118 i32)
 (local $*x/1/118 i32)
 (local $*x/2/118 i32)
 (local $*Some/119 i64)
 (local $*bind/120 i64)
 (local $*Some/121 i64)
 (local $*pkg_end/122 i32)
 (local $pkg/0/123 i32)
 (local $pkg/1/123 i32)
 (local $pkg/2/123 i32)
 (local $*bind/124 i64)
 (local $*Some/125 i64)
 (local $*start_loc_end/126 i32)
 (local $end_loc/0/127 i32)
 (local $end_loc/1/127 i32)
 (local $end_loc/2/127 i32)
 (local $*bind/128 i32)
 (local $*Some/129 i32)
 (local $*x/130 i32)
 (local $*end_line/0/131 i32)
 (local $*end_line/1/131 i32)
 (local $*end_line/2/131 i32)
 (local $*end_column/0/132 i32)
 (local $*end_column/1/132 i32)
 (local $*end_column/2/132 i32)
 (local $rest/0/133 i32)
 (local $rest/1/133 i32)
 (local $rest/2/133 i32)
 (local $*bind/135 i64)
 (local $*Some/136 i64)
 (local $*start_line_end/137 i32)
 (local $*bind/138 i64)
 (local $*Some/139 i64)
 (local $*filename_end/140 i32)
 (local $start_loc/0/141 i32)
 (local $start_loc/1/141 i32)
 (local $start_loc/2/141 i32)
 (local $*bind/142 i32)
 (local $*Some/143 i32)
 (local $*x/144 i32)
 (local $*start_line/0/145 i32)
 (local $*start_line/1/145 i32)
 (local $*start_line/2/145 i32)
 (local $*start_column/0/146 i32)
 (local $*start_column/1/146 i32)
 (local $*start_column/2/146 i32)
 (local $filename/0/147 i32)
 (local $filename/1/147 i32)
 (local $filename/2/147 i32)
 (local $*bind/321 i64)
 (local $*tmp/691 i64)
 (local $*tmp/692 i32)
 (local $*tmp/693 i32)
 (local $*tmp/694 i32)
 (local $end/695 i32)
 (local $start/696 i32)
 (local $*tmp/697 i32)
 (local $*tmp/698 i32)
 (local $end/699 i32)
 (local $start/700 i32)
 (local $*tmp/701 i32)
 (local $*tmp/702 i32)
 (local $*tmp/703 i64)
 (local $*tmp/704 i32)
 (local $*tmp/0/705 i32)
 (local $*tmp/1/705 i32)
 (local $*tmp/2/705 i32)
 (local $*tmp/0/706 i32)
 (local $*tmp/1/706 i32)
 (local $*tmp/2/706 i32)
 (local $*tmp/707 i32)
 (local $*tmp/708 i64)
 (local $*tmp/0/709 i32)
 (local $*tmp/1/709 i32)
 (local $*tmp/2/709 i32)
 (local $*tmp/710 i32)
 (local $*tmp/711 i64)
 (local $*tmp/712 i32)
 (local $*tmp/0/713 i32)
 (local $*tmp/1/713 i32)
 (local $*tmp/2/713 i32)
 (local $*tmp/714 i32)
 (local $*tmp/715 i64)
 (local $*tmp/0/716 i32)
 (local $*tmp/1/716 i32)
 (local $*tmp/2/716 i32)
 (local $*tmp/717 i32)
 (local $*tmp/718 i32)
 (local $*tmp/719 i32)
 (local $*tmp/720 i64)
 (local $*tmp/721 i32)
 (local $*tmp/722 i32)
 (local $*field/0/950 i32)
 (local $*field/1/950 i32)
 (local $*field/2/950 i32)
 (local $*field/0/951 i32)
 (local $*field/1/951 i32)
 (local $*field/2/951 i32)
 (local $*field/0/952 i32)
 (local $*field/1/952 i32)
 (local $*field/2/952 i32)
 (local $*field/0/953 i32)
 (local $*field/1/953 i32)
 (local $*field/2/953 i32)
 (local $*cnt/1014 i32)
 (local $*new_cnt/1015 i32)
 (local $*cnt/1016 i32)
 (local $*new_cnt/1017 i32)
 (local $ptr/1033 i32)
 (block $join:115
  (local.set $*tmp/691
   (i64.extend_i32_s
    (local.tee $*tmp/692
     (call $moonbit.array_length
      (local.get $repr/116)))))
  (call $moonbit.incref
   (local.get $repr/116))
  (if (result i32)
   (call $String::char_length_ge.inner
    (local.get $repr/116)
    (i32.const 1)
    (i32.const 0)
    (local.get $*tmp/691))
   (then
    (if (result i32)
     (i32.eq
      (local.tee $*x/117
       (local.tee $*tmp/722
        (i32.load16_u offset=8
         (i32.add
          (local.get $repr/116)
          (i32.shl
           (i32.const 0)
           (i32.const 1))))))
      (i32.const 64))
     (then
      (local.set $*tmp/720
       (i64.extend_i32_s
        (local.tee $*tmp/721
         (call $moonbit.array_length
          (local.get $repr/116)))))
      (call $moonbit.incref
       (local.get $repr/116))
      (local.set $*tmp/718
       (if (result i32)
        (i64.eq
         (local.tee $*bind/321
          (call $String::offset_of_nth_char.inner
           (local.get $repr/116)
           (i32.const 1)
           (i32.const 0)
           (local.get $*tmp/720)))
         (i64.const 4294967296))
        (then
         (call $moonbit.array_length
          (local.get $repr/116)))
        (else
         (i32.wrap_i64
          (local.tee $*Some/119
           (local.get $*bind/321))))))
      (local.set $*tmp/719
       (call $moonbit.array_length
        (local.get $repr/116)))
      (local.get $repr/116)
      (local.get $*tmp/718)
      (local.set $*x/2/118
       (local.get $*tmp/719))
      (local.set $*x/1/118)
      (local.set $*x/0/118)
      (local.set $*tmp/717
       (call $moonbit.array_length
        (global.get $moonbitlang/core/builtin.parse.*bind|5440)))
      (call $moonbit.incref
       (global.get $moonbitlang/core/builtin.parse.*bind|5440))
      (global.get $moonbitlang/core/builtin.parse.*bind|5440)
      (i32.const 0)
      (local.set $*tmp/2/716
       (local.get $*tmp/717))
      (local.set $*tmp/1/716)
      (local.set $*tmp/0/716)
      (call $moonbit.incref
       (local.get $*x/0/118))
      (if (result i32)
       (i64.eq
        (local.tee $*bind/120
         (call $StringView::find
          (local.get $*x/0/118)
          (local.get $*x/1/118)
          (local.get $*x/2/118)
          (local.get $*tmp/0/716)
          (local.get $*tmp/1/716)
          (local.get $*tmp/2/716)))
        (i64.const 4294967296))
       (then
        (call $moonbit.decref
         (local.get $*x/0/118))
        (unreachable))
       (else
        (local.set $*tmp/715
         (i64.extend_i32_s
          (local.tee $*pkg_end/122
           (i32.wrap_i64
            (local.tee $*Some/121
             (local.get $*bind/120))))))
        (call $moonbit.incref
         (local.get $*x/0/118))
        (call $StringView::view.inner
         (local.get $*x/0/118)
         (local.get $*x/1/118)
         (local.get $*x/2/118)
         (i32.const 0)
         (local.get $*tmp/715))
        (local.set $pkg/2/123)
        (local.set $pkg/1/123)
        (local.set $pkg/0/123)
        (local.set $*tmp/714
         (call $moonbit.array_length
          (global.get $moonbitlang/core/builtin.parse.*bind|5434)))
        (call $moonbit.incref
         (global.get $moonbitlang/core/builtin.parse.*bind|5434))
        (global.get $moonbitlang/core/builtin.parse.*bind|5434)
        (i32.const 0)
        (local.set $*tmp/2/713
         (local.get $*tmp/714))
        (local.set $*tmp/1/713)
        (local.set $*tmp/0/713)
        (call $moonbit.incref
         (local.get $*x/0/118))
        (if (result i32)
         (i64.eq
          (local.tee $*bind/124
           (call $StringView::rev_find
            (local.get $*x/0/118)
            (local.get $*x/1/118)
            (local.get $*x/2/118)
            (local.get $*tmp/0/713)
            (local.get $*tmp/1/713)
            (local.get $*tmp/2/713)))
          (i64.const 4294967296))
         (then
          (call $moonbit.decref
           (local.get $pkg/0/123))
          (call $moonbit.decref
           (local.get $*x/0/118))
          (unreachable))
         (else
          (local.set $*tmp/693
           (i32.add
            (local.tee $*start_loc_end/126
             (i32.wrap_i64
              (local.tee $*Some/125
               (local.get $*bind/124))))
            (i32.const 1)))
          (local.set $end/695
           (local.get $*x/2/118))
          (local.set $start/696
           (local.get $*x/1/118))
          (local.set $*tmp/694
           (i32.sub
            (local.get $end/695)
            (local.get $start/696)))
          (if (result i32)
           (i32.lt_s
            (local.get $*tmp/693)
            (local.get $*tmp/694))
           (then
            (local.set $*tmp/712
             (i32.add
              (local.get $*start_loc_end/126)
              (i32.const 1)))
            (call $moonbit.incref
             (local.get $*x/0/118))
            (call $StringView::view.inner
             (local.get $*x/0/118)
             (local.get $*x/1/118)
             (local.get $*x/2/118)
             (local.get $*tmp/712)
             (i64.const 4294967296))
            (local.set $end_loc/2/127)
            (local.set $end_loc/1/127)
            (local.tee $end_loc/0/127)
            (local.get $end_loc/1/127)
            (local.get $end_loc/2/127)
            (call $moonbitlang/core/builtin.parse.parse_loc|1101)
            (local.tee $*bind/128)
            (i32.const 0)
            (i32.eq)
            (if (result i32)
             (then
              (if
               (local.get $*bind/128)
               (then
                (call $moonbit.decref
                 (local.get $*bind/128)))
               (else))
              (call $moonbit.decref
               (local.get $pkg/0/123))
              (call $moonbit.decref
               (local.get $*x/0/118))
              (unreachable))
             (else
              (i32.load offset=24
               (local.tee $*x/130
                (local.tee $*Some/129
                 (local.get $*bind/128))))
              (i32.load offset=8
               (local.get $*x/130))
              (local.set $*field/2/953
               (i32.load offset=12
                (local.get $*x/130)))
              (local.set $*field/1/953)
              (local.tee $*field/0/953)
              (local.get $*field/1/953)
              (local.set $*end_line/2/131
               (local.get $*field/2/953))
              (local.set $*end_line/1/131)
              (local.set $*end_line/0/131)
              (i32.load offset=28
               (local.get $*x/130))
              (i32.load offset=16
               (local.get $*x/130))
              (local.set $*field/2/952
               (i32.load offset=20
                (local.get $*x/130)))
              (local.set $*field/1/952)
              (local.set $*field/0/952)
              (if
               (i32.gt_s
                (local.tee $*cnt/1014
                 (i32.load
                  (local.get $*x/130)))
                (i32.const 1))
               (then
                (call $moonbit.incref
                 (local.get $*field/0/952))
                (call $moonbit.incref
                 (local.get $*end_line/0/131))
                (local.set $*new_cnt/1015
                 (i32.sub
                  (local.get $*cnt/1014)
                  (i32.const 1)))
                (i32.store
                 (local.get $*x/130)
                 (local.get $*new_cnt/1015)))
               (else
                (if
                 (i32.eq
                  (local.get $*cnt/1014)
                  (i32.const 1))
                 (then
                  (call $moonbit.free
                   (local.get $*x/130)))
                 (else))))
              (local.get $*field/0/952)
              (local.get $*field/1/952)
              (local.set $*end_column/2/132
               (local.get $*field/2/952))
              (local.set $*end_column/1/132)
              (local.set $*end_column/0/132)
              (local.set $*tmp/711
               (i64.extend_i32_s
                (local.get $*start_loc_end/126)))
              (call $StringView::view.inner
               (local.get $*x/0/118)
               (local.get $*x/1/118)
               (local.get $*x/2/118)
               (i32.const 0)
               (local.get $*tmp/711))
              (local.set $rest/2/133)
              (local.set $rest/1/133)
              (local.set $rest/0/133)
              (block $join:134
               (local.set $*tmp/710
                (call $moonbit.array_length
                 (global.get $moonbitlang/core/builtin.parse.*bind|5421)))
               (call $moonbit.incref
                (global.get $moonbitlang/core/builtin.parse.*bind|5421))
               (global.get $moonbitlang/core/builtin.parse.*bind|5421)
               (i32.const 0)
               (local.set $*tmp/2/709
                (local.get $*tmp/710))
               (local.set $*tmp/1/709)
               (local.set $*tmp/0/709)
               (call $moonbit.incref
                (local.get $rest/0/133))
               (if (result i32)
                (i64.eq
                 (local.tee $*bind/135
                  (call $StringView::rev_find
                   (local.get $rest/0/133)
                   (local.get $rest/1/133)
                   (local.get $rest/2/133)
                   (local.get $*tmp/0/709)
                   (local.get $*tmp/1/709)
                   (local.get $*tmp/2/709)))
                 (i64.const 4294967296))
                (then
                 (call $moonbit.decref
                  (local.get $rest/0/133))
                 (call $moonbit.decref
                  (local.get $*end_column/0/132))
                 (call $moonbit.decref
                  (local.get $*end_line/0/131))
                 (call $moonbit.decref
                  (local.get $pkg/0/123))
                 (br $join:134))
                (else
                 (local.set $*tmp/708
                  (i64.extend_i32_s
                   (local.tee $*start_line_end/137
                    (i32.wrap_i64
                     (local.tee $*Some/136
                      (local.get $*bind/135))))))
                 (call $moonbit.incref
                  (local.get $rest/0/133))
                 (call $StringView::view.inner
                  (local.get $rest/0/133)
                  (local.get $rest/1/133)
                  (local.get $rest/2/133)
                  (i32.const 0)
                  (local.get $*tmp/708))
                 (local.set $*tmp/2/705)
                 (local.set $*tmp/1/705)
                 (local.set $*tmp/0/705)
                 (local.set $*tmp/707
                  (call $moonbit.array_length
                   (global.get $moonbitlang/core/builtin.parse.*bind|5415)))
                 (call $moonbit.incref
                  (global.get $moonbitlang/core/builtin.parse.*bind|5415))
                 (global.get $moonbitlang/core/builtin.parse.*bind|5415)
                 (i32.const 0)
                 (local.set $*tmp/2/706
                  (local.get $*tmp/707))
                 (local.set $*tmp/1/706)
                 (local.set $*tmp/0/706)
                 (if (result i32)
                  (i64.eq
                   (local.tee $*bind/138
                    (call $StringView::rev_find
                     (local.get $*tmp/0/705)
                     (local.get $*tmp/1/705)
                     (local.get $*tmp/2/705)
                     (local.get $*tmp/0/706)
                     (local.get $*tmp/1/706)
                     (local.get $*tmp/2/706)))
                   (i64.const 4294967296))
                  (then
                   (call $moonbit.decref
                    (local.get $rest/0/133))
                   (call $moonbit.decref
                    (local.get $*end_column/0/132))
                   (call $moonbit.decref
                    (local.get $*end_line/0/131))
                   (call $moonbit.decref
                    (local.get $pkg/0/123))
                   (br $join:134))
                  (else
                   (local.set $*tmp/697
                    (i32.add
                     (local.tee $*filename_end/140
                      (i32.wrap_i64
                       (local.tee $*Some/139
                        (local.get $*bind/138))))
                     (i32.const 1)))
                   (local.set $end/699
                    (local.get $rest/2/133))
                   (local.set $start/700
                    (local.get $rest/1/133))
                   (local.set $*tmp/698
                    (i32.sub
                     (local.get $end/699)
                     (local.get $start/700)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $*tmp/697)
                     (local.get $*tmp/698))
                    (then
                     (local.set $*tmp/704
                      (i32.add
                       (local.get $*filename_end/140)
                       (i32.const 1)))
                     (call $moonbit.incref
                      (local.get $rest/0/133))
                     (call $StringView::view.inner
                      (local.get $rest/0/133)
                      (local.get $rest/1/133)
                      (local.get $rest/2/133)
                      (local.get $*tmp/704)
                      (i64.const 4294967296))
                     (local.set $start_loc/2/141)
                     (local.set $start_loc/1/141)
                     (local.tee $start_loc/0/141)
                     (local.get $start_loc/1/141)
                     (local.get $start_loc/2/141)
                     (call $moonbitlang/core/builtin.parse.parse_loc|1101)
                     (local.tee $*bind/142)
                     (i32.const 0)
                     (i32.eq)
                     (if (result i32)
                      (then
                       (if
                        (local.get $*bind/142)
                        (then
                         (call $moonbit.decref
                          (local.get $*bind/142)))
                        (else))
                       (call $moonbit.decref
                        (local.get $rest/0/133))
                       (call $moonbit.decref
                        (local.get $*end_column/0/132))
                       (call $moonbit.decref
                        (local.get $*end_line/0/131))
                       (call $moonbit.decref
                        (local.get $pkg/0/123))
                       (unreachable))
                      (else
                       (i32.load offset=24
                        (local.tee $*x/144
                         (local.tee $*Some/143
                          (local.get $*bind/142))))
                       (i32.load offset=8
                        (local.get $*x/144))
                       (local.set $*field/2/951
                        (i32.load offset=12
                         (local.get $*x/144)))
                       (local.set $*field/1/951)
                       (local.tee $*field/0/951)
                       (local.get $*field/1/951)
                       (local.set $*start_line/2/145
                        (local.get $*field/2/951))
                       (local.set $*start_line/1/145)
                       (local.set $*start_line/0/145)
                       (i32.load offset=28
                        (local.get $*x/144))
                       (i32.load offset=16
                        (local.get $*x/144))
                       (local.set $*field/2/950
                        (i32.load offset=20
                         (local.get $*x/144)))
                       (local.set $*field/1/950)
                       (local.set $*field/0/950)
                       (if
                        (i32.gt_s
                         (local.tee $*cnt/1016
                          (i32.load
                           (local.get $*x/144)))
                         (i32.const 1))
                        (then
                         (call $moonbit.incref
                          (local.get $*field/0/950))
                         (call $moonbit.incref
                          (local.get $*start_line/0/145))
                         (local.set $*new_cnt/1017
                          (i32.sub
                           (local.get $*cnt/1016)
                           (i32.const 1)))
                         (i32.store
                          (local.get $*x/144)
                          (local.get $*new_cnt/1017)))
                        (else
                         (if
                          (i32.eq
                           (local.get $*cnt/1016)
                           (i32.const 1))
                          (then
                           (call $moonbit.free
                            (local.get $*x/144)))
                          (else))))
                       (local.get $*field/0/950)
                       (local.get $*field/1/950)
                       (local.set $*start_column/2/146
                        (local.get $*field/2/950))
                       (local.set $*start_column/1/146)
                       (local.set $*start_column/0/146)
                       (local.set $*tmp/701
                        (i32.add
                         (local.get $*pkg_end/122)
                         (i32.const 1)))
                       (if (result i32)
                        (i32.gt_s
                         (local.get $*filename_end/140)
                         (local.get $*tmp/701))
                        (then
                         (local.set $*tmp/702
                          (i32.add
                           (local.get $*pkg_end/122)
                           (i32.const 1)))
                         (local.set $*tmp/703
                          (i64.extend_i32_s
                           (local.get $*filename_end/140)))
                         (call $StringView::view.inner
                          (local.get $rest/0/133)
                          (local.get $rest/1/133)
                          (local.get $rest/2/133)
                          (local.get $*tmp/702)
                          (local.get $*tmp/703))
                         (local.set $filename/2/147)
                         (local.set $filename/1/147)
                         (local.set $filename/0/147)
                         (i32.store offset=4
                          (local.tee $ptr/1033
                           (call $moonbit.gc.malloc
                            (i32.const 72)))
                          (i32.const 7341568))
                         (i32.store offset=76
                          (local.get $ptr/1033)
                          (local.get $*end_column/0/132))
                         (i32.store offset=48
                          (local.get $ptr/1033)
                          (local.get $*end_column/1/132))
                         (i32.store offset=52
                          (local.get $ptr/1033)
                          (local.get $*end_column/2/132))
                         (i32.store offset=72
                          (local.get $ptr/1033)
                          (local.get $*end_line/0/131))
                         (i32.store offset=40
                          (local.get $ptr/1033)
                          (local.get $*end_line/1/131))
                         (i32.store offset=44
                          (local.get $ptr/1033)
                          (local.get $*end_line/2/131))
                         (i32.store offset=68
                          (local.get $ptr/1033)
                          (local.get $*start_column/0/146))
                         (i32.store offset=32
                          (local.get $ptr/1033)
                          (local.get $*start_column/1/146))
                         (i32.store offset=36
                          (local.get $ptr/1033)
                          (local.get $*start_column/2/146))
                         (i32.store offset=64
                          (local.get $ptr/1033)
                          (local.get $*start_line/0/145))
                         (i32.store offset=24
                          (local.get $ptr/1033)
                          (local.get $*start_line/1/145))
                         (i32.store offset=28
                          (local.get $ptr/1033)
                          (local.get $*start_line/2/145))
                         (i32.store offset=60
                          (local.get $ptr/1033)
                          (local.get $filename/0/147))
                         (i32.store offset=16
                          (local.get $ptr/1033)
                          (local.get $filename/1/147))
                         (i32.store offset=20
                          (local.get $ptr/1033)
                          (local.get $filename/2/147))
                         (i32.store offset=56
                          (local.get $ptr/1033)
                          (local.get $pkg/0/123))
                         (i32.store offset=8
                          (local.get $ptr/1033)
                          (local.get $pkg/1/123))
                         (i32.store offset=12
                          (local.get $ptr/1033)
                          (local.get $pkg/2/123))
                         (local.get $ptr/1033))
                        (else
                         (call $moonbit.decref
                          (local.get $*start_column/0/146))
                         (call $moonbit.decref
                          (local.get $*start_line/0/145))
                         (call $moonbit.decref
                          (local.get $rest/0/133))
                         (call $moonbit.decref
                          (local.get $*end_column/0/132))
                         (call $moonbit.decref
                          (local.get $*end_line/0/131))
                         (call $moonbit.decref
                          (local.get $pkg/0/123))
                         (unreachable))))))
                    (else
                     (call $moonbit.decref
                      (local.get $rest/0/133))
                     (call $moonbit.decref
                      (local.get $*end_column/0/132))
                     (call $moonbit.decref
                      (local.get $*end_line/0/131))
                     (call $moonbit.decref
                      (local.get $pkg/0/123))
                     (unreachable)))))))
               (return))
              (unreachable))))
           (else
            (call $moonbit.decref
             (local.get $pkg/0/123))
            (call $moonbit.decref
             (local.get $*x/0/118))
            (unreachable))))))))
     (else
      (call $moonbit.decref
       (local.get $repr/116))
      (br $join:115))))
   (else
    (call $moonbit.decref
     (local.get $repr/116))
    (br $join:115)))
  (return))
 (unreachable))
(func $moonbitlang/core/builtin.parse.parse_loc|1101 (param $view/0/112 i32) (param $view/1/112 i32) (param $view/2/112 i32) (result i32)
 (local $*bind/111 i64)
 (local $*Some/113 i64)
 (local $*i/114 i32)
 (local $*tmp/680 i32)
 (local $*tmp/681 i32)
 (local $end/682 i32)
 (local $start/683 i32)
 (local $*tuple/684 i32)
 (local $*tmp/0/685 i32)
 (local $*tmp/1/685 i32)
 (local $*tmp/2/685 i32)
 (local $*tmp/0/686 i32)
 (local $*tmp/1/686 i32)
 (local $*tmp/2/686 i32)
 (local $*tmp/687 i32)
 (local $*tmp/688 i64)
 (local $*tmp/0/689 i32)
 (local $*tmp/1/689 i32)
 (local $*tmp/2/689 i32)
 (local $*tmp/690 i32)
 (local $ptr/1034 i32)
 (local.set $*tmp/690
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.parse.*bind|5401)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.parse.*bind|5401))
 (global.get $moonbitlang/core/builtin.parse.*bind|5401)
 (i32.const 0)
 (local.set $*tmp/2/689
  (local.get $*tmp/690))
 (local.set $*tmp/1/689)
 (local.set $*tmp/0/689)
 (call $moonbit.incref
  (local.get $view/0/112))
 (if (result i32)
  (i64.eq
   (local.tee $*bind/111
    (call $StringView::find
     (local.get $view/0/112)
     (local.get $view/1/112)
     (local.get $view/2/112)
     (local.get $*tmp/0/689)
     (local.get $*tmp/1/689)
     (local.get $*tmp/2/689)))
   (i64.const 4294967296))
  (then
   (call $moonbit.decref
    (local.get $view/0/112))
   (i32.const 0))
  (else
   (if (result i32)
    (if (result i32)
     (i32.gt_s
      (local.tee $*i/114
       (i32.wrap_i64
        (local.tee $*Some/113
         (local.get $*bind/111))))
      (i32.const 0))
     (then
      (local.set $*tmp/680
       (i32.add
        (local.get $*i/114)
        (i32.const 1)))
      (local.set $end/682
       (local.get $view/2/112))
      (local.set $start/683
       (local.get $view/1/112))
      (local.set $*tmp/681
       (i32.sub
        (local.get $end/682)
        (local.get $start/683)))
      (i32.lt_s
       (local.get $*tmp/680)
       (local.get $*tmp/681)))
     (else
      (i32.const 0)))
    (then
     (local.set $*tmp/688
      (i64.extend_i32_s
       (local.get $*i/114)))
     (call $moonbit.incref
      (local.get $view/0/112))
     (call $StringView::view.inner
      (local.get $view/0/112)
      (local.get $view/1/112)
      (local.get $view/2/112)
      (i32.const 0)
      (local.get $*tmp/688))
     (local.set $*tmp/2/685)
     (local.set $*tmp/1/685)
     (local.set $*tmp/0/685)
     (local.set $*tmp/687
      (i32.add
       (local.get $*i/114)
       (i32.const 1)))
     (call $StringView::view.inner
      (local.get $view/0/112)
      (local.get $view/1/112)
      (local.get $view/2/112)
      (local.get $*tmp/687)
      (i64.const 4294967296))
     (local.set $*tmp/2/686)
     (local.set $*tmp/1/686)
     (local.set $*tmp/0/686)
     (i32.store offset=4
      (local.tee $ptr/1034
       (call $moonbit.gc.malloc
        (i32.const 24)))
      (i32.const 3146240))
     (i32.store offset=28
      (local.get $ptr/1034)
      (local.get $*tmp/0/686))
     (i32.store offset=16
      (local.get $ptr/1034)
      (local.get $*tmp/1/686))
     (i32.store offset=20
      (local.get $ptr/1034)
      (local.get $*tmp/2/686))
     (i32.store offset=24
      (local.get $ptr/1034)
      (local.get $*tmp/0/685))
     (i32.store offset=8
      (local.get $ptr/1034)
      (local.get $*tmp/1/685))
     (i32.store offset=12
      (local.get $ptr/1034)
      (local.get $*tmp/2/685))
     (local.tee $*tuple/684
      (local.get $ptr/1034)))
    (else
     (call $moonbit.decref
      (local.get $view/0/112))
     (i32.const 0))))))
(func $StringView::view.inner (param $self/0/109 i32) (param $self/1/109 i32) (param $self/2/109 i32) (param $start_offset/110 i32) (param $end_offset/107 i64) (result i32) (result i32) (result i32)
 (local $end_offset/106 i32)
 (local $*Some/108 i64)
 (local $*tmp/670 i32)
 (local $end/671 i32)
 (local $start/672 i32)
 (local $str/673 i32)
 (local $*tmp/674 i32)
 (local $*tmp/675 i32)
 (local $start/676 i32)
 (local $start/677 i32)
 (local $end/678 i32)
 (local $start/679 i32)
 (local $*field/954 i32)
 (local $*field/955 i32)
 (local.set $end_offset/106
  (if (result i32)
   (i64.eq
    (local.get $end_offset/107)
    (i64.const 4294967296))
   (then
    (local.set $end/678
     (local.get $self/2/109))
    (local.set $start/679
     (local.get $self/1/109))
    (i32.sub
     (local.get $end/678)
     (local.get $start/679)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/108
      (local.get $end_offset/107))))))
 (if (result i32) (result i32) (result i32)
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
      (local.set $end/671
       (local.get $self/2/109))
      (local.set $start/672
       (local.get $self/1/109))
      (local.set $*tmp/670
       (i32.sub
        (local.get $end/671)
        (local.get $start/672)))
      (i32.le_s
       (local.get $end_offset/106)
       (local.get $*tmp/670)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $str/673
    (local.tee $*field/955
     (local.get $self/0/109)))
   (local.set $*tmp/674
    (i32.add
     (local.tee $start/677
      (local.get $self/1/109))
     (local.get $start_offset/110)))
   (local.set $*tmp/675
    (i32.add
     (local.tee $start/676
      (local.tee $*field/954
       (local.get $self/1/109)))
     (local.get $end_offset/106)))
   (local.get $str/673)
   (local.get $*tmp/674)
   (local.get $*tmp/675))
  (else
   (call $moonbit.decref
    (local.get $self/0/109))
   (call $moonbitlang/core/builtin.abort|StringView|
    (i32.const 10776)
    (i32.const 10656)))))
(func $StringView::rev_find (param $self/0/105 i32) (param $self/1/105 i32) (param $self/2/105 i32) (param $str/0/104 i32) (param $str/1/104 i32) (param $str/2/104 i32) (result i64)
 (local $*tmp/667 i32)
 (local $end/668 i32)
 (local $start/669 i32)
 (local.set $end/668
  (local.get $str/2/104))
 (local.set $start/669
  (local.get $str/1/104))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/667
    (i32.sub
     (local.get $end/668)
     (local.get $start/669)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_rev_find
    (local.get $self/0/105)
    (local.get $self/1/105)
    (local.get $self/2/105)
    (local.get $str/0/104)
    (local.get $str/1/104)
    (local.get $str/2/104)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_rev_find
    (local.get $self/0/105)
    (local.get $self/1/105)
    (local.get $self/2/105)
    (local.get $str/0/104)
    (local.get $str/1/104)
    (local.get $str/2/104)))))
(func $moonbitlang/core/builtin.brute_force_rev_find (param $haystack/0/95 i32) (param $haystack/1/95 i32) (param $haystack/2/95 i32) (param $needle/0/97 i32) (param $needle/1/97 i32) (param $needle/2/97 i32) (result i64)
 (local $haystack_len/94 i32)
 (local $needle_len/96 i32)
 (local $needle_first/98 i32)
 (local $j/101 i32)
 (local $*p/400 i32)
 (local $*p/403 i32)
 (local $*p/406 i32)
 (local $*tmp/640 i32)
 (local $*tmp/641 i32)
 (local $str/642 i32)
 (local $*tmp/643 i32)
 (local $start/644 i32)
 (local $*tmp/645 i32)
 (local $*tmp/646 i32)
 (local $*tmp/647 i32)
 (local $*tmp/648 i32)
 (local $*tmp/649 i32)
 (local $str/650 i32)
 (local $*tmp/651 i32)
 (local $start/652 i32)
 (local $str/653 i32)
 (local $*tmp/654 i32)
 (local $start/655 i32)
 (local $*tmp/656 i32)
 (local $*tmp/657 i32)
 (local $*tmp/658 i32)
 (local $*tmp/659 i32)
 (local $str/660 i32)
 (local $*tmp/661 i32)
 (local $start/662 i32)
 (local $end/663 i32)
 (local $start/664 i32)
 (local $end/665 i32)
 (local $start/666 i32)
 (local $*tmp/956 i32)
 (local $*field/957 i32)
 (local $*tmp/958 i32)
 (local $*field/959 i32)
 (local $*tmp/960 i32)
 (local $*field/961 i32)
 (local $*tmp/962 i32)
 (local $*field/963 i32)
 (local $i/99 i32)
 (local.set $end/665
  (local.get $haystack/2/95))
 (local.set $start/666
  (local.get $haystack/1/95))
 (local.set $haystack_len/94
  (i32.sub
   (local.get $end/665)
   (local.get $start/666)))
 (local.set $end/663
  (local.get $needle/2/97))
 (local.set $start/664
  (local.get $needle/1/97))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/96
    (i32.sub
     (local.get $end/663)
     (local.get $start/664)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/94)
     (local.get $needle_len/96))
    (then
     (local.set $*p/400
      (i32.const 0))
     (local.set $str/660
      (local.tee $*field/963
       (local.get $needle/0/97)))
     (local.set $*tmp/661
      (i32.add
       (local.tee $start/662
        (local.get $needle/1/97))
       (local.get $*p/400)))
     (local.set $needle_first/98
      (local.tee $*tmp/962
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/660)
         (i32.shl
          (local.get $*tmp/661)
          (i32.const 1))))))
     (local.set $i/99
      (i32.sub
       (local.get $haystack_len/94)
       (local.get $needle_len/96)))
     (loop $loop:103
      (if
       (i32.ge_s
        (local.tee $*tmp/640
         (local.get $i/99))
        (i32.const 0))
       (then
        (loop $loop:100
         (if
          (if (result i32)
           (i32.ge_s
            (local.tee $*tmp/645
             (local.get $i/99))
            (i32.const 0))
           (then
            (local.set $*p/403
             (local.get $i/99))
            (local.set $str/642
             (local.tee $*field/961
              (local.get $haystack/0/95)))
            (local.set $*tmp/643
             (i32.add
              (local.tee $start/644
               (local.get $haystack/1/95))
              (local.get $*p/403)))
            (local.tee $*tmp/641
             (local.tee $*tmp/960
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/642)
                (i32.shl
                 (local.get $*tmp/643)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/98)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/99
            (i32.sub
             (local.tee $*tmp/646
              (local.get $i/99))
             (i32.const 1)))
           (br $loop:100))
          (else)))
        (if
         (i32.ge_s
          (local.tee $*tmp/647
           (local.get $i/99))
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
              (local.set $*p/406
               (i32.add
                (local.tee $*tmp/656
                 (local.get $i/99))
                (local.get $j/101)))
              (local.set $str/653
               (local.tee $*field/959
                (local.get $haystack/0/95)))
              (local.set $*tmp/654
               (i32.add
                (local.tee $start/655
                 (local.get $haystack/1/95))
                (local.get $*p/406)))
              (local.set $*tmp/648
               (local.tee $*tmp/958
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/653)
                  (i32.shl
                   (local.get $*tmp/654)
                   (i32.const 1))))))
              (local.set $str/650
               (local.tee $*field/957
                (local.get $needle/0/97)))
              (local.set $*tmp/651
               (i32.add
                (local.tee $start/652
                 (local.get $needle/1/97))
                (local.get $j/101)))
              (local.set $*tmp/649
               (local.tee $*tmp/956
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/650)
                  (i32.shl
                   (local.get $*tmp/651)
                   (i32.const 1))))))
              (local.get $*tmp/648)
              (if
               (i32.ne
                (local.get $*tmp/649))
               (then
                (br $break:102))
               (else))
              (local.tee $*tmp/657
               (i32.add
                (local.get $j/101)
                (i32.const 1)))
              (br $loop:102))
             (else
              (call $moonbit.decref
               (local.get $needle/0/97))
              (call $moonbit.decref
               (local.get $haystack/0/95))
              (i64.extend_i32_s
               (local.tee $*tmp/658
                (local.get $i/99)))
              (return)))))
          (local.set $i/99
           (i32.sub
            (local.tee $*tmp/659
             (local.get $i/99))
            (i32.const 1))))
         (else))
        (br $loop:103))
       (else
        (call $moonbit.decref
         (local.get $needle/0/97))
        (call $moonbit.decref
         (local.get $haystack/0/95)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/97))
     (call $moonbit.decref
      (local.get $haystack/0/95))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/97))
   (call $moonbit.decref
    (local.get $haystack/0/95))
   (i64.extend_i32_s
    (local.get $haystack_len/94)))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_rev_find (param $haystack/0/84 i32) (param $haystack/1/84 i32) (param $haystack/2/84 i32) (param $needle/0/86 i32) (param $needle/1/86 i32) (param $needle/2/86 i32) (result i64)
 (local $haystack_len/83 i32)
 (local $needle_len/85 i32)
 (local $skip_table/87 i32)
 (local $i/88 i32)
 (local $i/90 i32)
 (local $j/91 i32)
 (local $*p/389 i32)
 (local $*tmp/612 i32)
 (local $*tmp/613 i32)
 (local $str/614 i32)
 (local $*tmp/615 i32)
 (local $start/616 i32)
 (local $*tmp/617 i32)
 (local $*tmp/618 i32)
 (local $*tmp/619 i32)
 (local $*tmp/620 i32)
 (local $str/621 i32)
 (local $*tmp/622 i32)
 (local $start/623 i32)
 (local $str/624 i32)
 (local $*tmp/625 i32)
 (local $start/626 i32)
 (local $*tmp/627 i32)
 (local $*tmp/628 i32)
 (local $*tmp/629 i32)
 (local $*tmp/630 i32)
 (local $*tmp/631 i32)
 (local $str/632 i32)
 (local $*tmp/633 i32)
 (local $start/634 i32)
 (local $*tmp/635 i32)
 (local $end/636 i32)
 (local $start/637 i32)
 (local $end/638 i32)
 (local $start/639 i32)
 (local $*tmp/964 i32)
 (local $*field/965 i32)
 (local $*tmp/966 i32)
 (local $*field/967 i32)
 (local $*tmp/968 i32)
 (local $*field/969 i32)
 (local $*tmp/970 i32)
 (local $*field/971 i32)
 (local $*arr/1035 i32)
 (local $*idx/1036 i32)
 (local $*arr/1037 i32)
 (local $*idx/1038 i32)
 (local.set $end/638
  (local.get $haystack/2/84))
 (local.set $start/639
  (local.get $haystack/1/84))
 (local.set $haystack_len/83
  (i32.sub
   (local.get $end/638)
   (local.get $start/639)))
 (local.set $end/636
  (local.get $needle/2/86))
 (local.set $start/637
  (local.get $needle/1/86))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/85
    (i32.sub
     (local.get $end/636)
     (local.get $start/637)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/83)
     (local.get $needle_len/85))
    (then
     (local.set $skip_table/87
      (call $moonbit.i32_array_make
       (i32.const 256)
       (local.get $needle_len/85)))
     (local.tee $*tmp/618
      (i32.sub
       (local.get $needle_len/85)
       (i32.const 1)))
     (loop $loop:89 (param i32)
      (local.tee $i/88)
      (i32.const 0)
      (i32.gt_s)
      (if
       (then
        (local.set $str/614
         (local.tee $*field/971
          (local.get $needle/0/86)))
        (local.set $*tmp/615
         (i32.add
          (local.tee $start/616
           (local.get $needle/1/86))
          (local.get $i/88)))
        (local.set $*tmp/612
         (i32.and
          (local.tee $*tmp/613
           (local.tee $*tmp/970
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/614)
              (i32.shl
               (local.get $*tmp/615)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/87)
        (local.set $*idx/1038
         (local.get $*tmp/612))
        (local.set $*arr/1037)
        (call $moonbit.check_range
         (local.get $*idx/1038)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1037))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1037)
          (i32.shl
           (local.get $*idx/1038)
           (i32.const 2)))
         (local.get $i/88))
        (local.tee $*tmp/617
         (i32.sub
          (local.get $i/88)
          (i32.const 1)))
        (br $loop:89))
       (else)))
     (local.tee $*tmp/635
      (i32.sub
       (local.get $haystack_len/83)
       (local.get $needle_len/85)))
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
            (local.set $*p/389
             (i32.add
              (local.get $i/90)
              (local.get $j/91)))
            (local.set $str/624
             (local.tee $*field/969
              (local.get $haystack/0/84)))
            (local.set $*tmp/625
             (i32.add
              (local.tee $start/626
               (local.get $haystack/1/84))
              (local.get $*p/389)))
            (local.set $*tmp/619
             (local.tee $*tmp/968
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/624)
                (i32.shl
                 (local.get $*tmp/625)
                 (i32.const 1))))))
            (local.set $str/621
             (local.tee $*field/967
              (local.get $needle/0/86)))
            (local.set $*tmp/622
             (i32.add
              (local.tee $start/623
               (local.get $needle/1/86))
              (local.get $j/91)))
            (local.set $*tmp/620
             (local.tee $*tmp/966
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/621)
                (i32.shl
                 (local.get $*tmp/622)
                 (i32.const 1))))))
            (local.get $*tmp/619)
            (if
             (i32.ne
              (local.get $*tmp/620))
             (then
              (br $break:92))
             (else))
            (local.tee $*tmp/627
             (i32.add
              (local.get $j/91)
              (i32.const 1)))
            (br $loop:92))
           (else
            (call $moonbit.decref
             (local.get $skip_table/87))
            (call $moonbit.decref
             (local.get $needle/0/86))
            (call $moonbit.decref
             (local.get $haystack/0/84))
            (i64.extend_i32_s
             (local.get $i/90))
            (return)))))
        (local.set $str/632
         (local.tee $*field/965
          (local.get $haystack/0/84)))
        (local.set $*tmp/633
         (i32.add
          (local.tee $start/634
           (local.get $haystack/1/84))
          (local.get $i/90)))
        (local.set $*tmp/630
         (i32.and
          (local.tee $*tmp/631
           (local.tee $*tmp/964
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/632)
              (i32.shl
               (local.get $*tmp/633)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/87)
        (local.set $*idx/1036
         (local.get $*tmp/630))
        (local.set $*arr/1035)
        (call $moonbit.check_range
         (local.get $*idx/1036)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1035))
          (i32.const 1)))
        (local.set $*tmp/629
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1035)
           (i32.shl
            (local.get $*idx/1036)
            (i32.const 2)))))
        (local.tee $*tmp/628
         (i32.sub
          (local.get $i/90)
          (local.get $*tmp/629)))
        (br $loop:93))
       (else
        (call $moonbit.decref
         (local.get $skip_table/87))
        (call $moonbit.decref
         (local.get $needle/0/86))
        (call $moonbit.decref
         (local.get $haystack/0/84)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/86))
     (call $moonbit.decref
      (local.get $haystack/0/84))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/86))
   (call $moonbit.decref
    (local.get $haystack/0/84))
   (i64.extend_i32_s
    (local.get $haystack_len/83)))))
(func $StringView::find (param $self/0/82 i32) (param $self/1/82 i32) (param $self/2/82 i32) (param $str/0/81 i32) (param $str/1/81 i32) (param $str/2/81 i32) (result i64)
 (local $*tmp/609 i32)
 (local $end/610 i32)
 (local $start/611 i32)
 (local.set $end/610
  (local.get $str/2/81))
 (local.set $start/611
  (local.get $str/1/81))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/609
    (i32.sub
     (local.get $end/610)
     (local.get $start/611)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_find
    (local.get $self/0/82)
    (local.get $self/1/82)
    (local.get $self/2/82)
    (local.get $str/0/81)
    (local.get $str/1/81)
    (local.get $str/2/81)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_find
    (local.get $self/0/82)
    (local.get $self/1/82)
    (local.get $self/2/82)
    (local.get $str/0/81)
    (local.get $str/1/81)
    (local.get $str/2/81)))))
(func $moonbitlang/core/builtin.brute_force_find (param $haystack/0/71 i32) (param $haystack/1/71 i32) (param $haystack/2/71 i32) (param $needle/0/73 i32) (param $needle/1/73 i32) (param $needle/2/73 i32) (result i64)
 (local $haystack_len/70 i32)
 (local $needle_len/72 i32)
 (local $needle_first/74 i32)
 (local $forward_len/75 i32)
 (local $j/78 i32)
 (local $*p/370 i32)
 (local $*p/373 i32)
 (local $*p/376 i32)
 (local $*tmp/582 i32)
 (local $*tmp/583 i32)
 (local $str/584 i32)
 (local $*tmp/585 i32)
 (local $start/586 i32)
 (local $*tmp/587 i32)
 (local $*tmp/588 i32)
 (local $*tmp/589 i32)
 (local $*tmp/590 i32)
 (local $*tmp/591 i32)
 (local $str/592 i32)
 (local $*tmp/593 i32)
 (local $start/594 i32)
 (local $str/595 i32)
 (local $*tmp/596 i32)
 (local $start/597 i32)
 (local $*tmp/598 i32)
 (local $*tmp/599 i32)
 (local $*tmp/600 i32)
 (local $*tmp/601 i32)
 (local $str/602 i32)
 (local $*tmp/603 i32)
 (local $start/604 i32)
 (local $end/605 i32)
 (local $start/606 i32)
 (local $end/607 i32)
 (local $start/608 i32)
 (local $*tmp/972 i32)
 (local $*field/973 i32)
 (local $*tmp/974 i32)
 (local $*field/975 i32)
 (local $*tmp/976 i32)
 (local $*field/977 i32)
 (local $*tmp/978 i32)
 (local $*field/979 i32)
 (local $i/76 i32)
 (local.set $end/607
  (local.get $haystack/2/71))
 (local.set $start/608
  (local.get $haystack/1/71))
 (local.set $haystack_len/70
  (i32.sub
   (local.get $end/607)
   (local.get $start/608)))
 (local.set $end/605
  (local.get $needle/2/73))
 (local.set $start/606
  (local.get $needle/1/73))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/72
    (i32.sub
     (local.get $end/605)
     (local.get $start/606)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/70)
     (local.get $needle_len/72))
    (then
     (local.set $*p/370
      (i32.const 0))
     (local.set $str/602
      (local.tee $*field/979
       (local.get $needle/0/73)))
     (local.set $*tmp/603
      (i32.add
       (local.tee $start/604
        (local.get $needle/1/73))
       (local.get $*p/370)))
     (local.set $needle_first/74
      (local.tee $*tmp/978
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/602)
         (i32.shl
          (local.get $*tmp/603)
          (i32.const 1))))))
     (local.set $forward_len/75
      (i32.sub
       (local.get $haystack_len/70)
       (local.get $needle_len/72)))
     (local.set $i/76
      (i32.const 0))
     (loop $loop:80
      (if
       (i32.le_s
        (local.tee $*tmp/582
         (local.get $i/76))
        (local.get $forward_len/75))
       (then
        (loop $loop:77
         (if
          (if (result i32)
           (i32.le_s
            (local.tee $*tmp/587
             (local.get $i/76))
            (local.get $forward_len/75))
           (then
            (local.set $*p/373
             (local.get $i/76))
            (local.set $str/584
             (local.tee $*field/977
              (local.get $haystack/0/71)))
            (local.set $*tmp/585
             (i32.add
              (local.tee $start/586
               (local.get $haystack/1/71))
              (local.get $*p/373)))
            (local.tee $*tmp/583
             (local.tee $*tmp/976
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/584)
                (i32.shl
                 (local.get $*tmp/585)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/74)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/76
            (i32.add
             (local.tee $*tmp/588
              (local.get $i/76))
             (i32.const 1)))
           (br $loop:77))
          (else)))
        (if
         (i32.le_s
          (local.tee $*tmp/589
           (local.get $i/76))
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
              (local.set $*p/376
               (i32.add
                (local.tee $*tmp/598
                 (local.get $i/76))
                (local.get $j/78)))
              (local.set $str/595
               (local.tee $*field/975
                (local.get $haystack/0/71)))
              (local.set $*tmp/596
               (i32.add
                (local.tee $start/597
                 (local.get $haystack/1/71))
                (local.get $*p/376)))
              (local.set $*tmp/590
               (local.tee $*tmp/974
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/595)
                  (i32.shl
                   (local.get $*tmp/596)
                   (i32.const 1))))))
              (local.set $str/592
               (local.tee $*field/973
                (local.get $needle/0/73)))
              (local.set $*tmp/593
               (i32.add
                (local.tee $start/594
                 (local.get $needle/1/73))
                (local.get $j/78)))
              (local.set $*tmp/591
               (local.tee $*tmp/972
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/592)
                  (i32.shl
                   (local.get $*tmp/593)
                   (i32.const 1))))))
              (local.get $*tmp/590)
              (if
               (i32.ne
                (local.get $*tmp/591))
               (then
                (br $break:79))
               (else))
              (local.tee $*tmp/599
               (i32.add
                (local.get $j/78)
                (i32.const 1)))
              (br $loop:79))
             (else
              (call $moonbit.decref
               (local.get $needle/0/73))
              (call $moonbit.decref
               (local.get $haystack/0/71))
              (i64.extend_i32_s
               (local.tee $*tmp/600
                (local.get $i/76)))
              (return)))))
          (local.set $i/76
           (i32.add
            (local.tee $*tmp/601
             (local.get $i/76))
            (i32.const 1))))
         (else))
        (br $loop:80))
       (else
        (call $moonbit.decref
         (local.get $needle/0/73))
        (call $moonbit.decref
         (local.get $haystack/0/71)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/73))
     (call $moonbit.decref
      (local.get $haystack/0/71))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/73))
   (call $moonbit.decref
    (local.get $haystack/0/71))
   (global.get $moonbitlang/core/builtin.brute_force_find.constr/69))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_find (param $haystack/0/57 i32) (param $haystack/1/57 i32) (param $haystack/2/57 i32) (param $needle/0/59 i32) (param $needle/1/59 i32) (param $needle/2/59 i32) (result i64)
 (local $haystack_len/56 i32)
 (local $needle_len/58 i32)
 (local $skip_table/60 i32)
 (local $*end4298/61 i32)
 (local $i/62 i32)
 (local $i/64 i32)
 (local $*end4304/65 i32)
 (local $j/66 i32)
 (local $*p/358 i32)
 (local $*p/363 i32)
 (local $*tmp/552 i32)
 (local $*tmp/553 i32)
 (local $*tmp/554 i32)
 (local $*tmp/555 i32)
 (local $str/556 i32)
 (local $*tmp/557 i32)
 (local $start/558 i32)
 (local $*tmp/559 i32)
 (local $*tmp/560 i32)
 (local $*tmp/561 i32)
 (local $*tmp/562 i32)
 (local $str/563 i32)
 (local $*tmp/564 i32)
 (local $start/565 i32)
 (local $str/566 i32)
 (local $*tmp/567 i32)
 (local $start/568 i32)
 (local $*tmp/569 i32)
 (local $*tmp/570 i32)
 (local $*tmp/571 i32)
 (local $*tmp/572 i32)
 (local $*tmp/573 i32)
 (local $str/574 i32)
 (local $*tmp/575 i32)
 (local $start/576 i32)
 (local $*tmp/577 i32)
 (local $end/578 i32)
 (local $start/579 i32)
 (local $end/580 i32)
 (local $start/581 i32)
 (local $*tmp/980 i32)
 (local $*field/981 i32)
 (local $*tmp/982 i32)
 (local $*field/983 i32)
 (local $*tmp/984 i32)
 (local $*field/985 i32)
 (local $*tmp/986 i32)
 (local $*field/987 i32)
 (local $*arr/1039 i32)
 (local $*idx/1040 i32)
 (local $*arr/1041 i32)
 (local $*idx/1042 i32)
 (local.set $end/580
  (local.get $haystack/2/57))
 (local.set $start/581
  (local.get $haystack/1/57))
 (local.set $haystack_len/56
  (i32.sub
   (local.get $end/580)
   (local.get $start/581)))
 (local.set $end/578
  (local.get $needle/2/59))
 (local.set $start/579
  (local.get $needle/1/59))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/58
    (i32.sub
     (local.get $end/578)
     (local.get $start/579)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/56)
     (local.get $needle_len/58))
    (then
     (local.set $skip_table/60
      (call $moonbit.i32_array_make
       (i32.const 256)
       (local.get $needle_len/58)))
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
        (local.set $str/556
         (local.tee $*field/987
          (local.get $needle/0/59)))
        (local.set $*tmp/557
         (i32.add
          (local.tee $start/558
           (local.get $needle/1/59))
          (local.get $i/62)))
        (local.set $*tmp/552
         (i32.and
          (local.tee $*tmp/555
           (local.tee $*tmp/986
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/556)
              (i32.shl
               (local.get $*tmp/557)
               (i32.const 1))))))
          (i32.const 255)))
        (local.set $*tmp/553
         (i32.sub
          (local.tee $*tmp/554
           (i32.sub
            (local.get $needle_len/58)
            (i32.const 1)))
          (local.get $i/62)))
        (local.get $skip_table/60)
        (local.set $*idx/1042
         (local.get $*tmp/552))
        (local.set $*arr/1041)
        (call $moonbit.check_range
         (local.get $*idx/1042)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1041))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1041)
          (i32.shl
           (local.get $*idx/1042)
           (i32.const 2)))
         (local.get $*tmp/553))
        (local.tee $*tmp/559
         (i32.add
          (local.get $i/62)
          (i32.const 1)))
        (br $loop:63))
       (else)))
     (i32.const 0)
     (loop $loop:68 (param i32)
      (local.set $i/64)
      (local.set $*tmp/560
       (i32.sub
        (local.get $haystack_len/56)
        (local.get $needle_len/58)))
      (if
       (i32.le_s
        (local.get $i/64)
        (local.get $*tmp/560))
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
            (local.set $*p/358
             (i32.add
              (local.get $i/64)
              (local.get $j/66)))
            (local.set $str/566
             (local.tee $*field/985
              (local.get $haystack/0/57)))
            (local.set $*tmp/567
             (i32.add
              (local.tee $start/568
               (local.get $haystack/1/57))
              (local.get $*p/358)))
            (local.set $*tmp/561
             (local.tee $*tmp/984
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/566)
                (i32.shl
                 (local.get $*tmp/567)
                 (i32.const 1))))))
            (local.set $str/563
             (local.tee $*field/983
              (local.get $needle/0/59)))
            (local.set $*tmp/564
             (i32.add
              (local.tee $start/565
               (local.get $needle/1/59))
              (local.get $j/66)))
            (local.set $*tmp/562
             (local.tee $*tmp/982
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/563)
                (i32.shl
                 (local.get $*tmp/564)
                 (i32.const 1))))))
            (local.get $*tmp/561)
            (if
             (i32.ne
              (local.get $*tmp/562))
             (then
              (br $break:67))
             (else))
            (local.tee $*tmp/569
             (i32.add
              (local.get $j/66)
              (i32.const 1)))
            (br $loop:67))
           (else
            (call $moonbit.decref
             (local.get $skip_table/60))
            (call $moonbit.decref
             (local.get $needle/0/59))
            (call $moonbit.decref
             (local.get $haystack/0/57))
            (i64.extend_i32_s
             (local.get $i/64))
            (return)))))
        (local.set $*p/363
         (i32.sub
          (local.tee $*tmp/577
           (i32.add
            (local.get $i/64)
            (local.get $needle_len/58)))
          (i32.const 1)))
        (local.set $str/574
         (local.tee $*field/981
          (local.get $haystack/0/57)))
        (local.set $*tmp/575
         (i32.add
          (local.tee $start/576
           (local.get $haystack/1/57))
          (local.get $*p/363)))
        (local.set $*tmp/572
         (i32.and
          (local.tee $*tmp/573
           (local.tee $*tmp/980
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/574)
              (i32.shl
               (local.get $*tmp/575)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/60)
        (local.set $*idx/1040
         (local.get $*tmp/572))
        (local.set $*arr/1039)
        (call $moonbit.check_range
         (local.get $*idx/1040)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1039))
          (i32.const 1)))
        (local.set $*tmp/571
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1039)
           (i32.shl
            (local.get $*idx/1040)
            (i32.const 2)))))
        (local.tee $*tmp/570
         (i32.add
          (local.get $i/64)
          (local.get $*tmp/571)))
        (br $loop:68))
       (else
        (call $moonbit.decref
         (local.get $skip_table/60))
        (call $moonbit.decref
         (local.get $needle/0/59))
        (call $moonbit.decref
         (local.get $haystack/0/57)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/59))
     (call $moonbit.decref
      (local.get $haystack/0/57))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/59))
   (call $moonbit.decref
    (local.get $haystack/0/57))
   (global.get $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/47 i32) (param $ch/49 i32) (result i32)
 (local $inc/48 i32)
 (local $*tmp/541 i32)
 (local $len/542 i32)
 (local $*tmp/543 i32)
 (local $len/544 i32)
 (local $data/545 i32)
 (local $len/546 i32)
 (local $*field/992 i32)
 (local.set $*tmp/541
  (i32.add
   (local.tee $len/542
    (i32.load offset=8
     (local.get $self/47)))
   (i32.const 4)))
 (call $moonbit.incref
  (local.get $self/47))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/47)
   (local.get $*tmp/541)))
 (local.set $data/545
  (local.tee $*field/992
   (i32.load offset=12
    (local.get $self/47))))
 (local.set $len/546
  (i32.load offset=8
   (local.get $self/47)))
 (call $moonbit.incref
  (local.get $data/545))
 (local.set $inc/48
  (call $FixedArray::set_utf16le_char
   (local.get $data/545)
   (local.get $len/546)
   (local.get $ch/49)))
 (local.set $*tmp/543
  (i32.add
   (local.tee $len/544
    (i32.load offset=8
     (local.get $self/47)))
   (local.get $inc/48)))
 (i32.store offset=8
  (local.get $self/47)
  (local.get $*tmp/543))
 (call $moonbit.decref
  (local.get $self/47))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/42 i32) (param $required/43 i32) (result i32)
 (local $current_len/41 i32)
 (local $new_data/46 i32)
 (local $*tmp/535 i32)
 (local $*tmp/536 i32)
 (local $data/537 i32)
 (local $len/538 i32)
 (local $*tmp/539 i32)
 (local $data/540 i32)
 (local $*old/993 i32)
 (local $*field/994 i32)
 (local $*tmp/995 i32)
 (local $*field/996 i32)
 (local $enough_space/44 i32)
 (local.set $current_len/41
  (local.tee $*tmp/995
   (call $moonbit.array_length
    (local.tee $data/540
     (local.tee $*field/996
      (i32.load offset=12
       (local.get $self/42)))))))
 (if
  (i32.le_s
   (local.get $required/43)
   (local.get $current_len/41))
  (then
   (call $moonbit.decref
    (local.get $self/42))
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/44
  (local.get $current_len/41))
 (loop $loop:45
  (if
   (i32.lt_s
    (local.tee $*tmp/535
     (local.get $enough_space/44))
    (local.get $required/43))
   (then
    (local.set $enough_space/44
     (i32.mul
      (local.tee $*tmp/536
       (local.get $enough_space/44))
      (i32.const 2)))
    (br $loop:45))
   (else)))
 (local.set $new_data/46
  (call $moonbit.bytes_make
   (local.tee $*tmp/539
    (local.get $enough_space/44))
   (i32.const 0)))
 (local.set $data/537
  (local.tee $*field/994
   (i32.load offset=12
    (local.get $self/42))))
 (local.set $len/538
  (i32.load offset=8
   (local.get $self/42)))
 (call $moonbit.incref
  (local.get $data/537))
 (call $moonbit.incref
  (local.get $new_data/46))
 (drop
  (call $FixedArray::unsafe_blit|Byte|
   (local.get $new_data/46)
   (i32.const 0)
   (local.get $data/537)
   (i32.const 0)
   (local.get $len/538)))
 (call $moonbit.decref
  (local.tee $*old/993
   (i32.load offset=12
    (local.get $self/42))))
 (i32.store offset=12
  (local.get $self/42)
  (local.get $new_data/46))
 (call $moonbit.decref
  (local.get $self/42))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/36 i32) (param $offset/37 i32) (param $value/35 i32) (result i32)
 (local $code/34 i32)
 (local $hi/38 i32)
 (local $lo/39 i32)
 (local $hi/40 i32)
 (local $*p/332 i32)
 (local $*p/335 i32)
 (local $*p/338 i32)
 (local $*p/341 i32)
 (local $*p/344 i32)
 (local $*p/347 i32)
 (local $*tmp/516 i32)
 (local $*tmp/517 i32)
 (local $*tmp/518 i32)
 (local $*tmp/519 i32)
 (local $*tmp/520 i32)
 (local $*tmp/521 i32)
 (local $*tmp/522 i32)
 (local $*tmp/523 i32)
 (local $*tmp/524 i32)
 (local $*tmp/525 i32)
 (local $*tmp/526 i32)
 (local $*tmp/527 i32)
 (local $*tmp/528 i32)
 (local $*tmp/529 i32)
 (local $*tmp/530 i32)
 (local $*tmp/531 i32)
 (local $*tmp/532 i32)
 (local $*tmp/533 i32)
 (local $*tmp/534 i32)
 (local $*arr/1043 i32)
 (local $*idx/1044 i32)
 (local $*arr/1045 i32)
 (local $*idx/1046 i32)
 (local $*arr/1047 i32)
 (local $*idx/1048 i32)
 (local $*arr/1049 i32)
 (local $*idx/1050 i32)
 (local $*arr/1051 i32)
 (local $*idx/1052 i32)
 (local $*arr/1053 i32)
 (local $*idx/1054 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/34
    (local.tee $*tmp/534
     (local.get $value/35)))
   (i32.const 65536))
  (then
   (local.set $*tmp/516
    (i32.and
     (local.tee $*tmp/517
      (local.tee $*p/332
       (i32.and
        (local.get $code/34)
        (i32.const 255))))
     (i32.const 255)))
   (local.get $self/36)
   (local.set $*idx/1046
    (local.get $offset/37))
   (local.set $*arr/1045)
   (call $moonbit.check_range
    (local.get $*idx/1046)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1045))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1045)
     (local.get $*idx/1046))
    (local.get $*tmp/516))
   (local.set $*tmp/518
    (i32.add
     (local.get $offset/37)
     (i32.const 1)))
   (local.set $*tmp/519
    (i32.and
     (local.tee $*tmp/520
      (local.tee $*p/335
       (i32.shr_u
        (local.get $code/34)
        (i32.const 8))))
     (i32.const 255)))
   (local.get $self/36)
   (local.set $*idx/1044
    (local.get $*tmp/518))
   (local.set $*arr/1043)
   (call $moonbit.check_range
    (local.get $*idx/1044)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1043))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1043)
     (local.get $*idx/1044))
    (local.get $*tmp/519))
   (call $moonbit.decref
    (local.get $self/36))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/34)
     (i32.const 1114112))
    (then
     (local.set $lo/39
      (i32.or
       (local.tee $*tmp/533
        (i32.shr_u
         (local.tee $hi/38
          (i32.sub
           (local.get $code/34)
           (i32.const 65536)))
         (i32.const 10)))
       (i32.const 55296)))
     (local.set $hi/40
      (i32.or
       (local.tee $*tmp/532
        (i32.and
         (local.get $hi/38)
         (i32.const 1023)))
       (i32.const 56320)))
     (local.set $*tmp/521
      (i32.and
       (local.tee $*tmp/522
        (local.tee $*p/338
         (i32.and
          (local.get $lo/39)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1054
      (local.get $offset/37))
     (local.set $*arr/1053)
     (call $moonbit.check_range
      (local.get $*idx/1054)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1053))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1053)
       (local.get $*idx/1054))
      (local.get $*tmp/521))
     (local.set $*tmp/523
      (i32.add
       (local.get $offset/37)
       (i32.const 1)))
     (local.set $*tmp/524
      (i32.and
       (local.tee $*tmp/525
        (local.tee $*p/341
         (i32.shr_u
          (local.get $lo/39)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1052
      (local.get $*tmp/523))
     (local.set $*arr/1051)
     (call $moonbit.check_range
      (local.get $*idx/1052)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1051))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1051)
       (local.get $*idx/1052))
      (local.get $*tmp/524))
     (local.set $*tmp/526
      (i32.add
       (local.get $offset/37)
       (i32.const 2)))
     (local.set $*tmp/527
      (i32.and
       (local.tee $*tmp/528
        (local.tee $*p/344
         (i32.and
          (local.get $hi/40)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1050
      (local.get $*tmp/526))
     (local.set $*arr/1049)
     (call $moonbit.check_range
      (local.get $*idx/1050)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1049))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1049)
       (local.get $*idx/1050))
      (local.get $*tmp/527))
     (local.set $*tmp/529
      (i32.add
       (local.get $offset/37)
       (i32.const 3)))
     (local.set $*tmp/530
      (i32.and
       (local.tee $*tmp/531
        (local.tee $*p/347
         (i32.shr_u
          (local.get $hi/40)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1048
      (local.get $*tmp/529))
     (local.set $*arr/1047)
     (call $moonbit.check_range
      (local.get $*idx/1048)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1047))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1047)
       (local.get $*idx/1048))
      (local.get $*tmp/530))
     (call $moonbit.decref
      (local.get $self/36))
     (i32.const 4))
    (else
     (call $moonbit.decref
      (local.get $self/36))
     (call $moonbitlang/core/builtin.abort|Int|
      (i32.const 10944)
      (i32.const 10832)))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/31 i32) (result i32)
 (local $*tmp/510 i32)
 (local $*tmp/511 i64)
 (local $len/512 i32)
 (local $data/513 i32)
 (local $*field/997 i32)
 (local $*field/998 i32)
 (call $moonbit.incref
  (local.tee $data/513
   (local.tee $*field/998
    (i32.load offset=12
     (local.get $self/31)))))
 (local.set $*tmp/510
  (local.get $data/513))
 (local.set $*field/997
  (i32.load offset=8
   (local.get $self/31)))
 (call $moonbit.decref
  (local.get $self/31))
 (local.set $*tmp/511
  (i64.extend_i32_s
   (local.tee $len/512
    (local.get $*field/997))))
 (call $Bytes::to_unchecked_string.inner
  (local.get $*tmp/510)
  (i32.const 0)
  (local.get $*tmp/511)))
(func $Bytes::to_unchecked_string.inner (param $self/26 i32) (param $offset/30 i32) (param $length/28 i64) (result i32)
 (local $len/25 i32)
 (local $length/27 i32)
 (local $*Some/29 i64)
 (local $*tmp/509 i32)
 (local.set $len/25
  (call $moonbit.array_length
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
 (if (result i32)
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
       (local.tee $*tmp/509
        (i32.add
         (local.get $offset/30)
         (local.get $length/27)))
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
   (call $moonbit.decref
    (local.get $self/26))
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/462 i32) (param $*param/463 i32) (param $*param/464 i32) (result i32)
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/462)
  (local.get $*param/463)
  (local.get $*param/464)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/23 i32) (result i32)
 (local $initial/22 i32)
 (local $data/24 i32)
 (local $ptr/1055 i32)
 (local.set $data/24
  (call $moonbit.bytes_make
   (local.tee $initial/22
    (if (result i32)
     (i32.lt_s
      (local.get $size_hint/23)
      (i32.const 1))
     (then
      (i32.const 1))
     (else
      (local.get $size_hint/23))))
   (i32.const 0)))
 (i32.store offset=4
  (local.tee $ptr/1055
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1055)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/1055)
  (local.get $data/24))
 (local.get $ptr/1055))
(func $FixedArray::unsafe_blit|Byte| (param $dst/13 i32) (param $dst_offset/15 i32) (param $src/14 i32) (param $src_offset/16 i32) (param $len/18 i32) (result i32)
 (local $i/17 i32)
 (local $i/20 i32)
 (local $*tmp/500 i32)
 (local $*tmp/501 i32)
 (local $*tmp/502 i32)
 (local $*tmp/503 i32)
 (local $*tmp/504 i32)
 (local $*tmp/505 i32)
 (local $*tmp/506 i32)
 (local $*tmp/507 i32)
 (local $*tmp/508 i32)
 (local $*arr/1056 i32)
 (local $*idx/1057 i32)
 (local $*arr/1058 i32)
 (local $*idx/1059 i32)
 (local $*arr/1060 i32)
 (local $*idx/1061 i32)
 (local $*arr/1062 i32)
 (local $*idx/1063 i32)
 (if (result i32)
  (if (result i32)
   (i32.eq
    (local.get $dst/13)
    (local.get $src/14))
   (then
    (i32.lt_s
     (local.get $dst_offset/15)
     (local.get $src_offset/16)))
   (else
    (i32.const 0)))
  (then
   (i32.const 0)
   (loop $loop:19 (param i32)
    (local.tee $i/17)
    (local.get $len/18)
    (i32.lt_s)
    (if
     (then
      (local.set $*tmp/500
       (i32.add
        (local.get $dst_offset/15)
        (local.get $i/17)))
      (local.set $*tmp/502
       (i32.add
        (local.get $src_offset/16)
        (local.get $i/17)))
      (local.get $src/14)
      (local.set $*idx/1059
       (local.get $*tmp/502))
      (local.set $*arr/1058)
      (call $moonbit.check_range
       (local.get $*idx/1059)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1058))
        (i32.const 1)))
      (local.set $*tmp/501
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1058)
         (local.get $*idx/1059))))
      (local.get $dst/13)
      (local.set $*idx/1057
       (local.get $*tmp/500))
      (local.set $*arr/1056)
      (call $moonbit.check_range
       (local.get $*idx/1057)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1056))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1056)
        (local.get $*idx/1057))
       (local.get $*tmp/501))
      (local.tee $*tmp/503
       (i32.add
        (local.get $i/17)
        (i32.const 1)))
      (br $loop:19))
     (else
      (call $moonbit.decref
       (local.get $src/14))
      (call $moonbit.decref
       (local.get $dst/13)))))
   (i32.const 0))
  (else
   (local.tee $*tmp/508
    (i32.sub
     (local.get $len/18)
     (i32.const 1)))
   (loop $loop:21 (param i32)
    (local.tee $i/20)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/504
       (i32.add
        (local.get $dst_offset/15)
        (local.get $i/20)))
      (local.set $*tmp/506
       (i32.add
        (local.get $src_offset/16)
        (local.get $i/20)))
      (local.get $src/14)
      (local.set $*idx/1063
       (local.get $*tmp/506))
      (local.set $*arr/1062)
      (call $moonbit.check_range
       (local.get $*idx/1063)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1062))
        (i32.const 1)))
      (local.set $*tmp/505
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1062)
         (local.get $*idx/1063))))
      (local.get $dst/13)
      (local.set $*idx/1061
       (local.get $*tmp/504))
      (local.set $*arr/1060)
      (call $moonbit.check_range
       (local.get $*idx/1061)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1060))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1060)
        (local.get $*idx/1061))
       (local.get $*tmp/505))
      (local.tee $*tmp/507
       (i32.sub
        (local.get $i/20)
        (i32.const 1)))
      (br $loop:21))
     (else
      (call $moonbit.decref
       (local.get $src/14))
      (call $moonbit.decref
       (local.get $dst/13)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.abort|Option<Int>| (param $string/11 i32) (param $loc/12 i32) (result i64)
 (local $*tmp/496 i32)
 (local $*tmp/497 i32)
 (local $*tmp/498 i32)
 (local $*tmp/499 i32)
 (local.set $*tmp/498
  (call $moonbit.add_string
   (local.get $string/11)
   (i32.const 11008)))
 (local.set $*tmp/499
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/12)))
 (call $moonbitlang/core/abort.abort|Option<Int>|
  (local.tee $*tmp/496
   (call $moonbit.add_string
    (local.tee $*tmp/497
     (call $moonbit.add_string
      (local.get $*tmp/498)
      (local.get $*tmp/499)))
    (i32.const 10992)))))
(func $moonbitlang/core/builtin.abort|StringView| (param $string/9 i32) (param $loc/10 i32) (result i32) (result i32) (result i32)
 (local $*tmp/492 i32)
 (local $*tmp/493 i32)
 (local $*tmp/494 i32)
 (local $*tmp/495 i32)
 (local.set $*tmp/494
  (call $moonbit.add_string
   (local.get $string/9)
   (i32.const 11008)))
 (local.set $*tmp/495
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/10)))
 (call $moonbitlang/core/abort.abort|StringView|
  (local.tee $*tmp/492
   (call $moonbit.add_string
    (local.tee $*tmp/493
     (call $moonbit.add_string
      (local.get $*tmp/494)
      (local.get $*tmp/495)))
    (i32.const 10992)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/7 i32) (param $loc/8 i32) (result i32)
 (local $*tmp/488 i32)
 (local $*tmp/489 i32)
 (local $*tmp/490 i32)
 (local $*tmp/491 i32)
 (local.set $*tmp/490
  (call $moonbit.add_string
   (local.get $string/7)
   (i32.const 11008)))
 (local.set $*tmp/491
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/8)))
 (call $moonbitlang/core/abort.abort|Int|
  (local.tee $*tmp/488
   (call $moonbit.add_string
    (local.tee $*tmp/489
     (call $moonbit.add_string
      (local.get $*tmp/490)
      (local.get $*tmp/491)))
    (i32.const 10992)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/5 i32) (param $loc/6 i32) (result i32)
 (local $*tmp/484 i32)
 (local $*tmp/485 i32)
 (local $*tmp/486 i32)
 (local $*tmp/487 i32)
 (local.set $*tmp/486
  (call $moonbit.add_string
   (local.get $string/5)
   (i32.const 11008)))
 (local.set $*tmp/487
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/6)))
 (call $moonbitlang/core/abort.abort|Unit|
  (local.tee $*tmp/484
   (call $moonbit.add_string
    (local.tee $*tmp/485
     (call $moonbit.add_string
      (local.get $*tmp/486)
      (local.get $*tmp/487)))
    (i32.const 10992)))))
(func $moonbitlang/core/abort.abort|Option<Int>| (param $msg/4 i32) (result i64)
 (call $moonbit.decref
  (local.get $msg/4))
 (unreachable))
(func $moonbitlang/core/abort.abort|StringView| (param $msg/3 i32) (result i32) (result i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/3))
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/2 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/2))
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/1 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/1))
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/478 i32) (param $*param/477 i32) (result i32)
 (local $*self/476 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/476
   (local.get $*obj_ptr/478))
  (local.get $*param/477)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/475 i32) (param $*param/0/474 i32) (param $*param/1/474 i32) (param $*param/2/474 i32) (result i32)
 (local $*self/473 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/473
   (local.get $*obj_ptr/475))
  (local.get $*param/0/474)
  (local.get $*param/1/474)
  (local.get $*param/2/474)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (param $*obj_ptr/472 i32) (param $*param/469 i32) (param $*param/470 i32) (param $*param/471 i32) (result i32)
 (local $*self/468 i32)
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/468
   (local.get $*obj_ptr/472))
  (local.get $*param/469)
  (local.get $*param/470)
  (local.get $*param/471)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/467 i32) (param $*param/466 i32) (result i32)
 (local $*self/465 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/465
   (local.get $*obj_ptr/467))
  (local.get $*param/466)))
(start $*init*/2)
(func $*init*/2
 (global.set $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55
  (i64.extend_i32_s
   (i32.const 0)))
 (global.set $moonbitlang/core/builtin.brute_force_find.constr/69
  (i64.extend_i32_s
   (i32.const 0))))
(func $*main*/1
 (local $int_box/319 i32)
 (local $str_box/320 i32)
 (local $*tmp/479 i32)
 (local $*tmp/480 i32)
 (local $value/481 i32)
 (local $*tmp/482 i32)
 (local $value/483 i32)
 (local $*field/999 i32)
 (local $*field/1000 i32)
 (local $*cnt/1018 i32)
 (local $*new_cnt/1019 i32)
 (local.set $int_box/319
  (call $@username/moonbit_examples/cmd/generics.Box::new|Int|
   (i32.const 42)))
 (local.set $str_box/320
  (call $@username/moonbit_examples/cmd/generics.Box::new|String|
   (i32.const 11136)))
 (local.set $*field/1000
  (i32.load offset=8
   (local.get $int_box/319)))
 (call $moonbit.decref
  (local.get $int_box/319))
 (local.set $*tmp/480
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $value/481
    (local.get $*field/1000))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/479
    (call $moonbit.add_string
     (i32.const 11088)
     (local.get $*tmp/480)))))
 (local.set $*field/999
  (i32.load offset=8
   (local.get $str_box/320)))
 (if
  (i32.gt_s
   (local.tee $*cnt/1018
    (i32.load
     (local.get $str_box/320)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/999))
   (local.set $*new_cnt/1019
    (i32.sub
     (local.get $*cnt/1018)
     (i32.const 1)))
   (i32.store
    (local.get $str_box/320)
    (local.get $*new_cnt/1019)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1018)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $str_box/320)))
    (else))))
 (local.set $value/483
  (local.get $*field/999))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/482
    (call $moonbit.add_string
     (i32.const 11032)
     (local.get $value/483))))))
(export "_start" (func $*main*/1))