(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data  (memory $moonbit.memory) (offset (i32.const 10000)) "\FF\FF\FF\FF\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\02\00\00P,\00 \00\00\00\00\00\FF\FF\FF\FF\01\00\00P]\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P[\00\00\00\00\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\003\006\006\00:\005\00-\003\006\006\00:\003\003\00\00\00\00\00\00\00\FF\FF\FF\FF\13\00\00PI\00n\00v\00a\00l\00i\00d\00 \00s\00t\00a\00r\00t\00 \00i\00n\00d\00e\00x\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\004\009\001\00:\009\00-\004\009\001\00:\004\000\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00Pi\00n\00v\00a\00l\00i\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00 \00p\00a\00i\00r\00\00\00\00\00\FF\FF\FF\FF\01\00\00P0\00\00\00\00\00\00\00\FF\FF\FF\FF4\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00Pr\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\FF\FF\FF\FF$\00\00P0\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF5\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00v\00i\00e\00w\00.\00m\00b\00t\00:\001\001\001\00:\005\00-\001\001\001\00:\003\006\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00PI\00n\00v\00a\00l\00i\00d\00 \00i\00n\00d\00e\00x\00 \00f\00o\00r\00 \00V\00i\00e\00w\00\00\00\00\00\FF\FF\FF\FF0\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\000\00:\005\00-\002\009\000\00:\003\001\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\11\00\00PC\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P\0A\00\00\00\00\00\00\00\FF\FF\FF\FF\06\00\00P\0A\00 \00 \00a\00t\00 \00\00\00\00\00\FF\FF\FF\FF\0F\00\00PD\00o\00u\00b\00l\00e\00d\00 \00a\00r\00r\00a\00y\00:\00 \00\00\00\FF\FF\FF\FF\00\00\00`\00\00\00\00\00\00\00\00\FF\FF\FF\FF\17\00\00PS\00u\00m\00 \00o\00f\00 \00a\00r\00r\00a\00y\00 \00e\00l\00e\00m\00e\00n\00t\00s\00:\00 \00\00\00\FF\FF\FF\FF\10\00\00PO\00r\00i\00g\00i\00n\00a\00l\00 \00a\00r\00r\00a\00y\00:\00 \00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\00\04\10\00\04\00\00\00\05\00\00\00\06\00\00\00\07\00\00\00\FF\FF\FF\FF\01\00\00P:\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P-\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P/\00\00\00\00\00\00\00")
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
    (i32.const 11312)
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
   (i32.const 11312)
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
(type $<<Int>=>Int>=>Int
 (func
  (param i32) (param i32)
  (result i32)))
(type $<>=>Option<Int>
 (func
  (param i32)
  (result i64)))
(table $moonbit.global 8 8 funcref )
(elem
 (table $moonbit.global) (offset (i32.const 0))
 funcref
 (ref.func $ArrayView::iterator|Int|.*p.fn/4)
 (ref.func $Iterator::iter|Int|.fn/3)
 (ref.func $Logger::write_iter.inner|Int|.fn/1)
 (ref.func $Logger::write_iter.inner|Int|.fn/2)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger))
(global $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id
 i32
 (i32.const 11240)
)
(global $moonbitlang/core/builtin.parse.*bind|5401
 i32
 (i32.const 11264)
)
(global $moonbitlang/core/builtin.parse.*bind|5440
 i32
 (i32.const 11264)
)
(global $moonbitlang/core/builtin.parse.*bind|5434
 i32
 (i32.const 11280)
)
(global $moonbitlang/core/builtin.parse.*bind|5421
 i32
 (i32.const 11264)
)
(global $moonbitlang/core/builtin.parse.*bind|5415
 i32
 (i32.const 11264)
)
(global $moonbitlang/core/builtin.output.*bind|8190
 i32
 (i32.const 11296)
)
(global $moonbitlang/core/builtin.output.*bind|8184
 i32
 (i32.const 11296)
)
(global $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/72
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/builtin.brute_force_find.constr/86
 (mut i64)
 (i64.const 0)
)
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/371 i32) (param $logger/0/372 i32) (param $logger/1/372 i32) (result i32)
 (local $*tmp/1047 i32)
 (local $*tmp/1048 i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (local.tee $*tmp/1047
   (call $@moonbitlang/core/builtin.SourceLocRepr::parse
    (local.tee $*tmp/1048
     (local.get $self/371))))
  (local.get $logger/0/372)
  (local.get $logger/1/372)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/357 i32) (param $logger/0/370 i32) (param $logger/1/370 i32) (result i32)
 (local $pkg/0/356 i32)
 (local $pkg/1/356 i32)
 (local $pkg/2/356 i32)
 (local $*bind/358 i64)
 (local $*bind/359 i32)
 (local $*Some/360 i64)
 (local $*first_slash/361 i32)
 (local $*bind/362 i64)
 (local $*Some/363 i64)
 (local $*second_slash/364 i32)
 (local $module_name_end/365 i32)
 (local $*module_name/0/366 i32)
 (local $*module_name/1/366 i32)
 (local $*module_name/2/366 i32)
 (local $*package_name/367 i32)
 (local $*Some/368 i32)
 (local $*pkg_name/0/369 i32)
 (local $*pkg_name/1/369 i32)
 (local $*pkg_name/2/369 i32)
 (local $*bind/0/1026 i32)
 (local $*bind/1/1026 i32)
 (local $*bind/0/1027 i32)
 (local $*bind/1/1027 i32)
 (local $filename/0/1028 i32)
 (local $filename/1/1028 i32)
 (local $filename/2/1028 i32)
 (local $start_line/0/1029 i32)
 (local $start_line/1/1029 i32)
 (local $start_line/2/1029 i32)
 (local $start_column/0/1030 i32)
 (local $start_column/1/1030 i32)
 (local $start_column/2/1030 i32)
 (local $end_line/0/1031 i32)
 (local $end_line/1/1031 i32)
 (local $end_line/2/1031 i32)
 (local $end_column/0/1032 i32)
 (local $end_column/1/1032 i32)
 (local $end_column/2/1032 i32)
 (local $None/1033 i32)
 (local $None/1034 i32)
 (local $*tmp/0/1035 i32)
 (local $*tmp/1/1035 i32)
 (local $*tmp/2/1035 i32)
 (local $Some/1036 i32)
 (local $*tmp/0/1037 i32)
 (local $*tmp/1/1037 i32)
 (local $*tmp/2/1037 i32)
 (local $*tmp/1038 i32)
 (local $*tmp/1039 i64)
 (local $*tmp/1040 i32)
 (local $*tmp/0/1041 i32)
 (local $*tmp/1/1041 i32)
 (local $*tmp/2/1041 i32)
 (local $*tmp/0/1042 i32)
 (local $*tmp/1/1042 i32)
 (local $*tmp/2/1042 i32)
 (local $*tmp/1043 i32)
 (local $*tmp/1044 i32)
 (local $*tmp/0/1045 i32)
 (local $*tmp/1/1045 i32)
 (local $*tmp/2/1045 i32)
 (local $*tmp/1046 i32)
 (local $*field/0/1049 i32)
 (local $*field/1/1049 i32)
 (local $*field/2/1049 i32)
 (local $*field/0/1050 i32)
 (local $*field/1/1050 i32)
 (local $*field/2/1050 i32)
 (local $*field/0/1051 i32)
 (local $*field/1/1051 i32)
 (local $*field/2/1051 i32)
 (local $*field/0/1052 i32)
 (local $*field/1/1052 i32)
 (local $*field/2/1052 i32)
 (local $*field/0/1053 i32)
 (local $*field/1/1053 i32)
 (local $*field/2/1053 i32)
 (local $*field/0/1054 i32)
 (local $*field/1/1054 i32)
 (local $*field/2/1054 i32)
 (local $*field/1055 i32)
 (local $*field/0/1056 i32)
 (local $*field/1/1056 i32)
 (local $*field/2/1056 i32)
 (local $*field/0/1057 i32)
 (local $*field/1/1057 i32)
 (local $*field/2/1057 i32)
 (local $*cnt/1138 i32)
 (local $*new_cnt/1139 i32)
 (local $*cnt/1140 i32)
 (local $*new_cnt/1141 i32)
 (local $*cnt/1142 i32)
 (local $*field/0/1143 i32)
 (local $*field/1/1143 i32)
 (local $*field/2/1143 i32)
 (local $*field/0/1144 i32)
 (local $*field/1/1144 i32)
 (local $*field/2/1144 i32)
 (local $*field/0/1145 i32)
 (local $*field/1/1145 i32)
 (local $*field/2/1145 i32)
 (local $*field/0/1146 i32)
 (local $*field/1/1146 i32)
 (local $*field/2/1146 i32)
 (local $*field/0/1147 i32)
 (local $*field/1/1147 i32)
 (local $*field/2/1147 i32)
 (local $*new_cnt/1148 i32)
 (local $*tag/1165 i32)
 (local $ptr/1166 i32)
 (local $ptr/1167 i32)
 (local $ptr/1168 i32)
 (local $ptr/1169 i32)
 (i32.load offset=56
  (local.get $self/357))
 (i32.load offset=8
  (local.get $self/357))
 (local.set $*field/2/1057
  (i32.load offset=12
   (local.get $self/357)))
 (local.set $*field/1/1057)
 (local.tee $*field/0/1057)
 (local.get $*field/1/1057)
 (local.set $pkg/2/356
  (local.get $*field/2/1057))
 (local.set $pkg/1/356)
 (local.set $pkg/0/356)
 (local.set $*tmp/1046
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.output.*bind|8190)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.output.*bind|8190))
 (global.get $moonbitlang/core/builtin.output.*bind|8190)
 (i32.const 0)
 (local.set $*tmp/2/1045
  (local.get $*tmp/1046))
 (local.set $*tmp/1/1045)
 (local.set $*tmp/0/1045)
 (call $moonbit.incref
  (local.get $pkg/0/356))
 (call $moonbit.incref
  (local.get $pkg/0/356))
 (i32.load offset=16
  (local.tee $*bind/359
   (if (result i32)
    (i64.eq
     (local.tee $*bind/358
      (call $StringView::find
       (local.get $pkg/0/356)
       (local.get $pkg/1/356)
       (local.get $pkg/2/356)
       (local.get $*tmp/0/1045)
       (local.get $*tmp/1/1045)
       (local.get $*tmp/2/1045)))
     (i64.const 4294967296))
    (then
     (local.set $None/1033
      (i32.const 10000))
     (i32.store offset=4
      (local.tee $ptr/1166
       (call $moonbit.gc.malloc
        (i32.const 16)))
      (i32.const 2097664))
     (i32.store offset=20
      (local.get $ptr/1166)
      (local.get $None/1033))
     (i32.store offset=16
      (local.get $ptr/1166)
      (local.get $pkg/0/356))
     (i32.store offset=8
      (local.get $ptr/1166)
      (local.get $pkg/1/356))
     (i32.store offset=12
      (local.get $ptr/1166)
      (local.get $pkg/2/356))
     (local.get $ptr/1166))
    (else
     (local.set $*tmp/1044
      (i32.add
       (local.tee $*first_slash/361
        (i32.wrap_i64
         (local.tee $*Some/360
          (local.get $*bind/358))))
       (i32.const 1)))
     (call $moonbit.incref
      (local.get $pkg/0/356))
     (call $StringView::view.inner
      (local.get $pkg/0/356)
      (local.get $pkg/1/356)
      (local.get $pkg/2/356)
      (local.get $*tmp/1044)
      (i64.const 4294967296))
     (local.set $*tmp/2/1041)
     (local.set $*tmp/1/1041)
     (local.set $*tmp/0/1041)
     (local.set $*tmp/1043
      (call $moonbit.array_length
       (global.get $moonbitlang/core/builtin.output.*bind|8184)))
     (call $moonbit.incref
      (global.get $moonbitlang/core/builtin.output.*bind|8184))
     (global.get $moonbitlang/core/builtin.output.*bind|8184)
     (i32.const 0)
     (local.set $*tmp/2/1042
      (local.get $*tmp/1043))
     (local.set $*tmp/1/1042)
     (local.set $*tmp/0/1042)
     (if (result i32)
      (i64.eq
       (local.tee $*bind/362
        (call $StringView::find
         (local.get $*tmp/0/1041)
         (local.get $*tmp/1/1041)
         (local.get $*tmp/2/1041)
         (local.get $*tmp/0/1042)
         (local.get $*tmp/1/1042)
         (local.get $*tmp/2/1042)))
       (i64.const 4294967296))
      (then
       (local.set $None/1034
        (i32.const 10000))
       (i32.store offset=4
        (local.tee $ptr/1167
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1167)
        (local.get $None/1034))
       (i32.store offset=16
        (local.get $ptr/1167)
        (local.get $pkg/0/356))
       (i32.store offset=8
        (local.get $ptr/1167)
        (local.get $pkg/1/356))
       (i32.store offset=12
        (local.get $ptr/1167)
        (local.get $pkg/2/356))
       (local.get $ptr/1167))
      (else
       (local.set $*second_slash/364
        (i32.wrap_i64
         (local.tee $*Some/363
          (local.get $*bind/362))))
       (local.set $*tmp/1039
        (i64.extend_i32_s
         (local.tee $module_name_end/365
          (i32.add
           (local.tee $*tmp/1040
            (i32.add
             (local.get $*first_slash/361)
             (i32.const 1)))
           (local.get $*second_slash/364)))))
       (call $moonbit.incref
        (local.get $pkg/0/356))
       (call $StringView::view.inner
        (local.get $pkg/0/356)
        (local.get $pkg/1/356)
        (local.get $pkg/2/356)
        (i32.const 0)
        (local.get $*tmp/1039))
       (local.set $*tmp/2/1035)
       (local.set $*tmp/1/1035)
       (local.set $*tmp/0/1035)
       (local.set $*tmp/1038
        (i32.add
         (local.get $module_name_end/365)
         (i32.const 1)))
       (call $StringView::view.inner
        (local.get $pkg/0/356)
        (local.get $pkg/1/356)
        (local.get $pkg/2/356)
        (local.get $*tmp/1038)
        (i64.const 4294967296))
       (local.set $*tmp/2/1037)
       (local.set $*tmp/1/1037)
       (local.set $*tmp/0/1037)
       (i32.store offset=4
        (local.tee $ptr/1169
         (call $moonbit.gc.malloc
          (i32.const 12)))
        (i32.const 2097409))
       (i32.store offset=16
        (local.get $ptr/1169)
        (local.get $*tmp/0/1037))
       (i32.store offset=8
        (local.get $ptr/1169)
        (local.get $*tmp/1/1037))
       (i32.store offset=12
        (local.get $ptr/1169)
        (local.get $*tmp/2/1037))
       (local.set $Some/1036
        (local.get $ptr/1169))
       (i32.store offset=4
        (local.tee $ptr/1168
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1168)
        (local.get $Some/1036))
       (i32.store offset=16
        (local.get $ptr/1168)
        (local.get $*tmp/0/1035))
       (i32.store offset=8
        (local.get $ptr/1168)
        (local.get $*tmp/1/1035))
       (i32.store offset=12
        (local.get $ptr/1168)
        (local.get $*tmp/2/1035))
       (local.get $ptr/1168)))))))
 (i32.load offset=8
  (local.get $*bind/359))
 (local.set $*field/2/1056
  (i32.load offset=12
   (local.get $*bind/359)))
 (local.set $*field/1/1056)
 (local.tee $*field/0/1056)
 (local.get $*field/1/1056)
 (local.set $*module_name/2/366
  (local.get $*field/2/1056))
 (local.set $*module_name/1/366)
 (local.set $*module_name/0/366)
 (local.set $*field/1055
  (i32.load offset=20
   (local.get $*bind/359)))
 (if
  (i32.gt_s
   (local.tee $*cnt/1138
    (i32.load
     (local.get $*bind/359)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/1055))
   (call $moonbit.incref
    (local.get $*module_name/0/366))
   (local.set $*new_cnt/1139
    (i32.sub
     (local.get $*cnt/1138)
     (i32.const 1)))
   (i32.store
    (local.get $*bind/359)
    (local.get $*new_cnt/1139)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1138)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*bind/359)))
    (else))))
 (if
  (i32.eq
   (local.tee $*tag/1165
    (call $moonbit.get_tag
     (local.tee $*package_name/367
      (local.get $*field/1055))))
   (i32.const 1))
  (then
   (i32.load offset=16
    (local.tee $*Some/368
     (local.get $*package_name/367)))
   (i32.load offset=8
    (local.get $*Some/368))
   (local.set $*field/2/1054
    (i32.load offset=12
     (local.get $*Some/368)))
   (local.set $*field/1/1054)
   (local.set $*field/0/1054)
   (if
    (i32.gt_s
     (local.tee $*cnt/1140
      (i32.load
       (local.get $*Some/368)))
     (i32.const 1))
    (then
     (call $moonbit.incref
      (local.get $*field/0/1054))
     (local.set $*new_cnt/1141
      (i32.sub
       (local.get $*cnt/1140)
       (i32.const 1)))
     (i32.store
      (local.get $*Some/368)
      (local.get $*new_cnt/1141)))
    (else
     (if
      (i32.eq
       (local.get $*cnt/1140)
       (i32.const 1))
      (then
       (call $moonbit.free
        (local.get $*Some/368)))
      (else))))
   (local.get $*field/0/1054)
   (local.get $*field/1/1054)
   (local.set $*pkg_name/2/369
    (local.get $*field/2/1054))
   (local.set $*pkg_name/1/369)
   (local.set $*pkg_name/0/369)
   (if
    (local.get $logger/1/370)
    (then
     (call $moonbit.incref
      (local.get $logger/1/370)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
     (local.get $logger/1/370)
     (local.get $*pkg_name/0/369)
     (local.get $*pkg_name/1/369)
     (local.get $*pkg_name/2/369)
     (i32.load offset=16
      (local.get $logger/0/370))))
   (local.get $logger/0/370)
   (local.set $*bind/1/1026
    (local.get $logger/1/370))
   (local.set $*bind/0/1026)
   (if
    (local.get $*bind/1/1026)
    (then
     (call $moonbit.incref
      (local.get $*bind/1/1026)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
     (local.get $*bind/1/1026)
     (i32.const 47)
     (i32.load offset=20
      (local.get $*bind/0/1026)))))
  (else
   (call $moonbit.decref
    (local.get $*package_name/367))))
 (i32.load offset=60
  (local.get $self/357))
 (i32.load offset=16
  (local.get $self/357))
 (local.set $*field/2/1053
  (i32.load offset=20
   (local.get $self/357)))
 (local.set $*field/1/1053)
 (local.tee $*field/0/1053)
 (local.get $*field/1/1053)
 (local.set $filename/2/1028
  (local.get $*field/2/1053))
 (local.set $filename/1/1028)
 (local.tee $filename/0/1028)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/370)
   (local.get $filename/0/1028)
   (local.get $filename/1/1028)
   (local.get $filename/2/1028)
   (i32.load offset=16
    (local.get $logger/0/370))))
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/370)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/370))))
 (i32.load offset=64
  (local.get $self/357))
 (i32.load offset=24
  (local.get $self/357))
 (local.set $*field/2/1052
  (i32.load offset=28
   (local.get $self/357)))
 (local.set $*field/1/1052)
 (local.tee $*field/0/1052)
 (local.get $*field/1/1052)
 (local.set $start_line/2/1029
  (local.get $*field/2/1052))
 (local.set $start_line/1/1029)
 (local.tee $start_line/0/1029)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/370)
   (local.get $start_line/0/1029)
   (local.get $start_line/1/1029)
   (local.get $start_line/2/1029)
   (i32.load offset=16
    (local.get $logger/0/370))))
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/370)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/370))))
 (i32.load offset=68
  (local.get $self/357))
 (i32.load offset=32
  (local.get $self/357))
 (local.set $*field/2/1051
  (i32.load offset=36
   (local.get $self/357)))
 (local.set $*field/1/1051)
 (local.tee $*field/0/1051)
 (local.get $*field/1/1051)
 (local.set $start_column/2/1030
  (local.get $*field/2/1051))
 (local.set $start_column/1/1030)
 (local.tee $start_column/0/1030)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/370)
   (local.get $start_column/0/1030)
   (local.get $start_column/1/1030)
   (local.get $start_column/2/1030)
   (i32.load offset=16
    (local.get $logger/0/370))))
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/370)
   (i32.const 45)
   (i32.load offset=20
    (local.get $logger/0/370))))
 (i32.load offset=72
  (local.get $self/357))
 (i32.load offset=40
  (local.get $self/357))
 (local.set $*field/2/1050
  (i32.load offset=44
   (local.get $self/357)))
 (local.set $*field/1/1050)
 (local.tee $*field/0/1050)
 (local.get $*field/1/1050)
 (local.set $end_line/2/1031
  (local.get $*field/2/1050))
 (local.set $end_line/1/1031)
 (local.tee $end_line/0/1031)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/370)
   (local.get $end_line/0/1031)
   (local.get $end_line/1/1031)
   (local.get $end_line/2/1031)
   (i32.load offset=16
    (local.get $logger/0/370))))
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/370)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/370))))
 (i32.load offset=76
  (local.get $self/357))
 (i32.load offset=48
  (local.get $self/357))
 (local.set $*field/2/1049
  (i32.load offset=52
   (local.get $self/357)))
 (local.set $*field/1/1049)
 (local.set $*field/0/1049)
 (if
  (i32.gt_s
   (local.tee $*cnt/1142
    (i32.load
     (local.get $self/357)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/0/1049))
   (local.set $*new_cnt/1148
    (i32.sub
     (local.get $*cnt/1142)
     (i32.const 1)))
   (i32.store
    (local.get $self/357)
    (local.get $*new_cnt/1148)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1142)
     (i32.const 1))
    (then
     (i32.load offset=72
      (local.get $self/357))
     (i32.load offset=40
      (local.get $self/357))
     (local.set $*field/2/1147
      (i32.load offset=44
       (local.get $self/357)))
     (local.set $*field/1/1147)
     (local.tee $*field/0/1147)
     (call $moonbit.decref)
     (i32.load offset=68
      (local.get $self/357))
     (i32.load offset=32
      (local.get $self/357))
     (local.set $*field/2/1146
      (i32.load offset=36
       (local.get $self/357)))
     (local.set $*field/1/1146)
     (local.tee $*field/0/1146)
     (call $moonbit.decref)
     (i32.load offset=64
      (local.get $self/357))
     (i32.load offset=24
      (local.get $self/357))
     (local.set $*field/2/1145
      (i32.load offset=28
       (local.get $self/357)))
     (local.set $*field/1/1145)
     (local.tee $*field/0/1145)
     (call $moonbit.decref)
     (i32.load offset=60
      (local.get $self/357))
     (i32.load offset=16
      (local.get $self/357))
     (local.set $*field/2/1144
      (i32.load offset=20
       (local.get $self/357)))
     (local.set $*field/1/1144)
     (local.tee $*field/0/1144)
     (call $moonbit.decref)
     (i32.load offset=56
      (local.get $self/357))
     (i32.load offset=8
      (local.get $self/357))
     (local.set $*field/2/1143
      (i32.load offset=12
       (local.get $self/357)))
     (local.set $*field/1/1143)
     (local.tee $*field/0/1143)
     (call $moonbit.decref)
     (call $moonbit.free
      (local.get $self/357)))
    (else))))
 (local.get $*field/0/1049)
 (local.get $*field/1/1049)
 (local.set $end_column/2/1032
  (local.get $*field/2/1049))
 (local.set $end_column/1/1032)
 (local.set $end_column/0/1032)
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/370)
   (local.get $end_column/0/1032)
   (local.get $end_column/1/1032)
   (local.get $end_column/2/1032)
   (i32.load offset=16
    (local.get $logger/0/370))))
 (if
  (local.get $logger/1/370)
  (then
   (call $moonbit.incref
    (local.get $logger/1/370)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/370)
   (i32.const 64)
   (i32.load offset=20
    (local.get $logger/0/370))))
 (local.get $logger/0/370)
 (local.set $*bind/1/1027
  (local.get $logger/1/370))
 (local.set $*bind/0/1027)
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
  (local.get $*bind/1/1027)
  (local.get $*module_name/0/366)
  (local.get $*module_name/1/366)
  (local.get $*module_name/2/366)
  (i32.load offset=16
   (local.get $*bind/0/1027))))
