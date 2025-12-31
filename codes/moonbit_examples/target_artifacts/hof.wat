(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data  (memory $moonbit.memory) (offset (i32.const 10000)) "\FF\FF\FF\FF\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\003\006\006\00:\005\00-\003\006\006\00:\003\003\00\00\00\00\00\00\00\FF\FF\FF\FF\13\00\00PI\00n\00v\00a\00l\00i\00d\00 \00s\00t\00a\00r\00t\00 \00i\00n\00d\00e\00x\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\004\009\001\00:\009\00-\004\009\001\00:\004\000\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00Pi\00n\00v\00a\00l\00i\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00 \00p\00a\00i\00r\00\00\00\00\00\FF\FF\FF\FF\01\00\00P0\00\00\00\00\00\00\00\FF\FF\FF\FF4\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00Pr\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\FF\FF\FF\FF$\00\00P0\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF5\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00v\00i\00e\00w\00.\00m\00b\00t\00:\001\001\001\00:\005\00-\001\001\001\00:\003\006\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00PI\00n\00v\00a\00l\00i\00d\00 \00i\00n\00d\00e\00x\00 \00f\00o\00r\00 \00V\00i\00e\00w\00\00\00\00\00\FF\FF\FF\FF0\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\000\00:\005\00-\002\009\000\00:\003\001\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\11\00\00PC\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P\0A\00\00\00\00\00\00\00\FF\FF\FF\FF\06\00\00P\0A\00 \00 \00a\00t\00 \00\00\00\00\00\FF\FF\FF\FF\13\00\00PA\00p\00p\00l\00y\00 \00s\00q\00u\00a\00r\00e\00 \00t\00o\00 \005\00:\00 \00\00\00\FF\FF\FF\FF\13\00\00PA\00p\00p\00l\00y\00 \00d\00o\00u\00b\00l\00e\00 \00t\00o\00 \005\00:\00 \00\00\00\FF\FF\FF\FF\00\04\10\00\00\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\FF\FF\FF\FF\01\00\00P:\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P-\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P/\00\00\00\00\00\00\00\FF\FF\FF\FF\00\00 \00\04\00\00\00\00\00\00\00\FF\FF\FF\FF\00\00 \00\05\00\00\00\00\00\00\00")
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
    (i32.const 11232)
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
   (i32.const 11232)
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
(type $<Int>=>Int
 (func
  (param i32) (param i32)
  (result i32)))
(table $moonbit.global 6 6 funcref )
(elem
 (table $moonbit.global) (offset (i32.const 0))
 funcref
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $username/moonbit_examples/cmd/hof.*init*.square|4.dyncall)
 (ref.func $username/moonbit_examples/cmd/hof.*init*.double|2.dyncall))
(global $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id
 i32
 (i32.const 11128)
)
(global $moonbitlang/core/builtin.parse.*bind|5401
 i32
 (i32.const 11152)
)
(global $moonbitlang/core/builtin.parse.*bind|5440
 i32
 (i32.const 11152)
)
(global $moonbitlang/core/builtin.parse.*bind|5434
 i32
 (i32.const 11168)
)
(global $moonbitlang/core/builtin.parse.*bind|5421
 i32
 (i32.const 11152)
)
(global $moonbitlang/core/builtin.parse.*bind|5415
 i32
 (i32.const 11152)
)
(global $moonbitlang/core/builtin.output.*bind|8190
 i32
 (i32.const 11184)
)
(global $moonbitlang/core/builtin.output.*bind|8184
 i32
 (i32.const 11184)
)
(global $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/builtin.brute_force_find.constr/69
 (mut i64)
 (i64.const 0)
)
(global $username/moonbit_examples/cmd/hof.*init*.double|2.clo
 (mut i32)
 (i32.const 0)
)
(global $username/moonbit_examples/cmd/hof.*init*.square|4.clo
 (mut i32)
 (i32.const 0)
)
(func $username/moonbit_examples/cmd/hof.*init*.square|4.dyncall (param $*env/925 i32) (param $x/318 i32) (result i32)
 (call $username/moonbit_examples/cmd/hof.*init*.square|4
  (local.get $x/318)))
(func $username/moonbit_examples/cmd/hof.*init*.double|2.dyncall (param $*env/924 i32) (param $x/317 i32) (result i32)
 (call $username/moonbit_examples/cmd/hof.*init*.double|2
  (local.get $x/317)))
(func $username/moonbit_examples/cmd/hof.*init*.square|4 (param $x/318 i32) (result i32)
 (i32.mul
  (local.get $x/318)
  (local.get $x/318)))
(func $username/moonbit_examples/cmd/hof.*init*.double|2 (param $x/317 i32) (result i32)
 (i32.mul
  (local.get $x/317)
  (i32.const 2)))
(func $username/moonbit_examples/cmd/hof.apply (param $f/315 i32) (param $x/316 i32) (result i32)
 (call_indirect $moonbit.global (type $<Int>=>Int)
  (local.get $f/315)
  (local.get $x/316)
  (i32.load offset=8
   (local.get $f/315))))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/313 i32) (param $logger/0/314 i32) (param $logger/1/314 i32) (result i32)
 (local $*tmp/922 i32)
 (local $*tmp/923 i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (local.tee $*tmp/922
   (call $@moonbitlang/core/builtin.SourceLocRepr::parse
    (local.tee $*tmp/923
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
 (local $*bind/0/901 i32)
 (local $*bind/1/901 i32)
 (local $*bind/0/902 i32)
 (local $*bind/1/902 i32)
 (local $filename/0/903 i32)
 (local $filename/1/903 i32)
 (local $filename/2/903 i32)
 (local $start_line/0/904 i32)
 (local $start_line/1/904 i32)
 (local $start_line/2/904 i32)
 (local $start_column/0/905 i32)
 (local $start_column/1/905 i32)
 (local $start_column/2/905 i32)
 (local $end_line/0/906 i32)
 (local $end_line/1/906 i32)
 (local $end_line/2/906 i32)
 (local $end_column/0/907 i32)
 (local $end_column/1/907 i32)
 (local $end_column/2/907 i32)
 (local $None/908 i32)
 (local $None/909 i32)
 (local $*tmp/0/910 i32)
 (local $*tmp/1/910 i32)
 (local $*tmp/2/910 i32)
 (local $Some/911 i32)
 (local $*tmp/0/912 i32)
 (local $*tmp/1/912 i32)
 (local $*tmp/2/912 i32)
 (local $*tmp/913 i32)
 (local $*tmp/914 i64)
 (local $*tmp/915 i32)
 (local $*tmp/0/916 i32)
 (local $*tmp/1/916 i32)
 (local $*tmp/2/916 i32)
 (local $*tmp/0/917 i32)
 (local $*tmp/1/917 i32)
 (local $*tmp/2/917 i32)
 (local $*tmp/918 i32)
 (local $*tmp/919 i32)
 (local $*tmp/0/920 i32)
 (local $*tmp/1/920 i32)
 (local $*tmp/2/920 i32)
 (local $*tmp/921 i32)
 (local $*field/0/926 i32)
 (local $*field/1/926 i32)
 (local $*field/2/926 i32)
 (local $*field/0/927 i32)
 (local $*field/1/927 i32)
 (local $*field/2/927 i32)
 (local $*field/0/928 i32)
 (local $*field/1/928 i32)
 (local $*field/2/928 i32)
 (local $*field/0/929 i32)
 (local $*field/1/929 i32)
 (local $*field/2/929 i32)
 (local $*field/0/930 i32)
 (local $*field/1/930 i32)
 (local $*field/2/930 i32)
 (local $*field/0/931 i32)
 (local $*field/1/931 i32)
 (local $*field/2/931 i32)
 (local $*field/932 i32)
 (local $*field/0/933 i32)
 (local $*field/1/933 i32)
 (local $*field/2/933 i32)
 (local $*field/0/934 i32)
 (local $*field/1/934 i32)
 (local $*field/2/934 i32)
 (local $*cnt/991 i32)
 (local $*new_cnt/992 i32)
 (local $*cnt/993 i32)
 (local $*new_cnt/994 i32)
 (local $*cnt/995 i32)
 (local $*field/0/996 i32)
 (local $*field/1/996 i32)
 (local $*field/2/996 i32)
 (local $*field/0/997 i32)
 (local $*field/1/997 i32)
 (local $*field/2/997 i32)
 (local $*field/0/998 i32)
 (local $*field/1/998 i32)
 (local $*field/2/998 i32)
 (local $*field/0/999 i32)
 (local $*field/1/999 i32)
 (local $*field/2/999 i32)
 (local $*field/0/1000 i32)
 (local $*field/1/1000 i32)
 (local $*field/2/1000 i32)
 (local $*new_cnt/1001 i32)
 (local $*tag/1006 i32)
 (local $ptr/1007 i32)
 (local $ptr/1008 i32)
 (local $ptr/1009 i32)
 (local $ptr/1010 i32)
 (i32.load offset=56
  (local.get $self/299))
 (i32.load offset=8
  (local.get $self/299))
 (local.set $*field/2/934
  (i32.load offset=12
   (local.get $self/299)))
 (local.set $*field/1/934)
 (local.tee $*field/0/934)
 (local.get $*field/1/934)
 (local.set $pkg/2/298
  (local.get $*field/2/934))
 (local.set $pkg/1/298)
 (local.set $pkg/0/298)
 (local.set $*tmp/921
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.output.*bind|8190)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.output.*bind|8190))
 (global.get $moonbitlang/core/builtin.output.*bind|8190)
 (i32.const 0)
 (local.set $*tmp/2/920
  (local.get $*tmp/921))
 (local.set $*tmp/1/920)
 (local.set $*tmp/0/920)
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
       (local.get $*tmp/0/920)
       (local.get $*tmp/1/920)
       (local.get $*tmp/2/920)))
     (i64.const 4294967296))
    (then
     (local.set $None/908
      (i32.const 10000))
     (i32.store offset=4
      (local.tee $ptr/1007
       (call $moonbit.gc.malloc
        (i32.const 16)))
      (i32.const 2097664))
     (i32.store offset=20
      (local.get $ptr/1007)
      (local.get $None/908))
     (i32.store offset=16
      (local.get $ptr/1007)
      (local.get $pkg/0/298))
     (i32.store offset=8
      (local.get $ptr/1007)
      (local.get $pkg/1/298))
     (i32.store offset=12
      (local.get $ptr/1007)
      (local.get $pkg/2/298))
     (local.get $ptr/1007))
    (else
     (local.set $*tmp/919
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
      (local.get $*tmp/919)
      (i64.const 4294967296))
     (local.set $*tmp/2/916)
     (local.set $*tmp/1/916)
     (local.set $*tmp/0/916)
     (local.set $*tmp/918
      (call $moonbit.array_length
       (global.get $moonbitlang/core/builtin.output.*bind|8184)))
     (call $moonbit.incref
      (global.get $moonbitlang/core/builtin.output.*bind|8184))
     (global.get $moonbitlang/core/builtin.output.*bind|8184)
     (i32.const 0)
     (local.set $*tmp/2/917
      (local.get $*tmp/918))
     (local.set $*tmp/1/917)
     (local.set $*tmp/0/917)
     (if (result i32)
      (i64.eq
       (local.tee $*bind/304
        (call $StringView::find
         (local.get $*tmp/0/916)
         (local.get $*tmp/1/916)
         (local.get $*tmp/2/916)
         (local.get $*tmp/0/917)
         (local.get $*tmp/1/917)
         (local.get $*tmp/2/917)))
       (i64.const 4294967296))
      (then
       (local.set $None/909
        (i32.const 10000))
       (i32.store offset=4
        (local.tee $ptr/1008
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1008)
        (local.get $None/909))
       (i32.store offset=16
        (local.get $ptr/1008)
        (local.get $pkg/0/298))
       (i32.store offset=8
        (local.get $ptr/1008)
        (local.get $pkg/1/298))
       (i32.store offset=12
        (local.get $ptr/1008)
        (local.get $pkg/2/298))
       (local.get $ptr/1008))
      (else
       (local.set $*second_slash/306
        (i32.wrap_i64
         (local.tee $*Some/305
          (local.get $*bind/304))))
       (local.set $*tmp/914
        (i64.extend_i32_s
         (local.tee $module_name_end/307
          (i32.add
           (local.tee $*tmp/915
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
        (local.get $*tmp/914))
       (local.set $*tmp/2/910)
       (local.set $*tmp/1/910)
       (local.set $*tmp/0/910)
       (local.set $*tmp/913
        (i32.add
         (local.get $module_name_end/307)
         (i32.const 1)))
       (call $StringView::view.inner
        (local.get $pkg/0/298)
        (local.get $pkg/1/298)
        (local.get $pkg/2/298)
        (local.get $*tmp/913)
        (i64.const 4294967296))
       (local.set $*tmp/2/912)
       (local.set $*tmp/1/912)
       (local.set $*tmp/0/912)
       (i32.store offset=4
        (local.tee $ptr/1010
         (call $moonbit.gc.malloc
          (i32.const 12)))
        (i32.const 2097409))
       (i32.store offset=16
        (local.get $ptr/1010)
        (local.get $*tmp/0/912))
       (i32.store offset=8
        (local.get $ptr/1010)
        (local.get $*tmp/1/912))
       (i32.store offset=12
        (local.get $ptr/1010)
        (local.get $*tmp/2/912))
       (local.set $Some/911
        (local.get $ptr/1010))
       (i32.store offset=4
        (local.tee $ptr/1009
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1009)
        (local.get $Some/911))
       (i32.store offset=16
        (local.get $ptr/1009)
        (local.get $*tmp/0/910))
       (i32.store offset=8
        (local.get $ptr/1009)
        (local.get $*tmp/1/910))
       (i32.store offset=12
        (local.get $ptr/1009)
        (local.get $*tmp/2/910))
       (local.get $ptr/1009)))))))
 (i32.load offset=8
  (local.get $*bind/301))
 (local.set $*field/2/933
  (i32.load offset=12
   (local.get $*bind/301)))
 (local.set $*field/1/933)
 (local.tee $*field/0/933)
 (local.get $*field/1/933)
 (local.set $*module_name/2/308
  (local.get $*field/2/933))
 (local.set $*module_name/1/308)
 (local.set $*module_name/0/308)
 (local.set $*field/932
  (i32.load offset=20
   (local.get $*bind/301)))
 (if
  (i32.gt_s
   (local.tee $*cnt/991
    (i32.load
     (local.get $*bind/301)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/932))
   (call $moonbit.incref
    (local.get $*module_name/0/308))
   (local.set $*new_cnt/992
    (i32.sub
     (local.get $*cnt/991)
     (i32.const 1)))
   (i32.store
    (local.get $*bind/301)
    (local.get $*new_cnt/992)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/991)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*bind/301)))
    (else))))
 (if
  (i32.eq
   (local.tee $*tag/1006
    (call $moonbit.get_tag
     (local.tee $*package_name/309
      (local.get $*field/932))))
   (i32.const 1))
  (then
   (i32.load offset=16
    (local.tee $*Some/310
     (local.get $*package_name/309)))
   (i32.load offset=8
    (local.get $*Some/310))
   (local.set $*field/2/931
    (i32.load offset=12
     (local.get $*Some/310)))
   (local.set $*field/1/931)
   (local.set $*field/0/931)
   (if
    (i32.gt_s
     (local.tee $*cnt/993
      (i32.load
       (local.get $*Some/310)))
     (i32.const 1))
    (then
     (call $moonbit.incref
      (local.get $*field/0/931))
     (local.set $*new_cnt/994
      (i32.sub
       (local.get $*cnt/993)
       (i32.const 1)))
     (i32.store
      (local.get $*Some/310)
      (local.get $*new_cnt/994)))
    (else
     (if
      (i32.eq
       (local.get $*cnt/993)
       (i32.const 1))
      (then
       (call $moonbit.free
        (local.get $*Some/310)))
      (else))))
   (local.get $*field/0/931)
   (local.get $*field/1/931)
   (local.set $*pkg_name/2/311
    (local.get $*field/2/931))
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
   (local.set $*bind/1/901
    (local.get $logger/1/312))
   (local.set $*bind/0/901)
   (if
    (local.get $*bind/1/901)
    (then
     (call $moonbit.incref
      (local.get $*bind/1/901)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
     (local.get $*bind/1/901)
     (i32.const 47)
     (i32.load offset=20
      (local.get $*bind/0/901)))))
  (else
   (call $moonbit.decref
    (local.get $*package_name/309))))
 (i32.load offset=60
  (local.get $self/299))
 (i32.load offset=16
  (local.get $self/299))
 (local.set $*field/2/930
  (i32.load offset=20
   (local.get $self/299)))
 (local.set $*field/1/930)
 (local.tee $*field/0/930)
 (local.get $*field/1/930)
 (local.set $filename/2/903
  (local.get $*field/2/930))
 (local.set $filename/1/903)
 (local.tee $filename/0/903)
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
   (local.get $filename/0/903)
   (local.get $filename/1/903)
   (local.get $filename/2/903)
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
 (local.set $*field/2/929
  (i32.load offset=28
   (local.get $self/299)))
 (local.set $*field/1/929)
 (local.tee $*field/0/929)
 (local.get $*field/1/929)
 (local.set $start_line/2/904
  (local.get $*field/2/929))
 (local.set $start_line/1/904)
 (local.tee $start_line/0/904)
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
   (local.get $start_line/0/904)
   (local.get $start_line/1/904)
   (local.get $start_line/2/904)
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
 (local.set $*field/2/928
  (i32.load offset=36
   (local.get $self/299)))
 (local.set $*field/1/928)
 (local.tee $*field/0/928)
 (local.get $*field/1/928)
 (local.set $start_column/2/905
  (local.get $*field/2/928))
 (local.set $start_column/1/905)
 (local.tee $start_column/0/905)
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
   (local.get $start_column/0/905)
   (local.get $start_column/1/905)
   (local.get $start_column/2/905)
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
 (local.set $*field/2/927
  (i32.load offset=44
   (local.get $self/299)))
 (local.set $*field/1/927)
 (local.tee $*field/0/927)
 (local.get $*field/1/927)
 (local.set $end_line/2/906
  (local.get $*field/2/927))
 (local.set $end_line/1/906)
 (local.tee $end_line/0/906)
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
   (local.get $end_line/0/906)
   (local.get $end_line/1/906)
   (local.get $end_line/2/906)
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
 (local.set $*field/2/926
  (i32.load offset=52
   (local.get $self/299)))
 (local.set $*field/1/926)
 (local.set $*field/0/926)
 (if
  (i32.gt_s
   (local.tee $*cnt/995
    (i32.load
     (local.get $self/299)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/0/926))
   (local.set $*new_cnt/1001
    (i32.sub
     (local.get $*cnt/995)
     (i32.const 1)))
   (i32.store
    (local.get $self/299)
    (local.get $*new_cnt/1001)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/995)
     (i32.const 1))
    (then
     (i32.load offset=72
      (local.get $self/299))
     (i32.load offset=40
      (local.get $self/299))
     (local.set $*field/2/1000
      (i32.load offset=44
       (local.get $self/299)))
     (local.set $*field/1/1000)
     (local.tee $*field/0/1000)
     (call $moonbit.decref)
     (i32.load offset=68
      (local.get $self/299))
     (i32.load offset=32
      (local.get $self/299))
     (local.set $*field/2/999
      (i32.load offset=36
       (local.get $self/299)))
     (local.set $*field/1/999)
     (local.tee $*field/0/999)
     (call $moonbit.decref)
     (i32.load offset=64
      (local.get $self/299))
     (i32.load offset=24
      (local.get $self/299))
     (local.set $*field/2/998
      (i32.load offset=28
       (local.get $self/299)))
     (local.set $*field/1/998)
     (local.tee $*field/0/998)
     (call $moonbit.decref)
     (i32.load offset=60
      (local.get $self/299))
     (i32.load offset=16
      (local.get $self/299))
     (local.set $*field/2/997
      (i32.load offset=20
       (local.get $self/299)))
     (local.set $*field/1/997)
     (local.tee $*field/0/997)
     (call $moonbit.decref)
     (i32.load offset=56
      (local.get $self/299))
     (i32.load offset=8
      (local.get $self/299))
     (local.set $*field/2/996
      (i32.load offset=12
       (local.get $self/299)))
     (local.set $*field/1/996)
     (local.tee $*field/0/996)
     (call $moonbit.decref)
     (call $moonbit.free
      (local.get $self/299)))
    (else))))
 (local.get $*field/0/926)
 (local.get $*field/1/926)
 (local.set $end_column/2/907
  (local.get $*field/2/926))
 (local.set $end_column/1/907)
 (local.set $end_column/0/907)
 (if
  (local.get $logger/1/312)
  (then
   (call $moonbit.incref
    (local.get $logger/1/312)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/312)
   (local.get $end_column/0/907)
   (local.get $end_column/1/907)
   (local.get $end_column/2/907)
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
 (local.set $*bind/1/902
  (local.get $logger/1/312))
 (local.set $*bind/0/902)
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
  (local.get $*bind/1/902)
  (local.get $*module_name/0/308)
  (local.get $*module_name/1/308)
  (local.get $*module_name/2/308)
  (i32.load offset=16
   (local.get $*bind/0/902))))
