(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data  (memory $moonbit.memory) (offset (i32.const 10000)) "\FF\FF\FF\FF\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P0\00\00\00\00\00\00\00\FF\FF\FF\FF4\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00Pr\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\FF\FF\FF\FF$\00\00P0\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF0\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\008\00:\005\00-\002\009\008\00:\003\001\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\11\00\00PC\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P\0A\00\00\00\00\00\00\00\FF\FF\FF\FF\06\00\00P\0A\00 \00 \00a\00t\00 \00\00\00\00\00\FF\FF\FF\FF\13\00\00PA\00p\00p\00l\00y\00 \00s\00q\00u\00a\00r\00e\00 \00t\00o\00 \005\00:\00 \00\00\00\FF\FF\FF\FF\13\00\00PA\00p\00p\00l\00y\00 \00d\00o\00u\00b\00l\00e\00 \00t\00o\00 \005\00:\00 \00\00\00\FF\FF\FF\FF\00\04\10\00\00\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\FF\FF\FF\FF\00\00 \00\04\00\00\00\00\00\00\00\FF\FF\FF\FF\00\00 \00\05\00\00\00\00\00\00\00")
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
    (i32.const 10680)
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
   (i32.const 10680)
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
 (i32.const 10624)
)
(global $username/moonbit_examples/cmd/hof.*init*.double|2.clo
 (mut i32)
 (i32.const 0)
)
(global $username/moonbit_examples/cmd/hof.*init*.square|4.clo
 (mut i32)
 (i32.const 0)
)
(func $username/moonbit_examples/cmd/hof.*init*.square|4.dyncall (param $*env/800 i32) (param $x/291 i32) (result i32)
 (call $username/moonbit_examples/cmd/hof.*init*.square|4
  (local.get $x/291)))
(func $username/moonbit_examples/cmd/hof.*init*.double|2.dyncall (param $*env/799 i32) (param $x/290 i32) (result i32)
 (call $username/moonbit_examples/cmd/hof.*init*.double|2
  (local.get $x/290)))
(func $username/moonbit_examples/cmd/hof.*init*.square|4 (param $x/291 i32) (result i32)
 (i32.mul
  (local.get $x/291)
  (local.get $x/291)))
(func $username/moonbit_examples/cmd/hof.*init*.double|2 (param $x/290 i32) (result i32)
 (i32.mul
  (local.get $x/290)
  (i32.const 2)))