(func $moonbitlang/core/builtin.println|String| (param $input/355 i32) (result i32)
 (call $moonbit.println
  (local.get $input/355))
 (call $moonbit.decref
  (local.get $input/355))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int| (param $self/354 i32) (param $logger/0/353 i32) (param $logger/1/353 i32) (result i32)
 (local $*tmp/1025 i32)
 (local.set $*tmp/1025
  (call $@moonbitlang/core/builtin.Array::iter|Int|
   (local.get $self/354)))
 (call $@moonbitlang/core/builtin.Logger::write_iter.inner|Int|
  (local.get $logger/0/353)
  (local.get $logger/1/353)
  (local.get $*tmp/1025)
  (i32.const 10048)
  (i32.const 10032)
  (i32.const 10016)
  (i32.const 0)))
(func $@moonbitlang/core/builtin.Array::iter|Int| (param $self/352 i32) (result i32)
 (local $*tmp/1024 i32)
 (call $@moonbitlang/core/builtin.Iterator::iter|Int|
  (local.tee $*tmp/1024
   (call $@moonbitlang/core/builtin.Array::iterator|Int|
    (local.get $self/352)))))
(func $@moonbitlang/core/builtin.Array::iterator|Int| (param $self/351 i32) (result i32)
 (local $*tmp/0/1021 i32)
 (local $*tmp/1/1021 i32)
 (local $*tmp/2/1021 i32)
 (local $buf/1022 i32)
 (local $len/1023 i32)
 (local $*field/1058 i32)
 (local $*field/1059 i32)
 (local $*cnt/1149 i32)
 (local $*new_cnt/1150 i32)
 (local.set $buf/1022
  (local.tee $*field/1059
   (i32.load offset=12
    (local.get $self/351))))
 (local.set $*field/1058
  (i32.load offset=8
   (local.get $self/351)))
 (if
  (i32.gt_s
   (local.tee $*cnt/1149
    (i32.load
     (local.get $self/351)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $buf/1022))
   (local.set $*new_cnt/1150
    (i32.sub
     (local.get $*cnt/1149)
     (i32.const 1)))
   (i32.store
    (local.get $self/351)
    (local.get $*new_cnt/1150)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1149)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $self/351)))
    (else))))
 (local.set $len/1023
  (local.get $*field/1058))
 (local.get $buf/1022)
 (i32.const 0)
 (local.set $*tmp/2/1021
  (local.get $len/1023))
 (local.set $*tmp/1/1021)
 (local.tee $*tmp/0/1021)
 (local.get $*tmp/1/1021)
 (local.get $*tmp/2/1021)
 (call $@moonbitlang/core/builtin.ArrayView::iterator|Int|))
(func $@moonbitlang/core/builtin.ArrayView::iterator|Int| (param $self/0/349 i32) (param $self/1/349 i32) (param $self/2/349 i32) (result i32)
 (local $i/348 i32)
 (local $*p/520 i32)
 (local $*ptr/1170 i32)
 (local $ptr/1171 i32)
 (i32.store offset=4
  (local.tee $ptr/1171
   (call $moonbit.gc.malloc
    (i32.const 4)))
  (i32.const 1572864))
 (i32.store offset=8
  (local.get $ptr/1171)
  (i32.const 0))
 (local.set $i/348
  (local.get $ptr/1171))
 (i32.store offset=4
  (local.tee $*ptr/1170
   (call $moonbit.gc.malloc
    (i32.const 20)))
  (i32.const 2621952))
 (i32.store offset=8
  (local.get $*ptr/1170)
  (i32.const 0))
 (i32.store offset=24
  (local.get $*ptr/1170)
  (local.get $i/348))
 (i32.store offset=20
  (local.get $*ptr/1170)
  (local.get $self/0/349))
 (i32.store offset=12
  (local.get $*ptr/1170)
  (local.get $self/1/349))
 (i32.store offset=16
  (local.get $*ptr/1170)
  (local.get $self/2/349))
 (local.tee $*p/520
  (local.get $*ptr/1170)))
(func $ArrayView::iterator|Int|.*p.fn/4 (param $*env/1009 i32) (result i64)
 (local $i/348 i32)
 (local $self/0/349 i32)
 (local $self/1/349 i32)
 (local $self/2/349 i32)
 (local $elem/350 i32)
 (local $*casted_env/1010 i32)
 (local $val/1011 i32)
 (local $*tmp/1012 i32)
 (local $end/1013 i32)
 (local $start/1014 i32)
 (local $*tmp/1015 i32)
 (local $val/1016 i32)
 (local $buf/1017 i32)
 (local $*tmp/1018 i32)
 (local $start/1019 i32)
 (local $val/1020 i32)
 (local $*tmp/1060 i32)
 (local $*field/1061 i32)
 (local $*field/1062 i32)
 (local $*field/0/1063 i32)
 (local $*field/1/1063 i32)
 (local $*field/2/1063 i32)
 (local $*field/1064 i32)
 (local $*cnt/1151 i32)
 (local $*new_cnt/1152 i32)
 (local.set $i/348
  (local.tee $*field/1064
   (i32.load offset=24
    (local.tee $*casted_env/1010
     (local.get $*env/1009)))))
 (i32.load offset=20
  (local.get $*casted_env/1010))
 (i32.load offset=12
  (local.get $*casted_env/1010))
 (local.set $*field/2/1063
  (i32.load offset=16
   (local.get $*casted_env/1010)))
 (local.set $*field/1/1063)
 (local.set $*field/0/1063)
 (if
  (i32.gt_s
   (local.tee $*cnt/1151
    (i32.load
     (local.get $*casted_env/1010)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $i/348))
   (call $moonbit.incref
    (local.get $*field/0/1063))
   (local.set $*new_cnt/1152
    (i32.sub
     (local.get $*cnt/1151)
     (i32.const 1)))
   (i32.store
    (local.get $*casted_env/1010)
    (local.get $*new_cnt/1152)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1151)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*casted_env/1010)))
    (else))))
 (local.get $*field/0/1063)
 (local.get $*field/1/1063)
 (local.set $self/2/349
  (local.get $*field/2/1063))
 (local.set $self/1/349)
 (local.set $self/0/349)
 (local.set $val/1011
  (i32.load offset=8
   (local.get $i/348)))
 (local.set $end/1013
  (local.get $self/2/349))
 (local.set $start/1014
  (local.get $self/1/349))
 (local.set $*tmp/1012
  (i32.sub
   (local.get $end/1013)
   (local.get $start/1014)))
 (if (result i64)
  (i32.lt_s
   (local.get $val/1011)
   (local.get $*tmp/1012))
  (then
   (local.set $buf/1017
    (local.tee $*field/1062
     (local.get $self/0/349)))
   (local.set $start/1019
    (local.tee $*field/1061
     (local.get $self/1/349)))
   (local.set $val/1020
    (i32.load offset=8
     (local.get $i/348)))
   (local.set $*tmp/1018
    (i32.add
     (local.get $start/1019)
     (local.get $val/1020)))
   (local.set $*tmp/1060
    (i32.load offset=8
     (i32.add
      (local.get $buf/1017)
      (i32.shl
       (local.get $*tmp/1018)
       (i32.const 2)))))
   (call $moonbit.decref
    (local.get $buf/1017))
   (local.set $elem/350
    (local.get $*tmp/1060))
   (local.set $*tmp/1015
    (i32.add
     (local.tee $val/1016
      (i32.load offset=8
       (local.get $i/348)))
     (i32.const 1)))
   (i32.store offset=8
    (local.get $i/348)
    (local.get $*tmp/1015))
   (call $moonbit.decref
    (local.get $i/348))
   (i64.extend_i32_s
    (local.get $elem/350)))
  (else
   (call $moonbit.decref
    (local.get $self/0/349))
   (call $moonbit.decref
    (local.get $i/348))
   (i64.const 4294967296))))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/346 i32) (param $logger/0/345 i32) (param $logger/1/345 i32) (result i32)
 (local $*tmp/1008 i32)
 (local.set $*tmp/1008
  (call $Int::to_string.inner
   (local.get $self/346)
   (i32.const 10)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/345)
  (local.get $*tmp/1008)
  (i32.load offset=8
   (local.get $logger/0/345))))
(func $@moonbitlang/core/builtin.Array::push|Int| (param $self/342 i32) (param $value/344 i32) (result i32)
 (local $length/343 i32)
 (local $len/1003 i32)
 (local $*tmp/1004 i32)
 (local $buf/1005 i32)
 (local $buf/1006 i32)
 (local $*tmp/1007 i32)
 (local $*field/1065 i32)
 (local $*tmp/1066 i32)
 (local $*field/1067 i32)
 (local.set $len/1003
  (i32.load offset=8
   (local.get $self/342)))
 (local.set $*tmp/1004
  (local.tee $*tmp/1066
   (call $moonbit.array_length
    (local.tee $buf/1005
     (local.tee $*field/1067
      (i32.load offset=12
       (local.get $self/342)))))))
 (if
  (i32.eq
   (local.get $len/1003)
   (local.get $*tmp/1004))
  (then
   (call $moonbit.incref
    (local.get $self/342))
   (drop
    (call $@moonbitlang/core/builtin.Array::realloc|Int|
     (local.get $self/342))))
  (else))
 (local.set $length/343
  (i32.load offset=8
   (local.get $self/342)))
 (i32.store offset=8
  (i32.add
   (local.tee $buf/1006
    (local.tee $*field/1065
     (i32.load offset=12
      (local.get $self/342))))
   (i32.shl
    (local.get $length/343)
    (i32.const 2)))
  (local.get $value/344))
 (local.set $*tmp/1007
  (i32.add
   (local.get $length/343)
   (i32.const 1)))
 (i32.store offset=8
  (local.get $self/342)
  (local.get $*tmp/1007))
 (call $moonbit.decref
  (local.get $self/342))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Array::realloc|Int| (param $self/340 i32) (result i32)
 (local $old_cap/339 i32)
 (local $new_cap/341 i32)
 (local.set $new_cap/341
  (if (result i32)
   (i32.eq
    (local.tee $old_cap/339
     (i32.load offset=8
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
(func $@moonbitlang/core/builtin.Array::resize_buffer|Int| (param $self/336 i32) (param $new_capacity/334 i32) (result i32)
 (local $new_buf/333 i32)
 (local $old_buf/335 i32)
 (local $old_cap/337 i32)
 (local $copy_len/338 i32)
 (local $*old/1068 i32)
 (local $*field/1069 i32)
 (local.set $new_buf/333
  (call $moonbit.i32_array_make_raw
   (local.get $new_capacity/334)))
 (local.set $copy_len/338
  (if (result i32)
   (i32.lt_s
    (local.tee $old_cap/337
     (call $moonbit.array_length
      (local.tee $old_buf/335
       (local.tee $*field/1069
        (i32.load offset=12
         (local.get $self/336))))))
    (local.get $new_capacity/334))
   (then
    (local.get $old_cap/337))
   (else
    (local.get $new_capacity/334))))
 (call $moonbit.incref
  (local.get $old_buf/335))
 (call $moonbit.incref
  (local.get $new_buf/333))
 (drop
  (call $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int|
   (local.get $new_buf/333)
   (i32.const 0)
   (local.get $old_buf/335)
   (i32.const 0)
   (local.get $copy_len/338)))
 (call $moonbit.decref
  (local.tee $*old/1068
   (i32.load offset=12
    (local.get $self/336))))
 (i32.store offset=12
  (local.get $self/336)
  (local.get $new_buf/333))
 (call $moonbit.decref
  (local.get $self/336))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/331 i32) (param $str/0/332 i32) (param $str/1/332 i32) (param $str/2/332 i32) (result i32)
 (local $*tmp/984 i32)
 (local $len/985 i32)
 (local $*tmp/986 i32)
 (local $*tmp/987 i32)
 (local $end/988 i32)
 (local $start/989 i32)
 (local $data/990 i32)
 (local $len/991 i32)
 (local $str/992 i32)
 (local $start/993 i32)
 (local $*tmp/994 i32)
 (local $end/995 i32)
 (local $start/996 i32)
 (local $*tmp/997 i32)
 (local $len/998 i32)
 (local $*tmp/999 i32)
 (local $*tmp/1000 i32)
 (local $end/1001 i32)
 (local $start/1002 i32)
 (local $*field/1070 i32)
 (local $*field/1071 i32)
 (local $*field/1072 i32)
 (local.set $len/985
  (i32.load offset=8
   (local.get $self/331)))
 (local.set $end/988
  (local.get $str/2/332))
 (local.set $start/989
  (local.get $str/1/332))
 (local.set $*tmp/986
  (i32.mul
   (local.tee $*tmp/987
    (i32.sub
     (local.get $end/988)
     (local.get $start/989)))
   (i32.const 2)))
 (local.set $*tmp/984
  (i32.add
   (local.get $len/985)
   (local.get $*tmp/986)))
 (call $moonbit.incref
  (local.get $self/331))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/331)
   (local.get $*tmp/984)))
 (local.set $data/990
  (local.tee $*field/1072
   (i32.load offset=12
    (local.get $self/331))))
 (local.set $len/991
  (i32.load offset=8
   (local.get $self/331)))
 (local.set $str/992
  (local.tee $*field/1071
   (local.get $str/0/332)))
 (local.set $start/993
  (local.get $str/1/332))
 (local.set $end/995
  (local.get $str/2/332))
 (local.set $start/996
  (local.get $str/1/332))
 (local.set $*tmp/994
  (i32.sub
   (local.get $end/995)
   (local.get $start/996)))
 (call $moonbit.incref
  (local.get $str/992))
 (call $moonbit.incref
  (local.get $data/990))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/990)
   (local.get $len/991)
   (local.get $str/992)
   (local.get $start/993)
   (local.get $*tmp/994)))
 (local.set $len/998
  (i32.load offset=8
   (local.get $self/331)))
 (local.set $end/1001
  (local.get $str/2/332))
 (local.set $*field/1070
  (local.get $str/1/332))
 (call $moonbit.decref
  (local.get $str/0/332))
 (local.set $start/1002
  (local.get $*field/1070))
 (local.set $*tmp/999
  (i32.mul
   (local.tee $*tmp/1000
    (i32.sub
     (local.get $end/1001)
     (local.get $start/1002)))
   (i32.const 2)))
 (local.set $*tmp/997
  (i32.add
   (local.get $len/998)
   (local.get $*tmp/999)))
 (i32.store offset=8
  (local.get $self/331)
  (local.get $*tmp/997))
 (call $moonbit.decref
  (local.get $self/331))
 (i32.const 0))
(func $String::offset_of_nth_char.inner (param $self/328 i32) (param $i/329 i32) (param $start_offset/330 i32) (param $end_offset/326 i64) (result i64)
 (local $end_offset/325 i32)
 (local $*Some/327 i64)
 (local $*tmp/983 i32)
 (local.set $end_offset/325
  (if (result i32)
   (i64.eq
    (local.get $end_offset/326)
    (i64.const 4294967296))
   (then
    (call $moonbit.array_length
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
   (local.set $*tmp/983
    (i32.sub
     (i32.const 0)
     (local.get $i/329)))
   (call $String::offset_of_nth_char_backward
    (local.get $self/328)
    (local.get $*tmp/983)
    (local.get $start_offset/330)
    (local.get $end_offset/325)))))
(func $String::offset_of_nth_char_forward (param $self/323 i32) (param $n/321 i32) (param $start_offset/317 i32) (param $end_offset/318 i32) (result i64)
 (local $c/322 i32)
 (local $*tmp/974 i32)
 (local $*tmp/975 i32)
 (local $*tmp/976 i32)
 (local $*tmp/977 i32)
 (local $*tmp/978 i32)
 (local $*tmp/979 i32)
 (local $*tmp/980 i32)
 (local $*tmp/981 i32)
 (local $*tmp/982 i32)
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
       (local.tee $*tmp/975
        (local.get $utf16_offset/319))
       (local.get $end_offset/318))
      (then
       (i32.lt_s
        (local.tee $*tmp/974
         (local.get $char_count/320))
        (local.get $n/321)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/979
       (local.get $utf16_offset/319))
      (local.set $c/322
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/323)
         (i32.shl
          (local.get $*tmp/979)
          (i32.const 1)))))
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
          (local.tee $*tmp/976
           (local.get $utf16_offset/319))
          (i32.const 2))))
       (else
        (local.set $utf16_offset/319
         (i32.add
          (local.tee $*tmp/977
           (local.get $utf16_offset/319))
          (i32.const 1)))))
      (local.set $char_count/320
       (i32.add
        (local.tee $*tmp/978
         (local.get $char_count/320))
        (i32.const 1)))
      (br $loop:324))
     (else
      (call $moonbit.decref
       (local.get $self/323)))))
   (if (result i64)
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/981
       (local.get $char_count/320))
      (local.get $n/321))
     (then
      (i32.const 1))
     (else
      (i32.ge_s
       (local.tee $*tmp/980
        (local.get $utf16_offset/319))
       (local.get $end_offset/318))))
    (then
     (i64.const 4294967296))
    (else
     (i64.extend_i32_s
      (local.tee $*tmp/982
       (local.get $utf16_offset/319))))))
  (else
   (call $moonbit.decref
    (local.get $self/323))
   (call $moonbitlang/core/builtin.abort|Option<Int>|
    (i32.const 10176)
    (i32.const 10064)))))
(func $String::offset_of_nth_char_backward (param $self/315 i32) (param $n/313 i32) (param $start_offset/312 i32) (param $end_offset/311 i32) (result i64)
 (local $c/314 i32)
 (local $*tmp/963 i32)
 (local $*tmp/964 i32)
 (local $*tmp/965 i32)
 (local $*tmp/966 i32)
 (local $*tmp/967 i32)
 (local $*tmp/968 i32)
 (local $*tmp/969 i32)
 (local $*tmp/970 i32)
 (local $*tmp/971 i32)
 (local $*tmp/972 i32)
 (local $*tmp/973 i32)
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
     (local.tee $*tmp/964
      (i32.sub
       (local.tee $*tmp/965
        (local.get $utf16_offset/310))
       (i32.const 1)))
     (local.get $start_offset/312))
    (then
     (i32.lt_s
      (local.tee $*tmp/963
       (local.get $char_count/309))
      (local.get $n/313)))
    (else
     (i32.const 0)))
   (then
    (local.set $*tmp/969
     (i32.sub
      (local.tee $*tmp/970
       (local.get $utf16_offset/310))
      (i32.const 1)))
    (local.set $c/314
     (i32.load16_u offset=8
      (i32.add
       (local.get $self/315)
       (i32.shl
        (local.get $*tmp/969)
        (i32.const 1)))))
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
        (local.tee $*tmp/966
         (local.get $utf16_offset/310))
        (i32.const 2))))
     (else
      (local.set $utf16_offset/310
       (i32.sub
        (local.tee $*tmp/967
         (local.get $utf16_offset/310))
        (i32.const 1)))))
    (local.set $char_count/309
     (i32.add
      (local.tee $*tmp/968
       (local.get $char_count/309))
      (i32.const 1)))
    (br $loop:316))
   (else
    (call $moonbit.decref
     (local.get $self/315)))))
 (if (result i64)
  (if (result i32)
   (i32.lt_s
    (local.tee $*tmp/972
     (local.get $char_count/309))
    (local.get $n/313))
   (then
    (i32.const 1))
   (else
    (i32.lt_s
     (local.tee $*tmp/971
      (local.get $utf16_offset/310))
     (local.get $start_offset/312))))
  (then
   (i64.const 4294967296))
  (else
   (i64.extend_i32_s
    (local.tee $*tmp/973
     (local.get $utf16_offset/310))))))