(func $moonbitlang/core/builtin.println|String| (param $input/297 i32) (result i32)
 (call $moonbit.println
  (local.get $input/297))
 (call $moonbit.decref
  (local.get $input/297))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/295 i32) (param $logger/0/294 i32) (param $logger/1/294 i32) (result i32)
 (local $*tmp/900 i32)
 (local.set $*tmp/900
  (call $Int::to_string.inner
   (local.get $self/295)
   (i32.const 10)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/294)
  (local.get $*tmp/900)
  (i32.load offset=8
   (local.get $logger/0/294))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/292 i32) (param $str/0/293 i32) (param $str/1/293 i32) (param $str/2/293 i32) (result i32)
 (local $*tmp/881 i32)
 (local $len/882 i32)
 (local $*tmp/883 i32)
 (local $*tmp/884 i32)
 (local $end/885 i32)
 (local $start/886 i32)
 (local $data/887 i32)
 (local $len/888 i32)
 (local $str/889 i32)
 (local $start/890 i32)
 (local $*tmp/891 i32)
 (local $end/892 i32)
 (local $start/893 i32)
 (local $*tmp/894 i32)
 (local $len/895 i32)
 (local $*tmp/896 i32)
 (local $*tmp/897 i32)
 (local $end/898 i32)
 (local $start/899 i32)
 (local $*field/935 i32)
 (local $*field/936 i32)
 (local $*field/937 i32)
 (local.set $len/882
  (i32.load offset=8
   (local.get $self/292)))
 (local.set $end/885
  (local.get $str/2/293))
 (local.set $start/886
  (local.get $str/1/293))
 (local.set $*tmp/883
  (i32.mul
   (local.tee $*tmp/884
    (i32.sub
     (local.get $end/885)
     (local.get $start/886)))
   (i32.const 2)))
 (local.set $*tmp/881
  (i32.add
   (local.get $len/882)
   (local.get $*tmp/883)))
 (call $moonbit.incref
  (local.get $self/292))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/292)
   (local.get $*tmp/881)))
 (local.set $data/887
  (local.tee $*field/937
   (i32.load offset=12
    (local.get $self/292))))
 (local.set $len/888
  (i32.load offset=8
   (local.get $self/292)))
 (local.set $str/889
  (local.tee $*field/936
   (local.get $str/0/293)))
 (local.set $start/890
  (local.get $str/1/293))
 (local.set $end/892
  (local.get $str/2/293))
 (local.set $start/893
  (local.get $str/1/293))
 (local.set $*tmp/891
  (i32.sub
   (local.get $end/892)
   (local.get $start/893)))
 (call $moonbit.incref
  (local.get $str/889))
 (call $moonbit.incref
  (local.get $data/887))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/887)
   (local.get $len/888)
   (local.get $str/889)
   (local.get $start/890)
   (local.get $*tmp/891)))
 (local.set $len/895
  (i32.load offset=8
   (local.get $self/292)))
 (local.set $end/898
  (local.get $str/2/293))
 (local.set $*field/935
  (local.get $str/1/293))
 (call $moonbit.decref
  (local.get $str/0/293))
 (local.set $start/899
  (local.get $*field/935))
 (local.set $*tmp/896
  (i32.mul
   (local.tee $*tmp/897
    (i32.sub
     (local.get $end/898)
     (local.get $start/899)))
   (i32.const 2)))
 (local.set $*tmp/894
  (i32.add
   (local.get $len/895)
   (local.get $*tmp/896)))
 (i32.store offset=8
  (local.get $self/292)
  (local.get $*tmp/894))
 (call $moonbit.decref
  (local.get $self/292))
 (i32.const 0))
(func $String::offset_of_nth_char.inner (param $self/289 i32) (param $i/290 i32) (param $start_offset/291 i32) (param $end_offset/287 i64) (result i64)
 (local $end_offset/286 i32)
 (local $*Some/288 i64)
 (local $*tmp/880 i32)
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
   (local.set $*tmp/880
    (i32.sub
     (i32.const 0)
     (local.get $i/290)))
   (call $String::offset_of_nth_char_backward
    (local.get $self/289)
    (local.get $*tmp/880)
    (local.get $start_offset/291)
    (local.get $end_offset/286)))))
(func $String::offset_of_nth_char_forward (param $self/284 i32) (param $n/282 i32) (param $start_offset/278 i32) (param $end_offset/279 i32) (result i64)
 (local $c/283 i32)
 (local $*tmp/871 i32)
 (local $*tmp/872 i32)
 (local $*tmp/873 i32)
 (local $*tmp/874 i32)
 (local $*tmp/875 i32)
 (local $*tmp/876 i32)
 (local $*tmp/877 i32)
 (local $*tmp/878 i32)
 (local $*tmp/879 i32)
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
       (local.tee $*tmp/872
        (local.get $utf16_offset/280))
       (local.get $end_offset/279))
      (then
       (i32.lt_s
        (local.tee $*tmp/871
         (local.get $char_count/281))
        (local.get $n/282)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/876
       (local.get $utf16_offset/280))
      (local.set $c/283
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/284)
         (i32.shl
          (local.get $*tmp/876)
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
          (local.tee $*tmp/873
           (local.get $utf16_offset/280))
          (i32.const 2))))
       (else
        (local.set $utf16_offset/280
         (i32.add
          (local.tee $*tmp/874
           (local.get $utf16_offset/280))
          (i32.const 1)))))
      (local.set $char_count/281
       (i32.add
        (local.tee $*tmp/875
         (local.get $char_count/281))
        (i32.const 1)))
      (br $loop:285))
     (else
      (call $moonbit.decref
       (local.get $self/284)))))
   (if (result i64)
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/878
       (local.get $char_count/281))
      (local.get $n/282))
     (then
      (i32.const 1))
     (else
      (i32.ge_s
       (local.tee $*tmp/877
        (local.get $utf16_offset/280))
       (local.get $end_offset/279))))
    (then
     (i64.const 4294967296))
    (else
     (i64.extend_i32_s
      (local.tee $*tmp/879
       (local.get $utf16_offset/280))))))
  (else
   (call $moonbit.decref
    (local.get $self/284))
   (call $moonbitlang/core/builtin.abort|Option<Int>|
    (i32.const 10128)
    (i32.const 10016)))))