(func $username/moonbit_examples/cmd/hof.apply (param $f/288 i32) (param $x/289 i32) (result i32)
 (call_indirect $moonbit.global (type $<Int>=>Int)
  (local.get $f/288)
  (local.get $x/289)
  (i32.load offset=8
   (local.get $f/288))))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/286 i32) (param $logger/0/287 i32) (param $logger/1/287 i32) (result i32)
 (local $*tmp/797 i32)
 (local $*tmp/798 i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (local.tee $*tmp/797
   (call $@moonbitlang/core/builtin.SourceLocRepr::parse
    (local.tee $*tmp/798
     (local.get $self/286))))
  (local.get $logger/0/287)
  (local.get $logger/1/287)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/249 i32) (param $logger/0/285 i32) (param $logger/1/285 i32) (result i32)
 (local $pkg/0/248 i32)
 (local $pkg/1/248 i32)
 (local $pkg/2/248 i32)
 (local $*data/250 i32)
 (local $*start/251 i32)
 (local $*end/252 i32)
 (local $*bind/258 i32)
 (local $package_name/0/260 i32)
 (local $package_name/1/260 i32)
 (local $package_name/2/260 i32)
 (local $*try_err/262 i32)
 (local $module_name/0/263 i32)
 (local $module_name/1/263 i32)
 (local $module_name/2/263 i32)
 (local $*try_err/265 i32)
 (local $next_char/268 i32)
 (local $next_char/271 i32)
 (local $next_char/274 i32)
 (local $next_char/275 i32)
 (local $next_char/276 i32)
 (local $next_char/277 i32)
 (local $next_char/278 i32)
 (local $next_char/279 i32)
 (local $next_char/280 i32)
 (local $*module_name/0/281 i32)
 (local $*module_name/1/281 i32)
 (local $*module_name/2/281 i32)
 (local $*package_name/282 i32)
 (local $*Some/283 i32)
 (local $*pkg_name/0/284 i32)
 (local $*pkg_name/1/284 i32)
 (local $*pkg_name/2/284 i32)
 (local $*p/408 i32)
 (local $*p/411 i32)
 (local $*p/414 i32)
 (local $*p/417 i32)
 (local $*p/420 i32)
 (local $*p/423 i32)
 (local $*p/426 i32)
 (local $*p/429 i32)
 (local $*p/432 i32)
 (local $*bind/0/755 i32)
 (local $*bind/1/755 i32)
 (local $*bind/0/756 i32)
 (local $*bind/1/756 i32)
 (local $filename/0/757 i32)
 (local $filename/1/757 i32)
 (local $filename/2/757 i32)
 (local $start_line/0/758 i32)
 (local $start_line/1/758 i32)
 (local $start_line/2/758 i32)
 (local $start_column/0/759 i32)
 (local $start_column/1/759 i32)
 (local $start_column/2/759 i32)
 (local $end_line/0/760 i32)
 (local $end_line/1/760 i32)
 (local $end_line/2/760 i32)
 (local $end_column/0/761 i32)
 (local $end_column/1/761 i32)
 (local $end_column/2/761 i32)
 (local $Some/762 i32)
 (local $*tmp/763 i64)
 (local $*tmp/764 i64)
 (local $*tmp/765 i32)
 (local $*ok/0/766 i32)
 (local $*ok/1/766 i32)
 (local $*ok/2/766 i32)
 (local $*err/767 i32)
 (local $*tmp/768 i64)
 (local $*tmp/769 i64)
 (local $*tmp/770 i32)
 (local $*tmp/771 i32)
 (local $*tmp/772 i32)
 (local $*ok/0/773 i32)
 (local $*ok/1/773 i32)
 (local $*ok/2/773 i32)
 (local $*err/774 i32)
 (local $None/775 i32)
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
 (local $end/795 i32)
 (local $start/796 i32)
 (local $*field/0/801 i32)
 (local $*field/1/801 i32)
 (local $*field/2/801 i32)
 (local $*field/0/802 i32)
 (local $*field/1/802 i32)
 (local $*field/2/802 i32)
 (local $*field/0/803 i32)
 (local $*field/1/803 i32)
 (local $*field/2/803 i32)
 (local $*field/0/804 i32)
 (local $*field/1/804 i32)
 (local $*field/2/804 i32)
 (local $*field/0/805 i32)
 (local $*field/1/805 i32)
 (local $*field/2/805 i32)
 (local $*field/0/806 i32)
 (local $*field/1/806 i32)
 (local $*field/2/806 i32)
 (local $*field/807 i32)
 (local $*field/0/808 i32)
 (local $*field/1/808 i32)
 (local $*field/2/808 i32)
 (local $*field/809 i32)
 (local $*field/0/810 i32)
 (local $*field/1/810 i32)
 (local $*field/2/810 i32)
 (local $*cnt/829 i32)
 (local $*new_cnt/830 i32)
 (local $*cnt/831 i32)
 (local $*new_cnt/832 i32)
 (local $*cnt/833 i32)
 (local $*field/0/834 i32)
 (local $*field/1/834 i32)
 (local $*field/2/834 i32)
 (local $*field/0/835 i32)
 (local $*field/1/835 i32)
 (local $*field/2/835 i32)
 (local $*field/0/836 i32)
 (local $*field/1/836 i32)
 (local $*field/2/836 i32)
 (local $*field/0/837 i32)
 (local $*field/1/837 i32)
 (local $*field/2/837 i32)
 (local $*field/0/838 i32)
 (local $*field/1/838 i32)
 (local $*field/2/838 i32)
 (local $*new_cnt/839 i32)
 (local $*tag/840 i32)
 (local $ptr/845 i32)
 (local $ptr/846 i32)
 (local $ptr/847 i32)
 (local $*obj/0/849 i32)
 (local $*obj/1/849 i32)
 (local $*obj/2/849 i32)
 (local $*obj/0/851 i32)
 (local $*obj/1/851 i32)
 (local $*obj/2/851 i32)
 (local $*cursor/253 i32)
 (local $accept_state/254 i32)
 (local $match_end/255 i32)
 (local $match_tag_saver_0/256 i32)
 (local $tag_0/257 i32)
 (i32.load offset=56
  (local.get $self/249))
 (i32.load offset=8
  (local.get $self/249))
 (local.set $*field/2/810
  (i32.load offset=12
   (local.get $self/249)))
 (local.set $*field/1/810)
 (local.tee $*field/0/810)
 (local.get $*field/1/810)
 (local.set $pkg/2/248
  (local.get $*field/2/810))
 (local.set $pkg/1/248)
 (local.tee $pkg/0/248)
 (local.tee $*field/809)
 (local.set $*data/250)
 (local.set $*start/251
  (local.get $pkg/1/248))
 (local.set $end/795
  (local.get $pkg/2/248))
 (local.set $start/796
  (local.get $pkg/1/248))
 (local.set $*tmp/794
  (i32.sub
   (local.get $end/795)
   (local.get $start/796)))
 (local.set $*end/252
  (i32.add
   (local.get $*start/251)
   (local.get $*tmp/794)))
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
 (block $outer/841 (result i32)
  (block $join:259
   (call $moonbit.incref
    (local.get $*data/250))
   (call $moonbit.incref
    (local.get $pkg/0/248))
   (loop $loop:267 (result i32)
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/776
       (local.get $*cursor/253))
      (local.get $*end/252))
     (then
      (block $outer/842 (result i32)
       (block $join:266
        (local.set $*p/408
         (local.get $*cursor/253))
        (local.set $next_char/268
         (i32.load16_u offset=8
          (i32.add
           (local.get $*data/250)
           (i32.shl
            (local.get $*p/408)
            (i32.const 1)))))
        (local.set $*cursor/253
         (i32.add
          (local.tee $*tmp/777
           (local.get $*cursor/253))
          (i32.const 1)))
        (if (result i32)
         (i32.lt_s
          (local.get $next_char/268)
          (i32.const 55296))
         (then
          (if (result i32)
           (i32.lt_s
            (local.get $next_char/268)
            (i32.const 47))
           (then
            (br $join:266))
           (else
            (if (result i32)
             (i32.gt_s
              (local.get $next_char/268)
              (i32.const 47))
             (then
              (br $join:266))
             (else
              (loop $loop:270 (result i32)
               (local.set $tag_0/257
                (local.get $*cursor/253))
               (if (result i32)
                (i32.lt_s
                 (local.tee $*tmp/778
                  (local.get $*cursor/253))
                 (local.get $*end/252))
                (then
                 (block $outer/843 (result i32)
                  (block $join:269
                   (local.set $*p/411
                    (local.get $*cursor/253))
                   (local.set $next_char/271
                    (i32.load16_u offset=8
                     (i32.add
                      (local.get $*data/250)
                      (i32.shl
                       (local.get $*p/411)
                       (i32.const 1)))))
                   (local.set $*cursor/253
                    (i32.add
                     (local.tee $*tmp/779
                      (local.get $*cursor/253))
                     (i32.const 1)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/271)
                     (i32.const 55296))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/271)
                       (i32.const 47))
                      (then
                       (br $join:269))
                      (else
                       (if (result i32)
                        (i32.gt_s
                         (local.get $next_char/271)
                         (i32.const 47))
                        (then
                         (br $join:269))
                        (else
                         (loop $loop:273 (result i32)
                          (if (result i32)
                           (i32.lt_s
                            (local.tee $*tmp/780
                             (local.get $*cursor/253))
                            (local.get $*end/252))
                           (then
                            (block $outer/844 (result i32)
                             (block $join:272
                              (local.set $*p/414
                               (local.get $*cursor/253))
                              (local.set $next_char/274
                               (i32.load16_u offset=8
                                (i32.add
                                 (local.get $*data/250)
                                 (i32.shl
                                  (local.get $*p/414)
                                  (i32.const 1)))))
                              (local.set $*cursor/253
                               (i32.add
                                (local.tee $*tmp/781
                                 (local.get $*cursor/253))
                                (i32.const 1)))
                              (if (result i32)
                               (i32.lt_s
                                (local.get $next_char/274)
                                (i32.const 56319))
                               (then
                                (if (result i32)
                                 (i32.lt_s
                                  (local.get $next_char/274)
                                  (i32.const 55296))
                                 (then
                                  (br $join:272))
                                 (else
                                  (if (result i32)
                                   (i32.lt_s
                                    (local.tee $*tmp/782
                                     (local.get $*cursor/253))
                                    (local.get $*end/252))
                                   (then
                                    (local.set $*p/417
                                     (local.get $*cursor/253))
                                    (local.set $next_char/275
                                     (i32.load16_u offset=8
                                      (i32.add
                                       (local.get $*data/250)
                                       (i32.shl
                                        (local.get $*p/417)
                                        (i32.const 1)))))
                                    (local.set $*cursor/253
                                     (i32.add
                                      (local.tee $*tmp/783
                                       (local.get $*cursor/253))
                                      (i32.const 1)))
                                    (if (result i32)
                                     (i32.lt_s
                                      (local.get $next_char/275)
                                      (i32.const 56320))
                                     (then
                                      (br $join:259))
                                     (else
                                      (if (result i32)
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
                                (if (result i32)
                                 (i32.gt_s
                                  (local.get $next_char/274)
                                  (i32.const 56319))
                                 (then
                                  (if (result i32)
                                   (i32.lt_s
                                    (local.get $next_char/274)
                                    (i32.const 65536))
                                   (then
                                    (br $join:272))
                                   (else
                                    (br $join:259))))
                                 (else
                                  (if (result i32)
                                   (i32.lt_s
                                    (local.tee $*tmp/784
                                     (local.get $*cursor/253))
                                    (local.get $*end/252))
                                   (then
                                    (local.set $*p/420
                                     (local.get $*cursor/253))
                                    (local.set $next_char/276
                                     (i32.load16_u offset=8
                                      (i32.add
                                       (local.get $*data/250)
                                       (i32.shl
                                        (local.get $*p/420)
                                        (i32.const 1)))))
                                    (local.set $*cursor/253
                                     (i32.add
                                      (local.tee $*tmp/785
                                       (local.get $*cursor/253))
                                      (i32.const 1)))
                                    (if (result i32)
                                     (i32.lt_s
                                      (local.get $next_char/276)
                                      (i32.const 56320))
                                     (then
                                      (br $join:259))
                                     (else
                                      (if (result i32)
                                       (i32.gt_s
                                        (local.get $next_char/276)
                                        (i32.const 57343))
                                       (then
                                        (br $join:259))
                                       (else
                                        (br $loop:273))))))
                                   (else
                                    (br $join:259)))))))
                              (br $outer/844))
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
                     (if (result i32)
                      (i32.gt_s
                       (local.get $next_char/271)
                       (i32.const 56318))
                      (then
                       (if (result i32)
                        (i32.lt_s
                         (local.get $next_char/271)
                         (i32.const 57344))
                        (then
                         (if (result i32)
                          (i32.lt_s
                           (local.tee $*tmp/786
                            (local.get $*cursor/253))
                           (local.get $*end/252))
                          (then
                           (local.set $*p/423
                            (local.get $*cursor/253))
                           (local.set $next_char/277
                            (i32.load16_u offset=8
                             (i32.add
                              (local.get $*data/250)
                              (i32.shl
                               (local.get $*p/423)
                               (i32.const 1)))))
                           (local.set $*cursor/253
                            (i32.add
                             (local.tee $*tmp/787
                              (local.get $*cursor/253))
                             (i32.const 1)))
                           (if (result i32)
                            (i32.lt_s
                             (local.get $next_char/277)
                             (i32.const 56320))
                            (then
                             (br $join:259))
                            (else
                             (if (result i32)
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
                         (if (result i32)
                          (i32.gt_s
                           (local.get $next_char/271)
                           (i32.const 65535))
                          (then
                           (br $join:259))
                          (else
                           (br $join:269))))))
                      (else
                       (if (result i32)
                        (i32.lt_s
                         (local.tee $*tmp/788
                          (local.get $*cursor/253))
                         (local.get $*end/252))
                        (then
                         (local.set $*p/426
                          (local.get $*cursor/253))
                         (local.set $next_char/278
                          (i32.load16_u offset=8
                           (i32.add
                            (local.get $*data/250)
                            (i32.shl
                             (local.get $*p/426)
                             (i32.const 1)))))
                         (local.set $*cursor/253
                          (i32.add
                           (local.tee $*tmp/789
                            (local.get $*cursor/253))
                           (i32.const 1)))
                         (if (result i32)
                          (i32.lt_s
                           (local.get $next_char/278)
                           (i32.const 56320))
                          (then
                           (br $join:259))
                          (else
                           (if (result i32)
                            (i32.gt_s
                             (local.get $next_char/278)
                             (i32.const 65535))
                            (then
                             (br $join:259))
                            (else
                             (br $loop:270))))))
                        (else
                         (br $join:259)))))))
                   (br $outer/843))
                  (br $loop:270)))
                (else
                 (br $join:259)))))))))
         (else
          (if (result i32)
           (i32.gt_s
            (local.get $next_char/268)
            (i32.const 56318))
           (then
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/268)
              (i32.const 57344))
             (then
              (if (result i32)
               (i32.lt_s
                (local.tee $*tmp/790
                 (local.get $*cursor/253))
                (local.get $*end/252))
               (then
                (local.set $*p/429
                 (local.get $*cursor/253))
                (local.set $next_char/279
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/250)
                   (i32.shl
                    (local.get $*p/429)
                    (i32.const 1)))))
                (local.set $*cursor/253
                 (i32.add
                  (local.tee $*tmp/791
                   (local.get $*cursor/253))
                  (i32.const 1)))
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/279)
                  (i32.const 56320))
                 (then
                  (br $join:259))
                 (else
                  (if (result i32)
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
              (if (result i32)
               (i32.gt_s
                (local.get $next_char/268)
                (i32.const 65535))
               (then
                (br $join:259))
               (else
                (br $join:266))))))
           (else
            (if (result i32)
             (i32.lt_s
              (local.tee $*tmp/792
               (local.get $*cursor/253))
              (local.get $*end/252))
             (then
              (local.set $*p/432
               (local.get $*cursor/253))
              (local.set $next_char/280
               (i32.load16_u offset=8
                (i32.add
                 (local.get $*data/250)
                 (i32.shl
                  (local.get $*p/432)
                  (i32.const 1)))))
              (local.set $*cursor/253
               (i32.add
                (local.tee $*tmp/793
                 (local.get $*cursor/253))
                (i32.const 1)))
              (if (result i32)
               (i32.lt_s
                (local.get $next_char/280)
                (i32.const 56320))
               (then
                (br $join:259))
               (else
                (if (result i32)
                 (i32.gt_s
                  (local.get $next_char/280)
                  (i32.const 65535))
                 (then
                  (br $join:259))
                 (else
                  (br $loop:267))))))
             (else
              (br $join:259)))))))
        (br $outer/842))
       (br $loop:267)))
     (else
      (br $join:259))))
   (br $outer/841))
  (if (result i32)
   (i32.eq
    (local.get $accept_state/254)
    (i32.const 0))
   (then
    (call $moonbit.decref
     (local.get $pkg/0/248))
    (block $outer/850 (result i32) (result i32) (result i32)
     (block $join:261
      (local.set $*tmp/768
       (i64.extend_i32_s
        (local.tee $*tmp/771
         (i32.add
          (local.tee $*tmp/772
           (local.get $match_tag_saver_0/256))
          (i32.const 1)))))
      (local.set $*tmp/769
       (i64.extend_i32_s
        (local.tee $*tmp/770
         (local.get $match_end/255))))
      (call $moonbit.incref
       (local.get $*data/250))
      (call $String::sub
       (local.get $*data/250)
       (local.get $*tmp/768)
       (local.get $*tmp/769))
      (local.set $*obj/2/851)
      (local.set $*obj/1/851)
      (local.set $*obj/0/851)
      (if (result i32) (result i32) (result i32)
       (then
        (local.get $*obj/0/851)
        (local.get $*obj/1/851)
        (local.set $*ok/2/773
         (local.get $*obj/2/851))
        (local.set $*ok/1/773)
        (local.tee $*ok/0/773)
        (local.get $*ok/1/773)
        (local.get $*ok/2/773))
       (else
        (local.set $*try_err/262
         (local.tee $*err/774
          (local.get $*obj/0/851)))
        (br $join:261)))
      (br $outer/850))
     (call $moonbit.decref
      (local.get $*try_err/262))
     (unreachable))
    (local.set $package_name/2/260)
    (local.set $package_name/1/260)
    (local.set $package_name/0/260)
    (block $outer/848 (result i32) (result i32) (result i32)
     (block $join:264
      (local.set $*tmp/763
       (i64.extend_i32_s
        (local.get $*start/251)))
      (local.set $*tmp/764
       (i64.extend_i32_s
        (local.tee $*tmp/765
         (local.get $match_tag_saver_0/256))))
      (call $String::sub
       (local.get $*data/250)
       (local.get $*tmp/763)
       (local.get $*tmp/764))
      (local.set $*obj/2/849)
      (local.set $*obj/1/849)
      (local.set $*obj/0/849)
      (if (result i32) (result i32) (result i32)
       (then
        (local.get $*obj/0/849)
        (local.get $*obj/1/849)
        (local.set $*ok/2/766
         (local.get $*obj/2/849))
        (local.set $*ok/1/766)
        (local.tee $*ok/0/766)
        (local.get $*ok/1/766)
        (local.get $*ok/2/766))
       (else
        (local.set $*try_err/265
         (local.tee $*err/767
          (local.get $*obj/0/849)))
        (br $join:264)))
      (br $outer/848))
     (call $moonbit.decref
      (local.get $*try_err/265))
     (unreachable))
    (local.set $module_name/2/263)
    (local.set $module_name/1/263)
    (local.set $module_name/0/263)
    (i32.store offset=4
     (local.tee $ptr/847
      (call $moonbit.gc.malloc
       (i32.const 12)))
     (i32.const 2097409))
    (i32.store offset=16
     (local.get $ptr/847)
     (local.get $package_name/0/260))
    (i32.store offset=8
     (local.get $ptr/847)
     (local.get $package_name/1/260))
    (i32.store offset=12
     (local.get $ptr/847)
     (local.get $package_name/2/260))
    (local.set $Some/762
     (local.get $ptr/847))
    (i32.store offset=4
     (local.tee $ptr/846
      (call $moonbit.gc.malloc
       (i32.const 16)))
     (i32.const 2097664))
    (i32.store offset=20
     (local.get $ptr/846)
     (local.get $Some/762))
    (i32.store offset=16
     (local.get $ptr/846)
     (local.get $module_name/0/263))
    (i32.store offset=8
     (local.get $ptr/846)
     (local.get $module_name/1/263))
    (i32.store offset=12
     (local.get $ptr/846)
     (local.get $module_name/2/263))
    (local.get $ptr/846))
   (else
    (call $moonbit.decref
     (local.get $*data/250))
    (local.set $None/775
     (i32.const 10000))
    (i32.store offset=4
     (local.tee $ptr/845
      (call $moonbit.gc.malloc
       (i32.const 16)))
     (i32.const 2097664))
    (i32.store offset=20
     (local.get $ptr/845)
     (local.get $None/775))
    (i32.store offset=16
     (local.get $ptr/845)
     (local.get $pkg/0/248))
    (i32.store offset=8
     (local.get $ptr/845)
     (local.get $pkg/1/248))
    (i32.store offset=12
     (local.get $ptr/845)
     (local.get $pkg/2/248))
    (local.get $ptr/845))))
 (local.tee $*bind/258)
 (i32.load offset=16)
 (i32.load offset=8
  (local.get $*bind/258))
 (local.set $*field/2/808
  (i32.load offset=12
   (local.get $*bind/258)))
 (local.set $*field/1/808)
 (local.tee $*field/0/808)
 (local.get $*field/1/808)
 (local.set $*module_name/2/281
  (local.get $*field/2/808))
 (local.set $*module_name/1/281)
 (local.set $*module_name/0/281)
 (local.set $*field/807
  (i32.load offset=20
   (local.get $*bind/258)))
 (if
  (i32.gt_s
   (local.tee $*cnt/829
    (i32.load
     (local.get $*bind/258)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/830
    (i32.sub
     (local.get $*cnt/829)
     (i32.const 1)))
   (i32.store
    (local.get $*bind/258)
    (local.get $*new_cnt/830))
   (call $moonbit.incref
    (local.get $*field/807))
   (call $moonbit.incref
    (local.get $*module_name/0/281)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/829)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*bind/258)))
    (else))))
 (if
  (i32.eq
   (local.tee $*tag/840
    (call $moonbit.get_tag
     (local.tee $*package_name/282
      (local.get $*field/807))))
   (i32.const 1))
  (then
   (i32.load offset=16
    (local.tee $*Some/283
     (local.get $*package_name/282)))
   (i32.load offset=8
    (local.get $*Some/283))
   (local.set $*field/2/806
    (i32.load offset=12
     (local.get $*Some/283)))
   (local.set $*field/1/806)
   (local.set $*field/0/806)
   (if
    (i32.gt_s
     (local.tee $*cnt/831
      (i32.load
       (local.get $*Some/283)))
     (i32.const 1))
    (then
     (local.set $*new_cnt/832
      (i32.sub
       (local.get $*cnt/831)
       (i32.const 1)))
     (i32.store
      (local.get $*Some/283)
      (local.get $*new_cnt/832))
     (call $moonbit.incref
      (local.get $*field/0/806)))
    (else
     (if
      (i32.eq
       (local.get $*cnt/831)
       (i32.const 1))
      (then
       (call $moonbit.free
        (local.get $*Some/283)))
      (else))))
   (local.get $*field/0/806)
   (local.get $*field/1/806)
   (local.set $*pkg_name/2/284
    (local.get $*field/2/806))
   (local.set $*pkg_name/1/284)
   (local.set $*pkg_name/0/284)
   (if
    (local.get $logger/1/285)
    (then
     (call $moonbit.incref
      (local.get $logger/1/285)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
     (local.get $logger/1/285)
     (local.get $*pkg_name/0/284)
     (local.get $*pkg_name/1/284)
     (local.get $*pkg_name/2/284)
     (i32.load offset=16
      (local.get $logger/0/285))))
   (local.get $logger/0/285)
   (local.set $*bind/1/755
    (local.get $logger/1/285))
   (local.set $*bind/0/755)
   (if
    (local.get $*bind/1/755)
    (then
     (call $moonbit.incref
      (local.get $*bind/1/755)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
     (local.get $*bind/1/755)
     (i32.const 47)
     (i32.load offset=20
      (local.get $*bind/0/755)))))
  (else
   (call $moonbit.decref
    (local.get $*package_name/282))))
 (i32.load offset=60
  (local.get $self/249))
 (i32.load offset=16
  (local.get $self/249))
 (local.set $*field/2/805
  (i32.load offset=20
   (local.get $self/249)))
 (local.set $*field/1/805)
 (local.tee $*field/0/805)
 (local.get $*field/1/805)
 (local.set $filename/2/757
  (local.get $*field/2/805))
 (local.set $filename/1/757)
 (local.tee $filename/0/757)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/285)
   (local.get $filename/0/757)
   (local.get $filename/1/757)
   (local.get $filename/2/757)
   (i32.load offset=16
    (local.get $logger/0/285))))
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/285)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/285))))
 (i32.load offset=64
  (local.get $self/249))
 (i32.load offset=24
  (local.get $self/249))
 (local.set $*field/2/804
  (i32.load offset=28
   (local.get $self/249)))
 (local.set $*field/1/804)
 (local.tee $*field/0/804)
 (local.get $*field/1/804)
 (local.set $start_line/2/758
  (local.get $*field/2/804))
 (local.set $start_line/1/758)
 (local.tee $start_line/0/758)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/285)
   (local.get $start_line/0/758)
   (local.get $start_line/1/758)
   (local.get $start_line/2/758)
   (i32.load offset=16
    (local.get $logger/0/285))))
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/285)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/285))))
 (i32.load offset=68
  (local.get $self/249))
 (i32.load offset=32
  (local.get $self/249))
 (local.set $*field/2/803
  (i32.load offset=36
   (local.get $self/249)))
 (local.set $*field/1/803)
 (local.tee $*field/0/803)
 (local.get $*field/1/803)
 (local.set $start_column/2/759
  (local.get $*field/2/803))
 (local.set $start_column/1/759)
 (local.tee $start_column/0/759)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/285)
   (local.get $start_column/0/759)
   (local.get $start_column/1/759)
   (local.get $start_column/2/759)
   (i32.load offset=16
    (local.get $logger/0/285))))
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/285)
   (i32.const 45)
   (i32.load offset=20
    (local.get $logger/0/285))))
 (i32.load offset=72
  (local.get $self/249))
 (i32.load offset=40
  (local.get $self/249))
 (local.set $*field/2/802
  (i32.load offset=44
   (local.get $self/249)))
 (local.set $*field/1/802)
 (local.tee $*field/0/802)
 (local.get $*field/1/802)
 (local.set $end_line/2/760
  (local.get $*field/2/802))
 (local.set $end_line/1/760)
 (local.tee $end_line/0/760)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/285)
   (local.get $end_line/0/760)
   (local.get $end_line/1/760)
   (local.get $end_line/2/760)
   (i32.load offset=16
    (local.get $logger/0/285))))
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/285)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/285))))
 (i32.load offset=76
  (local.get $self/249))
 (i32.load offset=48
  (local.get $self/249))
 (local.set $*field/2/801
  (i32.load offset=52
   (local.get $self/249)))
 (local.set $*field/1/801)
 (local.set $*field/0/801)
 (if
  (i32.gt_s
   (local.tee $*cnt/833
    (i32.load
     (local.get $self/249)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/839
    (i32.sub
     (local.get $*cnt/833)
     (i32.const 1)))
   (i32.store
    (local.get $self/249)
    (local.get $*new_cnt/839))
   (call $moonbit.incref
    (local.get $*field/0/801)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/833)
     (i32.const 1))
    (then
     (i32.load offset=72
      (local.get $self/249))
     (i32.load offset=40
      (local.get $self/249))
     (local.set $*field/2/838
      (i32.load offset=44
       (local.get $self/249)))
     (local.set $*field/1/838)
     (local.tee $*field/0/838)
     (call $moonbit.decref)
     (i32.load offset=68
      (local.get $self/249))
     (i32.load offset=32
      (local.get $self/249))
     (local.set $*field/2/837
      (i32.load offset=36
       (local.get $self/249)))
     (local.set $*field/1/837)
     (local.tee $*field/0/837)
     (call $moonbit.decref)
     (i32.load offset=64
      (local.get $self/249))
     (i32.load offset=24
      (local.get $self/249))
     (local.set $*field/2/836
      (i32.load offset=28
       (local.get $self/249)))
     (local.set $*field/1/836)
     (local.tee $*field/0/836)
     (call $moonbit.decref)
     (i32.load offset=60
      (local.get $self/249))
     (i32.load offset=16
      (local.get $self/249))
     (local.set $*field/2/835
      (i32.load offset=20
       (local.get $self/249)))
     (local.set $*field/1/835)
     (local.tee $*field/0/835)
     (call $moonbit.decref)
     (i32.load offset=56
      (local.get $self/249))
     (i32.load offset=8
      (local.get $self/249))
     (local.set $*field/2/834
      (i32.load offset=12
       (local.get $self/249)))
     (local.set $*field/1/834)
     (local.tee $*field/0/834)
     (call $moonbit.decref)
     (call $moonbit.free
      (local.get $self/249)))
    (else))))
 (local.get $*field/0/801)
 (local.get $*field/1/801)
 (local.set $end_column/2/761
  (local.get $*field/2/801))
 (local.set $end_column/1/761)
 (local.set $end_column/0/761)
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/285)
   (local.get $end_column/0/761)
   (local.get $end_column/1/761)
   (local.get $end_column/2/761)
   (i32.load offset=16
    (local.get $logger/0/285))))
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/285)
   (i32.const 64)
   (i32.load offset=20
    (local.get $logger/0/285))))
 (local.get $logger/0/285)
 (local.set $*bind/1/756
  (local.get $logger/1/285))
 (local.set $*bind/0/756)
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
  (local.get $*bind/1/756)
  (local.get $*module_name/0/281)
  (local.get $*module_name/1/281)
  (local.get $*module_name/2/281)
  (i32.load offset=16
   (local.get $*bind/0/756))))