(func $String::char_length_ge.inner (param $self/301 i32) (param $len/304 i32) (param $start_offset/308 i32) (param $end_offset/299 i64) (result i32)
 (local $end_offset/298 i32)
 (local $*Some/300 i64)
 (local $index/302 i32)
 (local $count/303 i32)
 (local $c1/305 i32)
 (local $c2/306 i32)
 (local $*tmp/957 i32)
 (local $*tmp/958 i32)
 (local $*tmp/959 i32)
 (local $*tmp/960 i32)
 (local $*tmp/961 i32)
 (local $*tmp/962 i32)
 (local.set $end_offset/298
  (if (result i32)
   (i64.eq
    (local.get $end_offset/299)
    (i64.const 4294967296))
   (then
    (call $moonbit.array_length
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
     (i32.load16_u offset=8
      (i32.add
       (local.get $self/301)
       (i32.shl
        (local.get $index/302)
        (i32.const 1)))))
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
        (local.tee $*tmp/957
         (i32.add
          (local.get $index/302)
          (i32.const 1)))
        (local.get $end_offset/298)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/960
       (i32.add
        (local.get $index/302)
        (i32.const 1)))
      (local.set $c2/306
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/301)
         (i32.shl
          (local.get $*tmp/960)
          (i32.const 1)))))
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
        (local.set $*tmp/958
         (i32.add
          (local.get $index/302)
          (i32.const 2)))
        (local.set $*tmp/959
         (i32.add
          (local.get $count/303)
          (i32.const 1)))
        (local.get $*tmp/958)
        (local.get $*tmp/959)
        (br $loop:307))
       (else
        (drop
         (call $moonbitlang/core/builtin.abort|Unit|
          (i32.const 10336)
          (i32.const 10224))))))
     (else))
    (local.set $*tmp/961
     (i32.add
      (local.get $index/302)
      (i32.const 1)))
    (local.set $*tmp/962
     (i32.add
      (local.get $count/303)
      (i32.const 1)))
    (local.get $*tmp/961)
    (local.get $*tmp/962)
    (br $loop:307))
   (else
    (call $moonbit.decref
     (local.get $self/301))
    (i32.ge_s
     (local.get $count/303)
     (local.get $len/304))))))
(func $@moonbitlang/core/builtin.Iterator::iter|Int| (param $self/292 i32) (result i32)
 (local $*ptr/1172 i32)
 (i32.store offset=4
  (local.tee $*ptr/1172
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $*ptr/1172)
  (i32.const 1))
 (i32.store offset=12
  (local.get $*ptr/1172)
  (local.get $self/292))
 (local.get $*ptr/1172))
(func $Iterator::iter|Int|.fn/3 (param $*env/953 i32) (param $yield_/290 i32) (result i32)
 (local $*bind/291 i64)
 (local $self/292 i32)
 (local $*Some/293 i64)
 (local $*x/294 i32)
 (local $*bind/295 i32)
 (local $*casted_env/954 i32)
 (local $*field/1074 i32)
 (local $*cnt/1153 i32)
 (local $*new_cnt/1154 i32)
 (local.set $*field/1074
  (i32.load offset=12
   (local.tee $*casted_env/954
    (local.get $*env/953))))
 (if
  (i32.gt_s
   (local.tee $*cnt/1153
    (i32.load
     (local.get $*casted_env/954)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/1074))
   (local.set $*new_cnt/1154
    (i32.sub
     (local.get $*cnt/1153)
     (i32.const 1)))
   (i32.store
    (local.get $*casted_env/954)
    (local.get $*new_cnt/1154)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1153)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*casted_env/954)))
    (else))))
 (local.set $self/292
  (local.get $*field/1074))
 (block $break:296 (result i32)
  (loop $loop:296 (result i32)
   (call $moonbit.incref
    (local.get $self/292))
   (if (result i32)
    (i64.eq
     (local.tee $*bind/291
      (call $@moonbitlang/core/builtin.Iterator::next|Int|
       (local.get $self/292)))
     (i64.const 4294967296))
    (then
     (call $moonbit.decref
      (local.get $self/292))
     (call $moonbit.decref
      (local.get $yield_/290))
     (i32.const 1))
    (else
     (local.set $*x/294
      (i32.wrap_i64
       (local.tee $*Some/293
        (local.get $*bind/291))))
     (call $moonbit.incref
      (local.get $yield_/290))
     (if
      (i32.eq
       (local.tee $*bind/295
        (call_indirect $moonbit.global (type $<Int>=>Int)
         (local.get $yield_/290)
         (local.get $*x/294)
         (i32.load offset=8
          (local.get $yield_/290))))
       (i32.const 1))
      (then)
      (else
       (call $moonbit.decref
        (local.get $self/292))
       (call $moonbit.decref
        (local.get $yield_/290))
       (i32.const 0)
       (br $break:296)))
     (br $loop:296))))))
(func $@moonbitlang/core/builtin.Iterator::next|Int| (param $self/289 i32) (result i64)
 (local $*func/288 i32)
 (call_indirect $moonbit.global (type $<>=>Option<Int>)
  (local.tee $*func/288
   (local.get $self/289))
  (i32.load offset=8
   (local.get $*func/288))))
(func $Int::to_string.inner (param $self/271 i32) (param $radix/270 i32) (result i32)
 (local $is_negative/272 i32)
 (local $num/273 i32)
 (local $buffer/274 i32)
 (local $digit_len/275 i32)
 (local $total_len/276 i32)
 (local $buffer/277 i32)
 (local $digit_start/278 i32)
 (local $digit_len/279 i32)
 (local $total_len/280 i32)
 (local $buffer/281 i32)
 (local $digit_start/282 i32)
 (local $digit_len/283 i32)
 (local $total_len/284 i32)
 (local $buffer/285 i32)
 (local $digit_start/286 i32)
 (local $*tmp/949 i32)
 (local $*tmp/950 i32)
 (local $*tmp/951 i32)
 (local $*tmp/952 i32)
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
     (i32.const 10528)
     (i32.const 10408))))
  (else))
 (if
  (i32.eq
   (local.get $self/271)
   (i32.const 0))
  (then
   (i32.const 10392)
   (return))
  (else))
 (local.set $num/273
  (if (result i32)
   (local.tee $is_negative/272
    (i32.lt_s
     (local.get $self/271)
     (i32.const 0)))
   (then
    (local.tee $*tmp/952
     (i32.sub
      (i32.const 0)
      (local.get $self/271))))
   (else
    (local.get $self/271))))
 (local.set $buffer/274
  (if (result i32)
   (i32.eq
    (local.get $radix/270)
    (i32.const 10))
   (then
    (local.set $digit_len/275
     (call $moonbitlang/core/builtin.dec_count32
      (local.get $num/273)))
    (local.set $*tmp/949
     (if (result i32)
      (local.get $is_negative/272)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (local.set $buffer/277
     (call $moonbit.int16_array_make
      (local.tee $total_len/276
       (i32.add
        (local.get $digit_len/275)
        (local.get $*tmp/949)))
      (i32.const 0)))
    (local.set $digit_start/278
     (if (result i32)
      (local.get $is_negative/272)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (call $moonbit.incref
     (local.get $buffer/277))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/277)
      (local.get $num/273)
      (local.get $digit_start/278)
      (local.get $total_len/276)))
    (local.get $buffer/277))
   (else
    (if (result i32)
     (i32.eq
      (local.get $radix/270)
      (i32.const 16))
     (then
      (local.set $digit_len/279
       (call $moonbitlang/core/builtin.hex_count32
        (local.get $num/273)))
      (local.set $*tmp/950
       (if (result i32)
        (local.get $is_negative/272)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/281
       (call $moonbit.int16_array_make
        (local.tee $total_len/280
         (i32.add
          (local.get $digit_len/279)
          (local.get $*tmp/950)))
        (i32.const 0)))
      (local.set $digit_start/282
       (if (result i32)
        (local.get $is_negative/272)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/281))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/281)
        (local.get $num/273)
        (local.get $digit_start/282)
        (local.get $total_len/280)))
      (local.get $buffer/281))
     (else
      (local.set $digit_len/283
       (call $moonbitlang/core/builtin.radix_count32
        (local.get $num/273)
        (local.get $radix/270)))
      (local.set $*tmp/951
       (if (result i32)
        (local.get $is_negative/272)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/285
       (call $moonbit.int16_array_make
        (local.tee $total_len/284
         (i32.add
          (local.get $digit_len/283)
          (local.get $*tmp/951)))
        (i32.const 0)))
      (local.set $digit_start/286
       (if (result i32)
        (local.get $is_negative/272)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/285))
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
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/274)
     (i32.shl
      (i32.const 0)
      (i32.const 1)))
    (i32.const 45)))
  (else))
 (local.get $buffer/274))
(func $moonbitlang/core/builtin.radix_count32 (param $value/264 i32) (param $radix/267 i32) (result i32)
 (local $base/266 i32)
 (local $*tmp/946 i32)
 (local $*tmp/947 i32)
 (local $*tmp/948 i32)
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
    (local.tee $*tmp/946
     (local.get $num/265))
    (i32.const 0))
   (then
    (local.set $count/268
     (i32.add
      (local.tee $*tmp/947
       (local.get $count/268))
      (i32.const 1)))
    (local.set $num/265
     (i32.div_u
      (local.tee $*tmp/948
       (local.get $num/265))
      (local.get $base/266)))
    (br $loop:269))
   (else)))
 (local.get $count/268))
(func $moonbitlang/core/builtin.hex_count32 (param $value/262 i32) (result i32)
 (local $leading_zeros/263 i32)
 (local $*tmp/944 i32)
 (local $*tmp/945 i32)
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
    (local.tee $*tmp/944
     (i32.div_s
      (local.tee $*tmp/945
       (i32.sub
        (i32.const 31)
        (local.get $leading_zeros/263)))
      (i32.const 4)))
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
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/251 i32) (param $num/239 i32) (param $digit_start/242 i32) (param $total_len/241 i32) (result i32)
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
 (local $*tmp/887 i32)
 (local $*tmp/888 i32)
 (local $*tmp/889 i32)
 (local $*tmp/890 i32)
 (local $*tmp/891 i32)
 (local $*tmp/892 i32)
 (local $*tmp/893 i32)
 (local $*tmp/894 i32)
 (local $*tmp/895 i32)
 (local $*tmp/896 i32)
 (local $*tmp/897 i32)
 (local $*tmp/898 i32)
 (local $*tmp/899 i32)
 (local $*tmp/900 i32)
 (local $*tmp/901 i32)
 (local $*tmp/902 i32)
 (local $*tmp/903 i32)
 (local $*tmp/904 i32)
 (local $*tmp/905 i32)
 (local $*tmp/906 i32)
 (local $*tmp/907 i32)
 (local $*tmp/908 i32)
 (local $*tmp/909 i32)
 (local $*tmp/910 i32)
 (local $*tmp/911 i32)
 (local $*tmp/912 i32)
 (local $*tmp/913 i32)
 (local $*tmp/914 i32)
 (local $*tmp/915 i32)
 (local $*tmp/916 i32)
 (local $*tmp/917 i32)
 (local $*tmp/918 i32)
 (local $*tmp/919 i32)
 (local $*tmp/920 i32)
 (local $*tmp/921 i32)
 (local $*tmp/922 i32)
 (local $*tmp/923 i32)
 (local $*tmp/924 i32)
 (local $*tmp/925 i32)
 (local $*tmp/926 i32)
 (local $*tmp/927 i32)
 (local $*tmp/928 i32)
 (local $*tmp/929 i32)
 (local $*tmp/930 i32)
 (local $*tmp/931 i32)
 (local $*tmp/932 i32)
 (local $*tmp/933 i32)
 (local $*tmp/934 i32)
 (local $*tmp/935 i32)
 (local $*tmp/936 i32)
 (local $*tmp/937 i32)
 (local $*tmp/938 i32)
 (local $*tmp/939 i32)
 (local $*tmp/940 i32)
 (local $*tmp/941 i32)
 (local $*tmp/942 i32)
 (local $*tmp/943 i32)
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
    (local.tee $*tmp/887
     (local.get $num/238))
    (i32.const 10000))
   (then
    (local.set $t/243
     (i32.div_u
      (local.tee $*tmp/910
       (local.get $num/238))
      (i32.const 10000)))
    (local.set $r/244
     (local.tee $*tmp/908
      (i32.rem_u
       (local.tee $*tmp/909
        (local.get $num/238))
       (i32.const 10000))))
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
      (local.tee $*tmp/888
       (local.get $offset/240))
      (i32.const 4)))
    (local.set $*tmp/907
     (i32.div_s
      (local.get $d1/245)
      (i32.const 10)))
    (local.set $d1_hi/247
     (i32.and
      (local.tee $*tmp/906
       (i32.add
        (i32.const 48)
        (local.get $*tmp/907)))
      (i32.const 65535)))
    (local.set $*tmp/905
     (i32.rem_s
      (local.get $d1/245)
      (i32.const 10)))
    (local.set $d1_lo/248
     (i32.and
      (local.tee $*tmp/904
       (i32.add
        (i32.const 48)
        (local.get $*tmp/905)))
      (i32.const 65535)))
    (local.set $*tmp/903
     (i32.div_s
      (local.get $d2/246)
      (i32.const 10)))
    (local.set $d2_hi/249
     (i32.and
      (local.tee $*tmp/902
       (i32.add
        (i32.const 48)
        (local.get $*tmp/903)))
      (i32.const 65535)))
    (local.set $*tmp/901
     (i32.rem_s
      (local.get $d2/246)
      (i32.const 10)))
    (local.set $d2_lo/250
     (i32.and
      (local.tee $*tmp/900
       (i32.add
        (i32.const 48)
        (local.get $*tmp/901)))
      (i32.const 65535)))
    (local.set $*tmp/890
     (local.get $offset/240))
    (local.set $*tmp/889
     (i32.add
      (local.get $digit_start/242)
      (local.get $*tmp/890)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/251)
      (i32.shl
       (local.get $*tmp/889)
       (i32.const 1)))
     (local.get $d1_hi/247))
    (local.set $*tmp/893
     (local.get $offset/240))
    (local.set $*tmp/891
     (i32.add
      (local.tee $*tmp/892
       (i32.add
        (local.get $digit_start/242)
        (local.get $*tmp/893)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/251)
      (i32.shl
       (local.get $*tmp/891)
       (i32.const 1)))
     (local.get $d1_lo/248))
    (local.set $*tmp/896
     (local.get $offset/240))
    (local.set $*tmp/894
     (i32.add
      (local.tee $*tmp/895
       (i32.add
        (local.get $digit_start/242)
        (local.get $*tmp/896)))
      (i32.const 2)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/251)
      (i32.shl
       (local.get $*tmp/894)
       (i32.const 1)))
     (local.get $d2_hi/249))
    (local.set $*tmp/899
     (local.get $offset/240))
    (local.set $*tmp/897
     (i32.add
      (local.tee $*tmp/898
       (i32.add
        (local.get $digit_start/242)
        (local.get $*tmp/899)))
      (i32.const 3)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/251)
      (i32.shl
       (local.get $*tmp/897)
       (i32.const 1)))
     (local.get $d2_lo/250))
    (br $loop:252))
   (else)))
 (local.set $remaining/253
  (local.tee $*tmp/943
   (local.get $num/238)))
 (loop $loop:258
  (if
   (i32.ge_s
    (local.tee $*tmp/911
     (local.get $remaining/253))
    (i32.const 100))
   (then
    (local.set $t/254
     (i32.div_s
      (local.tee $*tmp/923
       (local.get $remaining/253))
      (i32.const 100)))
    (local.set $d/255
     (i32.rem_s
      (local.tee $*tmp/922
       (local.get $remaining/253))
      (i32.const 100)))
    (local.set $remaining/253
     (local.get $t/254))
    (local.set $offset/240
     (i32.sub
      (local.tee $*tmp/912
       (local.get $offset/240))
      (i32.const 2)))
    (local.set $*tmp/921
     (i32.div_s
      (local.get $d/255)
      (i32.const 10)))
    (local.set $d_hi/256
     (i32.and
      (local.tee $*tmp/920
       (i32.add
        (i32.const 48)
        (local.get $*tmp/921)))
      (i32.const 65535)))
    (local.set $*tmp/919
     (i32.rem_s
      (local.get $d/255)
      (i32.const 10)))
    (local.set $d_lo/257
     (i32.and
      (local.tee $*tmp/918
       (i32.add
        (i32.const 48)
        (local.get $*tmp/919)))
      (i32.const 65535)))
    (local.set $*tmp/914
     (local.get $offset/240))
    (local.set $*tmp/913
     (i32.add
      (local.get $digit_start/242)
      (local.get $*tmp/914)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/251)
      (i32.shl
       (local.get $*tmp/913)
       (i32.const 1)))
     (local.get $d_hi/256))
    (local.set $*tmp/917
     (local.get $offset/240))
    (local.set $*tmp/915
     (i32.add
      (local.tee $*tmp/916
       (i32.add
        (local.get $digit_start/242)
        (local.get $*tmp/917)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/251)
      (i32.shl
       (local.get $*tmp/915)
       (i32.const 1)))
     (local.get $d_lo/257))
    (br $loop:258))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.tee $*tmp/924
    (local.get $remaining/253))
   (i32.const 10))
  (then
   (local.set $offset/240
    (i32.sub
     (local.tee $*tmp/925
      (local.get $offset/240))
     (i32.const 2)))
   (local.set $*tmp/935
    (i32.div_s
     (local.tee $*tmp/936
      (local.get $remaining/253))
     (i32.const 10)))
   (local.set $d_hi/259
    (i32.and
     (local.tee $*tmp/934
      (i32.add
       (i32.const 48)
       (local.get $*tmp/935)))
     (i32.const 65535)))
   (local.set $*tmp/932
    (i32.rem_s
     (local.tee $*tmp/933
      (local.get $remaining/253))
     (i32.const 10)))
   (local.set $d_lo/260
    (i32.and
     (local.tee $*tmp/931
      (i32.add
       (i32.const 48)
       (local.get $*tmp/932)))
     (i32.const 65535)))
   (local.set $*tmp/927
    (local.get $offset/240))
   (local.set $*tmp/926
    (i32.add
     (local.get $digit_start/242)
     (local.get $*tmp/927)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/251)
     (i32.shl
      (local.get $*tmp/926)
      (i32.const 1)))
    (local.get $d_hi/259))
   (local.set $*tmp/930
    (local.get $offset/240))
   (local.set $*tmp/928
    (i32.add
     (local.tee $*tmp/929
      (i32.add
       (local.get $digit_start/242)
       (local.get $*tmp/930)))
     (i32.const 1)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/251)
     (i32.shl
      (local.get $*tmp/928)
      (i32.const 1)))
    (local.get $d_lo/260))
   (call $moonbit.decref
    (local.get $buffer/251))
   (i32.const 0))
  (else
   (local.set $*tmp/942
    (local.tee $offset/240
     (i32.sub
      (local.tee $*tmp/937
       (local.get $offset/240))
      (i32.const 1))))
   (local.set $*tmp/938
    (i32.add
     (local.get $digit_start/242)
     (local.get $*tmp/942)))
   (local.set $*tmp/941
    (local.get $remaining/253))
   (local.set $*tmp/939
    (i32.and
     (local.tee $*tmp/940
      (i32.add
       (i32.const 48)
       (local.get $*tmp/941)))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/251)
     (i32.shl
      (local.get $*tmp/938)
      (i32.const 1)))
    (local.get $*tmp/939))
   (call $moonbit.decref
    (local.get $buffer/251))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/233 i32) (param $num/227 i32) (param $digit_start/225 i32) (param $total_len/224 i32) (param $radix/229 i32) (result i32)
 (local $base/228 i32)
 (local $shift/230 i32)
 (local $mask/231 i32)
 (local $digit/232 i32)
 (local $q/235 i32)
 (local $digit/236 i32)
 (local $*tmp/866 i32)
 (local $*tmp/867 i32)
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
 (local $*tmp/879 i32)
 (local $*tmp/880 i32)
 (local $*tmp/881 i32)
 (local $*tmp/882 i32)
 (local $*tmp/883 i32)
 (local $*tmp/884 i32)
 (local $*tmp/885 i32)
 (local $*tmp/886 i32)
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
 (local.set $*tmp/867
  (i32.sub
   (local.get $radix/229)
   (i32.const 1)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/866
    (i32.and
     (local.get $radix/229)
     (local.get $*tmp/867)))
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
      (local.tee $*tmp/868
       (local.get $n/226))
      (i32.const 0))
     (then
      (local.set $offset/223
       (i32.sub
        (local.tee $*tmp/869
         (local.get $offset/223))
        (i32.const 1)))
      (local.set $digit/232
       (local.tee $*tmp/875
        (i32.and
         (local.tee $*tmp/876
          (local.get $n/226))
         (local.get $mask/231))))
      (local.set $*tmp/873
       (local.get $offset/223))
      (local.set $*tmp/870
       (i32.add
        (local.get $digit_start/225)
        (local.get $*tmp/873)))
      (local.set $*tmp/871
       (i32.and
        (local.tee $*tmp/872
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10600)
           (i32.shl
            (local.get $digit/232)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/233)
        (i32.shl
         (local.get $*tmp/870)
         (i32.const 1)))
       (local.get $*tmp/871))
      (local.set $n/226
       (i32.shr_u
        (local.tee $*tmp/874
         (local.get $n/226))
        (local.get $shift/230)))
      (br $loop:234))
     (else
      (call $moonbit.decref
       (local.get $buffer/233)))))
   (i32.const 0))
  (else
   (loop $loop:237
    (if
     (i32.gt_u
      (local.tee $*tmp/877
       (local.get $n/226))
      (i32.const 0))
     (then
      (local.set $offset/223
       (i32.sub
        (local.tee $*tmp/878
         (local.get $offset/223))
        (i32.const 1)))
      (local.set $q/235
       (i32.div_u
        (local.tee $*tmp/886
         (local.get $n/226))
        (local.get $base/228)))
      (local.set $*tmp/884
       (local.get $n/226))
      (local.set $*tmp/885
       (i32.mul
        (local.get $q/235)
        (local.get $base/228)))
      (local.set $digit/236
       (local.tee $*tmp/883
        (i32.sub
         (local.get $*tmp/884)
         (local.get $*tmp/885))))
      (local.set $*tmp/882
       (local.get $offset/223))
      (local.set $*tmp/879
       (i32.add
        (local.get $digit_start/225)
        (local.get $*tmp/882)))
      (local.set $*tmp/880
       (i32.and
        (local.tee $*tmp/881
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10600)
           (i32.shl
            (local.get $digit/236)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/233)
        (i32.shl
         (local.get $*tmp/879)
         (i32.const 1)))
       (local.get $*tmp/880))
      (local.set $n/226
       (local.get $q/235))
      (br $loop:237))
     (else
      (call $moonbit.decref
       (local.get $buffer/233)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/220 i32) (param $num/216 i32) (param $digit_start/214 i32) (param $total_len/213 i32) (result i32)
 (local $byte_val/217 i32)
 (local $hi/218 i32)
 (local $lo/219 i32)
 (local $nibble/222 i32)
 (local $*tmp/847 i32)
 (local $*tmp/848 i32)
 (local $*tmp/849 i32)
 (local $*tmp/850 i32)
 (local $*tmp/851 i32)
 (local $*tmp/852 i32)
 (local $*tmp/853 i32)
 (local $*tmp/854 i32)
 (local $*tmp/855 i32)
 (local $*tmp/856 i32)
 (local $*tmp/857 i32)
 (local $*tmp/858 i32)
 (local $*tmp/859 i32)
 (local $*tmp/860 i32)
 (local $*tmp/861 i32)
 (local $*tmp/862 i32)
 (local $*tmp/863 i32)
 (local $*tmp/864 i32)
 (local $*tmp/865 i32)
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
    (local.tee $*tmp/847
     (local.get $offset/212))
    (i32.const 2))
   (then
    (local.set $offset/212
     (i32.sub
      (local.tee $*tmp/848
       (local.get $offset/212))
      (i32.const 2)))
    (local.set $hi/218
     (i32.div_s
      (local.tee $byte_val/217
       (local.tee $*tmp/859
        (i32.and
         (local.tee $*tmp/860
          (local.get $n/215))
         (i32.const 255))))
      (i32.const 16)))
    (local.set $lo/219
     (i32.rem_s
      (local.get $byte_val/217)
      (i32.const 16)))
    (local.set $*tmp/852
     (local.get $offset/212))
    (local.set $*tmp/849
     (i32.add
      (local.get $digit_start/214)
      (local.get $*tmp/852)))
    (local.set $*tmp/850
     (i32.and
      (local.tee $*tmp/851
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10600)
         (i32.shl
          (local.get $hi/218)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/220)
      (i32.shl
       (local.get $*tmp/849)
       (i32.const 1)))
     (local.get $*tmp/850))
    (local.set $*tmp/857
     (local.get $offset/212))
    (local.set $*tmp/853
     (i32.add
      (local.tee $*tmp/856
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/857)))
      (i32.const 1)))
    (local.set $*tmp/854
     (i32.and
      (local.tee $*tmp/855
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10600)
         (i32.shl
          (local.get $lo/219)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/220)
      (i32.shl
       (local.get $*tmp/853)
       (i32.const 1)))
     (local.get $*tmp/854))
    (local.set $n/215
     (i32.shr_u
      (local.tee $*tmp/858
       (local.get $n/215))
      (i32.const 8)))
    (br $loop:221))
   (else)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/861
    (local.get $offset/212))
   (i32.const 1))
  (then
   (local.set $nibble/222
    (local.tee $*tmp/864
     (i32.and
      (local.tee $*tmp/865
       (local.get $n/215))
      (i32.const 15))))
   (local.set $*tmp/862
    (i32.and
     (local.tee $*tmp/863
      (i32.load16_u offset=8
       (i32.add
        (i32.const 10600)
        (i32.shl
         (local.get $nibble/222)
         (i32.const 1)))))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/220)
     (i32.shl
      (local.get $digit_start/214)
      (i32.const 1)))
    (local.get $*tmp/862))
   (call $moonbit.decref
    (local.get $buffer/220))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $buffer/220))
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::write_iter.inner|Int| (param $self/0/203 i32) (param $self/1/203 i32) (param $iter/206 i32) (param $prefix/204 i32) (param $suffix/211 i32) (param $sep/208 i32) (param $trailing/205 i32) (result i32)
 (local $first/209 i32)
 (local $*tmp/839 i32)
 (local $*tmp/840 i32)
 (local $*tmp/843 i32)
 (local $*tmp/844 i32)
 (local $*ptr/1173 i32)
 (local $*ptr/1174 i32)
 (local $ptr/1175 i32)
 (if
  (local.get $self/1/203)
  (then
   (call $moonbit.incref
    (local.get $self/1/203)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
   (local.get $self/1/203)
   (local.get $prefix/204)
   (i32.load offset=8
    (local.get $self/0/203))))
 (if
  (local.get $trailing/205)
  (then
   (if
    (local.get $self/1/203)
    (then
     (call $moonbit.incref
      (local.get $self/1/203)))
    (else))
   (i32.store offset=4
    (local.tee $*ptr/1173
     (call $moonbit.gc.malloc
      (i32.const 16)))
    (i32.const 1573632))
   (i32.store offset=8
    (local.get $*ptr/1173)
    (i32.const 2))
   (i32.store offset=16
    (local.get $*ptr/1173)
    (local.get $self/0/203))
   (i32.store offset=20
    (local.get $*ptr/1173)
    (local.get $self/1/203))
   (i32.store offset=12
    (local.get $*ptr/1173)
    (local.get $sep/208))
   (local.set $*tmp/840
    (local.get $*ptr/1173))
   (local.set $*tmp/839
    (call_indirect $moonbit.global (type $<<Int>=>Int>=>Int)
     (local.get $iter/206)
     (local.get $*tmp/840)
     (i32.load offset=8
      (local.get $iter/206)))))
  (else
   (i32.store offset=4
    (local.tee $ptr/1175
     (call $moonbit.gc.malloc
      (i32.const 4)))
    (i32.const 1572864))
   (i32.store offset=8
    (local.get $ptr/1175)
    (i32.const 1))
   (local.set $first/209
    (local.get $ptr/1175))
   (if
    (local.get $self/1/203)
    (then
     (call $moonbit.incref
      (local.get $self/1/203)))
    (else))
   (i32.store offset=4
    (local.tee $*ptr/1174
     (call $moonbit.gc.malloc
      (i32.const 20)))
    (i32.const 1573888))
   (i32.store offset=8
    (local.get $*ptr/1174)
    (i32.const 3))
   (i32.store offset=20
    (local.get $*ptr/1174)
    (local.get $self/0/203))
   (i32.store offset=24
    (local.get $*ptr/1174)
    (local.get $self/1/203))
   (i32.store offset=16
    (local.get $*ptr/1174)
    (local.get $sep/208))
   (i32.store offset=12
    (local.get $*ptr/1174)
    (local.get $first/209))
   (local.set $*tmp/844
    (local.get $*ptr/1174))
   (local.set $*tmp/843
    (call_indirect $moonbit.global (type $<<Int>=>Int>=>Int)
     (local.get $iter/206)
     (local.get $*tmp/844)
     (i32.load offset=8
      (local.get $iter/206))))))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $self/1/203)
  (local.get $suffix/211)
  (i32.load offset=8
   (local.get $self/0/203))))