(func $String::offset_of_nth_char_backward (param $self/276 i32) (param $n/274 i32) (param $start_offset/273 i32) (param $end_offset/272 i32) (result i64)
 (local $c/275 i32)
 (local $*tmp/860 i32)
 (local $*tmp/861 i32)
 (local $*tmp/862 i32)
 (local $*tmp/863 i32)
 (local $*tmp/864 i32)
 (local $*tmp/865 i32)
 (local $*tmp/866 i32)
 (local $*tmp/867 i32)
 (local $*tmp/868 i32)
 (local $*tmp/869 i32)
 (local $*tmp/870 i32)
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
     (local.tee $*tmp/861
      (i32.sub
       (local.tee $*tmp/862
        (local.get $utf16_offset/271))
       (i32.const 1)))
     (local.get $start_offset/273))
    (then
     (i32.lt_s
      (local.tee $*tmp/860
       (local.get $char_count/270))
      (local.get $n/274)))
    (else
     (i32.const 0)))
   (then
    (local.set $*tmp/866
     (i32.sub
      (local.tee $*tmp/867
       (local.get $utf16_offset/271))
      (i32.const 1)))
    (local.set $c/275
     (i32.load16_u offset=8
      (i32.add
       (local.get $self/276)
       (i32.shl
        (local.get $*tmp/866)
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
        (local.tee $*tmp/863
         (local.get $utf16_offset/271))
        (i32.const 2))))
     (else
      (local.set $utf16_offset/271
       (i32.sub
        (local.tee $*tmp/864
         (local.get $utf16_offset/271))
        (i32.const 1)))))
    (local.set $char_count/270
     (i32.add
      (local.tee $*tmp/865
       (local.get $char_count/270))
      (i32.const 1)))
    (br $loop:277))
   (else
    (call $moonbit.decref
     (local.get $self/276)))))
 (if (result i64)
  (if (result i32)
   (i32.lt_s
    (local.tee $*tmp/869
     (local.get $char_count/270))
    (local.get $n/274))
   (then
    (i32.const 1))
   (else
    (i32.lt_s
     (local.tee $*tmp/868
      (local.get $utf16_offset/271))
     (local.get $start_offset/273))))
  (then
   (i64.const 4294967296))
  (else
   (i64.extend_i32_s
    (local.tee $*tmp/870
     (local.get $utf16_offset/271))))))
(func $String::char_length_ge.inner (param $self/262 i32) (param $len/265 i32) (param $start_offset/269 i32) (param $end_offset/260 i64) (result i32)
 (local $end_offset/259 i32)
 (local $*Some/261 i64)
 (local $index/263 i32)
 (local $count/264 i32)
 (local $c1/266 i32)
 (local $c2/267 i32)
 (local $*tmp/854 i32)
 (local $*tmp/855 i32)
 (local $*tmp/856 i32)
 (local $*tmp/857 i32)
 (local $*tmp/858 i32)
 (local $*tmp/859 i32)
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
        (local.tee $*tmp/854
         (i32.add
          (local.get $index/263)
          (i32.const 1)))
        (local.get $end_offset/259)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/857
       (i32.add
        (local.get $index/263)
        (i32.const 1)))
      (local.set $c2/267
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/262)
         (i32.shl
          (local.get $*tmp/857)
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
        (local.set $*tmp/855
         (i32.add
          (local.get $index/263)
          (i32.const 2)))
        (local.set $*tmp/856
         (i32.add
          (local.get $count/264)
          (i32.const 1)))
        (local.get $*tmp/855)
        (local.get $*tmp/856)
        (br $loop:268))
       (else
        (drop
         (call $moonbitlang/core/builtin.abort|Unit|
          (i32.const 10288)
          (i32.const 10176))))))
     (else))
    (local.set $*tmp/858
     (i32.add
      (local.get $index/263)
      (i32.const 1)))
    (local.set $*tmp/859
     (i32.add
      (local.get $count/264)
      (i32.const 1)))
    (local.get $*tmp/858)
    (local.get $*tmp/859)
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
 (local $*tmp/850 i32)
 (local $*tmp/851 i32)
 (local $*tmp/852 i32)
 (local $*tmp/853 i32)
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
    (local.tee $*tmp/853
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
    (local.set $*tmp/850
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
        (local.get $*tmp/850)))
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
      (local.set $*tmp/851
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
          (local.get $*tmp/851)))
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
      (local.set $*tmp/852
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
          (local.get $*tmp/852)))
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
 (local $*tmp/847 i32)
 (local $*tmp/848 i32)
 (local $*tmp/849 i32)
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
    (local.tee $*tmp/847
     (local.get $num/237))
    (i32.const 0))
   (then
    (local.set $count/240
     (i32.add
      (local.tee $*tmp/848
       (local.get $count/240))
      (i32.const 1)))
    (local.set $num/237
     (i32.div_u
      (local.tee $*tmp/849
       (local.get $num/237))
      (local.get $base/238)))
    (br $loop:241))
   (else)))
 (local.get $count/240))
(func $moonbitlang/core/builtin.hex_count32 (param $value/234 i32) (result i32)
 (local $leading_zeros/235 i32)
 (local $*tmp/845 i32)
 (local $*tmp/846 i32)
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
    (local.tee $*tmp/845
     (i32.div_s
      (local.tee $*tmp/846
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
 (local $*tmp/788 i32)
 (local $*tmp/789 i32)
 (local $*tmp/790 i32)
 (local $*tmp/791 i32)
 (local $*tmp/792 i32)
 (local $*tmp/793 i32)
 (local $*tmp/794 i32)
 (local $*tmp/795 i32)
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
    (local.tee $*tmp/788
     (local.get $num/210))
    (i32.const 10000))
   (then
    (local.set $t/215
     (i32.div_u
      (local.tee $*tmp/811
       (local.get $num/210))
      (i32.const 10000)))
    (local.set $r/216
     (local.tee $*tmp/809
      (i32.rem_u
       (local.tee $*tmp/810
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
      (local.tee $*tmp/789
       (local.get $offset/212))
      (i32.const 4)))
    (local.set $*tmp/808
     (i32.div_s
      (local.get $d1/217)
      (i32.const 10)))
    (local.set $d1_hi/219
     (i32.and
      (local.tee $*tmp/807
       (i32.add
        (i32.const 48)
        (local.get $*tmp/808)))
      (i32.const 65535)))
    (local.set $*tmp/806
     (i32.rem_s
      (local.get $d1/217)
      (i32.const 10)))
    (local.set $d1_lo/220
     (i32.and
      (local.tee $*tmp/805
       (i32.add
        (i32.const 48)
        (local.get $*tmp/806)))
      (i32.const 65535)))
    (local.set $*tmp/804
     (i32.div_s
      (local.get $d2/218)
      (i32.const 10)))
    (local.set $d2_hi/221
     (i32.and
      (local.tee $*tmp/803
       (i32.add
        (i32.const 48)
        (local.get $*tmp/804)))
      (i32.const 65535)))
    (local.set $*tmp/802
     (i32.rem_s
      (local.get $d2/218)
      (i32.const 10)))
    (local.set $d2_lo/222
     (i32.and
      (local.tee $*tmp/801
       (i32.add
        (i32.const 48)
        (local.get $*tmp/802)))
      (i32.const 65535)))
    (local.set $*tmp/791
     (local.get $offset/212))
    (local.set $*tmp/790
     (i32.add
      (local.get $digit_start/214)
      (local.get $*tmp/791)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/790)
       (i32.const 1)))
     (local.get $d1_hi/219))
    (local.set $*tmp/794
     (local.get $offset/212))
    (local.set $*tmp/792
     (i32.add
      (local.tee $*tmp/793
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/794)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/792)
       (i32.const 1)))
     (local.get $d1_lo/220))
    (local.set $*tmp/797
     (local.get $offset/212))
    (local.set $*tmp/795
     (i32.add
      (local.tee $*tmp/796
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/797)))
      (i32.const 2)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/795)
       (i32.const 1)))
     (local.get $d2_hi/221))
    (local.set $*tmp/800
     (local.get $offset/212))
    (local.set $*tmp/798
     (i32.add
      (local.tee $*tmp/799
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/800)))
      (i32.const 3)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/798)
       (i32.const 1)))
     (local.get $d2_lo/222))
    (br $loop:224))
   (else)))
 (local.set $remaining/225
  (local.tee $*tmp/844
   (local.get $num/210)))
 (loop $loop:230
  (if
   (i32.ge_s
    (local.tee $*tmp/812
     (local.get $remaining/225))
    (i32.const 100))
   (then
    (local.set $t/226
     (i32.div_s
      (local.tee $*tmp/824
       (local.get $remaining/225))
      (i32.const 100)))
    (local.set $d/227
     (i32.rem_s
      (local.tee $*tmp/823
       (local.get $remaining/225))
      (i32.const 100)))
    (local.set $remaining/225
     (local.get $t/226))
    (local.set $offset/212
     (i32.sub
      (local.tee $*tmp/813
       (local.get $offset/212))
      (i32.const 2)))
    (local.set $*tmp/822
     (i32.div_s
      (local.get $d/227)
      (i32.const 10)))
    (local.set $d_hi/228
     (i32.and
      (local.tee $*tmp/821
       (i32.add
        (i32.const 48)
        (local.get $*tmp/822)))
      (i32.const 65535)))
    (local.set $*tmp/820
     (i32.rem_s
      (local.get $d/227)
      (i32.const 10)))
    (local.set $d_lo/229
     (i32.and
      (local.tee $*tmp/819
       (i32.add
        (i32.const 48)
        (local.get $*tmp/820)))
      (i32.const 65535)))
    (local.set $*tmp/815
     (local.get $offset/212))
    (local.set $*tmp/814
     (i32.add
      (local.get $digit_start/214)
      (local.get $*tmp/815)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/814)
       (i32.const 1)))
     (local.get $d_hi/228))
    (local.set $*tmp/818
     (local.get $offset/212))
    (local.set $*tmp/816
     (i32.add
      (local.tee $*tmp/817
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/818)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/223)
      (i32.shl
       (local.get $*tmp/816)
       (i32.const 1)))
     (local.get $d_lo/229))
    (br $loop:230))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.tee $*tmp/825
    (local.get $remaining/225))
   (i32.const 10))
  (then
   (local.set $offset/212
    (i32.sub
     (local.tee $*tmp/826
      (local.get $offset/212))
     (i32.const 2)))
   (local.set $*tmp/836
    (i32.div_s
     (local.tee $*tmp/837
      (local.get $remaining/225))
     (i32.const 10)))
   (local.set $d_hi/231
    (i32.and
     (local.tee $*tmp/835
      (i32.add
       (i32.const 48)
       (local.get $*tmp/836)))
     (i32.const 65535)))
   (local.set $*tmp/833
    (i32.rem_s
     (local.tee $*tmp/834
      (local.get $remaining/225))
     (i32.const 10)))
   (local.set $d_lo/232
    (i32.and
     (local.tee $*tmp/832
      (i32.add
       (i32.const 48)
       (local.get $*tmp/833)))
     (i32.const 65535)))
   (local.set $*tmp/828
    (local.get $offset/212))
   (local.set $*tmp/827
    (i32.add
     (local.get $digit_start/214)
     (local.get $*tmp/828)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/223)
     (i32.shl
      (local.get $*tmp/827)
      (i32.const 1)))
    (local.get $d_hi/231))
   (local.set $*tmp/831
    (local.get $offset/212))
   (local.set $*tmp/829
    (i32.add
     (local.tee $*tmp/830
      (i32.add
       (local.get $digit_start/214)
       (local.get $*tmp/831)))
     (i32.const 1)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/223)
     (i32.shl
      (local.get $*tmp/829)
      (i32.const 1)))
    (local.get $d_lo/232))
   (call $moonbit.decref
    (local.get $buffer/223))
   (i32.const 0))
  (else
   (local.set $*tmp/843
    (local.tee $offset/212
     (i32.sub
      (local.tee $*tmp/838
       (local.get $offset/212))
      (i32.const 1))))
   (local.set $*tmp/839
    (i32.add
     (local.get $digit_start/214)
     (local.get $*tmp/843)))
   (local.set $*tmp/842
    (local.get $remaining/225))
   (local.set $*tmp/840
    (i32.and
     (local.tee $*tmp/841
      (i32.add
       (i32.const 48)
       (local.get $*tmp/842)))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/223)
     (i32.shl
      (local.get $*tmp/839)
      (i32.const 1)))
    (local.get $*tmp/840))
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
 (local $*tmp/767 i32)
 (local $*tmp/768 i32)
 (local $*tmp/769 i32)
 (local $*tmp/770 i32)
 (local $*tmp/771 i32)
 (local $*tmp/772 i32)
 (local $*tmp/773 i32)
 (local $*tmp/774 i32)
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
 (local.set $*tmp/768
  (i32.sub
   (local.get $radix/201)
   (i32.const 1)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/767
    (i32.and
     (local.get $radix/201)
     (local.get $*tmp/768)))
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
      (local.tee $*tmp/769
       (local.get $n/198))
      (i32.const 0))
     (then
      (local.set $offset/195
       (i32.sub
        (local.tee $*tmp/770
         (local.get $offset/195))
        (i32.const 1)))
      (local.set $digit/204
       (local.tee $*tmp/776
        (i32.and
         (local.tee $*tmp/777
          (local.get $n/198))
         (local.get $mask/203))))
      (local.set $*tmp/774
       (local.get $offset/195))
      (local.set $*tmp/771
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/774)))
      (local.set $*tmp/772
       (i32.and
        (local.tee $*tmp/773
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
         (local.get $*tmp/771)
         (i32.const 1)))
       (local.get $*tmp/772))
      (local.set $n/198
       (i32.shr_u
        (local.tee $*tmp/775
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
      (local.tee $*tmp/778
       (local.get $n/198))
      (i32.const 0))
     (then
      (local.set $offset/195
       (i32.sub
        (local.tee $*tmp/779
         (local.get $offset/195))
        (i32.const 1)))
      (local.set $q/207
       (i32.div_u
        (local.tee $*tmp/787
         (local.get $n/198))
        (local.get $base/200)))
      (local.set $*tmp/785
       (local.get $n/198))
      (local.set $*tmp/786
       (i32.mul
        (local.get $q/207)
        (local.get $base/200)))
      (local.set $digit/208
       (local.tee $*tmp/784
        (i32.sub
         (local.get $*tmp/785)
         (local.get $*tmp/786))))
      (local.set $*tmp/783
       (local.get $offset/195))
      (local.set $*tmp/780
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/783)))
      (local.set $*tmp/781
       (i32.and
        (local.tee $*tmp/782
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
         (local.get $*tmp/780)
         (i32.const 1)))
       (local.get $*tmp/781))
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
 (local $*tmp/748 i32)
 (local $*tmp/749 i32)
 (local $*tmp/750 i32)
 (local $*tmp/751 i32)
 (local $*tmp/752 i32)
 (local $*tmp/753 i32)
 (local $*tmp/754 i32)
 (local $*tmp/755 i32)
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
    (local.tee $*tmp/748
     (local.get $offset/184))
    (i32.const 2))
   (then
    (local.set $offset/184
     (i32.sub
      (local.tee $*tmp/749
       (local.get $offset/184))
      (i32.const 2)))
    (local.set $hi/190
     (i32.div_s
      (local.tee $byte_val/189
       (local.tee $*tmp/760
        (i32.and
         (local.tee $*tmp/761
          (local.get $n/187))
         (i32.const 255))))
      (i32.const 16)))
    (local.set $lo/191
     (i32.rem_s
      (local.get $byte_val/189)
      (i32.const 16)))
    (local.set $*tmp/753
     (local.get $offset/184))
    (local.set $*tmp/750
     (i32.add
      (local.get $digit_start/186)
      (local.get $*tmp/753)))
    (local.set $*tmp/751
     (i32.and
      (local.tee $*tmp/752
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
       (local.get $*tmp/750)
       (i32.const 1)))
     (local.get $*tmp/751))
    (local.set $*tmp/758
     (local.get $offset/184))
    (local.set $*tmp/754
     (i32.add
      (local.tee $*tmp/757
       (i32.add
        (local.get $digit_start/186)
        (local.get $*tmp/758)))
      (i32.const 1)))
    (local.set $*tmp/755
     (i32.and
      (local.tee $*tmp/756
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
       (local.get $*tmp/754)
       (i32.const 1)))
     (local.get $*tmp/755))
    (local.set $n/187
     (i32.shr_u
      (local.tee $*tmp/759
       (local.get $n/187))
      (i32.const 8)))
    (br $loop:193))
   (else)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/762
    (local.get $offset/184))
   (i32.const 1))
  (then
   (local.set $nibble/194
    (local.tee $*tmp/765
     (i32.and
      (local.tee $*tmp/766
       (local.get $n/187))
      (i32.const 15))))
   (local.set $*tmp/763
    (i32.and
     (local.tee $*tmp/764
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
    (local.get $*tmp/763))
   (call $moonbit.decref
    (local.get $buffer/192))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $buffer/192))
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/183 i32) (result i32)
 (local $logger/182 i32)
 (local $*tmp/0/747 i32)
 (local $*tmp/1/747 i32)
 (call $moonbit.incref
  (local.tee $logger/182
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/747
  (local.get $logger/182))
 (local.set $*tmp/0/747)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/183)
   (local.get $*tmp/0/747)
   (local.get $*tmp/1/747)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/182)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/181 i32) (result i32)
 (local $logger/180 i32)
 (local $*tmp/0/746 i32)
 (local $*tmp/1/746 i32)
 (call $moonbit.incref
  (local.tee $logger/180
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/746
  (local.get $logger/180))
 (local.set $*tmp/0/746)
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/181)
   (local.get $*tmp/0/746)
   (local.get $*tmp/1/746)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/180)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/172 i32) (param $value/175 i32) (param $start/176 i32) (param $len/177 i32) (result i32)
 (local $*try_err/174 i32)
 (local $*tmp/0/741 i32)
 (local $*tmp/1/741 i32)
 (local $*tmp/2/741 i32)
 (local $*tmp/742 i64)
 (local $*tmp/743 i32)
 (local $*ok/0/744 i32)
 (local $*ok/1/744 i32)
 (local $*ok/2/744 i32)
 (local $*err/745 i32)
 (local $*obj/0/1012 i32)
 (local $*obj/1/1012 i32)
 (local $*obj/2/1012 i32)
 (block $outer/1011 (result i32) (result i32) (result i32)
  (block $join:173
   (local.set $*tmp/742
    (i64.extend_i32_s
     (local.tee $*tmp/743
      (i32.add
       (local.get $start/176)
       (local.get $len/177)))))
   (call $String::sub.inner
    (local.get $value/175)
    (local.get $start/176)
    (local.get $*tmp/742))
   (local.set $*obj/2/1012)
   (local.set $*obj/1/1012)
   (local.set $*obj/0/1012)
   (if (result i32) (result i32) (result i32)
    (then
     (local.get $*obj/0/1012)
     (local.get $*obj/1/1012)
     (local.set $*ok/2/744
      (local.get $*obj/2/1012))
     (local.set $*ok/1/744)
     (local.tee $*ok/0/744)
     (local.get $*ok/1/744)
     (local.get $*ok/2/744))
    (else
     (local.set $*try_err/174
      (local.tee $*err/745
       (local.get $*obj/0/1012)))
     (br $join:173)))
   (br $outer/1011))
  (call $moonbit.decref
   (local.get $*try_err/174))
  (unreachable))
 (local.set $*tmp/2/741)
 (local.set $*tmp/1/741)
 (local.set $*tmp/0/741)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.get $self/172)
  (local.get $*tmp/0/741)
  (local.get $*tmp/1/741)
  (local.get $*tmp/2/741)))