(func $moonbitlang/core/builtin.println|String| (param $input/247 i32) (result i32)
 (call $moonbit.println
  (local.get $input/247))
 (call $moonbit.decref
  (local.get $input/247))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/245 i32) (param $logger/0/244 i32) (param $logger/1/244 i32) (result i32)
 (local $*tmp/754 i32)
 (local.set $*tmp/754
  (call $Int::to_string.inner
   (local.get $self/245)
   (i32.const 10)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/244)
  (local.get $*tmp/754)
  (i32.load offset=8
   (local.get $logger/0/244))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/242 i32) (param $str/0/243 i32) (param $str/1/243 i32) (param $str/2/243 i32) (result i32)
 (local $*tmp/735 i32)
 (local $len/736 i32)
 (local $*tmp/737 i32)
 (local $*tmp/738 i32)
 (local $end/739 i32)
 (local $start/740 i32)
 (local $data/741 i32)
 (local $len/742 i32)
 (local $str/743 i32)
 (local $start/744 i32)
 (local $*tmp/745 i32)
 (local $end/746 i32)
 (local $start/747 i32)
 (local $*tmp/748 i32)
 (local $len/749 i32)
 (local $*tmp/750 i32)
 (local $*tmp/751 i32)
 (local $end/752 i32)
 (local $start/753 i32)
 (local $*field/811 i32)
 (local $*field/812 i32)
 (local $*field/813 i32)
 (local.set $len/736
  (i32.load offset=8
   (local.get $self/242)))
 (local.set $end/739
  (local.get $str/2/243))
 (local.set $start/740
  (local.get $str/1/243))
 (local.set $*tmp/737
  (i32.mul
   (local.tee $*tmp/738
    (i32.sub
     (local.get $end/739)
     (local.get $start/740)))
   (i32.const 2)))
 (local.set $*tmp/735
  (i32.add
   (local.get $len/736)
   (local.get $*tmp/737)))
 (call $moonbit.incref
  (local.get $self/242))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/242)
   (local.get $*tmp/735)))
 (local.set $data/741
  (local.tee $*field/813
   (i32.load offset=12
    (local.get $self/242))))
 (local.set $len/742
  (i32.load offset=8
   (local.get $self/242)))
 (local.set $str/743
  (local.tee $*field/812
   (local.get $str/0/243)))
 (local.set $start/744
  (local.get $str/1/243))
 (local.set $end/746
  (local.get $str/2/243))
 (local.set $start/747
  (local.get $str/1/243))
 (local.set $*tmp/745
  (i32.sub
   (local.get $end/746)
   (local.get $start/747)))
 (call $moonbit.incref
  (local.get $str/743))
 (call $moonbit.incref
  (local.get $data/741))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/741)
   (local.get $len/742)
   (local.get $str/743)
   (local.get $start/744)
   (local.get $*tmp/745)))
 (local.set $len/749
  (i32.load offset=8
   (local.get $self/242)))
 (local.set $end/752
  (local.get $str/2/243))
 (local.set $*field/811
  (local.get $str/1/243))
 (call $moonbit.decref
  (local.get $str/0/243))
 (local.set $start/753
  (local.get $*field/811))
 (local.set $*tmp/750
  (i32.mul
   (local.tee $*tmp/751
    (i32.sub
     (local.get $end/752)
     (local.get $start/753)))
   (i32.const 2)))
 (local.set $*tmp/748
  (i32.add
   (local.get $len/749)
   (local.get $*tmp/750)))
 (i32.store offset=8
  (local.get $self/242)
  (local.get $*tmp/748))
 (call $moonbit.decref
  (local.get $self/242))
 (i32.const 0))
(func $Int::to_string.inner (param $self/226 i32) (param $radix/225 i32) (result i32)
 (local $is_negative/227 i32)
 (local $num/228 i32)
 (local $buffer/229 i32)
 (local $digit_len/230 i32)
 (local $total_len/231 i32)
 (local $buffer/232 i32)
 (local $digit_start/233 i32)
 (local $digit_len/234 i32)
 (local $total_len/235 i32)
 (local $buffer/236 i32)
 (local $digit_start/237 i32)
 (local $digit_len/238 i32)
 (local $total_len/239 i32)
 (local $buffer/240 i32)
 (local $digit_start/241 i32)
 (local $*tmp/731 i32)
 (local $*tmp/732 i32)
 (local $*tmp/733 i32)
 (local $*tmp/734 i32)
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
     (i32.const 10152)
     (i32.const 10032))))
  (else))
 (if
  (i32.eq
   (local.get $self/226)
   (i32.const 0))
  (then
   (i32.const 10016)
   (return))
  (else))
 (local.set $num/228
  (if (result i32)
   (local.tee $is_negative/227
    (i32.lt_s
     (local.get $self/226)
     (i32.const 0)))
   (then
    (local.tee $*tmp/734
     (i32.sub
      (i32.const 0)
      (local.get $self/226))))
   (else
    (local.get $self/226))))
 (local.set $buffer/229
  (if (result i32)
   (i32.eq
    (local.get $radix/225)
    (i32.const 10))
   (then
    (local.set $digit_len/230
     (call $moonbitlang/core/builtin.dec_count32
      (local.get $num/228)))
    (local.set $*tmp/731
     (if (result i32)
      (local.get $is_negative/227)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (local.set $buffer/232
     (call $moonbit.int16_array_make
      (local.tee $total_len/231
       (i32.add
        (local.get $digit_len/230)
        (local.get $*tmp/731)))
      (i32.const 0)))
    (local.set $digit_start/233
     (if (result i32)
      (local.get $is_negative/227)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (call $moonbit.incref
     (local.get $buffer/232))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/232)
      (local.get $num/228)
      (local.get $digit_start/233)
      (local.get $total_len/231)))
    (local.get $buffer/232))
   (else
    (if (result i32)
     (i32.eq
      (local.get $radix/225)
      (i32.const 16))
     (then
      (local.set $digit_len/234
       (call $moonbitlang/core/builtin.hex_count32
        (local.get $num/228)))
      (local.set $*tmp/732
       (if (result i32)
        (local.get $is_negative/227)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/236
       (call $moonbit.int16_array_make
        (local.tee $total_len/235
         (i32.add
          (local.get $digit_len/234)
          (local.get $*tmp/732)))
        (i32.const 0)))
      (local.set $digit_start/237
       (if (result i32)
        (local.get $is_negative/227)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/236))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/236)
        (local.get $num/228)
        (local.get $digit_start/237)
        (local.get $total_len/235)))
      (local.get $buffer/236))
     (else
      (local.set $digit_len/238
       (call $moonbitlang/core/builtin.radix_count32
        (local.get $num/228)
        (local.get $radix/225)))
      (local.set $*tmp/733
       (if (result i32)
        (local.get $is_negative/227)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/240
       (call $moonbit.int16_array_make
        (local.tee $total_len/239
         (i32.add
          (local.get $digit_len/238)
          (local.get $*tmp/733)))
        (i32.const 0)))
      (local.set $digit_start/241
       (if (result i32)
        (local.get $is_negative/227)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/240))
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
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/229)
     (i32.shl
      (i32.const 0)
      (i32.const 1)))
    (i32.const 45)))
  (else))
 (local.get $buffer/229))
(func $moonbitlang/core/builtin.radix_count32 (param $value/219 i32) (param $radix/222 i32) (result i32)
 (local $base/221 i32)
 (local $*tmp/728 i32)
 (local $*tmp/729 i32)
 (local $*tmp/730 i32)
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
    (local.tee $*tmp/728
     (local.get $num/220))
    (i32.const 0))
   (then
    (local.set $count/223
     (i32.add
      (local.tee $*tmp/729
       (local.get $count/223))
      (i32.const 1)))
    (local.set $num/220
     (i32.div_u
      (local.tee $*tmp/730
       (local.get $num/220))
      (local.get $base/221)))
    (br $loop:224))
   (else)))
 (local.get $count/223))