(func $Logger::write_iter.inner|Int|.fn/2 (param $*env/845 i32) (param $x/210 i32) (result i32)
 (local $self/0/203 i32)
 (local $self/1/203 i32)
 (local $sep/208 i32)
 (local $first/209 i32)
 (local $*casted_env/846 i32)
 (local $*field/1075 i32)
 (local $*field/1076 i32)
 (local $*field/0/1077 i32)
 (local $*field/1/1077 i32)
 (local $*cnt/1155 i32)
 (local $*new_cnt/1156 i32)
 (i32.load offset=20
  (local.tee $*casted_env/846
   (local.get $*env/845)))
 (local.set $*field/1/1077
  (i32.load offset=24
   (local.get $*casted_env/846)))
 (local.tee $*field/0/1077)
 (local.set $self/1/203
  (local.get $*field/1/1077))
 (local.set $self/0/203)
 (local.set $sep/208
  (local.tee $*field/1076
   (i32.load offset=16
    (local.get $*casted_env/846))))
 (local.set $*field/1075
  (i32.load offset=12
   (local.get $*casted_env/846)))
 (if
  (i32.gt_s
   (local.tee $*cnt/1155
    (i32.load
     (local.get $*casted_env/846)))
   (i32.const 1))
  (then
   (if
    (local.get $self/1/203)
    (then
     (call $moonbit.incref
      (local.get $self/1/203)))
    (else))
   (call $moonbit.incref
    (local.get $sep/208))
   (call $moonbit.incref
    (local.get $*field/1075))
   (local.set $*new_cnt/1156
    (i32.sub
     (local.get $*cnt/1155)
     (i32.const 1)))
   (i32.store
    (local.get $*casted_env/846)
    (local.get $*new_cnt/1156)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1155)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*casted_env/846)))
    (else))))
 (if
  (i32.load offset=8
   (local.tee $first/209
    (local.get $*field/1075)))
  (then
   (call $moonbit.decref
    (local.get $sep/208))
   (i32.store offset=8
    (local.get $first/209)
    (i32.const 0))
   (call $moonbit.decref
    (local.get $first/209)))
  (else
   (call $moonbit.decref
    (local.get $first/209))
   (if
    (local.get $self/1/203)
    (then
     (call $moonbit.incref
      (local.get $self/1/203)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
     (local.get $self/1/203)
     (local.get $sep/208)
     (i32.load offset=8
      (local.get $self/0/203))))))
 (drop
  (call $@moonbitlang/core/builtin.Logger::write_object|Int|
   (local.get $self/0/203)
   (local.get $self/1/203)
   (local.get $x/210)))
 (i32.const 1))
(func $Logger::write_iter.inner|Int|.fn/1 (param $*env/841 i32) (param $x/207 i32) (result i32)
 (local $self/0/203 i32)
 (local $self/1/203 i32)
 (local $sep/208 i32)
 (local $*casted_env/842 i32)
 (local $*field/1078 i32)
 (local $*field/0/1079 i32)
 (local $*field/1/1079 i32)
 (local $*cnt/1157 i32)
 (local $*new_cnt/1158 i32)
 (i32.load offset=16
  (local.tee $*casted_env/842
   (local.get $*env/841)))
 (local.set $*field/1/1079
  (i32.load offset=20
   (local.get $*casted_env/842)))
 (local.tee $*field/0/1079)
 (local.set $self/1/203
  (local.get $*field/1/1079))
 (local.set $self/0/203)
 (local.set $*field/1078
  (i32.load offset=12
   (local.get $*casted_env/842)))
 (if
  (i32.gt_s
   (local.tee $*cnt/1157
    (i32.load
     (local.get $*casted_env/842)))
   (i32.const 1))
  (then
   (if
    (local.get $self/1/203)
    (then
     (call $moonbit.incref
      (local.get $self/1/203)))
    (else))
   (call $moonbit.incref
    (local.get $*field/1078))
   (local.set $*new_cnt/1158
    (i32.sub
     (local.get $*cnt/1157)
     (i32.const 1)))
   (i32.store
    (local.get $*casted_env/842)
    (local.get $*new_cnt/1158)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1157)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*casted_env/842)))
    (else))))
 (local.set $sep/208
  (local.get $*field/1078))
 (if
  (local.get $self/1/203)
  (then
   (call $moonbit.incref
    (local.get $self/1/203)))
  (else))
 (drop
  (call $@moonbitlang/core/builtin.Logger::write_object|Int|
   (local.get $self/0/203)
   (local.get $self/1/203)
   (local.get $x/207)))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
   (local.get $self/1/203)
   (local.get $sep/208)
   (i32.load offset=8
    (local.get $self/0/203))))
 (i32.const 1))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/202 i32) (result i32)
 (local $logger/201 i32)
 (local $*tmp/0/838 i32)
 (local $*tmp/1/838 i32)
 (call $moonbit.incref
  (local.tee $logger/201
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/838
  (local.get $logger/201))
 (local.set $*tmp/0/838)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/202)
   (local.get $*tmp/0/838)
   (local.get $*tmp/1/838)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/201)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/200 i32) (result i32)
 (local $logger/199 i32)
 (local $*tmp/0/837 i32)
 (local $*tmp/1/837 i32)
 (call $moonbit.incref
  (local.tee $logger/199
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/837
  (local.get $logger/199))
 (local.set $*tmp/0/837)
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/200)
   (local.get $*tmp/0/837)
   (local.get $*tmp/1/837)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/199)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>| (param $self/198 i32) (result i32)
 (local $logger/197 i32)
 (local $*tmp/0/836 i32)
 (local $*tmp/1/836 i32)
 (call $moonbit.incref
  (local.tee $logger/197
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/836
  (local.get $logger/197))
 (local.set $*tmp/0/836)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int|
   (local.get $self/198)
   (local.get $*tmp/0/836)
   (local.get $*tmp/1/836)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/197)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/189 i32) (param $value/192 i32) (param $start/193 i32) (param $len/194 i32) (result i32)
 (local $*try_err/191 i32)
 (local $*tmp/0/831 i32)
 (local $*tmp/1/831 i32)
 (local $*tmp/2/831 i32)
 (local $*tmp/832 i64)
 (local $*tmp/833 i32)
 (local $*ok/0/834 i32)
 (local $*ok/1/834 i32)
 (local $*ok/2/834 i32)
 (local $*err/835 i32)
 (local $*obj/0/1177 i32)
 (local $*obj/1/1177 i32)
 (local $*obj/2/1177 i32)
 (block $outer/1176 (result i32) (result i32) (result i32)
  (block $join:190
   (local.set $*tmp/832
    (i64.extend_i32_s
     (local.tee $*tmp/833
      (i32.add
       (local.get $start/193)
       (local.get $len/194)))))
   (call $String::sub.inner
    (local.get $value/192)
    (local.get $start/193)
    (local.get $*tmp/832))
   (local.set $*obj/2/1177)
   (local.set $*obj/1/1177)
   (local.set $*obj/0/1177)
   (if (result i32) (result i32) (result i32)
    (then
     (local.get $*obj/0/1177)
     (local.get $*obj/1/1177)
     (local.set $*ok/2/834
      (local.get $*obj/2/1177))
     (local.set $*ok/1/834)
     (local.tee $*ok/0/834)
     (local.get $*ok/1/834)
     (local.get $*ok/2/834))
    (else
     (local.set $*try_err/191
      (local.tee $*err/835
       (local.get $*obj/0/1177)))
     (br $join:190)))
   (br $outer/1176))
  (call $moonbit.decref
   (local.get $*try_err/191))
  (unreachable))
 (local.set $*tmp/2/831)
 (local.set $*tmp/1/831)
 (local.set $*tmp/0/831)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.get $self/189)
  (local.get $*tmp/0/831)
  (local.get $*tmp/1/831)
  (local.get $*tmp/2/831)))