(func $String::sub.inner (param $self/165 i32) (param $start/171 i32) (param $end/167 i64) (result i32) (result i32) (result i32) (result i32)
 (local $len/164 i32)
 (local $end/166 i32)
 (local $*Some/168 i64)
 (local $*end/169 i32)
 (local $start/170 i32)
 (local $*p/427 i32)
 (local $*p/430 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/737 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/738 i32)
 (local $*tmp/0/739 i32)
 (local $*tmp/1/739 i32)
 (local $*tmp/2/739 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/740 i32)
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
      (local.set $*p/427
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/165)
         (i32.shl
          (local.get $start/170)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/427))
       (then
        (i32.le_s
         (local.get $*p/427)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/165))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/737
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/737)
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
      (local.set $*p/430
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/165)
         (i32.shl
          (local.get $end/166)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/430))
       (then
        (i32.le_s
         (local.get $*p/430)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/165))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/738
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/738)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (local.get $self/165)
   (local.get $start/170)
   (local.set $*tmp/2/739
    (local.get $end/166))
   (local.set $*tmp/1/739)
   (local.set $*tmp/0/739)
   (i32.const 1)
   (local.get $*tmp/0/739)
   (local.get $*tmp/1/739)
   (local.get $*tmp/2/739))
  (else
   (call $moonbit.decref
    (local.get $self/165))
   (local.set $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/740
    (i32.const 10640))
   (i32.const 0)
   (local.get $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/740)
   (i32.const 0)
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/162 i32) (param $str/163 i32) (result i32)
 (local $*tmp/726 i32)
 (local $len/727 i32)
 (local $*tmp/728 i32)
 (local $*tmp/729 i32)
 (local $data/730 i32)
 (local $len/731 i32)
 (local $*tmp/732 i32)
 (local $*tmp/733 i32)
 (local $len/734 i32)
 (local $*tmp/735 i32)
 (local $*tmp/736 i32)
 (local $*tmp/940 i32)
 (local $*field/941 i32)
 (local.set $len/727
  (i32.load offset=8
   (local.get $self/162)))
 (local.set $*tmp/728
  (i32.mul
   (local.tee $*tmp/729
    (call $moonbit.array_length
     (local.get $str/163)))
   (i32.const 2)))
 (local.set $*tmp/726
  (i32.add
   (local.get $len/727)
   (local.get $*tmp/728)))
 (call $moonbit.incref
  (local.get $self/162))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/162)
   (local.get $*tmp/726)))
 (local.set $data/730
  (local.tee $*field/941
   (i32.load offset=12
    (local.get $self/162))))
 (local.set $len/731
  (i32.load offset=8
   (local.get $self/162)))
 (local.set $*tmp/732
  (call $moonbit.array_length
   (local.get $str/163)))
 (call $moonbit.incref
  (local.get $data/730))
 (call $moonbit.incref
  (local.get $str/163))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/730)
   (local.get $len/731)
   (local.get $str/163)
   (i32.const 0)
   (local.get $*tmp/732)))
 (local.set $len/734
  (i32.load offset=8
   (local.get $self/162)))
 (local.set $*tmp/940
  (call $moonbit.array_length
   (local.get $str/163)))
 (call $moonbit.decref
  (local.get $str/163))
 (local.set $*tmp/735
  (i32.mul
   (local.tee $*tmp/736
    (local.get $*tmp/940))
   (i32.const 2)))
 (local.set $*tmp/733
  (i32.add
   (local.get $len/734)
   (local.get $*tmp/735)))
 (i32.store offset=8
  (local.get $self/162)
  (local.get $*tmp/733))
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
 (local $*p/421 i32)
 (local $*p/424 i32)
 (local $*tmp/715 i32)
 (local $*tmp/716 i32)
 (local $*tmp/717 i32)
 (local $*tmp/718 i32)
 (local $*tmp/719 i32)
 (local $*tmp/720 i32)
 (local $*tmp/721 i32)
 (local $*tmp/722 i32)
 (local $*tmp/723 i32)
 (local $*tmp/724 i32)
 (local $*tmp/725 i32)
 (local $*arr/1013 i32)
 (local $*idx/1014 i32)
 (local $*arr/1015 i32)
 (local $*idx/1016 i32)
 (local.set $*tmp/725
  (i32.mul
   (local.get $length/150)
   (i32.const 2)))
 (local.set $e1/148
  (i32.sub
   (local.tee $*tmp/724
    (i32.add
     (local.get $bytes_offset/149)
     (local.get $*tmp/725)))
   (i32.const 1)))
 (local.set $e2/151
  (i32.sub
   (local.tee $*tmp/723
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
      (local.set $*tmp/715
       (i32.and
        (local.tee $*tmp/716
         (local.tee $*p/421
          (i32.and
           (local.tee $c/160
            (local.tee $*tmp/720
             (i32.load16_u offset=8
              (i32.add
               (local.get $str/156)
               (i32.shl
                (local.get $i/158)
                (i32.const 1))))))
           (i32.const 255))))
        (i32.const 255)))
      (local.get $self/154)
      (local.set $*idx/1016
       (local.get $j/159))
      (local.set $*arr/1015)
      (call $moonbit.check_range
       (local.get $*idx/1016)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1015))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1015)
        (local.get $*idx/1016))
       (local.get $*tmp/715))
      (local.set $*tmp/717
       (i32.add
        (local.get $j/159)
        (i32.const 1)))
      (local.set $*tmp/718
       (i32.and
        (local.tee $*tmp/719
         (local.tee $*p/424
          (i32.shr_u
           (local.get $c/160)
           (i32.const 8))))
        (i32.const 255)))
      (local.get $self/154)
      (local.set $*idx/1014
       (local.get $*tmp/717))
      (local.set $*arr/1013)
      (call $moonbit.check_range
       (local.get $*idx/1014)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1013))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1013)
        (local.get $*idx/1014))
       (local.get $*tmp/718))
      (local.set $*tmp/721
       (i32.add
        (local.get $i/158)
        (i32.const 1)))
      (local.set $*tmp/722
       (i32.add
        (local.get $j/159)
        (i32.const 2)))
      (local.get $*tmp/721)
      (local.get $*tmp/722)
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
 (local $*bind/319 i64)
 (local $*tmp/683 i64)
 (local $*tmp/684 i32)
 (local $*tmp/685 i32)
 (local $*tmp/686 i32)
 (local $end/687 i32)
 (local $start/688 i32)
 (local $*tmp/689 i32)
 (local $*tmp/690 i32)
 (local $end/691 i32)
 (local $start/692 i32)
 (local $*tmp/693 i32)
 (local $*tmp/694 i32)
 (local $*tmp/695 i64)
 (local $*tmp/696 i32)
 (local $*tmp/0/697 i32)
 (local $*tmp/1/697 i32)
 (local $*tmp/2/697 i32)
 (local $*tmp/0/698 i32)
 (local $*tmp/1/698 i32)
 (local $*tmp/2/698 i32)
 (local $*tmp/699 i32)
 (local $*tmp/700 i64)
 (local $*tmp/0/701 i32)
 (local $*tmp/1/701 i32)
 (local $*tmp/2/701 i32)
 (local $*tmp/702 i32)
 (local $*tmp/703 i64)
 (local $*tmp/704 i32)
 (local $*tmp/0/705 i32)
 (local $*tmp/1/705 i32)
 (local $*tmp/2/705 i32)
 (local $*tmp/706 i32)
 (local $*tmp/707 i64)
 (local $*tmp/0/708 i32)
 (local $*tmp/1/708 i32)
 (local $*tmp/2/708 i32)
 (local $*tmp/709 i32)
 (local $*tmp/710 i32)
 (local $*tmp/711 i32)
 (local $*tmp/712 i64)
 (local $*tmp/713 i32)
 (local $*tmp/714 i32)
 (local $*field/0/942 i32)
 (local $*field/1/942 i32)
 (local $*field/2/942 i32)
 (local $*field/0/943 i32)
 (local $*field/1/943 i32)
 (local $*field/2/943 i32)
 (local $*field/0/944 i32)
 (local $*field/1/944 i32)
 (local $*field/2/944 i32)
 (local $*field/0/945 i32)
 (local $*field/1/945 i32)
 (local $*field/2/945 i32)
 (local $*cnt/1002 i32)
 (local $*new_cnt/1003 i32)
 (local $*cnt/1004 i32)
 (local $*new_cnt/1005 i32)
 (local $ptr/1017 i32)
 (block $join:115
  (local.set $*tmp/683
   (i64.extend_i32_s
    (local.tee $*tmp/684
     (call $moonbit.array_length
      (local.get $repr/116)))))
  (call $moonbit.incref
   (local.get $repr/116))
  (if (result i32)
   (call $String::char_length_ge.inner
    (local.get $repr/116)
    (i32.const 1)
    (i32.const 0)
    (local.get $*tmp/683))
   (then
    (if (result i32)
     (i32.eq
      (local.tee $*x/117
       (local.tee $*tmp/714
        (i32.load16_u offset=8
         (i32.add
          (local.get $repr/116)
          (i32.shl
           (i32.const 0)
           (i32.const 1))))))
      (i32.const 64))
     (then
      (local.set $*tmp/712
       (i64.extend_i32_s
        (local.tee $*tmp/713
         (call $moonbit.array_length
          (local.get $repr/116)))))
      (call $moonbit.incref
       (local.get $repr/116))
      (local.set $*tmp/710
       (if (result i32)
        (i64.eq
         (local.tee $*bind/319
          (call $String::offset_of_nth_char.inner
           (local.get $repr/116)
           (i32.const 1)
           (i32.const 0)
           (local.get $*tmp/712)))
         (i64.const 4294967296))
        (then
         (call $moonbit.array_length
          (local.get $repr/116)))
        (else
         (i32.wrap_i64
          (local.tee $*Some/119
           (local.get $*bind/319))))))
      (local.set $*tmp/711
       (call $moonbit.array_length
        (local.get $repr/116)))
      (local.get $repr/116)
      (local.get $*tmp/710)
      (local.set $*x/2/118
       (local.get $*tmp/711))
      (local.set $*x/1/118)
      (local.set $*x/0/118)
      (local.set $*tmp/709
       (call $moonbit.array_length
        (global.get $moonbitlang/core/builtin.parse.*bind|5440)))
      (call $moonbit.incref
       (global.get $moonbitlang/core/builtin.parse.*bind|5440))
      (global.get $moonbitlang/core/builtin.parse.*bind|5440)
      (i32.const 0)
      (local.set $*tmp/2/708
       (local.get $*tmp/709))
      (local.set $*tmp/1/708)
      (local.set $*tmp/0/708)
      (call $moonbit.incref
       (local.get $*x/0/118))
      (if (result i32)
       (i64.eq
        (local.tee $*bind/120
         (call $StringView::find
          (local.get $*x/0/118)
          (local.get $*x/1/118)
          (local.get $*x/2/118)
          (local.get $*tmp/0/708)
          (local.get $*tmp/1/708)
          (local.get $*tmp/2/708)))
        (i64.const 4294967296))
       (then
        (call $moonbit.decref
         (local.get $*x/0/118))
        (unreachable))
       (else
        (local.set $*tmp/707
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
         (local.get $*tmp/707))
        (local.set $pkg/2/123)
        (local.set $pkg/1/123)
        (local.set $pkg/0/123)
        (local.set $*tmp/706
         (call $moonbit.array_length
          (global.get $moonbitlang/core/builtin.parse.*bind|5434)))
        (call $moonbit.incref
         (global.get $moonbitlang/core/builtin.parse.*bind|5434))
        (global.get $moonbitlang/core/builtin.parse.*bind|5434)
        (i32.const 0)
        (local.set $*tmp/2/705
         (local.get $*tmp/706))
        (local.set $*tmp/1/705)
        (local.set $*tmp/0/705)
        (call $moonbit.incref
         (local.get $*x/0/118))
        (if (result i32)
         (i64.eq
          (local.tee $*bind/124
           (call $StringView::rev_find
            (local.get $*x/0/118)
            (local.get $*x/1/118)
            (local.get $*x/2/118)
            (local.get $*tmp/0/705)
            (local.get $*tmp/1/705)
            (local.get $*tmp/2/705)))
          (i64.const 4294967296))
         (then
          (call $moonbit.decref
           (local.get $pkg/0/123))
          (call $moonbit.decref
           (local.get $*x/0/118))
          (unreachable))
         (else
          (local.set $*tmp/685
           (i32.add
            (local.tee $*start_loc_end/126
             (i32.wrap_i64
              (local.tee $*Some/125
               (local.get $*bind/124))))
            (i32.const 1)))
          (local.set $end/687
           (local.get $*x/2/118))
          (local.set $start/688
           (local.get $*x/1/118))
          (local.set $*tmp/686
           (i32.sub
            (local.get $end/687)
            (local.get $start/688)))
          (if (result i32)
           (i32.lt_s
            (local.get $*tmp/685)
            (local.get $*tmp/686))
           (then
            (local.set $*tmp/704
             (i32.add
              (local.get $*start_loc_end/126)
              (i32.const 1)))
            (call $moonbit.incref
             (local.get $*x/0/118))
            (call $StringView::view.inner
             (local.get $*x/0/118)
             (local.get $*x/1/118)
             (local.get $*x/2/118)
             (local.get $*tmp/704)
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
              (local.set $*field/2/945
               (i32.load offset=12
                (local.get $*x/130)))
              (local.set $*field/1/945)
              (local.tee $*field/0/945)
              (local.get $*field/1/945)
              (local.set $*end_line/2/131
               (local.get $*field/2/945))
              (local.set $*end_line/1/131)
              (local.set $*end_line/0/131)
              (i32.load offset=28
               (local.get $*x/130))
              (i32.load offset=16
               (local.get $*x/130))
              (local.set $*field/2/944
               (i32.load offset=20
                (local.get $*x/130)))
              (local.set $*field/1/944)
              (local.set $*field/0/944)
              (if
               (i32.gt_s
                (local.tee $*cnt/1002
                 (i32.load
                  (local.get $*x/130)))
                (i32.const 1))
               (then
                (call $moonbit.incref
                 (local.get $*field/0/944))
                (call $moonbit.incref
                 (local.get $*end_line/0/131))
                (local.set $*new_cnt/1003
                 (i32.sub
                  (local.get $*cnt/1002)
                  (i32.const 1)))
                (i32.store
                 (local.get $*x/130)
                 (local.get $*new_cnt/1003)))
               (else
                (if
                 (i32.eq
                  (local.get $*cnt/1002)
                  (i32.const 1))
                 (then
                  (call $moonbit.free
                   (local.get $*x/130)))
                 (else))))
              (local.get $*field/0/944)
              (local.get $*field/1/944)
              (local.set $*end_column/2/132
               (local.get $*field/2/944))
              (local.set $*end_column/1/132)
              (local.set $*end_column/0/132)
              (local.set $*tmp/703
               (i64.extend_i32_s
                (local.get $*start_loc_end/126)))
              (call $StringView::view.inner
               (local.get $*x/0/118)
               (local.get $*x/1/118)
               (local.get $*x/2/118)
               (i32.const 0)
               (local.get $*tmp/703))
              (local.set $rest/2/133)
              (local.set $rest/1/133)
              (local.set $rest/0/133)
              (block $join:134
               (local.set $*tmp/702
                (call $moonbit.array_length
                 (global.get $moonbitlang/core/builtin.parse.*bind|5421)))
               (call $moonbit.incref
                (global.get $moonbitlang/core/builtin.parse.*bind|5421))
               (global.get $moonbitlang/core/builtin.parse.*bind|5421)
               (i32.const 0)
               (local.set $*tmp/2/701
                (local.get $*tmp/702))
               (local.set $*tmp/1/701)
               (local.set $*tmp/0/701)
               (call $moonbit.incref
                (local.get $rest/0/133))
               (if (result i32)
                (i64.eq
                 (local.tee $*bind/135
                  (call $StringView::rev_find
                   (local.get $rest/0/133)
                   (local.get $rest/1/133)
                   (local.get $rest/2/133)
                   (local.get $*tmp/0/701)
                   (local.get $*tmp/1/701)
                   (local.get $*tmp/2/701)))
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
                 (local.set $*tmp/700
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
                  (local.get $*tmp/700))
                 (local.set $*tmp/2/697)
                 (local.set $*tmp/1/697)
                 (local.set $*tmp/0/697)
                 (local.set $*tmp/699
                  (call $moonbit.array_length
                   (global.get $moonbitlang/core/builtin.parse.*bind|5415)))
                 (call $moonbit.incref
                  (global.get $moonbitlang/core/builtin.parse.*bind|5415))
                 (global.get $moonbitlang/core/builtin.parse.*bind|5415)
                 (i32.const 0)
                 (local.set $*tmp/2/698
                  (local.get $*tmp/699))
                 (local.set $*tmp/1/698)
                 (local.set $*tmp/0/698)
                 (if (result i32)
                  (i64.eq
                   (local.tee $*bind/138
                    (call $StringView::rev_find
                     (local.get $*tmp/0/697)
                     (local.get $*tmp/1/697)
                     (local.get $*tmp/2/697)
                     (local.get $*tmp/0/698)
                     (local.get $*tmp/1/698)
                     (local.get $*tmp/2/698)))
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
                   (local.set $*tmp/689
                    (i32.add
                     (local.tee $*filename_end/140
                      (i32.wrap_i64
                       (local.tee $*Some/139
                        (local.get $*bind/138))))
                     (i32.const 1)))
                   (local.set $end/691
                    (local.get $rest/2/133))
                   (local.set $start/692
                    (local.get $rest/1/133))
                   (local.set $*tmp/690
                    (i32.sub
                     (local.get $end/691)
                     (local.get $start/692)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $*tmp/689)
                     (local.get $*tmp/690))
                    (then
                     (local.set $*tmp/696
                      (i32.add
                       (local.get $*filename_end/140)
                       (i32.const 1)))
                     (call $moonbit.incref
                      (local.get $rest/0/133))
                     (call $StringView::view.inner
                      (local.get $rest/0/133)
                      (local.get $rest/1/133)
                      (local.get $rest/2/133)
                      (local.get $*tmp/696)
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
                       (local.set $*field/2/943
                        (i32.load offset=12
                         (local.get $*x/144)))
                       (local.set $*field/1/943)
                       (local.tee $*field/0/943)
                       (local.get $*field/1/943)
                       (local.set $*start_line/2/145
                        (local.get $*field/2/943))
                       (local.set $*start_line/1/145)
                       (local.set $*start_line/0/145)
                       (i32.load offset=28
                        (local.get $*x/144))
                       (i32.load offset=16
                        (local.get $*x/144))
                       (local.set $*field/2/942
                        (i32.load offset=20
                         (local.get $*x/144)))
                       (local.set $*field/1/942)
                       (local.set $*field/0/942)
                       (if
                        (i32.gt_s
                         (local.tee $*cnt/1004
                          (i32.load
                           (local.get $*x/144)))
                         (i32.const 1))
                        (then
                         (call $moonbit.incref
                          (local.get $*field/0/942))
                         (call $moonbit.incref
                          (local.get $*start_line/0/145))
                         (local.set $*new_cnt/1005
                          (i32.sub
                           (local.get $*cnt/1004)
                           (i32.const 1)))
                         (i32.store
                          (local.get $*x/144)
                          (local.get $*new_cnt/1005)))
                        (else
                         (if
                          (i32.eq
                           (local.get $*cnt/1004)
                           (i32.const 1))
                          (then
                           (call $moonbit.free
                            (local.get $*x/144)))
                          (else))))
                       (local.get $*field/0/942)
                       (local.get $*field/1/942)
                       (local.set $*start_column/2/146
                        (local.get $*field/2/942))
                       (local.set $*start_column/1/146)
                       (local.set $*start_column/0/146)
                       (local.set $*tmp/693
                        (i32.add
                         (local.get $*pkg_end/122)
                         (i32.const 1)))
                       (if (result i32)
                        (i32.gt_s
                         (local.get $*filename_end/140)
                         (local.get $*tmp/693))
                        (then
                         (local.set $*tmp/694
                          (i32.add
                           (local.get $*pkg_end/122)
                           (i32.const 1)))
                         (local.set $*tmp/695
                          (i64.extend_i32_s
                           (local.get $*filename_end/140)))
                         (call $StringView::view.inner
                          (local.get $rest/0/133)
                          (local.get $rest/1/133)
                          (local.get $rest/2/133)
                          (local.get $*tmp/694)
                          (local.get $*tmp/695))
                         (local.set $filename/2/147)
                         (local.set $filename/1/147)
                         (local.set $filename/0/147)
                         (i32.store offset=4
                          (local.tee $ptr/1017
                           (call $moonbit.gc.malloc
                            (i32.const 72)))
                          (i32.const 7341568))
                         (i32.store offset=76
                          (local.get $ptr/1017)
                          (local.get $*end_column/0/132))
                         (i32.store offset=48
                          (local.get $ptr/1017)
                          (local.get $*end_column/1/132))
                         (i32.store offset=52
                          (local.get $ptr/1017)
                          (local.get $*end_column/2/132))
                         (i32.store offset=72
                          (local.get $ptr/1017)
                          (local.get $*end_line/0/131))
                         (i32.store offset=40
                          (local.get $ptr/1017)
                          (local.get $*end_line/1/131))
                         (i32.store offset=44
                          (local.get $ptr/1017)
                          (local.get $*end_line/2/131))
                         (i32.store offset=68
                          (local.get $ptr/1017)
                          (local.get $*start_column/0/146))
                         (i32.store offset=32
                          (local.get $ptr/1017)
                          (local.get $*start_column/1/146))
                         (i32.store offset=36
                          (local.get $ptr/1017)
                          (local.get $*start_column/2/146))
                         (i32.store offset=64
                          (local.get $ptr/1017)
                          (local.get $*start_line/0/145))
                         (i32.store offset=24
                          (local.get $ptr/1017)
                          (local.get $*start_line/1/145))
                         (i32.store offset=28
                          (local.get $ptr/1017)
                          (local.get $*start_line/2/145))
                         (i32.store offset=60
                          (local.get $ptr/1017)
                          (local.get $filename/0/147))
                         (i32.store offset=16
                          (local.get $ptr/1017)
                          (local.get $filename/1/147))
                         (i32.store offset=20
                          (local.get $ptr/1017)
                          (local.get $filename/2/147))
                         (i32.store offset=56
                          (local.get $ptr/1017)
                          (local.get $pkg/0/123))
                         (i32.store offset=8
                          (local.get $ptr/1017)
                          (local.get $pkg/1/123))
                         (i32.store offset=12
                          (local.get $ptr/1017)
                          (local.get $pkg/2/123))
                         (local.get $ptr/1017))
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
 (local $*tmp/672 i32)
 (local $*tmp/673 i32)
 (local $end/674 i32)
 (local $start/675 i32)
 (local $*tuple/676 i32)
 (local $*tmp/0/677 i32)
 (local $*tmp/1/677 i32)
 (local $*tmp/2/677 i32)
 (local $*tmp/0/678 i32)
 (local $*tmp/1/678 i32)
 (local $*tmp/2/678 i32)
 (local $*tmp/679 i32)
 (local $*tmp/680 i64)
 (local $*tmp/0/681 i32)
 (local $*tmp/1/681 i32)
 (local $*tmp/2/681 i32)
 (local $*tmp/682 i32)
 (local $ptr/1018 i32)
 (local.set $*tmp/682
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.parse.*bind|5401)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.parse.*bind|5401))
 (global.get $moonbitlang/core/builtin.parse.*bind|5401)
 (i32.const 0)
 (local.set $*tmp/2/681
  (local.get $*tmp/682))
 (local.set $*tmp/1/681)
 (local.set $*tmp/0/681)
 (call $moonbit.incref
  (local.get $view/0/112))
 (if (result i32)
  (i64.eq
   (local.tee $*bind/111
    (call $StringView::find
     (local.get $view/0/112)
     (local.get $view/1/112)
     (local.get $view/2/112)
     (local.get $*tmp/0/681)
     (local.get $*tmp/1/681)
     (local.get $*tmp/2/681)))
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
      (local.set $*tmp/672
       (i32.add
        (local.get $*i/114)
        (i32.const 1)))
      (local.set $end/674
       (local.get $view/2/112))
      (local.set $start/675
       (local.get $view/1/112))
      (local.set $*tmp/673
       (i32.sub
        (local.get $end/674)
        (local.get $start/675)))
      (i32.lt_s
       (local.get $*tmp/672)
       (local.get $*tmp/673)))
     (else
      (i32.const 0)))
    (then
     (local.set $*tmp/680
      (i64.extend_i32_s
       (local.get $*i/114)))
     (call $moonbit.incref
      (local.get $view/0/112))
     (call $StringView::view.inner
      (local.get $view/0/112)
      (local.get $view/1/112)
      (local.get $view/2/112)
      (i32.const 0)
      (local.get $*tmp/680))
     (local.set $*tmp/2/677)
     (local.set $*tmp/1/677)
     (local.set $*tmp/0/677)
     (local.set $*tmp/679
      (i32.add
       (local.get $*i/114)
       (i32.const 1)))
     (call $StringView::view.inner
      (local.get $view/0/112)
      (local.get $view/1/112)
      (local.get $view/2/112)
      (local.get $*tmp/679)
      (i64.const 4294967296))
     (local.set $*tmp/2/678)
     (local.set $*tmp/1/678)
     (local.set $*tmp/0/678)
     (i32.store offset=4
      (local.tee $ptr/1018
       (call $moonbit.gc.malloc
        (i32.const 24)))
      (i32.const 3146240))
     (i32.store offset=28
      (local.get $ptr/1018)
      (local.get $*tmp/0/678))
     (i32.store offset=16
      (local.get $ptr/1018)
      (local.get $*tmp/1/678))
     (i32.store offset=20
      (local.get $ptr/1018)
      (local.get $*tmp/2/678))
     (i32.store offset=24
      (local.get $ptr/1018)
      (local.get $*tmp/0/677))
     (i32.store offset=8
      (local.get $ptr/1018)
      (local.get $*tmp/1/677))
     (i32.store offset=12
      (local.get $ptr/1018)
      (local.get $*tmp/2/677))
     (local.tee $*tuple/676
      (local.get $ptr/1018)))
    (else
     (call $moonbit.decref
      (local.get $view/0/112))
     (i32.const 0))))))
(func $StringView::view.inner (param $self/0/109 i32) (param $self/1/109 i32) (param $self/2/109 i32) (param $start_offset/110 i32) (param $end_offset/107 i64) (result i32) (result i32) (result i32)
 (local $end_offset/106 i32)
 (local $*Some/108 i64)
 (local $*tmp/662 i32)
 (local $end/663 i32)
 (local $start/664 i32)
 (local $str/665 i32)
 (local $*tmp/666 i32)
 (local $*tmp/667 i32)
 (local $start/668 i32)
 (local $start/669 i32)
 (local $end/670 i32)
 (local $start/671 i32)
 (local $*field/946 i32)
 (local $*field/947 i32)
 (local.set $end_offset/106
  (if (result i32)
   (i64.eq
    (local.get $end_offset/107)
    (i64.const 4294967296))
   (then
    (local.set $end/670
     (local.get $self/2/109))
    (local.set $start/671
     (local.get $self/1/109))
    (i32.sub
     (local.get $end/670)
     (local.get $start/671)))
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
      (local.set $end/663
       (local.get $self/2/109))
      (local.set $start/664
       (local.get $self/1/109))
      (local.set $*tmp/662
       (i32.sub
        (local.get $end/663)
        (local.get $start/664)))
      (i32.le_s
       (local.get $end_offset/106)
       (local.get $*tmp/662)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $str/665
    (local.tee $*field/947
     (local.get $self/0/109)))
   (local.set $*tmp/666
    (i32.add
     (local.tee $start/669
      (local.get $self/1/109))
     (local.get $start_offset/110)))
   (local.set $*tmp/667
    (i32.add
     (local.tee $start/668
      (local.tee $*field/946
       (local.get $self/1/109)))
     (local.get $end_offset/106)))
   (local.get $str/665)
   (local.get $*tmp/666)
   (local.get $*tmp/667))
  (else
   (call $moonbit.decref
    (local.get $self/0/109))
   (call $moonbitlang/core/builtin.abort|StringView|
    (i32.const 10776)
    (i32.const 10656)))))
(func $StringView::rev_find (param $self/0/105 i32) (param $self/1/105 i32) (param $self/2/105 i32) (param $str/0/104 i32) (param $str/1/104 i32) (param $str/2/104 i32) (result i64)
 (local $*tmp/659 i32)
 (local $end/660 i32)
 (local $start/661 i32)
 (local.set $end/660
  (local.get $str/2/104))
 (local.set $start/661
  (local.get $str/1/104))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/659
    (i32.sub
     (local.get $end/660)
     (local.get $start/661)))
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
 (local $*p/398 i32)
 (local $*p/401 i32)
 (local $*p/404 i32)
 (local $*tmp/632 i32)
 (local $*tmp/633 i32)
 (local $str/634 i32)
 (local $*tmp/635 i32)
 (local $start/636 i32)
 (local $*tmp/637 i32)
 (local $*tmp/638 i32)
 (local $*tmp/639 i32)
 (local $*tmp/640 i32)
 (local $*tmp/641 i32)
 (local $str/642 i32)
 (local $*tmp/643 i32)
 (local $start/644 i32)
 (local $str/645 i32)
 (local $*tmp/646 i32)
 (local $start/647 i32)
 (local $*tmp/648 i32)
 (local $*tmp/649 i32)
 (local $*tmp/650 i32)
 (local $*tmp/651 i32)
 (local $str/652 i32)
 (local $*tmp/653 i32)
 (local $start/654 i32)
 (local $end/655 i32)
 (local $start/656 i32)
 (local $end/657 i32)
 (local $start/658 i32)
 (local $*tmp/948 i32)
 (local $*field/949 i32)
 (local $*tmp/950 i32)
 (local $*field/951 i32)
 (local $*tmp/952 i32)
 (local $*field/953 i32)
 (local $*tmp/954 i32)
 (local $*field/955 i32)
 (local $i/99 i32)
 (local.set $end/657
  (local.get $haystack/2/95))
 (local.set $start/658
  (local.get $haystack/1/95))
 (local.set $haystack_len/94
  (i32.sub
   (local.get $end/657)
   (local.get $start/658)))
 (local.set $end/655
  (local.get $needle/2/97))
 (local.set $start/656
  (local.get $needle/1/97))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/96
    (i32.sub
     (local.get $end/655)
     (local.get $start/656)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/94)
     (local.get $needle_len/96))
    (then
     (local.set $*p/398
      (i32.const 0))
     (local.set $str/652
      (local.tee $*field/955
       (local.get $needle/0/97)))
     (local.set $*tmp/653
      (i32.add
       (local.tee $start/654
        (local.get $needle/1/97))
       (local.get $*p/398)))
     (local.set $needle_first/98
      (local.tee $*tmp/954
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/652)
         (i32.shl
          (local.get $*tmp/653)
          (i32.const 1))))))
     (local.set $i/99
      (i32.sub
       (local.get $haystack_len/94)
       (local.get $needle_len/96)))
     (loop $loop:103
      (if
       (i32.ge_s
        (local.tee $*tmp/632
         (local.get $i/99))
        (i32.const 0))
       (then
        (loop $loop:100
         (if
          (if (result i32)
           (i32.ge_s
            (local.tee $*tmp/637
             (local.get $i/99))
            (i32.const 0))
           (then
            (local.set $*p/401
             (local.get $i/99))
            (local.set $str/634
             (local.tee $*field/953
              (local.get $haystack/0/95)))
            (local.set $*tmp/635
             (i32.add
              (local.tee $start/636
               (local.get $haystack/1/95))
              (local.get $*p/401)))
            (local.tee $*tmp/633
             (local.tee $*tmp/952
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/634)
                (i32.shl
                 (local.get $*tmp/635)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/98)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/99
            (i32.sub
             (local.tee $*tmp/638
              (local.get $i/99))
             (i32.const 1)))
           (br $loop:100))
          (else)))
        (if
         (i32.ge_s
          (local.tee $*tmp/639
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
              (local.set $*p/404
               (i32.add
                (local.tee $*tmp/648
                 (local.get $i/99))
                (local.get $j/101)))
              (local.set $str/645
               (local.tee $*field/951
                (local.get $haystack/0/95)))
              (local.set $*tmp/646
               (i32.add
                (local.tee $start/647
                 (local.get $haystack/1/95))
                (local.get $*p/404)))
              (local.set $*tmp/640
               (local.tee $*tmp/950
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/645)
                  (i32.shl
                   (local.get $*tmp/646)
                   (i32.const 1))))))
              (local.set $str/642
               (local.tee $*field/949
                (local.get $needle/0/97)))
              (local.set $*tmp/643
               (i32.add
                (local.tee $start/644
                 (local.get $needle/1/97))
                (local.get $j/101)))
              (local.set $*tmp/641
               (local.tee $*tmp/948
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/642)
                  (i32.shl
                   (local.get $*tmp/643)
                   (i32.const 1))))))
              (local.get $*tmp/640)
              (if
               (i32.ne
                (local.get $*tmp/641))
               (then
                (br $break:102))
               (else))
              (local.tee $*tmp/649
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
               (local.tee $*tmp/650
                (local.get $i/99)))
              (return)))))
          (local.set $i/99
           (i32.sub
            (local.tee $*tmp/651
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
 (local $*p/387 i32)
 (local $*tmp/604 i32)
 (local $*tmp/605 i32)
 (local $str/606 i32)
 (local $*tmp/607 i32)
 (local $start/608 i32)
 (local $*tmp/609 i32)
 (local $*tmp/610 i32)
 (local $*tmp/611 i32)
 (local $*tmp/612 i32)
 (local $str/613 i32)
 (local $*tmp/614 i32)
 (local $start/615 i32)
 (local $str/616 i32)
 (local $*tmp/617 i32)
 (local $start/618 i32)
 (local $*tmp/619 i32)
 (local $*tmp/620 i32)
 (local $*tmp/621 i32)
 (local $*tmp/622 i32)
 (local $*tmp/623 i32)
 (local $str/624 i32)
 (local $*tmp/625 i32)
 (local $start/626 i32)
 (local $*tmp/627 i32)
 (local $end/628 i32)
 (local $start/629 i32)
 (local $end/630 i32)
 (local $start/631 i32)
 (local $*tmp/956 i32)
 (local $*field/957 i32)
 (local $*tmp/958 i32)
 (local $*field/959 i32)
 (local $*tmp/960 i32)
 (local $*field/961 i32)
 (local $*tmp/962 i32)
 (local $*field/963 i32)
 (local $*arr/1019 i32)
 (local $*idx/1020 i32)
 (local $*arr/1021 i32)
 (local $*idx/1022 i32)
 (local.set $end/630
  (local.get $haystack/2/84))
 (local.set $start/631
  (local.get $haystack/1/84))
 (local.set $haystack_len/83
  (i32.sub
   (local.get $end/630)
   (local.get $start/631)))
 (local.set $end/628
  (local.get $needle/2/86))
 (local.set $start/629
  (local.get $needle/1/86))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/85
    (i32.sub
     (local.get $end/628)
     (local.get $start/629)))
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
     (local.tee $*tmp/610
      (i32.sub
       (local.get $needle_len/85)
       (i32.const 1)))
     (loop $loop:89 (param i32)
      (local.tee $i/88)
      (i32.const 0)
      (i32.gt_s)
      (if
       (then
        (local.set $str/606
         (local.tee $*field/963
          (local.get $needle/0/86)))
        (local.set $*tmp/607
         (i32.add
          (local.tee $start/608
           (local.get $needle/1/86))
          (local.get $i/88)))
        (local.set $*tmp/604
         (i32.and
          (local.tee $*tmp/605
           (local.tee $*tmp/962
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/606)
              (i32.shl
               (local.get $*tmp/607)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/87)
        (local.set $*idx/1022
         (local.get $*tmp/604))
        (local.set $*arr/1021)
        (call $moonbit.check_range
         (local.get $*idx/1022)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1021))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1021)
          (i32.shl
           (local.get $*idx/1022)
           (i32.const 2)))
         (local.get $i/88))
        (local.tee $*tmp/609
         (i32.sub
          (local.get $i/88)
          (i32.const 1)))
        (br $loop:89))
       (else)))
     (local.tee $*tmp/627
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
            (local.set $*p/387
             (i32.add
              (local.get $i/90)
              (local.get $j/91)))
            (local.set $str/616
             (local.tee $*field/961
              (local.get $haystack/0/84)))
            (local.set $*tmp/617
             (i32.add
              (local.tee $start/618
               (local.get $haystack/1/84))
              (local.get $*p/387)))
            (local.set $*tmp/611
             (local.tee $*tmp/960
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/616)
                (i32.shl
                 (local.get $*tmp/617)
                 (i32.const 1))))))
            (local.set $str/613
             (local.tee $*field/959
              (local.get $needle/0/86)))
            (local.set $*tmp/614
             (i32.add
              (local.tee $start/615
               (local.get $needle/1/86))
              (local.get $j/91)))
            (local.set $*tmp/612
             (local.tee $*tmp/958
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/613)
                (i32.shl
                 (local.get $*tmp/614)
                 (i32.const 1))))))
            (local.get $*tmp/611)
            (if
             (i32.ne
              (local.get $*tmp/612))
             (then
              (br $break:92))
             (else))
            (local.tee $*tmp/619
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
        (local.set $str/624
         (local.tee $*field/957
          (local.get $haystack/0/84)))
        (local.set $*tmp/625
         (i32.add
          (local.tee $start/626
           (local.get $haystack/1/84))
          (local.get $i/90)))
        (local.set $*tmp/622
         (i32.and
          (local.tee $*tmp/623
           (local.tee $*tmp/956
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/624)
              (i32.shl
               (local.get $*tmp/625)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/87)
        (local.set $*idx/1020
         (local.get $*tmp/622))
        (local.set $*arr/1019)
        (call $moonbit.check_range
         (local.get $*idx/1020)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1019))
          (i32.const 1)))
        (local.set $*tmp/621
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1019)
           (i32.shl
            (local.get $*idx/1020)
            (i32.const 2)))))
        (local.tee $*tmp/620
         (i32.sub
          (local.get $i/90)
          (local.get $*tmp/621)))
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
 (local $*tmp/601 i32)
 (local $end/602 i32)
 (local $start/603 i32)
 (local.set $end/602
  (local.get $str/2/81))
 (local.set $start/603
  (local.get $str/1/81))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/601
    (i32.sub
     (local.get $end/602)
     (local.get $start/603)))
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
 (local $*p/368 i32)
 (local $*p/371 i32)
 (local $*p/374 i32)
 (local $*tmp/574 i32)
 (local $*tmp/575 i32)
 (local $str/576 i32)
 (local $*tmp/577 i32)
 (local $start/578 i32)
 (local $*tmp/579 i32)
 (local $*tmp/580 i32)
 (local $*tmp/581 i32)
 (local $*tmp/582 i32)
 (local $*tmp/583 i32)
 (local $str/584 i32)
 (local $*tmp/585 i32)
 (local $start/586 i32)
 (local $str/587 i32)
 (local $*tmp/588 i32)
 (local $start/589 i32)
 (local $*tmp/590 i32)
 (local $*tmp/591 i32)
 (local $*tmp/592 i32)
 (local $*tmp/593 i32)
 (local $str/594 i32)
 (local $*tmp/595 i32)
 (local $start/596 i32)
 (local $end/597 i32)
 (local $start/598 i32)
 (local $end/599 i32)
 (local $start/600 i32)
 (local $*tmp/964 i32)
 (local $*field/965 i32)
 (local $*tmp/966 i32)
 (local $*field/967 i32)
 (local $*tmp/968 i32)
 (local $*field/969 i32)
 (local $*tmp/970 i32)
 (local $*field/971 i32)
 (local $i/76 i32)
 (local.set $end/599
  (local.get $haystack/2/71))
 (local.set $start/600
  (local.get $haystack/1/71))
 (local.set $haystack_len/70
  (i32.sub
   (local.get $end/599)
   (local.get $start/600)))
 (local.set $end/597
  (local.get $needle/2/73))
 (local.set $start/598
  (local.get $needle/1/73))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/72
    (i32.sub
     (local.get $end/597)
     (local.get $start/598)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/70)
     (local.get $needle_len/72))
    (then
     (local.set $*p/368
      (i32.const 0))
     (local.set $str/594
      (local.tee $*field/971
       (local.get $needle/0/73)))
     (local.set $*tmp/595
      (i32.add
       (local.tee $start/596
        (local.get $needle/1/73))
       (local.get $*p/368)))
     (local.set $needle_first/74
      (local.tee $*tmp/970
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/594)
         (i32.shl
          (local.get $*tmp/595)
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
        (local.tee $*tmp/574
         (local.get $i/76))
        (local.get $forward_len/75))
       (then
        (loop $loop:77
         (if
          (if (result i32)
           (i32.le_s
            (local.tee $*tmp/579
             (local.get $i/76))
            (local.get $forward_len/75))
           (then
            (local.set $*p/371
             (local.get $i/76))
            (local.set $str/576
             (local.tee $*field/969
              (local.get $haystack/0/71)))
            (local.set $*tmp/577
             (i32.add
              (local.tee $start/578
               (local.get $haystack/1/71))
              (local.get $*p/371)))
            (local.tee $*tmp/575
             (local.tee $*tmp/968
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/576)
                (i32.shl
                 (local.get $*tmp/577)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/74)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/76
            (i32.add
             (local.tee $*tmp/580
              (local.get $i/76))
             (i32.const 1)))
           (br $loop:77))
          (else)))
        (if
         (i32.le_s
          (local.tee $*tmp/581
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
              (local.set $*p/374
               (i32.add
                (local.tee $*tmp/590
                 (local.get $i/76))
                (local.get $j/78)))
              (local.set $str/587
               (local.tee $*field/967
                (local.get $haystack/0/71)))
              (local.set $*tmp/588
               (i32.add
                (local.tee $start/589
                 (local.get $haystack/1/71))
                (local.get $*p/374)))
              (local.set $*tmp/582
               (local.tee $*tmp/966
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/587)
                  (i32.shl
                   (local.get $*tmp/588)
                   (i32.const 1))))))
              (local.set $str/584
               (local.tee $*field/965
                (local.get $needle/0/73)))
              (local.set $*tmp/585
               (i32.add
                (local.tee $start/586
                 (local.get $needle/1/73))
                (local.get $j/78)))
              (local.set $*tmp/583
               (local.tee $*tmp/964
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/584)
                  (i32.shl
                   (local.get $*tmp/585)
                   (i32.const 1))))))
              (local.get $*tmp/582)
              (if
               (i32.ne
                (local.get $*tmp/583))
               (then
                (br $break:79))
               (else))
              (local.tee $*tmp/591
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
               (local.tee $*tmp/592
                (local.get $i/76)))
              (return)))))
          (local.set $i/76
           (i32.add
            (local.tee $*tmp/593
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
 (local $*p/356 i32)
 (local $*p/361 i32)
 (local $*tmp/544 i32)
 (local $*tmp/545 i32)
 (local $*tmp/546 i32)
 (local $*tmp/547 i32)
 (local $str/548 i32)
 (local $*tmp/549 i32)
 (local $start/550 i32)
 (local $*tmp/551 i32)
 (local $*tmp/552 i32)
 (local $*tmp/553 i32)
 (local $*tmp/554 i32)
 (local $str/555 i32)
 (local $*tmp/556 i32)
 (local $start/557 i32)
 (local $str/558 i32)
 (local $*tmp/559 i32)
 (local $start/560 i32)
 (local $*tmp/561 i32)
 (local $*tmp/562 i32)
 (local $*tmp/563 i32)
 (local $*tmp/564 i32)
 (local $*tmp/565 i32)
 (local $str/566 i32)
 (local $*tmp/567 i32)
 (local $start/568 i32)
 (local $*tmp/569 i32)
 (local $end/570 i32)
 (local $start/571 i32)
 (local $end/572 i32)
 (local $start/573 i32)
 (local $*tmp/972 i32)
 (local $*field/973 i32)
 (local $*tmp/974 i32)
 (local $*field/975 i32)
 (local $*tmp/976 i32)
 (local $*field/977 i32)
 (local $*tmp/978 i32)
 (local $*field/979 i32)
 (local $*arr/1023 i32)
 (local $*idx/1024 i32)
 (local $*arr/1025 i32)
 (local $*idx/1026 i32)
 (local.set $end/572
  (local.get $haystack/2/57))
 (local.set $start/573
  (local.get $haystack/1/57))
 (local.set $haystack_len/56
  (i32.sub
   (local.get $end/572)
   (local.get $start/573)))
 (local.set $end/570
  (local.get $needle/2/59))
 (local.set $start/571
  (local.get $needle/1/59))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/58
    (i32.sub
     (local.get $end/570)
     (local.get $start/571)))
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
        (local.set $str/548
         (local.tee $*field/979
          (local.get $needle/0/59)))
        (local.set $*tmp/549
         (i32.add
          (local.tee $start/550
           (local.get $needle/1/59))
          (local.get $i/62)))
        (local.set $*tmp/544
         (i32.and
          (local.tee $*tmp/547
           (local.tee $*tmp/978
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/548)
              (i32.shl
               (local.get $*tmp/549)
               (i32.const 1))))))
          (i32.const 255)))
        (local.set $*tmp/545
         (i32.sub
          (local.tee $*tmp/546
           (i32.sub
            (local.get $needle_len/58)
            (i32.const 1)))
          (local.get $i/62)))
        (local.get $skip_table/60)
        (local.set $*idx/1026
         (local.get $*tmp/544))
        (local.set $*arr/1025)
        (call $moonbit.check_range
         (local.get $*idx/1026)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1025))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1025)
          (i32.shl
           (local.get $*idx/1026)
           (i32.const 2)))
         (local.get $*tmp/545))
        (local.tee $*tmp/551
         (i32.add
          (local.get $i/62)
          (i32.const 1)))
        (br $loop:63))
       (else)))
     (i32.const 0)
     (loop $loop:68 (param i32)
      (local.set $i/64)
      (local.set $*tmp/552
       (i32.sub
        (local.get $haystack_len/56)
        (local.get $needle_len/58)))
      (if
       (i32.le_s
        (local.get $i/64)
        (local.get $*tmp/552))
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
            (local.set $*p/356
             (i32.add
              (local.get $i/64)
              (local.get $j/66)))
            (local.set $str/558
             (local.tee $*field/977
              (local.get $haystack/0/57)))
            (local.set $*tmp/559
             (i32.add
              (local.tee $start/560
               (local.get $haystack/1/57))
              (local.get $*p/356)))
            (local.set $*tmp/553
             (local.tee $*tmp/976
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/558)
                (i32.shl
                 (local.get $*tmp/559)
                 (i32.const 1))))))
            (local.set $str/555
             (local.tee $*field/975
              (local.get $needle/0/59)))
            (local.set $*tmp/556
             (i32.add
              (local.tee $start/557
               (local.get $needle/1/59))
              (local.get $j/66)))
            (local.set $*tmp/554
             (local.tee $*tmp/974
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/555)
                (i32.shl
                 (local.get $*tmp/556)
                 (i32.const 1))))))
            (local.get $*tmp/553)
            (if
             (i32.ne
              (local.get $*tmp/554))
             (then
              (br $break:67))
             (else))
            (local.tee $*tmp/561
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
        (local.set $*p/361
         (i32.sub
          (local.tee $*tmp/569
           (i32.add
            (local.get $i/64)
            (local.get $needle_len/58)))
          (i32.const 1)))
        (local.set $str/566
         (local.tee $*field/973
          (local.get $haystack/0/57)))
        (local.set $*tmp/567
         (i32.add
          (local.tee $start/568
           (local.get $haystack/1/57))
          (local.get $*p/361)))
        (local.set $*tmp/564
         (i32.and
          (local.tee $*tmp/565
           (local.tee $*tmp/972
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/566)
              (i32.shl
               (local.get $*tmp/567)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/60)
        (local.set $*idx/1024
         (local.get $*tmp/564))
        (local.set $*arr/1023)
        (call $moonbit.check_range
         (local.get $*idx/1024)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1023))
          (i32.const 1)))
        (local.set $*tmp/563
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1023)
           (i32.shl
            (local.get $*idx/1024)
            (i32.const 2)))))
        (local.tee $*tmp/562
         (i32.add
          (local.get $i/64)
          (local.get $*tmp/563)))
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
 (local $*tmp/533 i32)
 (local $len/534 i32)
 (local $*tmp/535 i32)
 (local $len/536 i32)
 (local $data/537 i32)
 (local $len/538 i32)
 (local $*field/984 i32)
 (local.set $*tmp/533
  (i32.add
   (local.tee $len/534
    (i32.load offset=8
     (local.get $self/47)))
   (i32.const 4)))
 (call $moonbit.incref
  (local.get $self/47))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/47)
   (local.get $*tmp/533)))
 (local.set $data/537
  (local.tee $*field/984
   (i32.load offset=12
    (local.get $self/47))))
 (local.set $len/538
  (i32.load offset=8
   (local.get $self/47)))
 (call $moonbit.incref
  (local.get $data/537))
 (local.set $inc/48
  (call $FixedArray::set_utf16le_char
   (local.get $data/537)
   (local.get $len/538)
   (local.get $ch/49)))
 (local.set $*tmp/535
  (i32.add
   (local.tee $len/536
    (i32.load offset=8
     (local.get $self/47)))
   (local.get $inc/48)))
 (i32.store offset=8
  (local.get $self/47)
  (local.get $*tmp/535))
 (call $moonbit.decref
  (local.get $self/47))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/42 i32) (param $required/43 i32) (result i32)
 (local $current_len/41 i32)
 (local $new_data/46 i32)
 (local $*tmp/527 i32)
 (local $*tmp/528 i32)
 (local $data/529 i32)
 (local $len/530 i32)
 (local $*tmp/531 i32)
 (local $data/532 i32)
 (local $*old/985 i32)
 (local $*field/986 i32)
 (local $*tmp/987 i32)
 (local $*field/988 i32)
 (local $enough_space/44 i32)
 (local.set $current_len/41
  (local.tee $*tmp/987
   (call $moonbit.array_length
    (local.tee $data/532
     (local.tee $*field/988
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
    (local.tee $*tmp/527
     (local.get $enough_space/44))
    (local.get $required/43))
   (then
    (local.set $enough_space/44
     (i32.mul
      (local.tee $*tmp/528
       (local.get $enough_space/44))
      (i32.const 2)))
    (br $loop:45))
   (else)))
 (local.set $new_data/46
  (call $moonbit.bytes_make
   (local.tee $*tmp/531
    (local.get $enough_space/44))
   (i32.const 0)))
 (local.set $data/529
  (local.tee $*field/986
   (i32.load offset=12
    (local.get $self/42))))
 (local.set $len/530
  (i32.load offset=8
   (local.get $self/42)))
 (call $moonbit.incref
  (local.get $data/529))
 (call $moonbit.incref
  (local.get $new_data/46))
 (drop
  (call $FixedArray::unsafe_blit|Byte|
   (local.get $new_data/46)
   (i32.const 0)
   (local.get $data/529)
   (i32.const 0)
   (local.get $len/530)))
 (call $moonbit.decref
  (local.tee $*old/985
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
 (local $*p/330 i32)
 (local $*p/333 i32)
 (local $*p/336 i32)
 (local $*p/339 i32)
 (local $*p/342 i32)
 (local $*p/345 i32)
 (local $*tmp/508 i32)
 (local $*tmp/509 i32)
 (local $*tmp/510 i32)
 (local $*tmp/511 i32)
 (local $*tmp/512 i32)
 (local $*tmp/513 i32)
 (local $*tmp/514 i32)
 (local $*tmp/515 i32)
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
 (local $*arr/1027 i32)
 (local $*idx/1028 i32)
 (local $*arr/1029 i32)
 (local $*idx/1030 i32)
 (local $*arr/1031 i32)
 (local $*idx/1032 i32)
 (local $*arr/1033 i32)
 (local $*idx/1034 i32)
 (local $*arr/1035 i32)
 (local $*idx/1036 i32)
 (local $*arr/1037 i32)
 (local $*idx/1038 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/34
    (local.tee $*tmp/526
     (local.get $value/35)))
   (i32.const 65536))
  (then
   (local.set $*tmp/508
    (i32.and
     (local.tee $*tmp/509
      (local.tee $*p/330
       (i32.and
        (local.get $code/34)
        (i32.const 255))))
     (i32.const 255)))
   (local.get $self/36)
   (local.set $*idx/1030
    (local.get $offset/37))
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
    (local.get $*tmp/508))
   (local.set $*tmp/510
    (i32.add
     (local.get $offset/37)
     (i32.const 1)))
   (local.set $*tmp/511
    (i32.and
     (local.tee $*tmp/512
      (local.tee $*p/333
       (i32.shr_u
        (local.get $code/34)
        (i32.const 8))))
     (i32.const 255)))
   (local.get $self/36)
   (local.set $*idx/1028
    (local.get $*tmp/510))
   (local.set $*arr/1027)
   (call $moonbit.check_range
    (local.get $*idx/1028)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1027))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1027)
     (local.get $*idx/1028))
    (local.get $*tmp/511))
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
       (local.tee $*tmp/525
        (i32.shr_u
         (local.tee $hi/38
          (i32.sub
           (local.get $code/34)
           (i32.const 65536)))
         (i32.const 10)))
       (i32.const 55296)))
     (local.set $hi/40
      (i32.or
       (local.tee $*tmp/524
        (i32.and
         (local.get $hi/38)
         (i32.const 1023)))
       (i32.const 56320)))
     (local.set $*tmp/513
      (i32.and
       (local.tee $*tmp/514
        (local.tee $*p/336
         (i32.and
          (local.get $lo/39)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1038
      (local.get $offset/37))
     (local.set $*arr/1037)
     (call $moonbit.check_range
      (local.get $*idx/1038)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1037))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1037)
       (local.get $*idx/1038))
      (local.get $*tmp/513))
     (local.set $*tmp/515
      (i32.add
       (local.get $offset/37)
       (i32.const 1)))
     (local.set $*tmp/516
      (i32.and
       (local.tee $*tmp/517
        (local.tee $*p/339
         (i32.shr_u
          (local.get $lo/39)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1036
      (local.get $*tmp/515))
     (local.set $*arr/1035)
     (call $moonbit.check_range
      (local.get $*idx/1036)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1035))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1035)
       (local.get $*idx/1036))
      (local.get $*tmp/516))
     (local.set $*tmp/518
      (i32.add
       (local.get $offset/37)
       (i32.const 2)))
     (local.set $*tmp/519
      (i32.and
       (local.tee $*tmp/520
        (local.tee $*p/342
         (i32.and
          (local.get $hi/40)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1034
      (local.get $*tmp/518))
     (local.set $*arr/1033)
     (call $moonbit.check_range
      (local.get $*idx/1034)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1033))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1033)
       (local.get $*idx/1034))
      (local.get $*tmp/519))
     (local.set $*tmp/521
      (i32.add
       (local.get $offset/37)
       (i32.const 3)))
     (local.set $*tmp/522
      (i32.and
       (local.tee $*tmp/523
        (local.tee $*p/345
         (i32.shr_u
          (local.get $hi/40)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/36)
     (local.set $*idx/1032
      (local.get $*tmp/521))
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
      (local.get $*tmp/522))
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
 (local $*tmp/502 i32)
 (local $*tmp/503 i64)
 (local $len/504 i32)
 (local $data/505 i32)
 (local $*field/989 i32)
 (local $*field/990 i32)
 (call $moonbit.incref
  (local.tee $data/505
   (local.tee $*field/990
    (i32.load offset=12
     (local.get $self/31)))))
 (local.set $*tmp/502
  (local.get $data/505))
 (local.set $*field/989
  (i32.load offset=8
   (local.get $self/31)))
 (call $moonbit.decref
  (local.get $self/31))
 (local.set $*tmp/503
  (i64.extend_i32_s
   (local.tee $len/504
    (local.get $*field/989))))
 (call $Bytes::to_unchecked_string.inner
  (local.get $*tmp/502)
  (i32.const 0)
  (local.get $*tmp/503)))
(func $Bytes::to_unchecked_string.inner (param $self/26 i32) (param $offset/30 i32) (param $length/28 i64) (result i32)
 (local $len/25 i32)
 (local $length/27 i32)
 (local $*Some/29 i64)
 (local $*tmp/501 i32)
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
       (local.tee $*tmp/501
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
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/453 i32) (param $*param/454 i32) (param $*param/455 i32) (result i32)
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/453)
  (local.get $*param/454)
  (local.get $*param/455)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/23 i32) (result i32)
 (local $initial/22 i32)
 (local $data/24 i32)
 (local $ptr/1039 i32)
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
  (local.tee $ptr/1039
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1039)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/1039)
  (local.get $data/24))
 (local.get $ptr/1039))