(func $moonbitlang/core/builtin.hex_count32 (param $value/217 i32) (result i32)
 (local $leading_zeros/218 i32)
 (local $*tmp/726 i32)
 (local $*tmp/727 i32)
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
    (local.tee $*tmp/726
     (i32.div_s
      (local.tee $*tmp/727
       (i32.sub
        (i32.const 31)
        (local.get $leading_zeros/218)))
      (i32.const 4)))
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
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/206 i32) (param $num/194 i32) (param $digit_start/197 i32) (param $total_len/196 i32) (result i32)
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
 (local $*tmp/669 i32)
 (local $*tmp/670 i32)
 (local $*tmp/671 i32)
 (local $*tmp/672 i32)
 (local $*tmp/673 i32)
 (local $*tmp/674 i32)
 (local $*tmp/675 i32)
 (local $*tmp/676 i32)
 (local $*tmp/677 i32)
 (local $*tmp/678 i32)
 (local $*tmp/679 i32)
 (local $*tmp/680 i32)
 (local $*tmp/681 i32)
 (local $*tmp/682 i32)
 (local $*tmp/683 i32)
 (local $*tmp/684 i32)
 (local $*tmp/685 i32)
 (local $*tmp/686 i32)
 (local $*tmp/687 i32)
 (local $*tmp/688 i32)
 (local $*tmp/689 i32)
 (local $*tmp/690 i32)
 (local $*tmp/691 i32)
 (local $*tmp/692 i32)
 (local $*tmp/693 i32)
 (local $*tmp/694 i32)
 (local $*tmp/695 i32)
 (local $*tmp/696 i32)
 (local $*tmp/697 i32)
 (local $*tmp/698 i32)
 (local $*tmp/699 i32)
 (local $*tmp/700 i32)
 (local $*tmp/701 i32)
 (local $*tmp/702 i32)
 (local $*tmp/703 i32)
 (local $*tmp/704 i32)
 (local $*tmp/705 i32)
 (local $*tmp/706 i32)
 (local $*tmp/707 i32)
 (local $*tmp/708 i32)
 (local $*tmp/709 i32)
 (local $*tmp/710 i32)
 (local $*tmp/711 i32)
 (local $*tmp/712 i32)
 (local $*tmp/713 i32)
 (local $*tmp/714 i32)
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
    (local.tee $*tmp/669
     (local.get $num/193))
    (i32.const 10000))
   (then
    (local.set $t/198
     (i32.div_u
      (local.tee $*tmp/692
       (local.get $num/193))
      (i32.const 10000)))
    (local.set $r/199
     (local.tee $*tmp/690
      (i32.rem_u
       (local.tee $*tmp/691
        (local.get $num/193))
       (i32.const 10000))))
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
      (local.tee $*tmp/670
       (local.get $offset/195))
      (i32.const 4)))
    (local.set $*tmp/689
     (i32.div_s
      (local.get $d1/200)
      (i32.const 10)))
    (local.set $d1_hi/202
     (i32.and
      (local.tee $*tmp/688
       (i32.add
        (i32.const 48)
        (local.get $*tmp/689)))
      (i32.const 65535)))
    (local.set $*tmp/687
     (i32.rem_s
      (local.get $d1/200)
      (i32.const 10)))
    (local.set $d1_lo/203
     (i32.and
      (local.tee $*tmp/686
       (i32.add
        (i32.const 48)
        (local.get $*tmp/687)))
      (i32.const 65535)))
    (local.set $*tmp/685
     (i32.div_s
      (local.get $d2/201)
      (i32.const 10)))
    (local.set $d2_hi/204
     (i32.and
      (local.tee $*tmp/684
       (i32.add
        (i32.const 48)
        (local.get $*tmp/685)))
      (i32.const 65535)))
    (local.set $*tmp/683
     (i32.rem_s
      (local.get $d2/201)
      (i32.const 10)))
    (local.set $d2_lo/205
     (i32.and
      (local.tee $*tmp/682
       (i32.add
        (i32.const 48)
        (local.get $*tmp/683)))
      (i32.const 65535)))
    (local.set $*tmp/672
     (local.get $offset/195))
    (local.set $*tmp/671
     (i32.add
      (local.get $digit_start/197)
      (local.get $*tmp/672)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/671)
       (i32.const 1)))
     (local.get $d1_hi/202))
    (local.set $*tmp/675
     (local.get $offset/195))
    (local.set $*tmp/673
     (i32.add
      (local.tee $*tmp/674
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/675)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/673)
       (i32.const 1)))
     (local.get $d1_lo/203))
    (local.set $*tmp/678
     (local.get $offset/195))
    (local.set $*tmp/676
     (i32.add
      (local.tee $*tmp/677
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/678)))
      (i32.const 2)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/676)
       (i32.const 1)))
     (local.get $d2_hi/204))
    (local.set $*tmp/681
     (local.get $offset/195))
    (local.set $*tmp/679
     (i32.add
      (local.tee $*tmp/680
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/681)))
      (i32.const 3)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/679)
       (i32.const 1)))
     (local.get $d2_lo/205))
    (br $loop:207))
   (else)))
 (local.set $remaining/208
  (local.tee $*tmp/725
   (local.get $num/193)))
 (loop $loop:213
  (if
   (i32.ge_s
    (local.tee $*tmp/693
     (local.get $remaining/208))
    (i32.const 100))
   (then
    (local.set $t/209
     (i32.div_s
      (local.tee $*tmp/705
       (local.get $remaining/208))
      (i32.const 100)))
    (local.set $d/210
     (i32.rem_s
      (local.tee $*tmp/704
       (local.get $remaining/208))
      (i32.const 100)))
    (local.set $remaining/208
     (local.get $t/209))
    (local.set $offset/195
     (i32.sub
      (local.tee $*tmp/694
       (local.get $offset/195))
      (i32.const 2)))
    (local.set $*tmp/703
     (i32.div_s
      (local.get $d/210)
      (i32.const 10)))
    (local.set $d_hi/211
     (i32.and
      (local.tee $*tmp/702
       (i32.add
        (i32.const 48)
        (local.get $*tmp/703)))
      (i32.const 65535)))
    (local.set $*tmp/701
     (i32.rem_s
      (local.get $d/210)
      (i32.const 10)))
    (local.set $d_lo/212
     (i32.and
      (local.tee $*tmp/700
       (i32.add
        (i32.const 48)
        (local.get $*tmp/701)))
      (i32.const 65535)))
    (local.set $*tmp/696
     (local.get $offset/195))
    (local.set $*tmp/695
     (i32.add
      (local.get $digit_start/197)
      (local.get $*tmp/696)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/695)
       (i32.const 1)))
     (local.get $d_hi/211))
    (local.set $*tmp/699
     (local.get $offset/195))
    (local.set $*tmp/697
     (i32.add
      (local.tee $*tmp/698
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/699)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/697)
       (i32.const 1)))
     (local.get $d_lo/212))
    (br $loop:213))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.tee $*tmp/706
    (local.get $remaining/208))
   (i32.const 10))
  (then
   (local.set $offset/195
    (i32.sub
     (local.tee $*tmp/707
      (local.get $offset/195))
     (i32.const 2)))
   (local.set $*tmp/717
    (i32.div_s
     (local.tee $*tmp/718
      (local.get $remaining/208))
     (i32.const 10)))
   (local.set $d_hi/214
    (i32.and
     (local.tee $*tmp/716
      (i32.add
       (i32.const 48)
       (local.get $*tmp/717)))
     (i32.const 65535)))
   (local.set $*tmp/714
    (i32.rem_s
     (local.tee $*tmp/715
      (local.get $remaining/208))
     (i32.const 10)))
   (local.set $d_lo/215
    (i32.and
     (local.tee $*tmp/713
      (i32.add
       (i32.const 48)
       (local.get $*tmp/714)))
     (i32.const 65535)))
   (local.set $*tmp/709
    (local.get $offset/195))
   (local.set $*tmp/708
    (i32.add
     (local.get $digit_start/197)
     (local.get $*tmp/709)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/206)
     (i32.shl
      (local.get $*tmp/708)
      (i32.const 1)))
    (local.get $d_hi/214))
   (local.set $*tmp/712
    (local.get $offset/195))
   (local.set $*tmp/710
    (i32.add
     (local.tee $*tmp/711
      (i32.add
       (local.get $digit_start/197)
       (local.get $*tmp/712)))
     (i32.const 1)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/206)
     (i32.shl
      (local.get $*tmp/710)
      (i32.const 1)))
    (local.get $d_lo/215))
   (call $moonbit.decref
    (local.get $buffer/206))
   (i32.const 0))
  (else
   (local.set $*tmp/724
    (local.tee $offset/195
     (i32.sub
      (local.tee $*tmp/719
       (local.get $offset/195))
      (i32.const 1))))
   (local.set $*tmp/720
    (i32.add
     (local.get $digit_start/197)
     (local.get $*tmp/724)))
   (local.set $*tmp/723
    (local.get $remaining/208))
   (local.set $*tmp/721
    (i32.and
     (local.tee $*tmp/722
      (i32.add
       (i32.const 48)
       (local.get $*tmp/723)))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/206)
     (i32.shl
      (local.get $*tmp/720)
      (i32.const 1)))
    (local.get $*tmp/721))
   (call $moonbit.decref
    (local.get $buffer/206))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/188 i32) (param $num/182 i32) (param $digit_start/180 i32) (param $total_len/179 i32) (param $radix/184 i32) (result i32)
 (local $base/183 i32)
 (local $shift/185 i32)
 (local $mask/186 i32)
 (local $digit/187 i32)
 (local $q/190 i32)
 (local $digit/191 i32)
 (local $*tmp/648 i32)
 (local $*tmp/649 i32)
 (local $*tmp/650 i32)
 (local $*tmp/651 i32)
 (local $*tmp/652 i32)
 (local $*tmp/653 i32)
 (local $*tmp/654 i32)
 (local $*tmp/655 i32)
 (local $*tmp/656 i32)
 (local $*tmp/657 i32)
 (local $*tmp/658 i32)
 (local $*tmp/659 i32)
 (local $*tmp/660 i32)
 (local $*tmp/661 i32)
 (local $*tmp/662 i32)
 (local $*tmp/663 i32)
 (local $*tmp/664 i32)
 (local $*tmp/665 i32)
 (local $*tmp/666 i32)
 (local $*tmp/667 i32)
 (local $*tmp/668 i32)
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
 (local.set $*tmp/649
  (i32.sub
   (local.get $radix/184)
   (i32.const 1)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/648
    (i32.and
     (local.get $radix/184)
     (local.get $*tmp/649)))
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
      (local.tee $*tmp/650
       (local.get $n/181))
      (i32.const 0))
     (then
      (local.set $offset/178
       (i32.sub
        (local.tee $*tmp/651
         (local.get $offset/178))
        (i32.const 1)))
      (local.set $digit/187
       (local.tee $*tmp/657
        (i32.and
         (local.tee $*tmp/658
          (local.get $n/181))
         (local.get $mask/186))))
      (local.set $*tmp/655
       (local.get $offset/178))
      (local.set $*tmp/652
       (i32.add
        (local.get $digit_start/180)
        (local.get $*tmp/655)))
      (local.set $*tmp/653
       (i32.and
        (local.tee $*tmp/654
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10224)
           (i32.shl
            (local.get $digit/187)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/188)
        (i32.shl
         (local.get $*tmp/652)
         (i32.const 1)))
       (local.get $*tmp/653))
      (local.set $n/181
       (i32.shr_u
        (local.tee $*tmp/656
         (local.get $n/181))
        (local.get $shift/185)))
      (br $loop:189))
     (else
      (call $moonbit.decref
       (local.get $buffer/188)))))
   (i32.const 0))
  (else
   (loop $loop:192
    (if
     (i32.gt_u
      (local.tee $*tmp/659
       (local.get $n/181))
      (i32.const 0))
     (then
      (local.set $offset/178
       (i32.sub
        (local.tee $*tmp/660
         (local.get $offset/178))
        (i32.const 1)))
      (local.set $q/190
       (i32.div_u
        (local.tee $*tmp/668
         (local.get $n/181))
        (local.get $base/183)))
      (local.set $*tmp/666
       (local.get $n/181))
      (local.set $*tmp/667
       (i32.mul
        (local.get $q/190)
        (local.get $base/183)))
      (local.set $digit/191
       (local.tee $*tmp/665
        (i32.sub
         (local.get $*tmp/666)
         (local.get $*tmp/667))))
      (local.set $*tmp/664
       (local.get $offset/178))
      (local.set $*tmp/661
       (i32.add
        (local.get $digit_start/180)
        (local.get $*tmp/664)))
      (local.set $*tmp/662
       (i32.and
        (local.tee $*tmp/663
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10224)
           (i32.shl
            (local.get $digit/191)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/188)
        (i32.shl
         (local.get $*tmp/661)
         (i32.const 1)))
       (local.get $*tmp/662))
      (local.set $n/181
       (local.get $q/190))
      (br $loop:192))
     (else
      (call $moonbit.decref
       (local.get $buffer/188)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/175 i32) (param $num/171 i32) (param $digit_start/169 i32) (param $total_len/168 i32) (result i32)
 (local $byte_val/172 i32)
 (local $hi/173 i32)
 (local $lo/174 i32)
 (local $nibble/177 i32)
 (local $*tmp/629 i32)
 (local $*tmp/630 i32)
 (local $*tmp/631 i32)
 (local $*tmp/632 i32)
 (local $*tmp/633 i32)
 (local $*tmp/634 i32)
 (local $*tmp/635 i32)
 (local $*tmp/636 i32)
 (local $*tmp/637 i32)
 (local $*tmp/638 i32)
 (local $*tmp/639 i32)
 (local $*tmp/640 i32)
 (local $*tmp/641 i32)
 (local $*tmp/642 i32)
 (local $*tmp/643 i32)
 (local $*tmp/644 i32)
 (local $*tmp/645 i32)
 (local $*tmp/646 i32)
 (local $*tmp/647 i32)
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
    (local.tee $*tmp/629
     (local.get $offset/167))
    (i32.const 2))
   (then
    (local.set $offset/167
     (i32.sub
      (local.tee $*tmp/630
       (local.get $offset/167))
      (i32.const 2)))
    (local.set $hi/173
     (i32.div_s
      (local.tee $byte_val/172
       (local.tee $*tmp/641
        (i32.and
         (local.tee $*tmp/642
          (local.get $n/170))
         (i32.const 255))))
      (i32.const 16)))
    (local.set $lo/174
     (i32.rem_s
      (local.get $byte_val/172)
      (i32.const 16)))
    (local.set $*tmp/634
     (local.get $offset/167))
    (local.set $*tmp/631
     (i32.add
      (local.get $digit_start/169)
      (local.get $*tmp/634)))
    (local.set $*tmp/632
     (i32.and
      (local.tee $*tmp/633
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10224)
         (i32.shl
          (local.get $hi/173)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/175)
      (i32.shl
       (local.get $*tmp/631)
       (i32.const 1)))
     (local.get $*tmp/632))
    (local.set $*tmp/639
     (local.get $offset/167))
    (local.set $*tmp/635
     (i32.add
      (local.tee $*tmp/638
       (i32.add
        (local.get $digit_start/169)
        (local.get $*tmp/639)))
      (i32.const 1)))
    (local.set $*tmp/636
     (i32.and
      (local.tee $*tmp/637
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10224)
         (i32.shl
          (local.get $lo/174)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/175)
      (i32.shl
       (local.get $*tmp/635)
       (i32.const 1)))
     (local.get $*tmp/636))
    (local.set $n/170
     (i32.shr_u
      (local.tee $*tmp/640
       (local.get $n/170))
      (i32.const 8)))
    (br $loop:176))
   (else)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/643
    (local.get $offset/167))
   (i32.const 1))
  (then
   (local.set $nibble/177
    (local.tee $*tmp/646
     (i32.and
      (local.tee $*tmp/647
       (local.get $n/170))
      (i32.const 15))))
   (local.set $*tmp/644
    (i32.and
     (local.tee $*tmp/645
      (i32.load16_u offset=8
       (i32.add
        (i32.const 10224)
        (i32.shl
         (local.get $nibble/177)
         (i32.const 1)))))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/175)
     (i32.shl
      (local.get $digit_start/169)
      (i32.const 1)))
    (local.get $*tmp/644))
   (call $moonbit.decref
    (local.get $buffer/175))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $buffer/175))
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/166 i32) (result i32)
 (local $logger/165 i32)
 (local $*tmp/0/628 i32)
 (local $*tmp/1/628 i32)
 (call $moonbit.incref
  (local.tee $logger/165
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/628
  (local.get $logger/165))
 (local.set $*tmp/0/628)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/166)
   (local.get $*tmp/0/628)
   (local.get $*tmp/1/628)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/165)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/164 i32) (result i32)
 (local $logger/163 i32)
 (local $*tmp/0/627 i32)
 (local $*tmp/1/627 i32)
 (call $moonbit.incref
  (local.tee $logger/163
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/627
  (local.get $logger/163))
 (local.set $*tmp/0/627)
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/164)
   (local.get $*tmp/0/627)
   (local.get $*tmp/1/627)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/163)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/154 i32) (param $value/157 i32) (param $start/158 i32) (param $len/159 i32) (result i32)
 (local $*try_err/156 i32)
 (local $*tmp/0/620 i32)
 (local $*tmp/1/620 i32)
 (local $*tmp/2/620 i32)
 (local $*tmp/621 i64)
 (local $*tmp/622 i32)
 (local $*ok/0/623 i32)
 (local $*ok/1/623 i32)
 (local $*ok/2/623 i32)
 (local $*err/624 i32)
 (local $*obj/0/853 i32)
 (local $*obj/1/853 i32)
 (local $*obj/2/853 i32)
 (block $outer/852 (result i32) (result i32) (result i32)
  (block $join:155
   (local.set $*tmp/621
    (i64.extend_i32_s
     (local.tee $*tmp/622
      (i32.add
       (local.get $start/158)
       (local.get $len/159)))))
   (call $String::sub.inner
    (local.get $value/157)
    (local.get $start/158)
    (local.get $*tmp/621))
   (local.set $*obj/2/853)
   (local.set $*obj/1/853)
   (local.set $*obj/0/853)
   (if (result i32) (result i32) (result i32)
    (then
     (local.get $*obj/0/853)
     (local.get $*obj/1/853)
     (local.set $*ok/2/623
      (local.get $*obj/2/853))
     (local.set $*ok/1/623)
     (local.tee $*ok/0/623)
     (local.get $*ok/1/623)
     (local.get $*ok/2/623))
    (else
     (local.set $*try_err/156
      (local.tee $*err/624
       (local.get $*obj/0/853)))
     (br $join:155)))
   (br $outer/852))
  (call $moonbit.decref
   (local.get $*try_err/156))
  (unreachable))
 (local.set $*tmp/2/620)
 (local.set $*tmp/1/620)
 (local.set $*tmp/0/620)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.get $self/154)
  (local.get $*tmp/0/620)
  (local.get $*tmp/1/620)
  (local.get $*tmp/2/620)))