(func $String::sub.inner (param $self/182 i32) (param $start/188 i32) (param $end/184 i64) (result i32) (result i32) (result i32) (result i32)
 (local $len/181 i32)
 (local $end/183 i32)
 (local $*Some/185 i64)
 (local $*end/186 i32)
 (local $start/187 i32)
 (local $*p/492 i32)
 (local $*p/495 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/827 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/828 i32)
 (local $*tmp/0/829 i32)
 (local $*tmp/1/829 i32)
 (local $*tmp/2/829 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/830 i32)
 (local.set $len/181
  (call $moonbit.array_length
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
 (if (result i32) (result i32) (result i32) (result i32)
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
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/182)
         (i32.shl
          (local.get $start/187)
          (i32.const 1)))))
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
     (call $moonbit.decref
      (local.get $self/182))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/827
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/827)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $end/183)
      (local.get $len/181))
     (then
      (local.set $*p/495
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/182)
         (i32.shl
          (local.get $end/183)
          (i32.const 1)))))
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
     (call $moonbit.decref
      (local.get $self/182))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/828
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/828)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (local.get $self/182)
   (local.get $start/187)
   (local.set $*tmp/2/829
    (local.get $end/183))
   (local.set $*tmp/1/829)
   (local.set $*tmp/0/829)
   (i32.const 1)
   (local.get $*tmp/0/829)
   (local.get $*tmp/1/829)
   (local.get $*tmp/2/829))
  (else
   (call $moonbit.decref
    (local.get $self/182))
   (local.set $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/830
    (i32.const 10688))
   (i32.const 0)
   (local.get $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/830)
   (i32.const 0)
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/179 i32) (param $str/180 i32) (result i32)
 (local $*tmp/816 i32)
 (local $len/817 i32)
 (local $*tmp/818 i32)
 (local $*tmp/819 i32)
 (local $data/820 i32)
 (local $len/821 i32)
 (local $*tmp/822 i32)
 (local $*tmp/823 i32)
 (local $len/824 i32)
 (local $*tmp/825 i32)
 (local $*tmp/826 i32)
 (local $*tmp/1082 i32)
 (local $*field/1083 i32)
 (local.set $len/817
  (i32.load offset=8
   (local.get $self/179)))
 (local.set $*tmp/818
  (i32.mul
   (local.tee $*tmp/819
    (call $moonbit.array_length
     (local.get $str/180)))
   (i32.const 2)))
 (local.set $*tmp/816
  (i32.add
   (local.get $len/817)
   (local.get $*tmp/818)))
 (call $moonbit.incref
  (local.get $self/179))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/179)
   (local.get $*tmp/816)))
 (local.set $data/820
  (local.tee $*field/1083
   (i32.load offset=12
    (local.get $self/179))))
 (local.set $len/821
  (i32.load offset=8
   (local.get $self/179)))
 (local.set $*tmp/822
  (call $moonbit.array_length
   (local.get $str/180)))
 (call $moonbit.incref
  (local.get $data/820))
 (call $moonbit.incref
  (local.get $str/180))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/820)
   (local.get $len/821)
   (local.get $str/180)
   (i32.const 0)
   (local.get $*tmp/822)))
 (local.set $len/824
  (i32.load offset=8
   (local.get $self/179)))
 (local.set $*tmp/1082
  (call $moonbit.array_length
   (local.get $str/180)))
 (call $moonbit.decref
  (local.get $str/180))
 (local.set $*tmp/825
  (i32.mul
   (local.tee $*tmp/826
    (local.get $*tmp/1082))
   (i32.const 2)))
 (local.set $*tmp/823
  (i32.add
   (local.get $len/824)
   (local.get $*tmp/825)))
 (i32.store offset=8
  (local.get $self/179)
  (local.get $*tmp/823))
 (call $moonbit.decref
  (local.get $self/179))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/171 i32) (param $bytes_offset/166 i32) (param $str/173 i32) (param $str_offset/169 i32) (param $length/167 i32) (result i32)
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
 (local $*arr/1178 i32)
 (local $*idx/1179 i32)
 (local $*arr/1180 i32)
 (local $*idx/1181 i32)
 (local.set $*tmp/815
  (i32.mul
   (local.get $length/167)
   (i32.const 2)))
 (local.set $e1/165
  (i32.sub
   (local.tee $*tmp/814
    (i32.add
     (local.get $bytes_offset/166)
     (local.get $*tmp/815)))
   (i32.const 1)))
 (local.set $e2/168
  (i32.sub
   (local.tee $*tmp/813
    (i32.add
     (local.get $str_offset/169)
     (local.get $length/167)))
   (i32.const 1)))
 (local.set $len1/170
  (call $moonbit.array_length
   (local.get $self/171)))
 (local.set $len2/172
  (call $moonbit.array_length
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
      (local.set $*tmp/805
       (i32.and
        (local.tee $*tmp/806
         (local.tee $*p/486
          (i32.and
           (local.tee $c/177
            (local.tee $*tmp/810
             (i32.load16_u offset=8
              (i32.add
               (local.get $str/173)
               (i32.shl
                (local.get $i/175)
                (i32.const 1))))))
           (i32.const 255))))
        (i32.const 255)))
      (local.get $self/171)
      (local.set $*idx/1181
       (local.get $j/176))
      (local.set $*arr/1180)
      (call $moonbit.check_range
       (local.get $*idx/1181)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1180))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1180)
        (local.get $*idx/1181))
       (local.get $*tmp/805))
      (local.set $*tmp/807
       (i32.add
        (local.get $j/176)
        (i32.const 1)))
      (local.set $*tmp/808
       (i32.and
        (local.tee $*tmp/809
         (local.tee $*p/489
          (i32.shr_u
           (local.get $c/177)
           (i32.const 8))))
        (i32.const 255)))
      (local.get $self/171)
      (local.set $*idx/1179
       (local.get $*tmp/807))
      (local.set $*arr/1178)
      (call $moonbit.check_range
       (local.get $*idx/1179)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1178))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1178)
        (local.get $*idx/1179))
       (local.get $*tmp/808))
      (local.set $*tmp/811
       (i32.add
        (local.get $i/175)
        (i32.const 1)))
      (local.set $*tmp/812
       (i32.add
        (local.get $j/176)
        (i32.const 2)))
      (local.get $*tmp/811)
      (local.get $*tmp/812)
      (br $loop:178))
     (else
      (call $moonbit.decref
       (local.get $str/173))
      (call $moonbit.decref
       (local.get $self/171)))))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $str/173))
   (call $moonbit.decref
    (local.get $self/171))
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/133 i32) (result i32)
 (local $*x/134 i32)
 (local $*x/0/135 i32)
 (local $*x/1/135 i32)
 (local $*x/2/135 i32)
 (local $*Some/136 i64)
 (local $*bind/137 i64)
 (local $*Some/138 i64)
 (local $*pkg_end/139 i32)
 (local $pkg/0/140 i32)
 (local $pkg/1/140 i32)
 (local $pkg/2/140 i32)
 (local $*bind/141 i64)
 (local $*Some/142 i64)
 (local $*start_loc_end/143 i32)
 (local $end_loc/0/144 i32)
 (local $end_loc/1/144 i32)
 (local $end_loc/2/144 i32)
 (local $*bind/145 i32)
 (local $*Some/146 i32)
 (local $*x/147 i32)
 (local $*end_line/0/148 i32)
 (local $*end_line/1/148 i32)
 (local $*end_line/2/148 i32)
 (local $*end_column/0/149 i32)
 (local $*end_column/1/149 i32)
 (local $*end_column/2/149 i32)
 (local $rest/0/150 i32)
 (local $rest/1/150 i32)
 (local $rest/2/150 i32)
 (local $*bind/152 i64)
 (local $*Some/153 i64)
 (local $*start_line_end/154 i32)
 (local $*bind/155 i64)
 (local $*Some/156 i64)
 (local $*filename_end/157 i32)
 (local $start_loc/0/158 i32)
 (local $start_loc/1/158 i32)
 (local $start_loc/2/158 i32)
 (local $*bind/159 i32)
 (local $*Some/160 i32)
 (local $*x/161 i32)
 (local $*start_line/0/162 i32)
 (local $*start_line/1/162 i32)
 (local $*start_line/2/162 i32)
 (local $*start_column/0/163 i32)
 (local $*start_column/1/163 i32)
 (local $*start_column/2/163 i32)
 (local $filename/0/164 i32)
 (local $filename/1/164 i32)
 (local $filename/2/164 i32)
 (local $*bind/384 i64)
 (local $*tmp/773 i64)
 (local $*tmp/774 i32)
 (local $*tmp/775 i32)
 (local $*tmp/776 i32)
 (local $end/777 i32)
 (local $start/778 i32)
 (local $*tmp/779 i32)
 (local $*tmp/780 i32)
 (local $end/781 i32)
 (local $start/782 i32)
 (local $*tmp/783 i32)
 (local $*tmp/784 i32)
 (local $*tmp/785 i64)
 (local $*tmp/786 i32)
 (local $*tmp/0/787 i32)
 (local $*tmp/1/787 i32)
 (local $*tmp/2/787 i32)
 (local $*tmp/0/788 i32)
 (local $*tmp/1/788 i32)
 (local $*tmp/2/788 i32)
 (local $*tmp/789 i32)
 (local $*tmp/790 i64)
 (local $*tmp/0/791 i32)
 (local $*tmp/1/791 i32)
 (local $*tmp/2/791 i32)
 (local $*tmp/792 i32)
 (local $*tmp/793 i64)
 (local $*tmp/794 i32)
 (local $*tmp/0/795 i32)
 (local $*tmp/1/795 i32)
 (local $*tmp/2/795 i32)
 (local $*tmp/796 i32)
 (local $*tmp/797 i64)
 (local $*tmp/0/798 i32)
 (local $*tmp/1/798 i32)
 (local $*tmp/2/798 i32)
 (local $*tmp/799 i32)
 (local $*tmp/800 i32)
 (local $*tmp/801 i32)
 (local $*tmp/802 i64)
 (local $*tmp/803 i32)
 (local $*tmp/804 i32)
 (local $*field/0/1084 i32)
 (local $*field/1/1084 i32)
 (local $*field/2/1084 i32)
 (local $*field/0/1085 i32)
 (local $*field/1/1085 i32)
 (local $*field/2/1085 i32)
 (local $*field/0/1086 i32)
 (local $*field/1/1086 i32)
 (local $*field/2/1086 i32)
 (local $*field/0/1087 i32)
 (local $*field/1/1087 i32)
 (local $*field/2/1087 i32)
 (local $*cnt/1159 i32)
 (local $*new_cnt/1160 i32)
 (local $*cnt/1161 i32)
 (local $*new_cnt/1162 i32)
 (local $ptr/1182 i32)
 (block $join:132
  (local.set $*tmp/773
   (i64.extend_i32_s
    (local.tee $*tmp/774
     (call $moonbit.array_length
      (local.get $repr/133)))))
  (call $moonbit.incref
   (local.get $repr/133))
  (if (result i32)
   (call $String::char_length_ge.inner
    (local.get $repr/133)
    (i32.const 1)
    (i32.const 0)
    (local.get $*tmp/773))
   (then
    (if (result i32)
     (i32.eq
      (local.tee $*x/134
       (local.tee $*tmp/804
        (i32.load16_u offset=8
         (i32.add
          (local.get $repr/133)
          (i32.shl
           (i32.const 0)
           (i32.const 1))))))
      (i32.const 64))
     (then
      (local.set $*tmp/802
       (i64.extend_i32_s
        (local.tee $*tmp/803
         (call $moonbit.array_length
          (local.get $repr/133)))))
      (call $moonbit.incref
       (local.get $repr/133))
      (local.set $*tmp/800
       (if (result i32)
        (i64.eq
         (local.tee $*bind/384
          (call $String::offset_of_nth_char.inner
           (local.get $repr/133)
           (i32.const 1)
           (i32.const 0)
           (local.get $*tmp/802)))
         (i64.const 4294967296))
        (then
         (call $moonbit.array_length
          (local.get $repr/133)))
        (else
         (i32.wrap_i64
          (local.tee $*Some/136
           (local.get $*bind/384))))))
      (local.set $*tmp/801
       (call $moonbit.array_length
        (local.get $repr/133)))
      (local.get $repr/133)
      (local.get $*tmp/800)
      (local.set $*x/2/135
       (local.get $*tmp/801))
      (local.set $*x/1/135)
      (local.set $*x/0/135)
      (local.set $*tmp/799
       (call $moonbit.array_length
        (global.get $moonbitlang/core/builtin.parse.*bind|5440)))
      (call $moonbit.incref
       (global.get $moonbitlang/core/builtin.parse.*bind|5440))
      (global.get $moonbitlang/core/builtin.parse.*bind|5440)
      (i32.const 0)
      (local.set $*tmp/2/798
       (local.get $*tmp/799))
      (local.set $*tmp/1/798)
      (local.set $*tmp/0/798)
      (call $moonbit.incref
       (local.get $*x/0/135))
      (if (result i32)
       (i64.eq
        (local.tee $*bind/137
         (call $StringView::find
          (local.get $*x/0/135)
          (local.get $*x/1/135)
          (local.get $*x/2/135)
          (local.get $*tmp/0/798)
          (local.get $*tmp/1/798)
          (local.get $*tmp/2/798)))
        (i64.const 4294967296))
       (then
        (call $moonbit.decref
         (local.get $*x/0/135))
        (unreachable))
       (else
        (local.set $*tmp/797
         (i64.extend_i32_s
          (local.tee $*pkg_end/139
           (i32.wrap_i64
            (local.tee $*Some/138
             (local.get $*bind/137))))))
        (call $moonbit.incref
         (local.get $*x/0/135))
        (call $StringView::view.inner
         (local.get $*x/0/135)
         (local.get $*x/1/135)
         (local.get $*x/2/135)
         (i32.const 0)
         (local.get $*tmp/797))
        (local.set $pkg/2/140)
        (local.set $pkg/1/140)
        (local.set $pkg/0/140)
        (local.set $*tmp/796
         (call $moonbit.array_length
          (global.get $moonbitlang/core/builtin.parse.*bind|5434)))
        (call $moonbit.incref
         (global.get $moonbitlang/core/builtin.parse.*bind|5434))
        (global.get $moonbitlang/core/builtin.parse.*bind|5434)
        (i32.const 0)
        (local.set $*tmp/2/795
         (local.get $*tmp/796))
        (local.set $*tmp/1/795)
        (local.set $*tmp/0/795)
        (call $moonbit.incref
         (local.get $*x/0/135))
        (if (result i32)
         (i64.eq
          (local.tee $*bind/141
           (call $StringView::rev_find
            (local.get $*x/0/135)
            (local.get $*x/1/135)
            (local.get $*x/2/135)
            (local.get $*tmp/0/795)
            (local.get $*tmp/1/795)
            (local.get $*tmp/2/795)))
          (i64.const 4294967296))
         (then
          (call $moonbit.decref
           (local.get $pkg/0/140))
          (call $moonbit.decref
           (local.get $*x/0/135))
          (unreachable))
         (else
          (local.set $*tmp/775
           (i32.add
            (local.tee $*start_loc_end/143
             (i32.wrap_i64
              (local.tee $*Some/142
               (local.get $*bind/141))))
            (i32.const 1)))
          (local.set $end/777
           (local.get $*x/2/135))
          (local.set $start/778
           (local.get $*x/1/135))
          (local.set $*tmp/776
           (i32.sub
            (local.get $end/777)
            (local.get $start/778)))
          (if (result i32)
           (i32.lt_s
            (local.get $*tmp/775)
            (local.get $*tmp/776))
           (then
            (local.set $*tmp/794
             (i32.add
              (local.get $*start_loc_end/143)
              (i32.const 1)))
            (call $moonbit.incref
             (local.get $*x/0/135))
            (call $StringView::view.inner
             (local.get $*x/0/135)
             (local.get $*x/1/135)
             (local.get $*x/2/135)
             (local.get $*tmp/794)
             (i64.const 4294967296))
            (local.set $end_loc/2/144)
            (local.set $end_loc/1/144)
            (local.tee $end_loc/0/144)
            (local.get $end_loc/1/144)
            (local.get $end_loc/2/144)
            (call $moonbitlang/core/builtin.parse.parse_loc|1101)
            (local.tee $*bind/145)
            (i32.const 0)
            (i32.eq)
            (if (result i32)
             (then
              (if
               (local.get $*bind/145)
               (then
                (call $moonbit.decref
                 (local.get $*bind/145)))
               (else))
              (call $moonbit.decref
               (local.get $pkg/0/140))
              (call $moonbit.decref
               (local.get $*x/0/135))
              (unreachable))
             (else
              (i32.load offset=24
               (local.tee $*x/147
                (local.tee $*Some/146
                 (local.get $*bind/145))))
              (i32.load offset=8
               (local.get $*x/147))
              (local.set $*field/2/1087
               (i32.load offset=12
                (local.get $*x/147)))
              (local.set $*field/1/1087)
              (local.tee $*field/0/1087)
              (local.get $*field/1/1087)
              (local.set $*end_line/2/148
               (local.get $*field/2/1087))
              (local.set $*end_line/1/148)
              (local.set $*end_line/0/148)
              (i32.load offset=28
               (local.get $*x/147))
              (i32.load offset=16
               (local.get $*x/147))
              (local.set $*field/2/1086
               (i32.load offset=20
                (local.get $*x/147)))
              (local.set $*field/1/1086)
              (local.set $*field/0/1086)
              (if
               (i32.gt_s
                (local.tee $*cnt/1159
                 (i32.load
                  (local.get $*x/147)))
                (i32.const 1))
               (then
                (call $moonbit.incref
                 (local.get $*field/0/1086))
                (call $moonbit.incref
                 (local.get $*end_line/0/148))
                (local.set $*new_cnt/1160
                 (i32.sub
                  (local.get $*cnt/1159)
                  (i32.const 1)))
                (i32.store
                 (local.get $*x/147)
                 (local.get $*new_cnt/1160)))
               (else
                (if
                 (i32.eq
                  (local.get $*cnt/1159)
                  (i32.const 1))
                 (then
                  (call $moonbit.free
                   (local.get $*x/147)))
                 (else))))
              (local.get $*field/0/1086)
              (local.get $*field/1/1086)
              (local.set $*end_column/2/149
               (local.get $*field/2/1086))
              (local.set $*end_column/1/149)
              (local.set $*end_column/0/149)
              (local.set $*tmp/793
               (i64.extend_i32_s
                (local.get $*start_loc_end/143)))
              (call $StringView::view.inner
               (local.get $*x/0/135)
               (local.get $*x/1/135)
               (local.get $*x/2/135)
               (i32.const 0)
               (local.get $*tmp/793))
              (local.set $rest/2/150)
              (local.set $rest/1/150)
              (local.set $rest/0/150)
              (block $join:151
               (local.set $*tmp/792
                (call $moonbit.array_length
                 (global.get $moonbitlang/core/builtin.parse.*bind|5421)))
               (call $moonbit.incref
                (global.get $moonbitlang/core/builtin.parse.*bind|5421))
               (global.get $moonbitlang/core/builtin.parse.*bind|5421)
               (i32.const 0)
               (local.set $*tmp/2/791
                (local.get $*tmp/792))
               (local.set $*tmp/1/791)
               (local.set $*tmp/0/791)
               (call $moonbit.incref
                (local.get $rest/0/150))
               (if (result i32)
                (i64.eq
                 (local.tee $*bind/152
                  (call $StringView::rev_find
                   (local.get $rest/0/150)
                   (local.get $rest/1/150)
                   (local.get $rest/2/150)
                   (local.get $*tmp/0/791)
                   (local.get $*tmp/1/791)
                   (local.get $*tmp/2/791)))
                 (i64.const 4294967296))
                (then
                 (call $moonbit.decref
                  (local.get $rest/0/150))
                 (call $moonbit.decref
                  (local.get $*end_column/0/149))
                 (call $moonbit.decref
                  (local.get $*end_line/0/148))
                 (call $moonbit.decref
                  (local.get $pkg/0/140))
                 (br $join:151))
                (else
                 (local.set $*tmp/790
                  (i64.extend_i32_s
                   (local.tee $*start_line_end/154
                    (i32.wrap_i64
                     (local.tee $*Some/153
                      (local.get $*bind/152))))))
                 (call $moonbit.incref
                  (local.get $rest/0/150))
                 (call $StringView::view.inner
                  (local.get $rest/0/150)
                  (local.get $rest/1/150)
                  (local.get $rest/2/150)
                  (i32.const 0)
                  (local.get $*tmp/790))
                 (local.set $*tmp/2/787)
                 (local.set $*tmp/1/787)
                 (local.set $*tmp/0/787)
                 (local.set $*tmp/789
                  (call $moonbit.array_length
                   (global.get $moonbitlang/core/builtin.parse.*bind|5415)))
                 (call $moonbit.incref
                  (global.get $moonbitlang/core/builtin.parse.*bind|5415))
                 (global.get $moonbitlang/core/builtin.parse.*bind|5415)
                 (i32.const 0)
                 (local.set $*tmp/2/788
                  (local.get $*tmp/789))
                 (local.set $*tmp/1/788)
                 (local.set $*tmp/0/788)
                 (if (result i32)
                  (i64.eq
                   (local.tee $*bind/155
                    (call $StringView::rev_find
                     (local.get $*tmp/0/787)
                     (local.get $*tmp/1/787)
                     (local.get $*tmp/2/787)
                     (local.get $*tmp/0/788)
                     (local.get $*tmp/1/788)
                     (local.get $*tmp/2/788)))
                   (i64.const 4294967296))
                  (then
                   (call $moonbit.decref
                    (local.get $rest/0/150))
                   (call $moonbit.decref
                    (local.get $*end_column/0/149))
                   (call $moonbit.decref
                    (local.get $*end_line/0/148))
                   (call $moonbit.decref
                    (local.get $pkg/0/140))
                   (br $join:151))
                  (else
                   (local.set $*tmp/779
                    (i32.add
                     (local.tee $*filename_end/157
                      (i32.wrap_i64
                       (local.tee $*Some/156
                        (local.get $*bind/155))))
                     (i32.const 1)))
                   (local.set $end/781
                    (local.get $rest/2/150))
                   (local.set $start/782
                    (local.get $rest/1/150))
                   (local.set $*tmp/780
                    (i32.sub
                     (local.get $end/781)
                     (local.get $start/782)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $*tmp/779)
                     (local.get $*tmp/780))
                    (then
                     (local.set $*tmp/786
                      (i32.add
                       (local.get $*filename_end/157)
                       (i32.const 1)))
                     (call $moonbit.incref
                      (local.get $rest/0/150))
                     (call $StringView::view.inner
                      (local.get $rest/0/150)
                      (local.get $rest/1/150)
                      (local.get $rest/2/150)
                      (local.get $*tmp/786)
                      (i64.const 4294967296))
                     (local.set $start_loc/2/158)
                     (local.set $start_loc/1/158)
                     (local.tee $start_loc/0/158)
                     (local.get $start_loc/1/158)
                     (local.get $start_loc/2/158)
                     (call $moonbitlang/core/builtin.parse.parse_loc|1101)
                     (local.tee $*bind/159)
                     (i32.const 0)
                     (i32.eq)
                     (if (result i32)
                      (then
                       (if
                        (local.get $*bind/159)
                        (then
                         (call $moonbit.decref
                          (local.get $*bind/159)))
                        (else))
                       (call $moonbit.decref
                        (local.get $rest/0/150))
                       (call $moonbit.decref
                        (local.get $*end_column/0/149))
                       (call $moonbit.decref
                        (local.get $*end_line/0/148))
                       (call $moonbit.decref
                        (local.get $pkg/0/140))
                       (unreachable))
                      (else
                       (i32.load offset=24
                        (local.tee $*x/161
                         (local.tee $*Some/160
                          (local.get $*bind/159))))
                       (i32.load offset=8
                        (local.get $*x/161))
                       (local.set $*field/2/1085
                        (i32.load offset=12
                         (local.get $*x/161)))
                       (local.set $*field/1/1085)
                       (local.tee $*field/0/1085)
                       (local.get $*field/1/1085)
                       (local.set $*start_line/2/162
                        (local.get $*field/2/1085))
                       (local.set $*start_line/1/162)
                       (local.set $*start_line/0/162)
                       (i32.load offset=28
                        (local.get $*x/161))
                       (i32.load offset=16
                        (local.get $*x/161))
                       (local.set $*field/2/1084
                        (i32.load offset=20
                         (local.get $*x/161)))
                       (local.set $*field/1/1084)
                       (local.set $*field/0/1084)
                       (if
                        (i32.gt_s
                         (local.tee $*cnt/1161
                          (i32.load
                           (local.get $*x/161)))
                         (i32.const 1))
                        (then
                         (call $moonbit.incref
                          (local.get $*field/0/1084))
                         (call $moonbit.incref
                          (local.get $*start_line/0/162))
                         (local.set $*new_cnt/1162
                          (i32.sub
                           (local.get $*cnt/1161)
                           (i32.const 1)))
                         (i32.store
                          (local.get $*x/161)
                          (local.get $*new_cnt/1162)))
                        (else
                         (if
                          (i32.eq
                           (local.get $*cnt/1161)
                           (i32.const 1))
                          (then
                           (call $moonbit.free
                            (local.get $*x/161)))
                          (else))))
                       (local.get $*field/0/1084)
                       (local.get $*field/1/1084)
                       (local.set $*start_column/2/163
                        (local.get $*field/2/1084))
                       (local.set $*start_column/1/163)
                       (local.set $*start_column/0/163)
                       (local.set $*tmp/783
                        (i32.add
                         (local.get $*pkg_end/139)
                         (i32.const 1)))
                       (if (result i32)
                        (i32.gt_s
                         (local.get $*filename_end/157)
                         (local.get $*tmp/783))
                        (then
                         (local.set $*tmp/784
                          (i32.add
                           (local.get $*pkg_end/139)
                           (i32.const 1)))
                         (local.set $*tmp/785
                          (i64.extend_i32_s
                           (local.get $*filename_end/157)))
                         (call $StringView::view.inner
                          (local.get $rest/0/150)
                          (local.get $rest/1/150)
                          (local.get $rest/2/150)
                          (local.get $*tmp/784)
                          (local.get $*tmp/785))
                         (local.set $filename/2/164)
                         (local.set $filename/1/164)
                         (local.set $filename/0/164)
                         (i32.store offset=4
                          (local.tee $ptr/1182
                           (call $moonbit.gc.malloc
                            (i32.const 72)))
                          (i32.const 7341568))
                         (i32.store offset=76
                          (local.get $ptr/1182)
                          (local.get $*end_column/0/149))
                         (i32.store offset=48
                          (local.get $ptr/1182)
                          (local.get $*end_column/1/149))
                         (i32.store offset=52
                          (local.get $ptr/1182)
                          (local.get $*end_column/2/149))
                         (i32.store offset=72
                          (local.get $ptr/1182)
                          (local.get $*end_line/0/148))
                         (i32.store offset=40
                          (local.get $ptr/1182)
                          (local.get $*end_line/1/148))
                         (i32.store offset=44
                          (local.get $ptr/1182)
                          (local.get $*end_line/2/148))
                         (i32.store offset=68
                          (local.get $ptr/1182)
                          (local.get $*start_column/0/163))
                         (i32.store offset=32
                          (local.get $ptr/1182)
                          (local.get $*start_column/1/163))
                         (i32.store offset=36
                          (local.get $ptr/1182)
                          (local.get $*start_column/2/163))
                         (i32.store offset=64
                          (local.get $ptr/1182)
                          (local.get $*start_line/0/162))
                         (i32.store offset=24
                          (local.get $ptr/1182)
                          (local.get $*start_line/1/162))
                         (i32.store offset=28
                          (local.get $ptr/1182)
                          (local.get $*start_line/2/162))
                         (i32.store offset=60
                          (local.get $ptr/1182)
                          (local.get $filename/0/164))
                         (i32.store offset=16
                          (local.get $ptr/1182)
                          (local.get $filename/1/164))
                         (i32.store offset=20
                          (local.get $ptr/1182)
                          (local.get $filename/2/164))
                         (i32.store offset=56
                          (local.get $ptr/1182)
                          (local.get $pkg/0/140))
                         (i32.store offset=8
                          (local.get $ptr/1182)
                          (local.get $pkg/1/140))
                         (i32.store offset=12
                          (local.get $ptr/1182)
                          (local.get $pkg/2/140))
                         (local.get $ptr/1182))
                        (else
                         (call $moonbit.decref
                          (local.get $*start_column/0/163))
                         (call $moonbit.decref
                          (local.get $*start_line/0/162))
                         (call $moonbit.decref
                          (local.get $rest/0/150))
                         (call $moonbit.decref
                          (local.get $*end_column/0/149))
                         (call $moonbit.decref
                          (local.get $*end_line/0/148))
                         (call $moonbit.decref
                          (local.get $pkg/0/140))
                         (unreachable))))))
                    (else
                     (call $moonbit.decref
                      (local.get $rest/0/150))
                     (call $moonbit.decref
                      (local.get $*end_column/0/149))
                     (call $moonbit.decref
                      (local.get $*end_line/0/148))
                     (call $moonbit.decref
                      (local.get $pkg/0/140))
                     (unreachable)))))))
               (return))
              (unreachable))))
           (else
            (call $moonbit.decref
             (local.get $pkg/0/140))
            (call $moonbit.decref
             (local.get $*x/0/135))
            (unreachable))))))))
     (else
      (call $moonbit.decref
       (local.get $repr/133))
      (br $join:132))))
   (else
    (call $moonbit.decref
     (local.get $repr/133))
    (br $join:132)))
  (return))
 (unreachable))