(func $FixedArray::unsafe_blit|Byte| (param $dst/13 i32) (param $dst_offset/15 i32) (param $src/14 i32) (param $src_offset/16 i32) (param $len/18 i32) (result i32)
 (local $i/17 i32)
 (local $i/20 i32)
 (local $*tmp/492 i32)
 (local $*tmp/493 i32)
 (local $*tmp/494 i32)
 (local $*tmp/495 i32)
 (local $*tmp/496 i32)
 (local $*tmp/497 i32)
 (local $*tmp/498 i32)
 (local $*tmp/499 i32)
 (local $*tmp/500 i32)
 (local $*arr/1040 i32)
 (local $*idx/1041 i32)
 (local $*arr/1042 i32)
 (local $*idx/1043 i32)
 (local $*arr/1044 i32)
 (local $*idx/1045 i32)
 (local $*arr/1046 i32)
 (local $*idx/1047 i32)
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
      (local.set $*tmp/492
       (i32.add
        (local.get $dst_offset/15)
        (local.get $i/17)))
      (local.set $*tmp/494
       (i32.add
        (local.get $src_offset/16)
        (local.get $i/17)))
      (local.get $src/14)
      (local.set $*idx/1043
       (local.get $*tmp/494))
      (local.set $*arr/1042)
      (call $moonbit.check_range
       (local.get $*idx/1043)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1042))
        (i32.const 1)))
      (local.set $*tmp/493
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1042)
         (local.get $*idx/1043))))
      (local.get $dst/13)
      (local.set $*idx/1041
       (local.get $*tmp/492))
      (local.set $*arr/1040)
      (call $moonbit.check_range
       (local.get $*idx/1041)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1040))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1040)
        (local.get $*idx/1041))
       (local.get $*tmp/493))
      (local.tee $*tmp/495
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
   (local.tee $*tmp/500
    (i32.sub
     (local.get $len/18)
     (i32.const 1)))
   (loop $loop:21 (param i32)
    (local.tee $i/20)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/496
       (i32.add
        (local.get $dst_offset/15)
        (local.get $i/20)))
      (local.set $*tmp/498
       (i32.add
        (local.get $src_offset/16)
        (local.get $i/20)))
      (local.get $src/14)
      (local.set $*idx/1047
       (local.get $*tmp/498))
      (local.set $*arr/1046)
      (call $moonbit.check_range
       (local.get $*idx/1047)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1046))
        (i32.const 1)))
      (local.set $*tmp/497
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1046)
         (local.get $*idx/1047))))
      (local.get $dst/13)
      (local.set $*idx/1045
       (local.get $*tmp/496))
      (local.set $*arr/1044)
      (call $moonbit.check_range
       (local.get $*idx/1045)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1044))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1044)
        (local.get $*idx/1045))
       (local.get $*tmp/497))
      (local.tee $*tmp/499
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
 (local $*tmp/488 i32)
 (local $*tmp/489 i32)
 (local $*tmp/490 i32)
 (local $*tmp/491 i32)
 (local.set $*tmp/490
  (call $moonbit.add_string
   (local.get $string/11)
   (i32.const 11008)))
 (local.set $*tmp/491
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/12)))
 (call $moonbitlang/core/abort.abort|Option<Int>|
  (local.tee $*tmp/488
   (call $moonbit.add_string
    (local.tee $*tmp/489
     (call $moonbit.add_string
      (local.get $*tmp/490)
      (local.get $*tmp/491)))
    (i32.const 10992)))))