(func $String::sub (param $self/152 i32) (param $start.opt/150 i64) (param $end/153 i64) (result i32) (result i32) (result i32) (result i32)
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
(func $String::sub.inner (param $self/142 i32) (param $start/148 i32) (param $end/144 i64) (result i32) (result i32) (result i32) (result i32)
 (local $len/141 i32)
 (local $end/143 i32)
 (local $*Some/145 i64)
 (local $*end/146 i32)
 (local $start/147 i32)
 (local $*p/384 i32)
 (local $*p/387 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/616 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/617 i32)
 (local $*tmp/0/618 i32)
 (local $*tmp/1/618 i32)
 (local $*tmp/2/618 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/619 i32)
 (local.set $len/141
  (call $moonbit.array_length
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
 (if (result i32) (result i32) (result i32) (result i32)
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
      (local.set $*p/384
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/142)
         (i32.shl
          (local.get $start/147)
          (i32.const 1)))))
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
     (call $moonbit.decref
      (local.get $self/142))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/616
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/616)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $end/143)
      (local.get $len/141))
     (then
      (local.set $*p/387
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/142)
         (i32.shl
          (local.get $end/143)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/387))
       (then
        (i32.le_s
         (local.get $*p/387)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/142))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/617
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/617)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (local.get $self/142)
   (local.get $start/147)
   (local.set $*tmp/2/618
    (local.get $end/143))
   (local.set $*tmp/1/618)
   (local.set $*tmp/0/618)
   (i32.const 1)
   (local.get $*tmp/0/618)
   (local.get $*tmp/1/618)
   (local.get $*tmp/2/618))
  (else
   (call $moonbit.decref
    (local.get $self/142))
   (local.set $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/619
    (i32.const 10312))
   (i32.const 0)
   (local.get $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/619)
   (i32.const 0)
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/139 i32) (param $str/140 i32) (result i32)
 (local $*tmp/605 i32)
 (local $len/606 i32)
 (local $*tmp/607 i32)
 (local $*tmp/608 i32)
 (local $data/609 i32)
 (local $len/610 i32)
 (local $*tmp/611 i32)
 (local $*tmp/612 i32)
 (local $len/613 i32)
 (local $*tmp/614 i32)
 (local $*tmp/615 i32)
 (local $*tmp/817 i32)
 (local $*field/818 i32)
 (local.set $len/606
  (i32.load offset=8
   (local.get $self/139)))
 (local.set $*tmp/607
  (i32.mul
   (local.tee $*tmp/608
    (call $moonbit.array_length
     (local.get $str/140)))
   (i32.const 2)))
 (local.set $*tmp/605
  (i32.add
   (local.get $len/606)
   (local.get $*tmp/607)))
 (call $moonbit.incref
  (local.get $self/139))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/139)
   (local.get $*tmp/605)))
 (local.set $data/609
  (local.tee $*field/818
   (i32.load offset=12
    (local.get $self/139))))
 (local.set $len/610
  (i32.load offset=8
   (local.get $self/139)))
 (local.set $*tmp/611
  (call $moonbit.array_length
   (local.get $str/140)))
 (call $moonbit.incref
  (local.get $data/609))
 (call $moonbit.incref
  (local.get $str/140))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/609)
   (local.get $len/610)
   (local.get $str/140)
   (i32.const 0)
   (local.get $*tmp/611)))
 (local.set $len/613
  (i32.load offset=8
   (local.get $self/139)))
 (local.set $*tmp/817
  (call $moonbit.array_length
   (local.get $str/140)))
 (call $moonbit.decref
  (local.get $str/140))
 (local.set $*tmp/614
  (i32.mul
   (local.tee $*tmp/615
    (local.get $*tmp/817))
   (i32.const 2)))
 (local.set $*tmp/612
  (i32.add
   (local.get $len/613)
   (local.get $*tmp/614)))
 (i32.store offset=8
  (local.get $self/139)
  (local.get $*tmp/612))
 (call $moonbit.decref
  (local.get $self/139))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/131 i32) (param $bytes_offset/126 i32) (param $str/133 i32) (param $str_offset/129 i32) (param $length/127 i32) (result i32)
 (local $e1/125 i32)
 (local $e2/128 i32)
 (local $len1/130 i32)
 (local $len2/132 i32)
 (local $end_str_offset/134 i32)
 (local $i/135 i32)
 (local $j/136 i32)
 (local $c/137 i32)
 (local $*p/378 i32)
 (local $*p/381 i32)
 (local $*tmp/594 i32)
 (local $*tmp/595 i32)
 (local $*tmp/596 i32)
 (local $*tmp/597 i32)
 (local $*tmp/598 i32)
 (local $*tmp/599 i32)
 (local $*tmp/600 i32)
 (local $*tmp/601 i32)
 (local $*tmp/602 i32)
 (local $*tmp/603 i32)
 (local $*tmp/604 i32)
 (local $*arr/854 i32)
 (local $*idx/855 i32)
 (local $*arr/856 i32)
 (local $*idx/857 i32)
 (local.set $*tmp/604
  (i32.mul
   (local.get $length/127)
   (i32.const 2)))
 (local.set $e1/125
  (i32.sub
   (local.tee $*tmp/603
    (i32.add
     (local.get $bytes_offset/126)
     (local.get $*tmp/604)))
   (i32.const 1)))
 (local.set $e2/128
  (i32.sub
   (local.tee $*tmp/602
    (i32.add
     (local.get $str_offset/129)
     (local.get $length/127)))
   (i32.const 1)))
 (local.set $len1/130
  (call $moonbit.array_length
   (local.get $self/131)))
 (local.set $len2/132
  (call $moonbit.array_length
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
      (local.set $*tmp/594
       (i32.and
        (local.tee $*tmp/595
         (local.tee $*p/378
          (i32.and
           (local.tee $c/137
            (local.tee $*tmp/599
             (i32.load16_u offset=8
              (i32.add
               (local.get $str/133)
               (i32.shl
                (local.get $i/135)
                (i32.const 1))))))
           (i32.const 255))))
        (i32.const 255)))
      (local.get $self/131)
      (local.set $*idx/857
       (local.get $j/136))
      (local.set $*arr/856)
      (call $moonbit.check_range
       (local.get $*idx/857)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/856))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/856)
        (local.get $*idx/857))
       (local.get $*tmp/594))
      (local.set $*tmp/596
       (i32.add
        (local.get $j/136)
        (i32.const 1)))
      (local.set $*tmp/597
       (i32.and
        (local.tee $*tmp/598
         (local.tee $*p/381
          (i32.shr_u
           (local.get $c/137)
           (i32.const 8))))
        (i32.const 255)))
      (local.get $self/131)
      (local.set $*idx/855
       (local.get $*tmp/596))
      (local.set $*arr/854)
      (call $moonbit.check_range
       (local.get $*idx/855)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/854))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/854)
        (local.get $*idx/855))
       (local.get $*tmp/597))
      (local.set $*tmp/600
       (i32.add
        (local.get $i/135)
        (i32.const 1)))
      (local.set $*tmp/601
       (i32.add
        (local.get $j/136)
        (i32.const 2)))
      (local.get $*tmp/600)
      (local.get $*tmp/601)
      (br $loop:138))
     (else
      (call $moonbit.decref
       (local.get $str/133))
      (call $moonbit.decref
       (local.get $self/131)))))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $str/133))
   (call $moonbit.decref
    (local.get $self/131))
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/48 i32) (result i32)
 (local $*bind/0/47 i32)
 (local $*bind/1/47 i32)
 (local $*bind/2/47 i32)
 (local $*data/49 i32)
 (local $*start/50 i32)
 (local $*end/51 i32)
 (local $start_line/0/69 i32)
 (local $start_line/1/69 i32)
 (local $start_line/2/69 i32)
 (local $*try_err/71 i32)
 (local $start_column/0/72 i32)
 (local $start_column/1/72 i32)
 (local $start_column/2/72 i32)
 (local $*try_err/74 i32)
 (local $pkg/0/75 i32)
 (local $pkg/1/75 i32)
 (local $pkg/2/75 i32)
 (local $*try_err/77 i32)
 (local $filename/0/78 i32)
 (local $filename/1/78 i32)
 (local $filename/2/78 i32)
 (local $*try_err/80 i32)
 (local $end_line/0/81 i32)
 (local $end_line/1/81 i32)
 (local $end_line/2/81 i32)
 (local $*try_err/83 i32)
 (local $end_column/0/84 i32)
 (local $end_column/1/84 i32)
 (local $end_column/2/84 i32)
 (local $*try_err/86 i32)
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
 (local $*p/375 i32)
 (local $*tmp/513 i64)
 (local $*tmp/514 i64)
 (local $*tmp/515 i32)
 (local $*tmp/516 i32)
 (local $*tmp/517 i32)
 (local $*ok/0/518 i32)
 (local $*ok/1/518 i32)
 (local $*ok/2/518 i32)
 (local $*err/519 i32)
 (local $*tmp/520 i64)
 (local $*tmp/521 i64)
 (local $*tmp/522 i32)
 (local $*tmp/523 i32)
 (local $*tmp/524 i32)
 (local $*ok/0/525 i32)
 (local $*ok/1/525 i32)
 (local $*ok/2/525 i32)
 (local $*err/526 i32)
 (local $*tmp/527 i64)
 (local $*tmp/528 i64)
 (local $*tmp/529 i32)
 (local $*tmp/530 i32)
 (local $*tmp/531 i32)
 (local $*ok/0/532 i32)
 (local $*ok/1/532 i32)
 (local $*ok/2/532 i32)
 (local $*err/533 i32)
 (local $*tmp/534 i64)
 (local $*tmp/535 i64)
 (local $*tmp/536 i32)
 (local $*tmp/537 i32)
 (local $*ok/0/538 i32)
 (local $*ok/1/538 i32)
 (local $*ok/2/538 i32)
 (local $*err/539 i32)
 (local $*tmp/540 i64)
 (local $*tmp/541 i64)
 (local $*tmp/542 i32)
 (local $*tmp/543 i32)
 (local $*tmp/544 i32)
 (local $*ok/0/545 i32)
 (local $*ok/1/545 i32)
 (local $*ok/2/545 i32)
 (local $*err/546 i32)
 (local $*tmp/547 i64)
 (local $*tmp/548 i64)
 (local $*tmp/549 i32)
 (local $*tmp/550 i32)
 (local $*tmp/551 i32)
 (local $*ok/0/552 i32)
 (local $*ok/1/552 i32)
 (local $*ok/2/552 i32)
 (local $*err/553 i32)
 (local $*tmp/554 i32)
 (local $*tmp/555 i32)
 (local $*tmp/556 i32)
 (local $*tmp/557 i32)
 (local $*tmp/558 i32)
 (local $*tmp/559 i32)
 (local $*tmp/560 i32)
 (local $*tmp/561 i32)
 (local $*tmp/562 i32)
 (local $*tmp/563 i32)
 (local $*tmp/564 i32)
 (local $*tmp/565 i32)
 (local $*tmp/566 i32)
 (local $*tmp/567 i32)
 (local $*tmp/568 i32)
 (local $*tmp/569 i32)
 (local $*tmp/570 i32)
 (local $*tmp/571 i32)
 (local $*tmp/572 i32)
 (local $*tmp/573 i32)
 (local $*tmp/574 i32)
 (local $*tmp/575 i32)
 (local $*tmp/576 i32)
 (local $*tmp/577 i32)
 (local $*tmp/578 i32)
 (local $*tmp/579 i32)
 (local $*tmp/580 i32)
 (local $*tmp/581 i32)
 (local $*tmp/582 i32)
 (local $*tmp/583 i32)
 (local $*tmp/584 i32)
 (local $*tmp/585 i32)
 (local $*tmp/586 i32)
 (local $*tmp/587 i32)
 (local $*tmp/588 i32)
 (local $*tmp/589 i32)
 (local $*tmp/590 i32)
 (local $end/591 i32)
 (local $start/592 i32)
 (local $*tmp/593 i32)
 (local $*field/819 i32)
 (local $*field/820 i32)
 (local $ptr/884 i32)
 (local $*obj/0/886 i32)
 (local $*obj/1/886 i32)
 (local $*obj/2/886 i32)
 (local $*obj/0/888 i32)
 (local $*obj/1/888 i32)
 (local $*obj/2/888 i32)
 (local $*obj/0/890 i32)
 (local $*obj/1/890 i32)
 (local $*obj/2/890 i32)
 (local $*obj/0/892 i32)
 (local $*obj/1/892 i32)
 (local $*obj/2/892 i32)
 (local $*obj/0/894 i32)
 (local $*obj/1/894 i32)
 (local $*obj/2/894 i32)
 (local $*obj/0/896 i32)
 (local $*obj/1/896 i32)
 (local $*obj/2/896 i32)
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
 (local.set $*tmp/593
  (call $moonbit.array_length
   (local.get $repr/48)))
 (local.get $repr/48)
 (i32.const 0)
 (local.set $*bind/2/47
  (local.get $*tmp/593))
 (local.set $*bind/1/47)
 (local.tee $*bind/0/47)
 (local.tee $*field/820)
 (local.set $*data/49)
 (local.set $*start/50
  (local.get $*bind/1/47))
 (local.set $end/591
  (local.get $*bind/2/47))
 (local.set $start/592
  (local.tee $*field/819
   (local.get $*bind/1/47)))
 (local.set $*tmp/590
  (i32.sub
   (local.get $end/591)
   (local.get $start/592)))
 (local.set $*end/51
  (i32.add
   (local.get $*start/50)
   (local.get $*tmp/590)))
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
  (block $join:87
   (if (result i32)
    (i32.lt_s
     (local.tee $*tmp/580
      (local.get $*cursor/52))
     (local.get $*end/51))
    (then
     (local.set $*p/324
      (local.get $*cursor/52))
     (local.set $next_char/117
      (i32.load16_u offset=8
       (i32.add
        (local.get $*data/49)
        (i32.shl
         (local.get $*p/324)
         (i32.const 1)))))
     (local.set $*cursor/52
      (i32.add
       (local.tee $*tmp/581
        (local.get $*cursor/52))
       (i32.const 1)))
     (if (result i32)
      (i32.lt_s
       (local.get $next_char/117)
       (i32.const 65))
      (then
       (if (result i32)
        (i32.lt_s
         (local.get $next_char/117)
         (i32.const 64))
        (then
         (br $join:68))
        (else
         (loop $loop:119 (result i32)
          (local.set $tag_0/60
           (local.get $*cursor/52))
          (if (result i32)
           (i32.lt_s
            (local.tee $*tmp/582
             (local.get $*cursor/52))
            (local.get $*end/51))
           (then
            (block $outer/858 (result i32)
             (block $join:118
              (local.set $*p/327
               (local.get $*cursor/52))
              (local.set $next_char/120
               (i32.load16_u offset=8
                (i32.add
                 (local.get $*data/49)
                 (i32.shl
                  (local.get $*p/327)
                  (i32.const 1)))))
              (local.set $*cursor/52
               (i32.add
                (local.tee $*tmp/583
                 (local.get $*cursor/52))
                (i32.const 1)))
              (if (result i32)
               (i32.lt_s
                (local.get $next_char/120)
                (i32.const 55296))
               (then
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/120)
                  (i32.const 58))
                 (then
                  (br $join:118))
                 (else
                  (if (result i32)
                   (i32.gt_s
                    (local.get $next_char/120)
                    (i32.const 58))
                   (then
                    (br $join:118))
                   (else
                    (if (result i32)
                     (i32.lt_s
                      (local.tee $*tmp/584
                       (local.get $*cursor/52))
                      (local.get $*end/51))
                     (then
                      (block $outer/859 (result i32)
                       (block $join:121
                        (local.set $*p/330
                         (local.get $*cursor/52))
                        (local.set $next_char/122
                         (i32.load16_u offset=8
                          (i32.add
                           (local.get $*data/49)
                           (i32.shl
                            (local.get $*p/330)
                            (i32.const 1)))))
                        (local.set $*cursor/52
                         (i32.add
                          (local.tee $*tmp/585
                           (local.get $*cursor/52))
                          (i32.const 1)))
                        (if (result i32)
                         (i32.lt_s
                          (local.get $next_char/122)
                          (i32.const 56319))
                         (then
                          (if (result i32)
                           (i32.lt_s
                            (local.get $next_char/122)
                            (i32.const 55296))
                           (then
                            (br $join:121))
                           (else
                            (local.set $join_dispatch_19/88
                             (i32.const 7))
                            (br $join:87))))
                         (else
                          (if (result i32)
                           (i32.gt_s
                            (local.get $next_char/122)
                            (i32.const 56319))
                           (then
                            (if (result i32)
                             (i32.lt_s
                              (local.get $next_char/122)
                              (i32.const 65536))
                             (then
                              (br $join:121))
                             (else
                              (br $join:68))))
                           (else
                            (local.set $join_dispatch_19/88
                             (i32.const 8))
                            (br $join:87)))))
                        (br $outer/859))
                       (local.set $join_dispatch_19/88
                        (i32.const 0))
                       (br $join:87)))
                     (else
                      (br $join:68))))))))
               (else
                (if (result i32)
                 (i32.gt_s
                  (local.get $next_char/120)
                  (i32.const 56318))
                 (then
                  (if (result i32)
                   (i32.lt_s
                    (local.get $next_char/120)
                    (i32.const 57344))
                   (then
                    (if (result i32)
                     (i32.lt_s
                      (local.tee $*tmp/586
                       (local.get $*cursor/52))
                      (local.get $*end/51))
                     (then
                      (local.set $*p/333
                       (local.get $*cursor/52))
                      (local.set $next_char/123
                       (i32.load16_u offset=8
                        (i32.add
                         (local.get $*data/49)
                         (i32.shl
                          (local.get $*p/333)
                          (i32.const 1)))))
                      (local.set $*cursor/52
                       (i32.add
                        (local.tee $*tmp/587
                         (local.get $*cursor/52))
                        (i32.const 1)))
                      (if (result i32)
                       (i32.lt_s
                        (local.get $next_char/123)
                        (i32.const 56320))
                       (then
                        (br $join:68))
                       (else
                        (if (result i32)
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
                    (if (result i32)
                     (i32.gt_s
                      (local.get $next_char/120)
                      (i32.const 65535))
                     (then
                      (br $join:68))
                     (else
                      (br $join:118))))))
                 (else
                  (if (result i32)
                   (i32.lt_s
                    (local.tee $*tmp/588
                     (local.get $*cursor/52))
                    (local.get $*end/51))
                   (then
                    (local.set $*p/336
                     (local.get $*cursor/52))
                    (local.set $next_char/124
                     (i32.load16_u offset=8
                      (i32.add
                       (local.get $*data/49)
                       (i32.shl
                        (local.get $*p/336)
                        (i32.const 1)))))
                    (local.set $*cursor/52
                     (i32.add
                      (local.tee $*tmp/589
                       (local.get $*cursor/52))
                      (i32.const 1)))
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/124)
                      (i32.const 56320))
                     (then
                      (br $join:68))
                     (else
                      (if (result i32)
                       (i32.gt_s
                        (local.get $next_char/124)
                        (i32.const 65535))
                       (then
                        (br $join:68))
                       (else
                        (br $loop:119))))))
                   (else
                    (br $join:68)))))))
              (br $outer/858))
             (br $loop:119)))
           (else
            (br $join:68)))))))
      (else
       (br $join:68))))
    (else
     (br $join:68)))
   (return))
  (local.get $join_dispatch_19/88)
  (loop $loop:92 (param i32) (result i32)
   (local.set $dispatch_19/89)
   (block $outer/860 (result i32)
    (block $join:90
     (block $outer/861 (result i32)
      (block $join:94
       (block $switch_int/872 (result i32)
        (block $switch_default/873
         (block $switch_int_1/875
          (block $switch_int_7/881
           (block $switch_int_6/880
            (block $switch_int_5/879
             (block $switch_int_4/878
              (block $switch_int_8/882
               (block $switch_int_0/874
                (block $switch_int_2/876
                 (block $switch_int_3/877
                  (local.get $dispatch_19/89)
                  (br_table
                   $switch_int_0/874
                   $switch_int_1/875
                   $switch_int_2/876
                   $switch_int_3/877
                   $switch_int_4/878
                   $switch_int_5/879
                   $switch_int_6/880
                   $switch_int_7/881
                   $switch_int_8/882
                   $switch_default/873
                   ))
                 (local.set $tag_1_2/63
                  (local.get $tag_1_1/62))
                 (local.set $tag_1_1/62
                  (local.get $tag_1/61))
                 (local.set $tag_1/61
                  (local.get $*cursor/52))
                 (if (result i32)
                  (i32.lt_s
                   (local.tee $*tmp/556
                    (local.get $*cursor/52))
                   (local.get $*end/51))
                  (then
                   (block $outer/862 (result i32)
                    (block $join:95
                     (local.set $*p/339
                      (local.get $*cursor/52))
                     (local.set $next_char/96
                      (i32.load16_u offset=8
                       (i32.add
                        (local.get $*data/49)
                        (i32.shl
                         (local.get $*p/339)
                         (i32.const 1)))))
                     (local.set $*cursor/52
                      (i32.add
                       (local.tee $*tmp/557
                        (local.get $*cursor/52))
                       (i32.const 1)))
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/96)
                       (i32.const 55296))
                      (then
                       (if (result i32)
                        (i32.lt_s
                         (local.get $next_char/96)
                         (i32.const 58))
                        (then
                         (if (result i32)
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
                           (if (result i32)
                            (i32.lt_s
                             (local.tee $*tmp/558
                              (local.get $*cursor/52))
                             (local.get $*end/51))
                            (then
                             (block $outer/863 (result i32)
                              (block $join:97
                               (local.set $*p/342
                                (local.get $*cursor/52))
                               (local.set $next_char/98
                                (i32.load16_u offset=8
                                 (i32.add
                                  (local.get $*data/49)
                                  (i32.shl
                                   (local.get $*p/342)
                                   (i32.const 1)))))
                               (local.set $*cursor/52
                                (i32.add
                                 (local.tee $*tmp/559
                                  (local.get $*cursor/52))
                                 (i32.const 1)))
                               (if (result i32)
                                (i32.lt_s
                                 (local.get $next_char/98)
                                 (i32.const 59))
                                (then
                                 (if (result i32)
                                  (i32.lt_s
                                   (local.get $next_char/98)
                                   (i32.const 46))
                                  (then
                                   (if (result i32)
                                    (i32.lt_s
                                     (local.get $next_char/98)
                                     (i32.const 45))
                                    (then
                                     (br $join:97))
                                    (else
                                     (br $join:90))))
                                  (else
                                   (if (result i32)
                                    (i32.gt_s
                                     (local.get $next_char/98)
                                     (i32.const 47))
                                    (then
                                     (if (result i32)
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
                                 (if (result i32)
                                  (i32.gt_s
                                   (local.get $next_char/98)
                                   (i32.const 55295))
                                  (then
                                   (if (result i32)
                                    (i32.lt_s
                                     (local.get $next_char/98)
                                     (i32.const 57344))
                                    (then
                                     (if (result i32)
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
                                     (if (result i32)
                                      (i32.gt_s
                                       (local.get $next_char/98)
                                       (i32.const 65535))
                                      (then
                                       (br $join:68))
                                      (else
                                       (br $join:97))))))
                                  (else
                                   (br $join:97)))))
                               (br $outer/863))
                              (i32.const 0)
                              (br $loop:92)))
                            (else
                             (br $join:68))))))
                        (else
                         (if (result i32)
                          (i32.gt_s
                           (local.get $next_char/96)
                           (i32.const 58))
                          (then
                           (br $join:95))
                          (else
                           (i32.const 1)
                           (br $loop:92))))))
                      (else
                       (if (result i32)
                        (i32.gt_s
                         (local.get $next_char/96)
                         (i32.const 56318))
                        (then
                         (if (result i32)
                          (i32.lt_s
                           (local.get $next_char/96)
                           (i32.const 57344))
                          (then
                           (i32.const 8)
                           (br $loop:92))
                          (else
                           (if (result i32)
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
                     (br $outer/862))
                    (i32.const 0)
                    (br $loop:92)))
                  (else
                   (br $join:68)))
                 (br $switch_int/872))
                (local.set $tag_1/61
                 (local.get $*cursor/52))
                (local.set $tag_2/65
                 (local.get $*cursor/52))
                (if (result i32)
                 (i32.lt_s
                  (local.tee $*tmp/560
                   (local.get $*cursor/52))
                  (local.get $*end/51))
                 (then
                  (block $outer/864 (result i32)
                   (block $join:99
                    (local.set $*p/345
                     (local.get $*cursor/52))
                    (local.set $next_char/100
                     (i32.load16_u offset=8
                      (i32.add
                       (local.get $*data/49)
                       (i32.shl
                        (local.get $*p/345)
                        (i32.const 1)))))
                    (local.set $*cursor/52
                     (i32.add
                      (local.tee $*tmp/561
                       (local.get $*cursor/52))
                      (i32.const 1)))
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/100)
                      (i32.const 55296))
                     (then
                      (if (result i32)
                       (i32.lt_s
                        (local.get $next_char/100)
                        (i32.const 58))
                       (then
                        (if (result i32)
                         (i32.lt_s
                          (local.get $next_char/100)
                          (i32.const 48))
                         (then
                          (br $join:99))
                         (else
                          (i32.const 2)
                          (br $loop:92))))
                       (else
                        (if (result i32)
                         (i32.gt_s
                          (local.get $next_char/100)
                          (i32.const 58))
                         (then
                          (br $join:99))
                         (else
                          (i32.const 3)
                          (br $loop:92))))))
                     (else
                      (if (result i32)
                       (i32.gt_s
                        (local.get $next_char/100)
                        (i32.const 56318))
                       (then
                        (if (result i32)
                         (i32.lt_s
                          (local.get $next_char/100)
                          (i32.const 57344))
                         (then
                          (i32.const 8)
                          (br $loop:92))
                         (else
                          (if (result i32)
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
                    (br $outer/864))
                   (i32.const 0)
                   (br $loop:92)))
                 (else
                  (br $join:68)))
                (br $switch_int/872))
               (local.set $tag_1/61
                (local.get $*cursor/52))
               (if (result i32)
                (i32.lt_s
                 (local.tee $*tmp/562
                  (local.get $*cursor/52))
                 (local.get $*end/51))
                (then
                 (block $outer/865 (result i32)
                  (block $join:101
                   (local.set $*p/348
                    (local.get $*cursor/52))
                   (local.set $next_char/102
                    (i32.load16_u offset=8
                     (i32.add
                      (local.get $*data/49)
                      (i32.shl
                       (local.get $*p/348)
                       (i32.const 1)))))
                   (local.set $*cursor/52
                    (i32.add
                     (local.tee $*tmp/563
                      (local.get $*cursor/52))
                     (i32.const 1)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/102)
                     (i32.const 55296))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/102)
                       (i32.const 58))
                      (then
                       (br $join:101))
                      (else
                       (if (result i32)
                        (i32.gt_s
                         (local.get $next_char/102)
                         (i32.const 58))
                        (then
                         (br $join:101))
                        (else
                         (i32.const 1)
                         (br $loop:92))))))
                    (else
                     (if (result i32)
                      (i32.gt_s
                       (local.get $next_char/102)
                       (i32.const 56318))
                      (then
                       (if (result i32)
                        (i32.lt_s
                         (local.get $next_char/102)
                         (i32.const 57344))
                        (then
                         (i32.const 8)
                         (br $loop:92))
                        (else
                         (if (result i32)
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
                   (br $outer/865))
                  (i32.const 0)
                  (br $loop:92)))
                (else
                 (br $join:68)))
               (br $switch_int/872))
              (if (result i32)
               (i32.lt_s
                (local.tee $*tmp/564
                 (local.get $*cursor/52))
                (local.get $*end/51))
               (then
                (local.set $*p/351
                 (local.get $*cursor/52))
                (local.set $next_char/103
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/49)
                   (i32.shl
                    (local.get $*p/351)
                    (i32.const 1)))))
                (local.set $*cursor/52
                 (i32.add
                  (local.tee $*tmp/565
                   (local.get $*cursor/52))
                  (i32.const 1)))
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/103)
                  (i32.const 56320))
                 (then
                  (br $join:68))
                 (else
                  (if (result i32)
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
              (br $switch_int/872))
             (local.set $tag_1/61
              (local.get $*cursor/52))
             (local.set $tag_4/67
              (local.get $*cursor/52))
             (if (result i32)
              (i32.lt_s
               (local.tee $*tmp/566
                (local.get $*cursor/52))
               (local.get $*end/51))
              (then
               (block $outer/866 (result i32)
                (block $join:104
                 (local.set $*p/354
                  (local.get $*cursor/52))
                 (local.set $next_char/105
                  (i32.load16_u offset=8
                   (i32.add
                    (local.get $*data/49)
                    (i32.shl
                     (local.get $*p/354)
                     (i32.const 1)))))
                 (local.set $*cursor/52
                  (i32.add
                   (local.tee $*tmp/567
                    (local.get $*cursor/52))
                   (i32.const 1)))
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/105)
                   (i32.const 55296))
                  (then
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/105)
                     (i32.const 58))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/105)
                       (i32.const 48))
                      (then
                       (br $join:104))
                      (else
                       (i32.const 4)
                       (br $loop:92))))
                    (else
                     (if (result i32)
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
                       (if (result i32)
                        (i32.lt_s
                         (local.tee $*tmp/568
                          (local.get $*cursor/52))
                         (local.get $*end/51))
                        (then
                         (block $outer/867 (result i32)
                          (block $join:106
                           (local.set $*p/357
                            (local.get $*cursor/52))
                           (local.set $next_char/107
                            (i32.load16_u offset=8
                             (i32.add
                              (local.get $*data/49)
                              (i32.shl
                               (local.get $*p/357)
                               (i32.const 1)))))
                           (local.set $*cursor/52
                            (i32.add
                             (local.tee $*tmp/569
                              (local.get $*cursor/52))
                             (i32.const 1)))
                           (if (result i32)
                            (i32.lt_s
                             (local.get $next_char/107)
                             (i32.const 55296))
                            (then
                             (if (result i32)
                              (i32.lt_s
                               (local.get $next_char/107)
                               (i32.const 58))
                              (then
                               (if (result i32)
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
                                 (if (result i32)
                                  (i32.lt_s
                                   (local.tee $*tmp/570
                                    (local.get $*cursor/52))
                                   (local.get $*end/51))
                                  (then
                                   (block $outer/868 (result i32)
                                    (block $join:108
                                     (local.set $*p/360
                                      (local.get $*cursor/52))
                                     (local.set $next_char/109
                                      (i32.load16_u offset=8
                                       (i32.add
                                        (local.get $*data/49)
                                        (i32.shl
                                         (local.get $*p/360)
                                         (i32.const 1)))))
                                     (local.set $*cursor/52
                                      (i32.add
                                       (local.tee $*tmp/571
                                        (local.get $*cursor/52))
                                       (i32.const 1)))
                                     (if (result i32)
                                      (i32.lt_s
                                       (local.get $next_char/109)
                                       (i32.const 55296))
                                      (then
                                       (if (result i32)
                                        (i32.lt_s
                                         (local.get $next_char/109)
                                         (i32.const 58))
                                        (then
                                         (if (result i32)
                                          (i32.lt_s
                                           (local.get $next_char/109)
                                           (i32.const 48))
                                          (then
                                           (br $join:108))
                                          (else
                                           (i32.const 5)
                                           (br $loop:92))))
                                        (else
                                         (if (result i32)
                                          (i32.gt_s
                                           (local.get $next_char/109)
                                           (i32.const 58))
                                          (then
                                           (br $join:108))
                                          (else
                                           (i32.const 3)
                                           (br $loop:92))))))
                                      (else
                                       (if (result i32)
                                        (i32.gt_s
                                         (local.get $next_char/109)
                                         (i32.const 56318))
                                        (then
                                         (if (result i32)
                                          (i32.lt_s
                                           (local.get $next_char/109)
                                           (i32.const 57344))
                                          (then
                                           (i32.const 8)
                                           (br $loop:92))
                                          (else
                                           (if (result i32)
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
                                     (br $outer/868))
                                    (i32.const 0)
                                    (br $loop:92)))
                                  (else
                                   (br $join:94))))))
                              (else
                               (if (result i32)
                                (i32.gt_s
                                 (local.get $next_char/107)
                                 (i32.const 58))
                                (then
                                 (br $join:106))
                                (else
                                 (i32.const 1)
                                 (br $loop:92))))))
                            (else
                             (if (result i32)
                              (i32.gt_s
                               (local.get $next_char/107)
                               (i32.const 56318))
                              (then
                               (if (result i32)
                                (i32.lt_s
                                 (local.get $next_char/107)
                                 (i32.const 57344))
                                (then
                                 (i32.const 8)
                                 (br $loop:92))
                                (else
                                 (if (result i32)
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
                           (br $outer/867))
                          (i32.const 0)
                          (br $loop:92)))
                        (else
                         (br $join:68))))))))
                  (else
                   (if (result i32)
                    (i32.gt_s
                     (local.get $next_char/105)
                     (i32.const 56318))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/105)
                       (i32.const 57344))
                      (then
                       (i32.const 8)
                       (br $loop:92))
                      (else
                       (if (result i32)
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
                 (br $outer/866))
                (i32.const 0)
                (br $loop:92)))
              (else
               (br $join:68)))
             (br $switch_int/872))
            (local.set $tag_1/61
             (local.get $*cursor/52))
            (local.set $tag_2/65
             (local.get $*cursor/52))
            (if (result i32)
             (i32.lt_s
              (local.tee $*tmp/572
               (local.get $*cursor/52))
              (local.get $*end/51))
             (then
              (block $outer/869 (result i32)
               (block $join:110
                (local.set $*p/363
                 (local.get $*cursor/52))
                (local.set $next_char/111
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/49)
                   (i32.shl
                    (local.get $*p/363)
                    (i32.const 1)))))
                (local.set $*cursor/52
                 (i32.add
                  (local.tee $*tmp/573
                   (local.get $*cursor/52))
                  (i32.const 1)))
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/111)
                  (i32.const 55296))
                 (then
                  (if (result i32)
                   (i32.lt_s
                    (local.get $next_char/111)
                    (i32.const 58))
                   (then
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/111)
                      (i32.const 48))
                     (then
                      (br $join:110))
                     (else
                      (i32.const 5)
                      (br $loop:92))))
                   (else
                    (if (result i32)
                     (i32.gt_s
                      (local.get $next_char/111)
                      (i32.const 58))
                     (then
                      (br $join:110))
                     (else
                      (i32.const 3)
                      (br $loop:92))))))
                 (else
                  (if (result i32)
                   (i32.gt_s
                    (local.get $next_char/111)
                    (i32.const 56318))
                   (then
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/111)
                      (i32.const 57344))
                     (then
                      (i32.const 8)
                      (br $loop:92))
                     (else
                      (if (result i32)
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
                (br $outer/869))
               (i32.const 0)
               (br $loop:92)))
             (else
              (br $join:94)))
            (br $switch_int/872))
           (local.set $tag_1/61
            (local.get $*cursor/52))
           (local.set $tag_2/65
            (local.get $*cursor/52))
           (local.set $tag_3/64
            (local.get $*cursor/52))
           (if (result i32)
            (i32.lt_s
             (local.tee $*tmp/574
              (local.get $*cursor/52))
             (local.get $*end/51))
            (then
             (block $outer/870 (result i32)
              (block $join:112
               (local.set $*p/366
                (local.get $*cursor/52))
               (local.set $next_char/113
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $*data/49)
                  (i32.shl
                   (local.get $*p/366)
                   (i32.const 1)))))
               (local.set $*cursor/52
                (i32.add
                 (local.tee $*tmp/575
                  (local.get $*cursor/52))
                 (i32.const 1)))
               (if (result i32)
                (i32.lt_s
                 (local.get $next_char/113)
                 (i32.const 59))
                (then
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/113)
                   (i32.const 46))
                  (then
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/113)
                     (i32.const 45))
                    (then
                     (br $join:112))
                    (else
                     (br $join:90))))
                  (else
                   (if (result i32)
                    (i32.gt_s
                     (local.get $next_char/113)
                     (i32.const 47))
                    (then
                     (if (result i32)
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
                 (if (result i32)
                  (i32.gt_s
                   (local.get $next_char/113)
                   (i32.const 55295))
                  (then
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/113)
                     (i32.const 57344))
                    (then
                     (if (result i32)
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
                     (if (result i32)
                      (i32.gt_s
                       (local.get $next_char/113)
                       (i32.const 65535))
                      (then
                       (br $join:68))
                      (else
                       (br $join:112))))))
                  (else
                   (br $join:112)))))
               (br $outer/870))
              (i32.const 0)
              (br $loop:92)))
            (else
             (br $join:68)))
           (br $switch_int/872))
          (if (result i32)
           (i32.lt_s
            (local.tee $*tmp/576
             (local.get $*cursor/52))
            (local.get $*end/51))
           (then
            (local.set $*p/369
             (local.get $*cursor/52))
            (local.set $next_char/114
             (i32.load16_u offset=8
              (i32.add
               (local.get $*data/49)
               (i32.shl
                (local.get $*p/369)
                (i32.const 1)))))
            (local.set $*cursor/52
             (i32.add
              (local.tee $*tmp/577
               (local.get $*cursor/52))
              (i32.const 1)))
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/114)
              (i32.const 56320))
             (then
              (br $join:68))
             (else
              (if (result i32)
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
          (br $switch_int/872))
         (local.set $tag_1_1/62
          (local.get $tag_1/61))
         (local.set $tag_1/61
          (local.get $*cursor/52))
         (if (result i32)
          (i32.lt_s
           (local.tee $*tmp/578
            (local.get $*cursor/52))
           (local.get $*end/51))
          (then
           (block $outer/871 (result i32)
            (block $join:115
             (local.set $*p/372
              (local.get $*cursor/52))
             (local.set $next_char/116
              (i32.load16_u offset=8
               (i32.add
                (local.get $*data/49)
                (i32.shl
                 (local.get $*p/372)
                 (i32.const 1)))))
             (local.set $*cursor/52
              (i32.add
               (local.tee $*tmp/579
                (local.get $*cursor/52))
               (i32.const 1)))
             (if (result i32)
              (i32.lt_s
               (local.get $next_char/116)
               (i32.const 55296))
              (then
               (if (result i32)
                (i32.lt_s
                 (local.get $next_char/116)
                 (i32.const 58))
                (then
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/116)
                   (i32.const 48))
                  (then
                   (br $join:115))
                  (else
                   (i32.const 2)
                   (br $loop:92))))
                (else
                 (if (result i32)
                  (i32.gt_s
                   (local.get $next_char/116)
                   (i32.const 58))
                  (then
                   (br $join:115))
                  (else
                   (i32.const 1)
                   (br $loop:92))))))
              (else
               (if (result i32)
                (i32.gt_s
                 (local.get $next_char/116)
                 (i32.const 56318))
                (then
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/116)
                   (i32.const 57344))
                  (then
                   (i32.const 8)
                   (br $loop:92))
                  (else
                   (if (result i32)
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
             (br $outer/871))
            (i32.const 0)
            (br $loop:92)))
          (else
           (br $join:68)))
         (br $switch_int/872))
        (br $join:68))
       (br $outer/861))
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
     (br $outer/860))
    (local.set $tag_1_1/62
     (local.get $tag_1_2/63))
    (local.set $tag_1/61
     (local.get $*cursor/52))
    (local.set $tag_2/65
     (local.get $tag_2_1/66))
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/554
       (local.get $*cursor/52))
      (local.get $*end/51))
     (then
      (block $outer/883 (result i32)
       (block $join:91
        (local.set $*p/375
         (local.get $*cursor/52))
        (local.set $next_char/93
         (i32.load16_u offset=8
          (i32.add
           (local.get $*data/49)
           (i32.shl
            (local.get $*p/375)
            (i32.const 1)))))
        (local.set $*cursor/52
         (i32.add
          (local.tee $*tmp/555
           (local.get $*cursor/52))
          (i32.const 1)))
        (if (result i32)
         (i32.lt_s
          (local.get $next_char/93)
          (i32.const 55296))
         (then
          (if (result i32)
           (i32.lt_s
            (local.get $next_char/93)
            (i32.const 58))
           (then
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/93)
              (i32.const 48))
             (then
              (br $join:91))
             (else
              (i32.const 4)
              (br $loop:92))))
           (else
            (if (result i32)
             (i32.gt_s
              (local.get $next_char/93)
              (i32.const 58))
             (then
              (br $join:91))
             (else
              (i32.const 1)
              (br $loop:92))))))
         (else
          (if (result i32)
           (i32.gt_s
            (local.get $next_char/93)
            (i32.const 56318))
           (then
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/93)
              (i32.const 57344))
             (then
              (i32.const 8)
              (br $loop:92))
             (else
              (if (result i32)
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
        (br $outer/883))
       (i32.const 0)
       (br $loop:92)))
     (else
      (br $join:68)))))
  (return))
 (if (result i32)
  (i32.eq
   (local.get $accept_state/53)
   (i32.const 0))
  (then
   (block $outer/895 (result i32) (result i32) (result i32)
    (block $join:70
     (local.set $*tmp/547
      (i64.extend_i32_s
       (local.tee $*tmp/550
        (i32.add
         (local.tee $*tmp/551
          (local.get $match_tag_saver_1/56))
         (i32.const 1)))))
     (local.set $*tmp/548
      (i64.extend_i32_s
       (local.tee $*tmp/549
        (local.get $match_tag_saver_2/57))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/547)
      (local.get $*tmp/548))
     (local.set $*obj/2/896)
     (local.set $*obj/1/896)
     (local.set $*obj/0/896)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/896)
       (local.get $*obj/1/896)
       (local.set $*ok/2/552
        (local.get $*obj/2/896))
       (local.set $*ok/1/552)
       (local.tee $*ok/0/552)
       (local.get $*ok/1/552)
       (local.get $*ok/2/552))
      (else
       (local.set $*try_err/71
        (local.tee $*err/553
         (local.get $*obj/0/896)))
       (br $join:70)))
     (br $outer/895))
    (call $moonbit.decref
     (local.get $*try_err/71))
    (unreachable))
   (local.set $start_line/2/69)
   (local.set $start_line/1/69)
   (local.set $start_line/0/69)
   (block $outer/893 (result i32) (result i32) (result i32)
    (block $join:73
     (local.set $*tmp/540
      (i64.extend_i32_s
       (local.tee $*tmp/543
        (i32.add
         (local.tee $*tmp/544
          (local.get $match_tag_saver_2/57))
         (i32.const 1)))))
     (local.set $*tmp/541
      (i64.extend_i32_s
       (local.tee $*tmp/542
        (local.get $match_tag_saver_3/58))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/540)
      (local.get $*tmp/541))
     (local.set $*obj/2/894)
     (local.set $*obj/1/894)
     (local.set $*obj/0/894)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/894)
       (local.get $*obj/1/894)
       (local.set $*ok/2/545
        (local.get $*obj/2/894))
       (local.set $*ok/1/545)
       (local.tee $*ok/0/545)
       (local.get $*ok/1/545)
       (local.get $*ok/2/545))
      (else
       (local.set $*try_err/74
        (local.tee $*err/546
         (local.get $*obj/0/894)))
       (br $join:73)))
     (br $outer/893))
    (call $moonbit.decref
     (local.get $*try_err/74))
    (unreachable))
   (local.set $start_column/2/72)
   (local.set $start_column/1/72)
   (local.set $start_column/0/72)
   (block $outer/891 (result i32) (result i32) (result i32)
    (block $join:76
     (local.set $*tmp/534
      (i64.extend_i32_s
       (local.tee $*tmp/537
        (i32.add
         (local.get $*start/50)
         (i32.const 1)))))
     (local.set $*tmp/535
      (i64.extend_i32_s
       (local.tee $*tmp/536
        (local.get $match_tag_saver_0/55))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/534)
      (local.get $*tmp/535))
     (local.set $*obj/2/892)
     (local.set $*obj/1/892)
     (local.set $*obj/0/892)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/892)
       (local.get $*obj/1/892)
       (local.set $*ok/2/538
        (local.get $*obj/2/892))
       (local.set $*ok/1/538)
       (local.tee $*ok/0/538)
       (local.get $*ok/1/538)
       (local.get $*ok/2/538))
      (else
       (local.set $*try_err/77
        (local.tee $*err/539
         (local.get $*obj/0/892)))
       (br $join:76)))
     (br $outer/891))
    (call $moonbit.decref
     (local.get $*try_err/77))
    (unreachable))
   (local.set $pkg/2/75)
   (local.set $pkg/1/75)
   (local.set $pkg/0/75)
   (block $outer/889 (result i32) (result i32) (result i32)
    (block $join:79
     (local.set $*tmp/527
      (i64.extend_i32_s
       (local.tee $*tmp/530
        (i32.add
         (local.tee $*tmp/531
          (local.get $match_tag_saver_0/55))
         (i32.const 1)))))
     (local.set $*tmp/528
      (i64.extend_i32_s
       (local.tee $*tmp/529
        (local.get $match_tag_saver_1/56))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/527)
      (local.get $*tmp/528))
     (local.set $*obj/2/890)
     (local.set $*obj/1/890)
     (local.set $*obj/0/890)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/890)
       (local.get $*obj/1/890)
       (local.set $*ok/2/532
        (local.get $*obj/2/890))
       (local.set $*ok/1/532)
       (local.tee $*ok/0/532)
       (local.get $*ok/1/532)
       (local.get $*ok/2/532))
      (else
       (local.set $*try_err/80
        (local.tee $*err/533
         (local.get $*obj/0/890)))
       (br $join:79)))
     (br $outer/889))
    (call $moonbit.decref
     (local.get $*try_err/80))
    (unreachable))
   (local.set $filename/2/78)
   (local.set $filename/1/78)
   (local.set $filename/0/78)
   (block $outer/887 (result i32) (result i32) (result i32)
    (block $join:82
     (local.set $*tmp/520
      (i64.extend_i32_s
       (local.tee $*tmp/523
        (i32.add
         (local.tee $*tmp/524
          (local.get $match_tag_saver_3/58))
         (i32.const 1)))))
     (local.set $*tmp/521
      (i64.extend_i32_s
       (local.tee $*tmp/522
        (local.get $match_tag_saver_4/59))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/520)
      (local.get $*tmp/521))
     (local.set $*obj/2/888)
     (local.set $*obj/1/888)
     (local.set $*obj/0/888)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/888)
       (local.get $*obj/1/888)
       (local.set $*ok/2/525
        (local.get $*obj/2/888))
       (local.set $*ok/1/525)
       (local.tee $*ok/0/525)
       (local.get $*ok/1/525)
       (local.get $*ok/2/525))
      (else
       (local.set $*try_err/83
        (local.tee $*err/526
         (local.get $*obj/0/888)))
       (br $join:82)))
     (br $outer/887))
    (call $moonbit.decref
     (local.get $*try_err/83))
    (unreachable))
   (local.set $end_line/2/81)
   (local.set $end_line/1/81)
   (local.set $end_line/0/81)
   (block $outer/885 (result i32) (result i32) (result i32)
    (block $join:85
     (local.set $*tmp/513
      (i64.extend_i32_s
       (local.tee $*tmp/516
        (i32.add
         (local.tee $*tmp/517
          (local.get $match_tag_saver_4/59))
         (i32.const 1)))))
     (local.set $*tmp/514
      (i64.extend_i32_s
       (local.tee $*tmp/515
        (local.get $match_end/54))))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/513)
      (local.get $*tmp/514))
     (local.set $*obj/2/886)
     (local.set $*obj/1/886)
     (local.set $*obj/0/886)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/886)
       (local.get $*obj/1/886)
       (local.set $*ok/2/518
        (local.get $*obj/2/886))
       (local.set $*ok/1/518)
       (local.tee $*ok/0/518)
       (local.get $*ok/1/518)
       (local.get $*ok/2/518))
      (else
       (local.set $*try_err/86
        (local.tee $*err/519
         (local.get $*obj/0/886)))
       (br $join:85)))
     (br $outer/885))
    (call $moonbit.decref
     (local.get $*try_err/86))
    (unreachable))
   (local.set $end_column/2/84)
   (local.set $end_column/1/84)
   (local.set $end_column/0/84)
   (i32.store offset=4
    (local.tee $ptr/884
     (call $moonbit.gc.malloc
      (i32.const 72)))
    (i32.const 7341568))
   (i32.store offset=76
    (local.get $ptr/884)
    (local.get $end_column/0/84))
   (i32.store offset=48
    (local.get $ptr/884)
    (local.get $end_column/1/84))
   (i32.store offset=52
    (local.get $ptr/884)
    (local.get $end_column/2/84))
   (i32.store offset=72
    (local.get $ptr/884)
    (local.get $end_line/0/81))
   (i32.store offset=40
    (local.get $ptr/884)
    (local.get $end_line/1/81))
   (i32.store offset=44
    (local.get $ptr/884)
    (local.get $end_line/2/81))
   (i32.store offset=68
    (local.get $ptr/884)
    (local.get $start_column/0/72))
   (i32.store offset=32
    (local.get $ptr/884)
    (local.get $start_column/1/72))
   (i32.store offset=36
    (local.get $ptr/884)
    (local.get $start_column/2/72))
   (i32.store offset=64
    (local.get $ptr/884)
    (local.get $start_line/0/69))
   (i32.store offset=24
    (local.get $ptr/884)
    (local.get $start_line/1/69))
   (i32.store offset=28
    (local.get $ptr/884)
    (local.get $start_line/2/69))
   (i32.store offset=60
    (local.get $ptr/884)
    (local.get $filename/0/78))
   (i32.store offset=16
    (local.get $ptr/884)
    (local.get $filename/1/78))
   (i32.store offset=20
    (local.get $ptr/884)
    (local.get $filename/2/78))
   (i32.store offset=56
    (local.get $ptr/884)
    (local.get $pkg/0/75))
   (i32.store offset=8
    (local.get $ptr/884)
    (local.get $pkg/1/75))
   (i32.store offset=12
    (local.get $ptr/884)
    (local.get $pkg/2/75))
   (local.get $ptr/884))
  (else
   (call $moonbit.decref
    (local.get $*data/49))
   (unreachable))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/41 i32) (param $ch/43 i32) (result i32)
 (local $inc/42 i32)
 (local $*tmp/507 i32)
 (local $len/508 i32)
 (local $*tmp/509 i32)
 (local $len/510 i32)
 (local $data/511 i32)
 (local $len/512 i32)
 (local $*field/822 i32)
 (local.set $*tmp/507
  (i32.add
   (local.tee $len/508
    (i32.load offset=8
     (local.get $self/41)))
   (i32.const 4)))
 (call $moonbit.incref
  (local.get $self/41))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/41)
   (local.get $*tmp/507)))
 (local.set $data/511
  (local.tee $*field/822
   (i32.load offset=12
    (local.get $self/41))))
 (local.set $len/512
  (i32.load offset=8
   (local.get $self/41)))
 (call $moonbit.incref
  (local.get $data/511))
 (local.set $inc/42
  (call $FixedArray::set_utf16le_char
   (local.get $data/511)
   (local.get $len/512)
   (local.get $ch/43)))
 (local.set $*tmp/509
  (i32.add
   (local.tee $len/510
    (i32.load offset=8
     (local.get $self/41)))
   (local.get $inc/42)))
 (i32.store offset=8
  (local.get $self/41)
  (local.get $*tmp/509))
 (call $moonbit.decref
  (local.get $self/41))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/36 i32) (param $required/37 i32) (result i32)
 (local $current_len/35 i32)
 (local $new_data/40 i32)
 (local $*tmp/501 i32)
 (local $*tmp/502 i32)
 (local $data/503 i32)
 (local $len/504 i32)
 (local $*tmp/505 i32)
 (local $data/506 i32)
 (local $*old/823 i32)
 (local $*field/824 i32)
 (local $*tmp/825 i32)
 (local $*field/826 i32)
 (local $enough_space/38 i32)
 (local.set $current_len/35
  (local.tee $*tmp/825
   (call $moonbit.array_length
    (local.tee $data/506
     (local.tee $*field/826
      (i32.load offset=12
       (local.get $self/36)))))))
 (if
  (i32.le_s
   (local.get $required/37)
   (local.get $current_len/35))
  (then
   (call $moonbit.decref
    (local.get $self/36))
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/38
  (local.get $current_len/35))
 (loop $loop:39
  (if
   (i32.lt_s
    (local.tee $*tmp/501
     (local.get $enough_space/38))
    (local.get $required/37))
   (then
    (local.set $enough_space/38
     (i32.mul
      (local.tee $*tmp/502
       (local.get $enough_space/38))
      (i32.const 2)))
    (br $loop:39))
   (else)))
 (local.set $new_data/40
  (call $moonbit.bytes_make
   (local.tee $*tmp/505
    (local.get $enough_space/38))
   (i32.const 0)))
 (local.set $data/503
  (local.tee $*field/824
   (i32.load offset=12
    (local.get $self/36))))
 (local.set $len/504
  (i32.load offset=8
   (local.get $self/36)))
 (call $moonbit.incref
  (local.get $data/503))
 (call $moonbit.incref
  (local.get $new_data/40))
 (drop
  (call $FixedArray::unsafe_blit|Byte|
   (local.get $new_data/40)
   (i32.const 0)
   (local.get $data/503)
   (i32.const 0)
   (local.get $len/504)))
 (call $moonbit.decref
  (local.tee $*old/823
   (i32.load offset=12
    (local.get $self/36))))
 (i32.store offset=12
  (local.get $self/36)
  (local.get $new_data/40))
 (call $moonbit.decref
  (local.get $self/36))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/30 i32) (param $offset/31 i32) (param $value/29 i32) (result i32)
 (local $code/28 i32)
 (local $hi/32 i32)
 (local $lo/33 i32)
 (local $hi/34 i32)
 (local $*p/298 i32)
 (local $*p/301 i32)
 (local $*p/304 i32)
 (local $*p/307 i32)
 (local $*p/310 i32)
 (local $*p/313 i32)
 (local $*tmp/482 i32)
 (local $*tmp/483 i32)
 (local $*tmp/484 i32)
 (local $*tmp/485 i32)
 (local $*tmp/486 i32)
 (local $*tmp/487 i32)
 (local $*tmp/488 i32)
 (local $*tmp/489 i32)
 (local $*tmp/490 i32)
 (local $*tmp/491 i32)
 (local $*tmp/492 i32)
 (local $*tmp/493 i32)
 (local $*tmp/494 i32)
 (local $*tmp/495 i32)
 (local $*tmp/496 i32)
 (local $*tmp/497 i32)
 (local $*tmp/498 i32)
 (local $*tmp/499 i32)
 (local $*tmp/500 i32)
 (local $*arr/897 i32)
 (local $*idx/898 i32)
 (local $*arr/899 i32)
 (local $*idx/900 i32)
 (local $*arr/901 i32)
 (local $*idx/902 i32)
 (local $*arr/903 i32)
 (local $*idx/904 i32)
 (local $*arr/905 i32)
 (local $*idx/906 i32)
 (local $*arr/907 i32)
 (local $*idx/908 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/28
    (local.tee $*tmp/500
     (local.get $value/29)))
   (i32.const 65536))
  (then
   (local.set $*tmp/482
    (i32.and
     (local.tee $*tmp/483
      (local.tee $*p/298
       (i32.and
        (local.get $code/28)
        (i32.const 255))))
     (i32.const 255)))
   (local.get $self/30)
   (local.set $*idx/900
    (local.get $offset/31))
   (local.set $*arr/899)
   (call $moonbit.check_range
    (local.get $*idx/900)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/899))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/899)
     (local.get $*idx/900))
    (local.get $*tmp/482))
   (local.set $*tmp/484
    (i32.add
     (local.get $offset/31)
     (i32.const 1)))
   (local.set $*tmp/485
    (i32.and
     (local.tee $*tmp/486
      (local.tee $*p/301
       (i32.shr_u
        (local.get $code/28)
        (i32.const 8))))
     (i32.const 255)))
   (local.get $self/30)
   (local.set $*idx/898
    (local.get $*tmp/484))
   (local.set $*arr/897)
   (call $moonbit.check_range
    (local.get $*idx/898)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/897))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/897)
     (local.get $*idx/898))
    (local.get $*tmp/485))
   (call $moonbit.decref
    (local.get $self/30))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/28)
     (i32.const 1114112))
    (then
     (local.set $lo/33
      (i32.or
       (local.tee $*tmp/499
        (i32.shr_u
         (local.tee $hi/32
          (i32.sub
           (local.get $code/28)
           (i32.const 65536)))
         (i32.const 10)))
       (i32.const 55296)))
     (local.set $hi/34
      (i32.or
       (local.tee $*tmp/498
        (i32.and
         (local.get $hi/32)
         (i32.const 1023)))
       (i32.const 56320)))
     (local.set $*tmp/487
      (i32.and
       (local.tee $*tmp/488
        (local.tee $*p/304
         (i32.and
          (local.get $lo/33)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/908
      (local.get $offset/31))
     (local.set $*arr/907)
     (call $moonbit.check_range
      (local.get $*idx/908)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/907))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/907)
       (local.get $*idx/908))
      (local.get $*tmp/487))
     (local.set $*tmp/489
      (i32.add
       (local.get $offset/31)
       (i32.const 1)))
     (local.set $*tmp/490
      (i32.and
       (local.tee $*tmp/491
        (local.tee $*p/307
         (i32.shr_u
          (local.get $lo/33)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/906
      (local.get $*tmp/489))
     (local.set $*arr/905)
     (call $moonbit.check_range
      (local.get $*idx/906)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/905))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/905)
       (local.get $*idx/906))
      (local.get $*tmp/490))
     (local.set $*tmp/492
      (i32.add
       (local.get $offset/31)
       (i32.const 2)))
     (local.set $*tmp/493
      (i32.and
       (local.tee $*tmp/494
        (local.tee $*p/310
         (i32.and
          (local.get $hi/34)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/904
      (local.get $*tmp/492))
     (local.set $*arr/903)
     (call $moonbit.check_range
      (local.get $*idx/904)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/903))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/903)
       (local.get $*idx/904))
      (local.get $*tmp/493))
     (local.set $*tmp/495
      (i32.add
       (local.get $offset/31)
       (i32.const 3)))
     (local.set $*tmp/496
      (i32.and
       (local.tee $*tmp/497
        (local.tee $*p/313
         (i32.shr_u
          (local.get $hi/34)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/902
      (local.get $*tmp/495))
     (local.set $*arr/901)
     (call $moonbit.check_range
      (local.get $*idx/902)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/901))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/901)
       (local.get $*idx/902))
      (local.get $*tmp/496))
     (call $moonbit.decref
      (local.get $self/30))
     (i32.const 4))
    (else
     (call $moonbit.decref
      (local.get $self/30))
     (call $moonbitlang/core/builtin.abort|Int|
      (i32.const 10440)
      (i32.const 10328)))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/25 i32) (result i32)
 (local $*tmp/476 i32)
 (local $*tmp/477 i64)
 (local $len/478 i32)
 (local $data/479 i32)
 (local $*field/827 i32)
 (local $*field/828 i32)
 (call $moonbit.incref
  (local.tee $data/479
   (local.tee $*field/828
    (i32.load offset=12
     (local.get $self/25)))))
 (local.set $*tmp/476
  (local.get $data/479))
 (local.set $*field/827
  (i32.load offset=8
   (local.get $self/25)))
 (call $moonbit.decref
  (local.get $self/25))
 (local.set $*tmp/477
  (i64.extend_i32_s
   (local.tee $len/478
    (local.get $*field/827))))
 (call $Bytes::to_unchecked_string.inner
  (local.get $*tmp/476)
  (i32.const 0)
  (local.get $*tmp/477)))