(func $moonbitlang/core/builtin.parse.parse_loc|1101 (param $view/0/129 i32) (param $view/1/129 i32) (param $view/2/129 i32) (result i32)
 (local $*bind/128 i64)
 (local $*Some/130 i64)
 (local $*i/131 i32)
 (local $*tmp/762 i32)
 (local $*tmp/763 i32)
 (local $end/764 i32)
 (local $start/765 i32)
 (local $*tuple/766 i32)
 (local $*tmp/0/767 i32)
 (local $*tmp/1/767 i32)
 (local $*tmp/2/767 i32)
 (local $*tmp/0/768 i32)
 (local $*tmp/1/768 i32)
 (local $*tmp/2/768 i32)
 (local $*tmp/769 i32)
 (local $*tmp/770 i64)
 (local $*tmp/0/771 i32)
 (local $*tmp/1/771 i32)
 (local $*tmp/2/771 i32)
 (local $*tmp/772 i32)
 (local $ptr/1183 i32)
 (local.set $*tmp/772
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.parse.*bind|5401)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.parse.*bind|5401))
 (global.get $moonbitlang/core/builtin.parse.*bind|5401)
 (i32.const 0)
 (local.set $*tmp/2/771
  (local.get $*tmp/772))
 (local.set $*tmp/1/771)
 (local.set $*tmp/0/771)
 (call $moonbit.incref
  (local.get $view/0/129))
 (if (result i32)
  (i64.eq
   (local.tee $*bind/128
    (call $StringView::find
     (local.get $view/0/129)
     (local.get $view/1/129)
     (local.get $view/2/129)
     (local.get $*tmp/0/771)
     (local.get $*tmp/1/771)
     (local.get $*tmp/2/771)))
   (i64.const 4294967296))
  (then
   (call $moonbit.decref
    (local.get $view/0/129))
   (i32.const 0))
  (else
   (if (result i32)
    (if (result i32)
     (i32.gt_s
      (local.tee $*i/131
       (i32.wrap_i64
        (local.tee $*Some/130
         (local.get $*bind/128))))
      (i32.const 0))
     (then
      (local.set $*tmp/762
       (i32.add
        (local.get $*i/131)
        (i32.const 1)))
      (local.set $end/764
       (local.get $view/2/129))
      (local.set $start/765
       (local.get $view/1/129))
      (local.set $*tmp/763
       (i32.sub
        (local.get $end/764)
        (local.get $start/765)))
      (i32.lt_s
       (local.get $*tmp/762)
       (local.get $*tmp/763)))
     (else
      (i32.const 0)))
    (then
     (local.set $*tmp/770
      (i64.extend_i32_s
       (local.get $*i/131)))
     (call $moonbit.incref
      (local.get $view/0/129))
     (call $StringView::view.inner
      (local.get $view/0/129)
      (local.get $view/1/129)
      (local.get $view/2/129)
      (i32.const 0)
      (local.get $*tmp/770))
     (local.set $*tmp/2/767)
     (local.set $*tmp/1/767)
     (local.set $*tmp/0/767)
     (local.set $*tmp/769
      (i32.add
       (local.get $*i/131)
       (i32.const 1)))
     (call $StringView::view.inner
      (local.get $view/0/129)
      (local.get $view/1/129)
      (local.get $view/2/129)
      (local.get $*tmp/769)
      (i64.const 4294967296))
     (local.set $*tmp/2/768)
     (local.set $*tmp/1/768)
     (local.set $*tmp/0/768)
     (i32.store offset=4
      (local.tee $ptr/1183
       (call $moonbit.gc.malloc
        (i32.const 24)))
      (i32.const 3146240))
     (i32.store offset=28
      (local.get $ptr/1183)
      (local.get $*tmp/0/768))
     (i32.store offset=16
      (local.get $ptr/1183)
      (local.get $*tmp/1/768))
     (i32.store offset=20
      (local.get $ptr/1183)
      (local.get $*tmp/2/768))
     (i32.store offset=24
      (local.get $ptr/1183)
      (local.get $*tmp/0/767))
     (i32.store offset=8
      (local.get $ptr/1183)
      (local.get $*tmp/1/767))
     (i32.store offset=12
      (local.get $ptr/1183)
      (local.get $*tmp/2/767))
     (local.tee $*tuple/766
      (local.get $ptr/1183)))
    (else
     (call $moonbit.decref
      (local.get $view/0/129))
     (i32.const 0))))))
(func $StringView::view.inner (param $self/0/126 i32) (param $self/1/126 i32) (param $self/2/126 i32) (param $start_offset/127 i32) (param $end_offset/124 i64) (result i32) (result i32) (result i32)
 (local $end_offset/123 i32)
 (local $*Some/125 i64)
 (local $*tmp/752 i32)
 (local $end/753 i32)
 (local $start/754 i32)
 (local $str/755 i32)
 (local $*tmp/756 i32)
 (local $*tmp/757 i32)
 (local $start/758 i32)
 (local $start/759 i32)
 (local $end/760 i32)
 (local $start/761 i32)
 (local $*field/1088 i32)
 (local $*field/1089 i32)
 (local.set $end_offset/123
  (if (result i32)
   (i64.eq
    (local.get $end_offset/124)
    (i64.const 4294967296))
   (then
    (local.set $end/760
     (local.get $self/2/126))
    (local.set $start/761
     (local.get $self/1/126))
    (i32.sub
     (local.get $end/760)
     (local.get $start/761)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/125
      (local.get $end_offset/124))))))
 (if (result i32) (result i32) (result i32)
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
      (local.set $end/753
       (local.get $self/2/126))
      (local.set $start/754
       (local.get $self/1/126))
      (local.set $*tmp/752
       (i32.sub
        (local.get $end/753)
        (local.get $start/754)))
      (i32.le_s
       (local.get $end_offset/123)
       (local.get $*tmp/752)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $str/755
    (local.tee $*field/1089
     (local.get $self/0/126)))
   (local.set $*tmp/756
    (i32.add
     (local.tee $start/759
      (local.get $self/1/126))
     (local.get $start_offset/127)))
   (local.set $*tmp/757
    (i32.add
     (local.tee $start/758
      (local.tee $*field/1088
       (local.get $self/1/126)))
     (local.get $end_offset/123)))
   (local.get $str/755)
   (local.get $*tmp/756)
   (local.get $*tmp/757))
  (else
   (call $moonbit.decref
    (local.get $self/0/126))
   (call $moonbitlang/core/builtin.abort|StringView|
    (i32.const 10824)
    (i32.const 10704)))))
(func $StringView::rev_find (param $self/0/122 i32) (param $self/1/122 i32) (param $self/2/122 i32) (param $str/0/121 i32) (param $str/1/121 i32) (param $str/2/121 i32) (result i64)
 (local $*tmp/749 i32)
 (local $end/750 i32)
 (local $start/751 i32)
 (local.set $end/750
  (local.get $str/2/121))
 (local.set $start/751
  (local.get $str/1/121))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/749
    (i32.sub
     (local.get $end/750)
     (local.get $start/751)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_rev_find
    (local.get $self/0/122)
    (local.get $self/1/122)
    (local.get $self/2/122)
    (local.get $str/0/121)
    (local.get $str/1/121)
    (local.get $str/2/121)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_rev_find
    (local.get $self/0/122)
    (local.get $self/1/122)
    (local.get $self/2/122)
    (local.get $str/0/121)
    (local.get $str/1/121)
    (local.get $str/2/121)))))
(func $moonbitlang/core/builtin.brute_force_rev_find (param $haystack/0/112 i32) (param $haystack/1/112 i32) (param $haystack/2/112 i32) (param $needle/0/114 i32) (param $needle/1/114 i32) (param $needle/2/114 i32) (result i64)
 (local $haystack_len/111 i32)
 (local $needle_len/113 i32)
 (local $needle_first/115 i32)
 (local $j/118 i32)
 (local $*p/463 i32)
 (local $*p/466 i32)
 (local $*p/469 i32)
 (local $*tmp/722 i32)
 (local $*tmp/723 i32)
 (local $str/724 i32)
 (local $*tmp/725 i32)
 (local $start/726 i32)
 (local $*tmp/727 i32)
 (local $*tmp/728 i32)
 (local $*tmp/729 i32)
 (local $*tmp/730 i32)
 (local $*tmp/731 i32)
 (local $str/732 i32)
 (local $*tmp/733 i32)
 (local $start/734 i32)
 (local $str/735 i32)
 (local $*tmp/736 i32)
 (local $start/737 i32)
 (local $*tmp/738 i32)
 (local $*tmp/739 i32)
 (local $*tmp/740 i32)
 (local $*tmp/741 i32)
 (local $str/742 i32)
 (local $*tmp/743 i32)
 (local $start/744 i32)
 (local $end/745 i32)
 (local $start/746 i32)
 (local $end/747 i32)
 (local $start/748 i32)
 (local $*tmp/1090 i32)
 (local $*field/1091 i32)
 (local $*tmp/1092 i32)
 (local $*field/1093 i32)
 (local $*tmp/1094 i32)
 (local $*field/1095 i32)
 (local $*tmp/1096 i32)
 (local $*field/1097 i32)
 (local $i/116 i32)
 (local.set $end/747
  (local.get $haystack/2/112))
 (local.set $start/748
  (local.get $haystack/1/112))
 (local.set $haystack_len/111
  (i32.sub
   (local.get $end/747)
   (local.get $start/748)))
 (local.set $end/745
  (local.get $needle/2/114))
 (local.set $start/746
  (local.get $needle/1/114))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/113
    (i32.sub
     (local.get $end/745)
     (local.get $start/746)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/111)
     (local.get $needle_len/113))
    (then
     (local.set $*p/463
      (i32.const 0))
     (local.set $str/742
      (local.tee $*field/1097
       (local.get $needle/0/114)))
     (local.set $*tmp/743
      (i32.add
       (local.tee $start/744
        (local.get $needle/1/114))
       (local.get $*p/463)))
     (local.set $needle_first/115
      (local.tee $*tmp/1096
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/742)
         (i32.shl
          (local.get $*tmp/743)
          (i32.const 1))))))
     (local.set $i/116
      (i32.sub
       (local.get $haystack_len/111)
       (local.get $needle_len/113)))
     (loop $loop:120
      (if
       (i32.ge_s
        (local.tee $*tmp/722
         (local.get $i/116))
        (i32.const 0))
       (then
        (loop $loop:117
         (if
          (if (result i32)
           (i32.ge_s
            (local.tee $*tmp/727
             (local.get $i/116))
            (i32.const 0))
           (then
            (local.set $*p/466
             (local.get $i/116))
            (local.set $str/724
             (local.tee $*field/1095
              (local.get $haystack/0/112)))
            (local.set $*tmp/725
             (i32.add
              (local.tee $start/726
               (local.get $haystack/1/112))
              (local.get $*p/466)))
            (local.tee $*tmp/723
             (local.tee $*tmp/1094
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/724)
                (i32.shl
                 (local.get $*tmp/725)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/115)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/116
            (i32.sub
             (local.tee $*tmp/728
              (local.get $i/116))
             (i32.const 1)))
           (br $loop:117))
          (else)))
        (if
         (i32.ge_s
          (local.tee $*tmp/729
           (local.get $i/116))
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
                (local.tee $*tmp/738
                 (local.get $i/116))
                (local.get $j/118)))
              (local.set $str/735
               (local.tee $*field/1093
                (local.get $haystack/0/112)))
              (local.set $*tmp/736
               (i32.add
                (local.tee $start/737
                 (local.get $haystack/1/112))
                (local.get $*p/469)))
              (local.set $*tmp/730
               (local.tee $*tmp/1092
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/735)
                  (i32.shl
                   (local.get $*tmp/736)
                   (i32.const 1))))))
              (local.set $str/732
               (local.tee $*field/1091
                (local.get $needle/0/114)))
              (local.set $*tmp/733
               (i32.add
                (local.tee $start/734
                 (local.get $needle/1/114))
                (local.get $j/118)))
              (local.set $*tmp/731
               (local.tee $*tmp/1090
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/732)
                  (i32.shl
                   (local.get $*tmp/733)
                   (i32.const 1))))))
              (local.get $*tmp/730)
              (if
               (i32.ne
                (local.get $*tmp/731))
               (then
                (br $break:119))
               (else))
              (local.tee $*tmp/739
               (i32.add
                (local.get $j/118)
                (i32.const 1)))
              (br $loop:119))
             (else
              (call $moonbit.decref
               (local.get $needle/0/114))
              (call $moonbit.decref
               (local.get $haystack/0/112))
              (i64.extend_i32_s
               (local.tee $*tmp/740
                (local.get $i/116)))
              (return)))))
          (local.set $i/116
           (i32.sub
            (local.tee $*tmp/741
             (local.get $i/116))
            (i32.const 1))))
         (else))
        (br $loop:120))
       (else
        (call $moonbit.decref
         (local.get $needle/0/114))
        (call $moonbit.decref
         (local.get $haystack/0/112)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/114))
     (call $moonbit.decref
      (local.get $haystack/0/112))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/114))
   (call $moonbit.decref
    (local.get $haystack/0/112))
   (i64.extend_i32_s
    (local.get $haystack_len/111)))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_rev_find (param $haystack/0/101 i32) (param $haystack/1/101 i32) (param $haystack/2/101 i32) (param $needle/0/103 i32) (param $needle/1/103 i32) (param $needle/2/103 i32) (result i64)
 (local $haystack_len/100 i32)
 (local $needle_len/102 i32)
 (local $skip_table/104 i32)
 (local $i/105 i32)
 (local $i/107 i32)
 (local $j/108 i32)
 (local $*p/452 i32)
 (local $*tmp/694 i32)
 (local $*tmp/695 i32)
 (local $str/696 i32)
 (local $*tmp/697 i32)
 (local $start/698 i32)
 (local $*tmp/699 i32)
 (local $*tmp/700 i32)
 (local $*tmp/701 i32)
 (local $*tmp/702 i32)
 (local $str/703 i32)
 (local $*tmp/704 i32)
 (local $start/705 i32)
 (local $str/706 i32)
 (local $*tmp/707 i32)
 (local $start/708 i32)
 (local $*tmp/709 i32)
 (local $*tmp/710 i32)
 (local $*tmp/711 i32)
 (local $*tmp/712 i32)
 (local $*tmp/713 i32)
 (local $str/714 i32)
 (local $*tmp/715 i32)
 (local $start/716 i32)
 (local $*tmp/717 i32)
 (local $end/718 i32)
 (local $start/719 i32)
 (local $end/720 i32)
 (local $start/721 i32)
 (local $*tmp/1098 i32)
 (local $*field/1099 i32)
 (local $*tmp/1100 i32)
 (local $*field/1101 i32)
 (local $*tmp/1102 i32)
 (local $*field/1103 i32)
 (local $*tmp/1104 i32)
 (local $*field/1105 i32)
 (local $*arr/1184 i32)
 (local $*idx/1185 i32)
 (local $*arr/1186 i32)
 (local $*idx/1187 i32)
 (local.set $end/720
  (local.get $haystack/2/101))
 (local.set $start/721
  (local.get $haystack/1/101))
 (local.set $haystack_len/100
  (i32.sub
   (local.get $end/720)
   (local.get $start/721)))
 (local.set $end/718
  (local.get $needle/2/103))
 (local.set $start/719
  (local.get $needle/1/103))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/102
    (i32.sub
     (local.get $end/718)
     (local.get $start/719)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/100)
     (local.get $needle_len/102))
    (then
     (local.set $skip_table/104
      (call $moonbit.i32_array_make
       (i32.const 256)
       (local.get $needle_len/102)))
     (local.tee $*tmp/700
      (i32.sub
       (local.get $needle_len/102)
       (i32.const 1)))
     (loop $loop:106 (param i32)
      (local.tee $i/105)
      (i32.const 0)
      (i32.gt_s)
      (if
       (then
        (local.set $str/696
         (local.tee $*field/1105
          (local.get $needle/0/103)))
        (local.set $*tmp/697
         (i32.add
          (local.tee $start/698
           (local.get $needle/1/103))
          (local.get $i/105)))
        (local.set $*tmp/694
         (i32.and
          (local.tee $*tmp/695
           (local.tee $*tmp/1104
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/696)
              (i32.shl
               (local.get $*tmp/697)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/104)
        (local.set $*idx/1187
         (local.get $*tmp/694))
        (local.set $*arr/1186)
        (call $moonbit.check_range
         (local.get $*idx/1187)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1186))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1186)
          (i32.shl
           (local.get $*idx/1187)
           (i32.const 2)))
         (local.get $i/105))
        (local.tee $*tmp/699
         (i32.sub
          (local.get $i/105)
          (i32.const 1)))
        (br $loop:106))
       (else)))
     (local.tee $*tmp/717
      (i32.sub
       (local.get $haystack_len/100)
       (local.get $needle_len/102)))
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
            (local.set $str/706
             (local.tee $*field/1103
              (local.get $haystack/0/101)))
            (local.set $*tmp/707
             (i32.add
              (local.tee $start/708
               (local.get $haystack/1/101))
              (local.get $*p/452)))
            (local.set $*tmp/701
             (local.tee $*tmp/1102
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/706)
                (i32.shl
                 (local.get $*tmp/707)
                 (i32.const 1))))))
            (local.set $str/703
             (local.tee $*field/1101
              (local.get $needle/0/103)))
            (local.set $*tmp/704
             (i32.add
              (local.tee $start/705
               (local.get $needle/1/103))
              (local.get $j/108)))
            (local.set $*tmp/702
             (local.tee $*tmp/1100
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/703)
                (i32.shl
                 (local.get $*tmp/704)
                 (i32.const 1))))))
            (local.get $*tmp/701)
            (if
             (i32.ne
              (local.get $*tmp/702))
             (then
              (br $break:109))
             (else))
            (local.tee $*tmp/709
             (i32.add
              (local.get $j/108)
              (i32.const 1)))
            (br $loop:109))
           (else
            (call $moonbit.decref
             (local.get $skip_table/104))
            (call $moonbit.decref
             (local.get $needle/0/103))
            (call $moonbit.decref
             (local.get $haystack/0/101))
            (i64.extend_i32_s
             (local.get $i/107))
            (return)))))
        (local.set $str/714
         (local.tee $*field/1099
          (local.get $haystack/0/101)))
        (local.set $*tmp/715
         (i32.add
          (local.tee $start/716
           (local.get $haystack/1/101))
          (local.get $i/107)))
        (local.set $*tmp/712
         (i32.and
          (local.tee $*tmp/713
           (local.tee $*tmp/1098
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/714)
              (i32.shl
               (local.get $*tmp/715)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/104)
        (local.set $*idx/1185
         (local.get $*tmp/712))
        (local.set $*arr/1184)
        (call $moonbit.check_range
         (local.get $*idx/1185)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1184))
          (i32.const 1)))
        (local.set $*tmp/711
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1184)
           (i32.shl
            (local.get $*idx/1185)
            (i32.const 2)))))
        (local.tee $*tmp/710
         (i32.sub
          (local.get $i/107)
          (local.get $*tmp/711)))
        (br $loop:110))
       (else
        (call $moonbit.decref
         (local.get $skip_table/104))
        (call $moonbit.decref
         (local.get $needle/0/103))
        (call $moonbit.decref
         (local.get $haystack/0/101)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/103))
     (call $moonbit.decref
      (local.get $haystack/0/101))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/103))
   (call $moonbit.decref
    (local.get $haystack/0/101))
   (i64.extend_i32_s
    (local.get $haystack_len/100)))))