(func $moonbitlang/core/builtin.abort|StringView| (param $string/9 i32) (param $loc/10 i32) (result i32) (result i32) (result i32)
 (local $*tmp/484 i32)
 (local $*tmp/485 i32)
 (local $*tmp/486 i32)
 (local $*tmp/487 i32)
 (local.set $*tmp/486
  (call $moonbit.add_string
   (local.get $string/9)
   (i32.const 11008)))
 (local.set $*tmp/487
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/10)))
 (call $moonbitlang/core/abort.abort|StringView|
  (local.tee $*tmp/484
   (call $moonbit.add_string
    (local.tee $*tmp/485
     (call $moonbit.add_string
      (local.get $*tmp/486)
      (local.get $*tmp/487)))
    (i32.const 10992)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/7 i32) (param $loc/8 i32) (result i32)
 (local $*tmp/480 i32)
 (local $*tmp/481 i32)
 (local $*tmp/482 i32)
 (local $*tmp/483 i32)
 (local.set $*tmp/482
  (call $moonbit.add_string
   (local.get $string/7)
   (i32.const 11008)))
 (local.set $*tmp/483
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/8)))
 (call $moonbitlang/core/abort.abort|Int|
  (local.tee $*tmp/480
   (call $moonbit.add_string
    (local.tee $*tmp/481
     (call $moonbit.add_string
      (local.get $*tmp/482)
      (local.get $*tmp/483)))
    (i32.const 10992)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/5 i32) (param $loc/6 i32) (result i32)
 (local $*tmp/476 i32)
 (local $*tmp/477 i32)
 (local $*tmp/478 i32)
 (local $*tmp/479 i32)
 (local.set $*tmp/478
  (call $moonbit.add_string
   (local.get $string/5)
   (i32.const 11008)))
 (local.set $*tmp/479
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/6)))
 (call $moonbitlang/core/abort.abort|Unit|
  (local.tee $*tmp/476
   (call $moonbit.add_string
    (local.tee $*tmp/477
     (call $moonbit.add_string
      (local.get $*tmp/478)
      (local.get $*tmp/479)))
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
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/469 i32) (param $*param/468 i32) (result i32)
 (local $*self/467 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/467
   (local.get $*obj_ptr/469))
  (local.get $*param/468)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/466 i32) (param $*param/0/465 i32) (param $*param/1/465 i32) (param $*param/2/465 i32) (result i32)
 (local $*self/464 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/464
   (local.get $*obj_ptr/466))
  (local.get $*param/0/465)
  (local.get $*param/1/465)
  (local.get $*param/2/465)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (param $*obj_ptr/463 i32) (param $*param/460 i32) (param $*param/461 i32) (param $*param/462 i32) (result i32)
 (local $*self/459 i32)
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/459
   (local.get $*obj_ptr/463))
  (local.get $*param/460)
  (local.get $*param/461)
  (local.get $*param/462)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/458 i32) (param $*param/457 i32) (result i32)
 (local $*self/456 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/456
   (local.get $*obj_ptr/458))
  (local.get $*param/457)))