(func $Bytes::to_unchecked_string.inner (param $self/20 i32) (param $offset/24 i32) (param $length/22 i64) (result i32)
 (local $len/19 i32)
 (local $length/21 i32)
 (local $*Some/23 i64)
 (local $*tmp/475 i32)
 (local.set $len/19
  (call $moonbit.array_length
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
 (if (result i32)
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
       (local.tee $*tmp/475
        (i32.add
         (local.get $offset/24)
         (local.get $length/21)))
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
   (call $moonbit.decref
    (local.get $self/20))
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/435 i32) (param $*param/436 i32) (param $*param/437 i32) (result i32)
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/435)
  (local.get $*param/436)
  (local.get $*param/437)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/17 i32) (result i32)
 (local $initial/16 i32)
 (local $data/18 i32)
 (local $ptr/909 i32)
 (local.set $data/18
  (call $moonbit.bytes_make
   (local.tee $initial/16
    (if (result i32)
     (i32.lt_s
      (local.get $size_hint/17)
      (i32.const 1))
     (then
      (i32.const 1))
     (else
      (local.get $size_hint/17))))
   (i32.const 0)))
 (i32.store offset=4
  (local.tee $ptr/909
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/909)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/909)
  (local.get $data/18))
 (local.get $ptr/909))
(func $FixedArray::unsafe_blit|Byte| (param $dst/7 i32) (param $dst_offset/9 i32) (param $src/8 i32) (param $src_offset/10 i32) (param $len/12 i32) (result i32)
 (local $i/11 i32)
 (local $i/14 i32)
 (local $*tmp/466 i32)
 (local $*tmp/467 i32)
 (local $*tmp/468 i32)
 (local $*tmp/469 i32)
 (local $*tmp/470 i32)
 (local $*tmp/471 i32)
 (local $*tmp/472 i32)
 (local $*tmp/473 i32)
 (local $*tmp/474 i32)
 (local $*arr/910 i32)
 (local $*idx/911 i32)
 (local $*arr/912 i32)
 (local $*idx/913 i32)
 (local $*arr/914 i32)
 (local $*idx/915 i32)
 (local $*arr/916 i32)
 (local $*idx/917 i32)
 (if (result i32)
  (if (result i32)
   (i32.eq
    (local.get $dst/7)
    (local.get $src/8))
   (then
    (i32.lt_s
     (local.get $dst_offset/9)
     (local.get $src_offset/10)))
   (else
    (i32.const 0)))
  (then
   (i32.const 0)
   (loop $loop:13 (param i32)
    (local.tee $i/11)
    (local.get $len/12)
    (i32.lt_s)
    (if
     (then
      (local.set $*tmp/466
       (i32.add
        (local.get $dst_offset/9)
        (local.get $i/11)))
      (local.set $*tmp/468
       (i32.add
        (local.get $src_offset/10)
        (local.get $i/11)))
      (local.get $src/8)
      (local.set $*idx/913
       (local.get $*tmp/468))
      (local.set $*arr/912)
      (call $moonbit.check_range
       (local.get $*idx/913)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/912))
        (i32.const 1)))
      (local.set $*tmp/467
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/912)
         (local.get $*idx/913))))
      (local.get $dst/7)
      (local.set $*idx/911
       (local.get $*tmp/466))
      (local.set $*arr/910)
      (call $moonbit.check_range
       (local.get $*idx/911)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/910))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/910)
        (local.get $*idx/911))
       (local.get $*tmp/467))
      (local.tee $*tmp/469
       (i32.add
        (local.get $i/11)
        (i32.const 1)))
      (br $loop:13))
     (else
      (call $moonbit.decref
       (local.get $src/8))
      (call $moonbit.decref
       (local.get $dst/7)))))
   (i32.const 0))
  (else
   (local.tee $*tmp/474
    (i32.sub
     (local.get $len/12)
     (i32.const 1)))
   (loop $loop:15 (param i32)
    (local.tee $i/14)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/470
       (i32.add
        (local.get $dst_offset/9)
        (local.get $i/14)))
      (local.set $*tmp/472
       (i32.add
        (local.get $src_offset/10)
        (local.get $i/14)))
      (local.get $src/8)
      (local.set $*idx/917
       (local.get $*tmp/472))
      (local.set $*arr/916)
      (call $moonbit.check_range
       (local.get $*idx/917)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/916))
        (i32.const 1)))
      (local.set $*tmp/471
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/916)
         (local.get $*idx/917))))
      (local.get $dst/7)
      (local.set $*idx/915
       (local.get $*tmp/470))
      (local.set $*arr/914)
      (call $moonbit.check_range
       (local.get $*idx/915)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/914))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/914)
        (local.get $*idx/915))
       (local.get $*tmp/471))
      (local.tee $*tmp/473
       (i32.sub
        (local.get $i/14)
        (i32.const 1)))
      (br $loop:15))
     (else
      (call $moonbit.decref
       (local.get $src/8))
      (call $moonbit.decref
       (local.get $dst/7)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/5 i32) (param $loc/6 i32) (result i32)
 (local $*tmp/462 i32)
 (local $*tmp/463 i32)
 (local $*tmp/464 i32)
 (local $*tmp/465 i32)
 (local.set $*tmp/464
  (call $moonbit.add_string
   (local.get $string/5)
   (i32.const 10504)))
 (local.set $*tmp/465
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/6)))
 (call $moonbitlang/core/abort.abort|Int|
  (local.tee $*tmp/462
   (call $moonbit.add_string
    (local.tee $*tmp/463
     (call $moonbit.add_string
      (local.get $*tmp/464)
      (local.get $*tmp/465)))
    (i32.const 10488)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/3 i32) (param $loc/4 i32) (result i32)
 (local $*tmp/458 i32)
 (local $*tmp/459 i32)
 (local $*tmp/460 i32)
 (local $*tmp/461 i32)
 (local.set $*tmp/460
  (call $moonbit.add_string
   (local.get $string/3)
   (i32.const 10504)))
 (local.set $*tmp/461
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/4)))
 (call $moonbitlang/core/abort.abort|Unit|
  (local.tee $*tmp/458
   (call $moonbit.add_string
    (local.tee $*tmp/459
     (call $moonbit.add_string
      (local.get $*tmp/460)
      (local.get $*tmp/461)))
    (i32.const 10488)))))