(func $StringView::find (param $self/0/99 i32) (param $self/1/99 i32) (param $self/2/99 i32) (param $str/0/98 i32) (param $str/1/98 i32) (param $str/2/98 i32) (result i64)
 (local $*tmp/691 i32)
 (local $end/692 i32)
 (local $start/693 i32)
 (local.set $end/692
  (local.get $str/2/98))
 (local.set $start/693
  (local.get $str/1/98))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/691
    (i32.sub
     (local.get $end/692)
     (local.get $start/693)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_find
    (local.get $self/0/99)
    (local.get $self/1/99)
    (local.get $self/2/99)
    (local.get $str/0/98)
    (local.get $str/1/98)
    (local.get $str/2/98)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_find
    (local.get $self/0/99)
    (local.get $self/1/99)
    (local.get $self/2/99)
    (local.get $str/0/98)
    (local.get $str/1/98)
    (local.get $str/2/98)))))
(func $moonbitlang/core/builtin.brute_force_find (param $haystack/0/88 i32) (param $haystack/1/88 i32) (param $haystack/2/88 i32) (param $needle/0/90 i32) (param $needle/1/90 i32) (param $needle/2/90 i32) (result i64)
 (local $haystack_len/87 i32)
 (local $needle_len/89 i32)
 (local $needle_first/91 i32)
 (local $forward_len/92 i32)
 (local $j/95 i32)
 (local $*p/433 i32)
 (local $*p/436 i32)
 (local $*p/439 i32)
 (local $*tmp/664 i32)
 (local $*tmp/665 i32)
 (local $str/666 i32)
 (local $*tmp/667 i32)
 (local $start/668 i32)
 (local $*tmp/669 i32)
 (local $*tmp/670 i32)
 (local $*tmp/671 i32)
 (local $*tmp/672 i32)
 (local $*tmp/673 i32)
 (local $str/674 i32)
 (local $*tmp/675 i32)
 (local $start/676 i32)
 (local $str/677 i32)
 (local $*tmp/678 i32)
 (local $start/679 i32)
 (local $*tmp/680 i32)
 (local $*tmp/681 i32)
 (local $*tmp/682 i32)
 (local $*tmp/683 i32)
 (local $str/684 i32)
 (local $*tmp/685 i32)
 (local $start/686 i32)
 (local $end/687 i32)
 (local $start/688 i32)
 (local $end/689 i32)
 (local $start/690 i32)
 (local $*tmp/1106 i32)
 (local $*field/1107 i32)
 (local $*tmp/1108 i32)
 (local $*field/1109 i32)
 (local $*tmp/1110 i32)
 (local $*field/1111 i32)
 (local $*tmp/1112 i32)
 (local $*field/1113 i32)
 (local $i/93 i32)
 (local.set $end/689
  (local.get $haystack/2/88))
 (local.set $start/690
  (local.get $haystack/1/88))
 (local.set $haystack_len/87
  (i32.sub
   (local.get $end/689)
   (local.get $start/690)))
 (local.set $end/687
  (local.get $needle/2/90))
 (local.set $start/688
  (local.get $needle/1/90))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/89
    (i32.sub
     (local.get $end/687)
     (local.get $start/688)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/87)
     (local.get $needle_len/89))
    (then
     (local.set $*p/433
      (i32.const 0))
     (local.set $str/684
      (local.tee $*field/1113
       (local.get $needle/0/90)))
     (local.set $*tmp/685
      (i32.add
       (local.tee $start/686
        (local.get $needle/1/90))
       (local.get $*p/433)))
     (local.set $needle_first/91
      (local.tee $*tmp/1112
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/684)
         (i32.shl
          (local.get $*tmp/685)
          (i32.const 1))))))
     (local.set $forward_len/92
      (i32.sub
       (local.get $haystack_len/87)
       (local.get $needle_len/89)))
     (local.set $i/93
      (i32.const 0))
     (loop $loop:97
      (if
       (i32.le_s
        (local.tee $*tmp/664
         (local.get $i/93))
        (local.get $forward_len/92))
       (then
        (loop $loop:94
         (if
          (if (result i32)
           (i32.le_s
            (local.tee $*tmp/669
             (local.get $i/93))
            (local.get $forward_len/92))
           (then
            (local.set $*p/436
             (local.get $i/93))
            (local.set $str/666
             (local.tee $*field/1111
              (local.get $haystack/0/88)))
            (local.set $*tmp/667
             (i32.add
              (local.tee $start/668
               (local.get $haystack/1/88))
              (local.get $*p/436)))
            (local.tee $*tmp/665
             (local.tee $*tmp/1110
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/666)
                (i32.shl
                 (local.get $*tmp/667)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/91)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/93
            (i32.add
             (local.tee $*tmp/670
              (local.get $i/93))
             (i32.const 1)))
           (br $loop:94))
          (else)))
        (if
         (i32.le_s
          (local.tee $*tmp/671
           (local.get $i/93))
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
                (local.tee $*tmp/680
                 (local.get $i/93))
                (local.get $j/95)))
              (local.set $str/677
               (local.tee $*field/1109
                (local.get $haystack/0/88)))
              (local.set $*tmp/678
               (i32.add
                (local.tee $start/679
                 (local.get $haystack/1/88))
                (local.get $*p/439)))
              (local.set $*tmp/672
               (local.tee $*tmp/1108
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/677)
                  (i32.shl
                   (local.get $*tmp/678)
                   (i32.const 1))))))
              (local.set $str/674
               (local.tee $*field/1107
                (local.get $needle/0/90)))
              (local.set $*tmp/675
               (i32.add
                (local.tee $start/676
                 (local.get $needle/1/90))
                (local.get $j/95)))
              (local.set $*tmp/673
               (local.tee $*tmp/1106
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/674)
                  (i32.shl
                   (local.get $*tmp/675)
                   (i32.const 1))))))
              (local.get $*tmp/672)
              (if
               (i32.ne
                (local.get $*tmp/673))
               (then
                (br $break:96))
               (else))
              (local.tee $*tmp/681
               (i32.add
                (local.get $j/95)
                (i32.const 1)))
              (br $loop:96))
             (else
              (call $moonbit.decref
               (local.get $needle/0/90))
              (call $moonbit.decref
               (local.get $haystack/0/88))
              (i64.extend_i32_s
               (local.tee $*tmp/682
                (local.get $i/93)))
              (return)))))
          (local.set $i/93
           (i32.add
            (local.tee $*tmp/683
             (local.get $i/93))
            (i32.const 1))))
         (else))
        (br $loop:97))
       (else
        (call $moonbit.decref
         (local.get $needle/0/90))
        (call $moonbit.decref
         (local.get $haystack/0/88)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/90))
     (call $moonbit.decref
      (local.get $haystack/0/88))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/90))
   (call $moonbit.decref
    (local.get $haystack/0/88))
   (global.get $moonbitlang/core/builtin.brute_force_find.constr/86))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_find (param $haystack/0/74 i32) (param $haystack/1/74 i32) (param $haystack/2/74 i32) (param $needle/0/76 i32) (param $needle/1/76 i32) (param $needle/2/76 i32) (result i64)
 (local $haystack_len/73 i32)
 (local $needle_len/75 i32)
 (local $skip_table/77 i32)
 (local $*end4298/78 i32)
 (local $i/79 i32)
 (local $i/81 i32)
 (local $*end4304/82 i32)
 (local $j/83 i32)
 (local $*p/421 i32)
 (local $*p/426 i32)
 (local $*tmp/634 i32)
 (local $*tmp/635 i32)
 (local $*tmp/636 i32)
 (local $*tmp/637 i32)
 (local $str/638 i32)
 (local $*tmp/639 i32)
 (local $start/640 i32)
 (local $*tmp/641 i32)
 (local $*tmp/642 i32)
 (local $*tmp/643 i32)
 (local $*tmp/644 i32)
 (local $str/645 i32)
 (local $*tmp/646 i32)
 (local $start/647 i32)
 (local $str/648 i32)
 (local $*tmp/649 i32)
 (local $start/650 i32)
 (local $*tmp/651 i32)
 (local $*tmp/652 i32)
 (local $*tmp/653 i32)
 (local $*tmp/654 i32)
 (local $*tmp/655 i32)
 (local $str/656 i32)
 (local $*tmp/657 i32)
 (local $start/658 i32)
 (local $*tmp/659 i32)
 (local $end/660 i32)
 (local $start/661 i32)
 (local $end/662 i32)
 (local $start/663 i32)
 (local $*tmp/1114 i32)
 (local $*field/1115 i32)
 (local $*tmp/1116 i32)
 (local $*field/1117 i32)
 (local $*tmp/1118 i32)
 (local $*field/1119 i32)
 (local $*tmp/1120 i32)
 (local $*field/1121 i32)
 (local $*arr/1188 i32)
 (local $*idx/1189 i32)
 (local $*arr/1190 i32)
 (local $*idx/1191 i32)
 (local.set $end/662
  (local.get $haystack/2/74))
 (local.set $start/663
  (local.get $haystack/1/74))
 (local.set $haystack_len/73
  (i32.sub
   (local.get $end/662)
   (local.get $start/663)))
 (local.set $end/660
  (local.get $needle/2/76))
 (local.set $start/661
  (local.get $needle/1/76))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/75
    (i32.sub
     (local.get $end/660)
     (local.get $start/661)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/73)
     (local.get $needle_len/75))
    (then
     (local.set $skip_table/77
      (call $moonbit.i32_array_make
       (i32.const 256)
       (local.get $needle_len/75)))
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
        (local.set $str/638
         (local.tee $*field/1121
          (local.get $needle/0/76)))
        (local.set $*tmp/639
         (i32.add
          (local.tee $start/640
           (local.get $needle/1/76))
          (local.get $i/79)))
        (local.set $*tmp/634
         (i32.and
          (local.tee $*tmp/637
           (local.tee $*tmp/1120
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/638)
              (i32.shl
               (local.get $*tmp/639)
               (i32.const 1))))))
          (i32.const 255)))
        (local.set $*tmp/635
         (i32.sub
          (local.tee $*tmp/636
           (i32.sub
            (local.get $needle_len/75)
            (i32.const 1)))
          (local.get $i/79)))
        (local.get $skip_table/77)
        (local.set $*idx/1191
         (local.get $*tmp/634))
        (local.set $*arr/1190)
        (call $moonbit.check_range
         (local.get $*idx/1191)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1190))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1190)
          (i32.shl
           (local.get $*idx/1191)
           (i32.const 2)))
         (local.get $*tmp/635))
        (local.tee $*tmp/641
         (i32.add
          (local.get $i/79)
          (i32.const 1)))
        (br $loop:80))
       (else)))
     (i32.const 0)
     (loop $loop:85 (param i32)
      (local.set $i/81)
      (local.set $*tmp/642
       (i32.sub
        (local.get $haystack_len/73)
        (local.get $needle_len/75)))
      (if
       (i32.le_s
        (local.get $i/81)
        (local.get $*tmp/642))
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
            (local.set $str/648
             (local.tee $*field/1119
              (local.get $haystack/0/74)))
            (local.set $*tmp/649
             (i32.add
              (local.tee $start/650
               (local.get $haystack/1/74))
              (local.get $*p/421)))
            (local.set $*tmp/643
             (local.tee $*tmp/1118
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/648)
                (i32.shl
                 (local.get $*tmp/649)
                 (i32.const 1))))))
            (local.set $str/645
             (local.tee $*field/1117
              (local.get $needle/0/76)))
            (local.set $*tmp/646
             (i32.add
              (local.tee $start/647
               (local.get $needle/1/76))
              (local.get $j/83)))
            (local.set $*tmp/644
             (local.tee $*tmp/1116
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/645)
                (i32.shl
                 (local.get $*tmp/646)
                 (i32.const 1))))))
            (local.get $*tmp/643)
            (if
             (i32.ne
              (local.get $*tmp/644))
             (then
              (br $break:84))
             (else))
            (local.tee $*tmp/651
             (i32.add
              (local.get $j/83)
              (i32.const 1)))
            (br $loop:84))
           (else
            (call $moonbit.decref
             (local.get $skip_table/77))
            (call $moonbit.decref
             (local.get $needle/0/76))
            (call $moonbit.decref
             (local.get $haystack/0/74))
            (i64.extend_i32_s
             (local.get $i/81))
            (return)))))
        (local.set $*p/426
         (i32.sub
          (local.tee $*tmp/659
           (i32.add
            (local.get $i/81)
            (local.get $needle_len/75)))
          (i32.const 1)))
        (local.set $str/656
         (local.tee $*field/1115
          (local.get $haystack/0/74)))
        (local.set $*tmp/657
         (i32.add
          (local.tee $start/658
           (local.get $haystack/1/74))
          (local.get $*p/426)))
        (local.set $*tmp/654
         (i32.and
          (local.tee $*tmp/655
           (local.tee $*tmp/1114
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/656)
              (i32.shl
               (local.get $*tmp/657)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/77)
        (local.set $*idx/1189
         (local.get $*tmp/654))
        (local.set $*arr/1188)
        (call $moonbit.check_range
         (local.get $*idx/1189)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1188))
          (i32.const 1)))
        (local.set $*tmp/653
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1188)
           (i32.shl
            (local.get $*idx/1189)
            (i32.const 2)))))
        (local.tee $*tmp/652
         (i32.add
          (local.get $i/81)
          (local.get $*tmp/653)))
        (br $loop:85))
       (else
        (call $moonbit.decref
         (local.get $skip_table/77))
        (call $moonbit.decref
         (local.get $needle/0/76))
        (call $moonbit.decref
         (local.get $haystack/0/74)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/76))
     (call $moonbit.decref
      (local.get $haystack/0/74))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/76))
   (call $moonbit.decref
    (local.get $haystack/0/74))
   (global.get $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/72))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/63 i32) (param $ch/65 i32) (result i32)
 (local $inc/64 i32)
 (local $*tmp/623 i32)
 (local $len/624 i32)
 (local $*tmp/625 i32)
 (local $len/626 i32)
 (local $data/627 i32)
 (local $len/628 i32)
 (local $*field/1127 i32)
 (local.set $*tmp/623
  (i32.add
   (local.tee $len/624
    (i32.load offset=8
     (local.get $self/63)))
   (i32.const 4)))
 (call $moonbit.incref
  (local.get $self/63))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/63)
   (local.get $*tmp/623)))
 (local.set $data/627
  (local.tee $*field/1127
   (i32.load offset=12
    (local.get $self/63))))
 (local.set $len/628
  (i32.load offset=8
   (local.get $self/63)))
 (call $moonbit.incref
  (local.get $data/627))
 (local.set $inc/64
  (call $FixedArray::set_utf16le_char
   (local.get $data/627)
   (local.get $len/628)
   (local.get $ch/65)))
 (local.set $*tmp/625
  (i32.add
   (local.tee $len/626
    (i32.load offset=8
     (local.get $self/63)))
   (local.get $inc/64)))
 (i32.store offset=8
  (local.get $self/63)
  (local.get $*tmp/625))
 (call $moonbit.decref
  (local.get $self/63))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/58 i32) (param $required/59 i32) (result i32)
 (local $current_len/57 i32)
 (local $new_data/62 i32)
 (local $*tmp/617 i32)
 (local $*tmp/618 i32)
 (local $data/619 i32)
 (local $len/620 i32)
 (local $*tmp/621 i32)
 (local $data/622 i32)
 (local $*old/1128 i32)
 (local $*field/1129 i32)
 (local $*tmp/1130 i32)
 (local $*field/1131 i32)
 (local $enough_space/60 i32)
 (local.set $current_len/57
  (local.tee $*tmp/1130
   (call $moonbit.array_length
    (local.tee $data/622
     (local.tee $*field/1131
      (i32.load offset=12
       (local.get $self/58)))))))
 (if
  (i32.le_s
   (local.get $required/59)
   (local.get $current_len/57))
  (then
   (call $moonbit.decref
    (local.get $self/58))
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/60
  (local.get $current_len/57))
 (loop $loop:61
  (if
   (i32.lt_s
    (local.tee $*tmp/617
     (local.get $enough_space/60))
    (local.get $required/59))
   (then
    (local.set $enough_space/60
     (i32.mul
      (local.tee $*tmp/618
       (local.get $enough_space/60))
      (i32.const 2)))
    (br $loop:61))
   (else)))
 (local.set $new_data/62
  (call $moonbit.bytes_make
   (local.tee $*tmp/621
    (local.get $enough_space/60))
   (i32.const 0)))
 (local.set $data/619
  (local.tee $*field/1129
   (i32.load offset=12
    (local.get $self/58))))
 (local.set $len/620
  (i32.load offset=8
   (local.get $self/58)))
 (call $moonbit.incref
  (local.get $data/619))
 (call $moonbit.incref
  (local.get $new_data/62))
 (drop
  (call $FixedArray::unsafe_blit|Byte|
   (local.get $new_data/62)
   (i32.const 0)
   (local.get $data/619)
   (i32.const 0)
   (local.get $len/620)))
 (call $moonbit.decref
  (local.tee $*old/1128
   (i32.load offset=12
    (local.get $self/58))))
 (i32.store offset=12
  (local.get $self/58)
  (local.get $new_data/62))
 (call $moonbit.decref
  (local.get $self/58))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/52 i32) (param $offset/53 i32) (param $value/51 i32) (result i32)
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
 (local $*tmp/598 i32)
 (local $*tmp/599 i32)
 (local $*tmp/600 i32)
 (local $*tmp/601 i32)
 (local $*tmp/602 i32)
 (local $*tmp/603 i32)
 (local $*tmp/604 i32)
 (local $*tmp/605 i32)
 (local $*tmp/606 i32)
 (local $*tmp/607 i32)
 (local $*tmp/608 i32)
 (local $*tmp/609 i32)
 (local $*tmp/610 i32)
 (local $*tmp/611 i32)
 (local $*tmp/612 i32)
 (local $*tmp/613 i32)
 (local $*tmp/614 i32)
 (local $*tmp/615 i32)
 (local $*tmp/616 i32)
 (local $*arr/1192 i32)
 (local $*idx/1193 i32)
 (local $*arr/1194 i32)
 (local $*idx/1195 i32)
 (local $*arr/1196 i32)
 (local $*idx/1197 i32)
 (local $*arr/1198 i32)
 (local $*idx/1199 i32)
 (local $*arr/1200 i32)
 (local $*idx/1201 i32)
 (local $*arr/1202 i32)
 (local $*idx/1203 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/50
    (local.tee $*tmp/616
     (local.get $value/51)))
   (i32.const 65536))
  (then
   (local.set $*tmp/598
    (i32.and
     (local.tee $*tmp/599
      (local.tee $*p/395
       (i32.and
        (local.get $code/50)
        (i32.const 255))))
     (i32.const 255)))
   (local.get $self/52)
   (local.set $*idx/1195
    (local.get $offset/53))
   (local.set $*arr/1194)
   (call $moonbit.check_range
    (local.get $*idx/1195)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1194))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1194)
     (local.get $*idx/1195))
    (local.get $*tmp/598))
   (local.set $*tmp/600
    (i32.add
     (local.get $offset/53)
     (i32.const 1)))
   (local.set $*tmp/601
    (i32.and
     (local.tee $*tmp/602
      (local.tee $*p/398
       (i32.shr_u
        (local.get $code/50)
        (i32.const 8))))
     (i32.const 255)))
   (local.get $self/52)
   (local.set $*idx/1193
    (local.get $*tmp/600))
   (local.set $*arr/1192)
   (call $moonbit.check_range
    (local.get $*idx/1193)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1192))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1192)
     (local.get $*idx/1193))
    (local.get $*tmp/601))
   (call $moonbit.decref
    (local.get $self/52))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/50)
     (i32.const 1114112))
    (then
     (local.set $lo/55
      (i32.or
       (local.tee $*tmp/615
        (i32.shr_u
         (local.tee $hi/54
          (i32.sub
           (local.get $code/50)
           (i32.const 65536)))
         (i32.const 10)))
       (i32.const 55296)))
     (local.set $hi/56
      (i32.or
       (local.tee $*tmp/614
        (i32.and
         (local.get $hi/54)
         (i32.const 1023)))
       (i32.const 56320)))
     (local.set $*tmp/603
      (i32.and
       (local.tee $*tmp/604
        (local.tee $*p/401
         (i32.and
          (local.get $lo/55)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/52)
     (local.set $*idx/1203
      (local.get $offset/53))
     (local.set $*arr/1202)
     (call $moonbit.check_range
      (local.get $*idx/1203)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1202))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1202)
       (local.get $*idx/1203))
      (local.get $*tmp/603))
     (local.set $*tmp/605
      (i32.add
       (local.get $offset/53)
       (i32.const 1)))
     (local.set $*tmp/606
      (i32.and
       (local.tee $*tmp/607
        (local.tee $*p/404
         (i32.shr_u
          (local.get $lo/55)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/52)
     (local.set $*idx/1201
      (local.get $*tmp/605))
     (local.set $*arr/1200)
     (call $moonbit.check_range
      (local.get $*idx/1201)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1200))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1200)
       (local.get $*idx/1201))
      (local.get $*tmp/606))
     (local.set $*tmp/608
      (i32.add
       (local.get $offset/53)
       (i32.const 2)))
     (local.set $*tmp/609
      (i32.and
       (local.tee $*tmp/610
        (local.tee $*p/407
         (i32.and
          (local.get $hi/56)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/52)
     (local.set $*idx/1199
      (local.get $*tmp/608))
     (local.set $*arr/1198)
     (call $moonbit.check_range
      (local.get $*idx/1199)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1198))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1198)
       (local.get $*idx/1199))
      (local.get $*tmp/609))
     (local.set $*tmp/611
      (i32.add
       (local.get $offset/53)
       (i32.const 3)))
     (local.set $*tmp/612
      (i32.and
       (local.tee $*tmp/613
        (local.tee $*p/410
         (i32.shr_u
          (local.get $hi/56)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/52)
     (local.set $*idx/1197
      (local.get $*tmp/611))
     (local.set $*arr/1196)
     (call $moonbit.check_range
      (local.get $*idx/1197)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1196))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1196)
       (local.get $*idx/1197))
      (local.get $*tmp/612))
     (call $moonbit.decref
      (local.get $self/52))
     (i32.const 4))
    (else
     (call $moonbit.decref
      (local.get $self/52))
     (call $moonbitlang/core/builtin.abort|Int|
      (i32.const 10992)
      (i32.const 10880)))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/47 i32) (result i32)
 (local $*tmp/592 i32)
 (local $*tmp/593 i64)
 (local $len/594 i32)
 (local $data/595 i32)
 (local $*field/1132 i32)
 (local $*field/1133 i32)
 (call $moonbit.incref
  (local.tee $data/595
   (local.tee $*field/1133
    (i32.load offset=12
     (local.get $self/47)))))
 (local.set $*tmp/592
  (local.get $data/595))
 (local.set $*field/1132
  (i32.load offset=8
   (local.get $self/47)))
 (call $moonbit.decref
  (local.get $self/47))
 (local.set $*tmp/593
  (i64.extend_i32_s
   (local.tee $len/594
    (local.get $*field/1132))))
 (call $Bytes::to_unchecked_string.inner
  (local.get $*tmp/592)
  (i32.const 0)
  (local.get $*tmp/593)))