(start $*init*/2)
(func $*init*/2
 (global.set $username/moonbit_examples/cmd/hof.*init*.double|2.clo
  (i32.const 11216))
 (global.set $username/moonbit_examples/cmd/hof.*init*.square|4.clo
  (i32.const 11200))
 (global.set $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/55
  (i64.extend_i32_s
   (i32.const 0)))
 (global.set $moonbitlang/core/builtin.brute_force_find.constr/69
  (i64.extend_i32_s
   (i32.const 0))))
(func $*main*/1
 (local $*tmp/470 i32)
 (local $*tmp/471 i32)
 (local $*tmp/472 i32)
 (local $*tmp/473 i32)
 (local $*tmp/474 i32)
 (local $*tmp/475 i32)
 (call $moonbit.incref
  (global.get $username/moonbit_examples/cmd/hof.*init*.double|2.clo))
 (local.set $*tmp/471
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $*tmp/472
    (call $username/moonbit_examples/cmd/hof.apply
     (global.get $username/moonbit_examples/cmd/hof.*init*.double|2.clo)
     (i32.const 5)))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/470
    (call $moonbit.add_string
     (i32.const 11080)
     (local.get $*tmp/471)))))
 (call $moonbit.incref
  (global.get $username/moonbit_examples/cmd/hof.*init*.square|4.clo))
 (local.set $*tmp/474
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $*tmp/475
    (call $username/moonbit_examples/cmd/hof.apply
     (global.get $username/moonbit_examples/cmd/hof.*init*.square|4.clo)
     (i32.const 5)))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/473
    (call $moonbit.add_string
     (i32.const 11032)
     (local.get $*tmp/474))))))
(export "_start" (func $*main*/1))