(func $moonbitlang/core/abort.abort|Int| (param $msg/2 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/2))
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/1 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/1))
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/451 i32) (param $*param/450 i32) (result i32)
 (local $*self/449 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/449
   (local.get $*obj_ptr/451))
  (local.get $*param/450)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/448 i32) (param $*param/0/447 i32) (param $*param/1/447 i32) (param $*param/2/447 i32) (result i32)
 (local $*self/446 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/446
   (local.get $*obj_ptr/448))
  (local.get $*param/0/447)
  (local.get $*param/1/447)
  (local.get $*param/2/447)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (param $*obj_ptr/445 i32) (param $*param/442 i32) (param $*param/443 i32) (param $*param/444 i32) (result i32)
 (local $*self/441 i32)
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/441
   (local.get $*obj_ptr/445))
  (local.get $*param/442)
  (local.get $*param/443)
  (local.get $*param/444)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/440 i32) (param $*param/439 i32) (result i32)
 (local $*self/438 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/438
   (local.get $*obj_ptr/440))
  (local.get $*param/439)))
(start $*init*/2)
(func $*init*/2
 (global.set $username/moonbit_examples/cmd/hof.*init*.double|2.clo
  (i32.const 10664))
 (global.set $username/moonbit_examples/cmd/hof.*init*.square|4.clo
  (i32.const 10648)))
(func $*main*/1
 (local $*tmp/452 i32)
 (local $*tmp/453 i32)
 (local $*tmp/454 i32)
 (local $*tmp/455 i32)
 (local $*tmp/456 i32)
 (local $*tmp/457 i32)
 (call $moonbit.incref
  (global.get $username/moonbit_examples/cmd/hof.*init*.double|2.clo))
 (local.set $*tmp/453
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $*tmp/454
    (call $username/moonbit_examples/cmd/hof.apply
     (global.get $username/moonbit_examples/cmd/hof.*init*.double|2.clo)
     (i32.const 5)))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/452
    (call $moonbit.add_string
     (i32.const 10576)
     (local.get $*tmp/453)))))
 (call $moonbit.incref
  (global.get $username/moonbit_examples/cmd/hof.*init*.square|4.clo))
 (local.set $*tmp/456
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $*tmp/457
    (call $username/moonbit_examples/cmd/hof.apply
     (global.get $username/moonbit_examples/cmd/hof.*init*.square|4.clo)
     (i32.const 5)))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/455
    (call $moonbit.add_string
     (i32.const 10528)
     (local.get $*tmp/456))))))
(export "_start" (func $*main*/1))