(func $Bytes::to_unchecked_string.inner (param $self/42 i32) (param $offset/46 i32) (param $length/44 i64) (result i32)
 (local $len/41 i32)
 (local $length/43 i32)
 (local $*Some/45 i64)
 (local $*tmp/591 i32)
 (local.set $len/41
  (call $moonbit.array_length
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
 (if (result i32)
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
       (local.tee $*tmp/591
        (i32.add
         (local.get $offset/46)
         (local.get $length/43)))
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
   (call $moonbit.decref
    (local.get $self/42))
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/525 i32) (param $*param/526 i32) (param $*param/527 i32) (result i32)
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/525)
  (local.get $*param/526)
  (local.get $*param/527)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/39 i32) (result i32)
 (local $initial/38 i32)
 (local $data/40 i32)
 (local $ptr/1204 i32)
 (local.set $data/40
  (call $moonbit.bytes_make
   (local.tee $initial/38
    (if (result i32)
     (i32.lt_s
      (local.get $size_hint/39)
      (i32.const 1))
     (then
      (i32.const 1))
     (else
      (local.get $size_hint/39))))
   (i32.const 0)))
 (i32.store offset=4
  (local.tee $ptr/1204
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1204)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/1204)
  (local.get $data/40))
 (local.get $ptr/1204))
(func $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int| (param $dst/33 i32) (param $dst_offset/34 i32) (param $src/35 i32) (param $src_offset/36 i32) (param $len/37 i32) (result i32)
 (call $FixedArray::unsafe_blit|@moonbitlang/core/builtin.UnsafeMaybeUninit<Int>|
  (local.get $dst/33)
  (local.get $dst_offset/34)
  (local.get $src/35)
  (local.get $src_offset/36)
  (local.get $len/37)))
(func $FixedArray::unsafe_blit|@moonbitlang/core/builtin.UnsafeMaybeUninit<Int>| (param $dst/24 i32) (param $dst_offset/26 i32) (param $src/25 i32) (param $src_offset/27 i32) (param $len/29 i32) (result i32)
 (local $i/28 i32)
 (local $i/31 i32)
 (local $*tmp/582 i32)
 (local $*tmp/583 i32)
 (local $*tmp/584 i32)
 (local $*tmp/585 i32)
 (local $*tmp/586 i32)
 (local $*tmp/587 i32)
 (local $*tmp/588 i32)
 (local $*tmp/589 i32)
 (local $*tmp/590 i32)
 (local $*arr/1205 i32)
 (local $*idx/1206 i32)
 (local $*arr/1207 i32)
 (local $*idx/1208 i32)
 (local $*arr/1209 i32)
 (local $*idx/1210 i32)
 (local $*arr/1211 i32)
 (local $*idx/1212 i32)
 (if (result i32)
  (if (result i32)
   (i32.eq
    (local.get $dst/24)
    (local.get $src/25))
   (then
    (i32.lt_s
     (local.get $dst_offset/26)
     (local.get $src_offset/27)))
   (else
    (i32.const 0)))
  (then
   (i32.const 0)
   (loop $loop:30 (param i32)
    (local.tee $i/28)
    (local.get $len/29)
    (i32.lt_s)
    (if
     (then
      (local.set $*tmp/582
       (i32.add
        (local.get $dst_offset/26)
        (local.get $i/28)))
      (local.set $*tmp/584
       (i32.add
        (local.get $src_offset/27)
        (local.get $i/28)))
      (local.get $src/25)
      (local.set $*idx/1208
       (local.get $*tmp/584))
      (local.set $*arr/1207)
      (call $moonbit.check_range
       (local.get $*idx/1208)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1207))
        (i32.const 1)))
      (local.set $*tmp/583
       (i32.load offset=8
        (i32.add
         (local.get $*arr/1207)
         (i32.shl
          (local.get $*idx/1208)
          (i32.const 2)))))
      (local.get $dst/24)
      (local.set $*idx/1206
       (local.get $*tmp/582))
      (local.set $*arr/1205)
      (call $moonbit.check_range
       (local.get $*idx/1206)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1205))
        (i32.const 1)))
      (i32.store offset=8
       (i32.add
        (local.get $*arr/1205)
        (i32.shl
         (local.get $*idx/1206)
         (i32.const 2)))
       (local.get $*tmp/583))
      (local.tee $*tmp/585
       (i32.add
        (local.get $i/28)
        (i32.const 1)))
      (br $loop:30))
     (else
      (call $moonbit.decref
       (local.get $src/25))
      (call $moonbit.decref
       (local.get $dst/24)))))
   (i32.const 0))
  (else
   (local.tee $*tmp/590
    (i32.sub
     (local.get $len/29)
     (i32.const 1)))
   (loop $loop:32 (param i32)
    (local.tee $i/31)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/586
       (i32.add
        (local.get $dst_offset/26)
        (local.get $i/31)))
      (local.set $*tmp/588
       (i32.add
        (local.get $src_offset/27)
        (local.get $i/31)))
      (local.get $src/25)
      (local.set $*idx/1212
       (local.get $*tmp/588))
      (local.set $*arr/1211)
      (call $moonbit.check_range
       (local.get $*idx/1212)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1211))
        (i32.const 1)))
      (local.set $*tmp/587
       (i32.load offset=8
        (i32.add
         (local.get $*arr/1211)
         (i32.shl
          (local.get $*idx/1212)
          (i32.const 2)))))
      (local.get $dst/24)
      (local.set $*idx/1210
       (local.get $*tmp/586))
      (local.set $*arr/1209)
      (call $moonbit.check_range
       (local.get $*idx/1210)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1209))
        (i32.const 1)))
      (i32.store offset=8
       (i32.add
        (local.get $*arr/1209)
        (i32.shl
         (local.get $*idx/1210)
         (i32.const 2)))
       (local.get $*tmp/587))
      (local.tee $*tmp/589
       (i32.sub
        (local.get $i/31)
        (i32.const 1)))
      (br $loop:32))
     (else
      (call $moonbit.decref
       (local.get $src/25))
      (call $moonbit.decref
       (local.get $dst/24)))))
   (i32.const 0))))
(func $FixedArray::unsafe_blit|Byte| (param $dst/15 i32) (param $dst_offset/17 i32) (param $src/16 i32) (param $src_offset/18 i32) (param $len/20 i32) (result i32)
 (local $i/19 i32)
 (local $i/22 i32)
 (local $*tmp/573 i32)
 (local $*tmp/574 i32)
 (local $*tmp/575 i32)
 (local $*tmp/576 i32)
 (local $*tmp/577 i32)
 (local $*tmp/578 i32)
 (local $*tmp/579 i32)
 (local $*tmp/580 i32)
 (local $*tmp/581 i32)
 (local $*arr/1213 i32)
 (local $*idx/1214 i32)
 (local $*arr/1215 i32)
 (local $*idx/1216 i32)
 (local $*arr/1217 i32)
 (local $*idx/1218 i32)
 (local $*arr/1219 i32)
 (local $*idx/1220 i32)
 (if (result i32)
  (if (result i32)
   (i32.eq
    (local.get $dst/15)
    (local.get $src/16))
   (then
    (i32.lt_s
     (local.get $dst_offset/17)
     (local.get $src_offset/18)))
   (else
    (i32.const 0)))
  (then
   (i32.const 0)
   (loop $loop:21 (param i32)
    (local.tee $i/19)
    (local.get $len/20)
    (i32.lt_s)
    (if
     (then
      (local.set $*tmp/573
       (i32.add
        (local.get $dst_offset/17)
        (local.get $i/19)))
      (local.set $*tmp/575
       (i32.add
        (local.get $src_offset/18)
        (local.get $i/19)))
      (local.get $src/16)
      (local.set $*idx/1216
       (local.get $*tmp/575))
      (local.set $*arr/1215)
      (call $moonbit.check_range
       (local.get $*idx/1216)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1215))
        (i32.const 1)))
      (local.set $*tmp/574
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1215)
         (local.get $*idx/1216))))
      (local.get $dst/15)
      (local.set $*idx/1214
       (local.get $*tmp/573))
      (local.set $*arr/1213)
      (call $moonbit.check_range
       (local.get $*idx/1214)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1213))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1213)
        (local.get $*idx/1214))
       (local.get $*tmp/574))
      (local.tee $*tmp/576
       (i32.add
        (local.get $i/19)
        (i32.const 1)))
      (br $loop:21))
     (else
      (call $moonbit.decref
       (local.get $src/16))
      (call $moonbit.decref
       (local.get $dst/15)))))
   (i32.const 0))
  (else
   (local.tee $*tmp/581
    (i32.sub
     (local.get $len/20)
     (i32.const 1)))
   (loop $loop:23 (param i32)
    (local.tee $i/22)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/577
       (i32.add
        (local.get $dst_offset/17)
        (local.get $i/22)))
      (local.set $*tmp/579
       (i32.add
        (local.get $src_offset/18)
        (local.get $i/22)))
      (local.get $src/16)
      (local.set $*idx/1220
       (local.get $*tmp/579))
      (local.set $*arr/1219)
      (call $moonbit.check_range
       (local.get $*idx/1220)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1219))
        (i32.const 1)))
      (local.set $*tmp/578
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1219)
         (local.get $*idx/1220))))
      (local.get $dst/15)
      (local.set $*idx/1218
       (local.get $*tmp/577))
      (local.set $*arr/1217)
      (call $moonbit.check_range
       (local.get $*idx/1218)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1217))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1217)
        (local.get $*idx/1218))
       (local.get $*tmp/578))
      (local.tee $*tmp/580
       (i32.sub
        (local.get $i/22)
        (i32.const 1)))
      (br $loop:23))
     (else
      (call $moonbit.decref
       (local.get $src/16))
      (call $moonbit.decref
       (local.get $dst/15)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.abort|Option<Int>| (param $string/13 i32) (param $loc/14 i32) (result i64)
 (local $*tmp/569 i32)
 (local $*tmp/570 i32)
 (local $*tmp/571 i32)
 (local $*tmp/572 i32)
 (local.set $*tmp/571
  (call $moonbit.add_string
   (local.get $string/13)
   (i32.const 11056)))
 (local.set $*tmp/572
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/14)))
 (call $moonbitlang/core/abort.abort|Option<Int>|
  (local.tee $*tmp/569
   (call $moonbit.add_string
    (local.tee $*tmp/570
     (call $moonbit.add_string
      (local.get $*tmp/571)
      (local.get $*tmp/572)))
    (i32.const 11040)))))
(func $moonbitlang/core/builtin.abort|StringView| (param $string/11 i32) (param $loc/12 i32) (result i32) (result i32) (result i32)
 (local $*tmp/565 i32)
 (local $*tmp/566 i32)
 (local $*tmp/567 i32)
 (local $*tmp/568 i32)
 (local.set $*tmp/567
  (call $moonbit.add_string
   (local.get $string/11)
   (i32.const 11056)))
 (local.set $*tmp/568
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/12)))
 (call $moonbitlang/core/abort.abort|StringView|
  (local.tee $*tmp/565
   (call $moonbit.add_string
    (local.tee $*tmp/566
     (call $moonbit.add_string
      (local.get $*tmp/567)
      (local.get $*tmp/568)))
    (i32.const 11040)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/9 i32) (param $loc/10 i32) (result i32)
 (local $*tmp/561 i32)
 (local $*tmp/562 i32)
 (local $*tmp/563 i32)
 (local $*tmp/564 i32)
 (local.set $*tmp/563
  (call $moonbit.add_string
   (local.get $string/9)
   (i32.const 11056)))
 (local.set $*tmp/564
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/10)))
 (call $moonbitlang/core/abort.abort|Unit|
  (local.tee $*tmp/561
   (call $moonbit.add_string
    (local.tee $*tmp/562
     (call $moonbit.add_string
      (local.get $*tmp/563)
      (local.get $*tmp/564)))
    (i32.const 11040)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/7 i32) (param $loc/8 i32) (result i32)
 (local $*tmp/557 i32)
 (local $*tmp/558 i32)
 (local $*tmp/559 i32)
 (local $*tmp/560 i32)
 (local.set $*tmp/559
  (call $moonbit.add_string
   (local.get $string/7)
   (i32.const 11056)))
 (local.set $*tmp/560
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/8)))
 (call $moonbitlang/core/abort.abort|Int|
  (local.tee $*tmp/557
   (call $moonbit.add_string
    (local.tee $*tmp/558
     (call $moonbit.add_string
      (local.get $*tmp/559)
      (local.get $*tmp/560)))
    (i32.const 11040)))))
(func $@moonbitlang/core/builtin.Logger::write_object|Int| (param $self/0/6 i32) (param $self/1/6 i32) (param $obj/5 i32) (result i32)
 (call $@moonbitlang/core/builtin.Show::Int::output
  (local.get $obj/5)
  (local.get $self/0/6)
  (local.get $self/1/6)))
(func $moonbitlang/core/abort.abort|Option<Int>| (param $msg/4 i32) (result i64)
 (call $moonbit.decref
  (local.get $msg/4))
 (unreachable))
(func $moonbitlang/core/abort.abort|StringView| (param $msg/3 i32) (result i32) (result i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/3))
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/2 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/2))
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/1 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/1))
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/541 i32) (param $*param/540 i32) (result i32)
 (local $*self/539 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/539
   (local.get $*obj_ptr/541))
  (local.get $*param/540)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/538 i32) (param $*param/0/537 i32) (param $*param/1/537 i32) (param $*param/2/537 i32) (result i32)
 (local $*self/536 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/536
   (local.get $*obj_ptr/538))
  (local.get $*param/0/537)
  (local.get $*param/1/537)
  (local.get $*param/2/537)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (param $*obj_ptr/535 i32) (param $*param/532 i32) (param $*param/533 i32) (param $*param/534 i32) (result i32)
 (local $*self/531 i32)
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/531
   (local.get $*obj_ptr/535))
  (local.get $*param/532)
  (local.get $*param/533)
  (local.get $*param/534)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/530 i32) (param $*param/529 i32) (result i32)
 (local $*self/528 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/528
   (local.get $*obj_ptr/530))
  (local.get $*param/529)))
(start $*init*/6)
(func $*init*/6
 (global.set $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/72
  (i64.extend_i32_s
   (i32.const 0)))
 (global.set $moonbitlang/core/builtin.brute_force_find.constr/86
  (i64.extend_i32_s
   (i32.const 0))))
(func $*main*/5
 (local $arr/373 i32)
 (local $*len/375 i32)
 (local $*i/376 i32)
 (local $x/377 i32)
 (local $doubled/379 i32)
 (local $*len/380 i32)
 (local $*i/381 i32)
 (local $x/382 i32)
 (local $*tmp/542 i32)
 (local $*tmp/543 i32)
 (local $*tmp/544 i32)
 (local $buf/545 i32)
 (local $*tmp/546 i32)
 (local $*tmp/547 i32)
 (local $*tmp/548 i32)
 (local $*tmp/549 i32)
 (local $*tmp/550 i32)
 (local $buf/551 i32)
 (local $*tmp/552 i32)
 (local $*tmp/553 i32)
 (local $*tmp/554 i32)
 (local $*tmp/555 i32)
 (local $*tmp/556 i32)
 (local $*tmp/1134 i32)
 (local $*field/1135 i32)
 (local $*tmp/1136 i32)
 (local $*field/1137 i32)
 (local $ptr/1221 i32)
 (local $ptr/1222 i32)
 (local $*ptr/1223 i32)
 (local $sum/374 i32)
 (i32.store offset=8
  (local.tee $*ptr/1223
   (call $moonbit.i32_array_make_raw
    (i32.const 5)))
  (i32.const 1))
 (i32.store offset=12
  (local.get $*ptr/1223)
  (i32.const 2))
 (i32.store offset=16
  (local.get $*ptr/1223)
  (i32.const 3))
 (i32.store offset=20
  (local.get $*ptr/1223)
  (i32.const 4))
 (i32.store offset=24
  (local.get $*ptr/1223)
  (i32.const 5))
 (local.set $*tmp/556
  (local.get $*ptr/1223))
 (i32.store offset=4
  (local.tee $ptr/1222
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1222)
  (i32.const 5))
 (i32.store offset=12
  (local.get $ptr/1222)
  (local.get $*tmp/556))
 (call $moonbit.incref
  (local.tee $arr/373
   (local.get $ptr/1222)))
 (local.set $*tmp/543
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
   (local.get $arr/373)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/542
    (call $moonbit.add_string
     (i32.const 11192)
     (local.get $*tmp/543)))))
 (local.set $sum/374
  (i32.const 0))
 (local.set $*len/375
  (i32.load offset=8
   (local.get $arr/373)))
 (i32.const 0)
 (loop $loop:378 (param i32)
  (local.tee $*i/376)
  (local.get $*len/375)
  (i32.lt_s)
  (if
   (then
    (local.set $x/377
     (local.tee $*tmp/1136
      (i32.load offset=8
       (i32.add
        (local.tee $buf/545
         (local.tee $*field/1137
          (i32.load offset=12
           (local.get $arr/373))))
        (i32.shl
         (local.get $*i/376)
         (i32.const 2))))))
    (local.set $sum/374
     (i32.add
      (local.tee $*tmp/544
       (local.get $sum/374))
      (local.get $x/377)))
    (local.tee $*tmp/546
     (i32.add
      (local.get $*i/376)
      (i32.const 1)))
    (br $loop:378))
   (else)))
 (local.set $*tmp/548
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $*tmp/549
    (local.get $sum/374))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/547
    (call $moonbit.add_string
     (i32.const 11136)
     (local.get $*tmp/548)))))
 (local.set $*tmp/555
  (i32.const 11120))
 (i32.store offset=4
  (local.tee $ptr/1221
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1221)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/1221)
  (local.get $*tmp/555))
 (local.set $doubled/379
  (local.get $ptr/1221))
 (local.set $*len/380
  (i32.load offset=8
   (local.get $arr/373)))
 (i32.const 0)
 (loop $loop:383 (param i32)
  (local.tee $*i/381)
  (local.get $*len/380)
  (i32.lt_s)
  (if
   (then
    (local.set $*tmp/550
     (i32.mul
      (local.tee $x/382
       (local.tee $*tmp/1134
        (i32.load offset=8
         (i32.add
          (local.tee $buf/551
           (local.tee $*field/1135
            (i32.load offset=12
             (local.get $arr/373))))
          (i32.shl
           (local.get $*i/381)
           (i32.const 2))))))
      (i32.const 2)))
    (call $moonbit.incref
     (local.get $doubled/379))
    (drop
     (call $@moonbitlang/core/builtin.Array::push|Int|
      (local.get $doubled/379)
      (local.get $*tmp/550)))
    (local.tee $*tmp/552
     (i32.add
      (local.get $*i/381)
      (i32.const 1)))
    (br $loop:383))
   (else
    (call $moonbit.decref
     (local.get $arr/373)))))
 (local.set $*tmp/554
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
   (local.get $doubled/379)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/553
    (call $moonbit.add_string
     (i32.const 11080)
     (local.get $*tmp/554))))))
(export "_start" (func $*main*/5))