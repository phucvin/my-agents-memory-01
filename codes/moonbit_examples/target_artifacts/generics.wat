(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data  (memory $moonbit.memory) (offset (i32.const 10000)) "\FF\FF\FF\FF\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P0\00\00\00\00\00\00\00\FF\FF\FF\FF4\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00Pr\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\FF\FF\FF\FF$\00\00P0\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF0\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\008\00:\005\00-\002\009\008\00:\003\001\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\11\00\00PC\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P\0A\00\00\00\00\00\00\00\FF\FF\FF\FF\06\00\00P\0A\00 \00 \00a\00t\00 \00\00\00\00\00\FF\FF\FF\FF\15\00\00PS\00t\00r\00i\00n\00g\00 \00b\00o\00x\00 \00c\00o\00n\00t\00a\00i\00n\00s\00:\00 \00\00\00\00\00\00\00\FF\FF\FF\FF\12\00\00PI\00n\00t\00 \00b\00o\00x\00 \00c\00o\00n\00t\00a\00i\00n\00s\00:\00 \00\00\00\00\00\FF\FF\FF\FF\0E\00\00PH\00e\00l\00l\00o\00 \00G\00e\00n\00e\00r\00i\00c\00s\00\00\00\00\00\FF\FF\FF\FF\00\04\10\00\00\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00")
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
    (i32.const 10696)
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
   (i32.const 10696)
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
 (i32.const 10672)
)
(func $@username/moonbit_examples/cmd/generics.Box::new|String| (param $value/289 i32) (result i32)
 (local $ptr/854 i32)
 (i32.store offset=4
  (local.tee $ptr/854
   (call $moonbit.gc.malloc
    (i32.const 4)))
  (i32.const 1048832))
 (i32.store offset=8
  (local.get $ptr/854)
  (local.get $value/289))
 (local.get $ptr/854))
(func $@username/moonbit_examples/cmd/generics.Box::new|Int| (param $value/288 i32) (result i32)
 (local $ptr/855 i32)
 (i32.store offset=4
  (local.tee $ptr/855
   (call $moonbit.gc.malloc
    (i32.const 4)))
  (i32.const 1572864))
 (i32.store offset=8
  (local.get $ptr/855)
  (local.get $value/288))
 (local.get $ptr/855))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/286 i32) (param $logger/0/287 i32) (param $logger/1/287 i32) (result i32)
 (local $*tmp/805 i32)
 (local $*tmp/806 i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (local.tee $*tmp/805
   (call $@moonbitlang/core/builtin.SourceLocRepr::parse
    (local.tee $*tmp/806
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
 (local $*p/410 i32)
 (local $*p/413 i32)
 (local $*p/416 i32)
 (local $*p/419 i32)
 (local $*p/422 i32)
 (local $*p/425 i32)
 (local $*p/428 i32)
 (local $*p/431 i32)
 (local $*p/434 i32)
 (local $*bind/0/763 i32)
 (local $*bind/1/763 i32)
 (local $*bind/0/764 i32)
 (local $*bind/1/764 i32)
 (local $filename/0/765 i32)
 (local $filename/1/765 i32)
 (local $filename/2/765 i32)
 (local $start_line/0/766 i32)
 (local $start_line/1/766 i32)
 (local $start_line/2/766 i32)
 (local $start_column/0/767 i32)
 (local $start_column/1/767 i32)
 (local $start_column/2/767 i32)
 (local $end_line/0/768 i32)
 (local $end_line/1/768 i32)
 (local $end_line/2/768 i32)
 (local $end_column/0/769 i32)
 (local $end_column/1/769 i32)
 (local $end_column/2/769 i32)
 (local $Some/770 i32)
 (local $*tmp/771 i64)
 (local $*tmp/772 i64)
 (local $*tmp/773 i32)
 (local $*ok/0/774 i32)
 (local $*ok/1/774 i32)
 (local $*ok/2/774 i32)
 (local $*err/775 i32)
 (local $*tmp/776 i64)
 (local $*tmp/777 i64)
 (local $*tmp/778 i32)
 (local $*tmp/779 i32)
 (local $*tmp/780 i32)
 (local $*ok/0/781 i32)
 (local $*ok/1/781 i32)
 (local $*ok/2/781 i32)
 (local $*err/782 i32)
 (local $None/783 i32)
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
 (local $*tmp/796 i32)
 (local $*tmp/797 i32)
 (local $*tmp/798 i32)
 (local $*tmp/799 i32)
 (local $*tmp/800 i32)
 (local $*tmp/801 i32)
 (local $*tmp/802 i32)
 (local $end/803 i32)
 (local $start/804 i32)
 (local $*field/0/809 i32)
 (local $*field/1/809 i32)
 (local $*field/2/809 i32)
 (local $*field/0/810 i32)
 (local $*field/1/810 i32)
 (local $*field/2/810 i32)
 (local $*field/0/811 i32)
 (local $*field/1/811 i32)
 (local $*field/2/811 i32)
 (local $*field/0/812 i32)
 (local $*field/1/812 i32)
 (local $*field/2/812 i32)
 (local $*field/0/813 i32)
 (local $*field/1/813 i32)
 (local $*field/2/813 i32)
 (local $*field/0/814 i32)
 (local $*field/1/814 i32)
 (local $*field/2/814 i32)
 (local $*field/815 i32)
 (local $*field/0/816 i32)
 (local $*field/1/816 i32)
 (local $*field/2/816 i32)
 (local $*field/817 i32)
 (local $*field/0/818 i32)
 (local $*field/1/818 i32)
 (local $*field/2/818 i32)
 (local $*cnt/841 i32)
 (local $*new_cnt/842 i32)
 (local $*cnt/843 i32)
 (local $*new_cnt/844 i32)
 (local $*cnt/845 i32)
 (local $*field/0/846 i32)
 (local $*field/1/846 i32)
 (local $*field/2/846 i32)
 (local $*field/0/847 i32)
 (local $*field/1/847 i32)
 (local $*field/2/847 i32)
 (local $*field/0/848 i32)
 (local $*field/1/848 i32)
 (local $*field/2/848 i32)
 (local $*field/0/849 i32)
 (local $*field/1/849 i32)
 (local $*field/2/849 i32)
 (local $*field/0/850 i32)
 (local $*field/1/850 i32)
 (local $*field/2/850 i32)
 (local $*new_cnt/851 i32)
 (local $*tag/856 i32)
 (local $ptr/861 i32)
 (local $ptr/862 i32)
 (local $ptr/863 i32)
 (local $*obj/0/865 i32)
 (local $*obj/1/865 i32)
 (local $*obj/2/865 i32)
 (local $*obj/0/867 i32)
 (local $*obj/1/867 i32)
 (local $*obj/2/867 i32)
 (local $*cursor/253 i32)
 (local $accept_state/254 i32)
 (local $match_end/255 i32)
 (local $match_tag_saver_0/256 i32)
 (local $tag_0/257 i32)
 (i32.load offset=56
  (local.get $self/249))
 (i32.load offset=8
  (local.get $self/249))
 (local.set $*field/2/818
  (i32.load offset=12
   (local.get $self/249)))
 (local.set $*field/1/818)
 (local.tee $*field/0/818)
 (local.get $*field/1/818)
 (local.set $pkg/2/248
  (local.get $*field/2/818))
 (local.set $pkg/1/248)
 (local.tee $pkg/0/248)
 (local.tee $*field/817)
 (local.set $*data/250)
 (local.set $*start/251
  (local.get $pkg/1/248))
 (local.set $end/803
  (local.get $pkg/2/248))
 (local.set $start/804
  (local.get $pkg/1/248))
 (local.set $*tmp/802
  (i32.sub
   (local.get $end/803)
   (local.get $start/804)))
 (local.set $*end/252
  (i32.add
   (local.get $*start/251)
   (local.get $*tmp/802)))
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
 (block $outer/857 (result i32)
  (block $join:259
   (call $moonbit.incref
    (local.get $*data/250))
   (call $moonbit.incref
    (local.get $pkg/0/248))
   (loop $loop:267 (result i32)
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/784
       (local.get $*cursor/253))
      (local.get $*end/252))
     (then
      (block $outer/858 (result i32)
       (block $join:266
        (local.set $*p/410
         (local.get $*cursor/253))
        (local.set $next_char/268
         (i32.load16_u offset=8
          (i32.add
           (local.get $*data/250)
           (i32.shl
            (local.get $*p/410)
            (i32.const 1)))))
        (local.set $*cursor/253
         (i32.add
          (local.tee $*tmp/785
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
                 (local.tee $*tmp/786
                  (local.get $*cursor/253))
                 (local.get $*end/252))
                (then
                 (block $outer/859 (result i32)
                  (block $join:269
                   (local.set $*p/413
                    (local.get $*cursor/253))
                   (local.set $next_char/271
                    (i32.load16_u offset=8
                     (i32.add
                      (local.get $*data/250)
                      (i32.shl
                       (local.get $*p/413)
                       (i32.const 1)))))
                   (local.set $*cursor/253
                    (i32.add
                     (local.tee $*tmp/787
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
                            (local.tee $*tmp/788
                             (local.get $*cursor/253))
                            (local.get $*end/252))
                           (then
                            (block $outer/860 (result i32)
                             (block $join:272
                              (local.set $*p/416
                               (local.get $*cursor/253))
                              (local.set $next_char/274
                               (i32.load16_u offset=8
                                (i32.add
                                 (local.get $*data/250)
                                 (i32.shl
                                  (local.get $*p/416)
                                  (i32.const 1)))))
                              (local.set $*cursor/253
                               (i32.add
                                (local.tee $*tmp/789
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
                                    (local.tee $*tmp/790
                                     (local.get $*cursor/253))
                                    (local.get $*end/252))
                                   (then
                                    (local.set $*p/419
                                     (local.get $*cursor/253))
                                    (local.set $next_char/275
                                     (i32.load16_u offset=8
                                      (i32.add
                                       (local.get $*data/250)
                                       (i32.shl
                                        (local.get $*p/419)
                                        (i32.const 1)))))
                                    (local.set $*cursor/253
                                     (i32.add
                                      (local.tee $*tmp/791
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
                                    (local.tee $*tmp/792
                                     (local.get $*cursor/253))
                                    (local.get $*end/252))
                                   (then
                                    (local.set $*p/422
                                     (local.get $*cursor/253))
                                    (local.set $next_char/276
                                     (i32.load16_u offset=8
                                      (i32.add
                                       (local.get $*data/250)
                                       (i32.shl
                                        (local.get $*p/422)
                                        (i32.const 1)))))
                                    (local.set $*cursor/253
                                     (i32.add
                                      (local.tee $*tmp/793
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
                              (br $outer/860))
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
                           (local.tee $*tmp/794
                            (local.get $*cursor/253))
                           (local.get $*end/252))
                          (then
                           (local.set $*p/425
                            (local.get $*cursor/253))
                           (local.set $next_char/277
                            (i32.load16_u offset=8
                             (i32.add
                              (local.get $*data/250)
                              (i32.shl
                               (local.get $*p/425)
                               (i32.const 1)))))
                           (local.set $*cursor/253
                            (i32.add
                             (local.tee $*tmp/795
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
                         (local.tee $*tmp/796
                          (local.get $*cursor/253))
                         (local.get $*end/252))
                        (then
                         (local.set $*p/428
                          (local.get $*cursor/253))
                         (local.set $next_char/278
                          (i32.load16_u offset=8
                           (i32.add
                            (local.get $*data/250)
                            (i32.shl
                             (local.get $*p/428)
                             (i32.const 1)))))
                         (local.set $*cursor/253
                          (i32.add
                           (local.tee $*tmp/797
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
                   (br $outer/859))
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
                (local.tee $*tmp/798
                 (local.get $*cursor/253))
                (local.get $*end/252))
               (then
                (local.set $*p/431
                 (local.get $*cursor/253))
                (local.set $next_char/279
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/250)
                   (i32.shl
                    (local.get $*p/431)
                    (i32.const 1)))))
                (local.set $*cursor/253
                 (i32.add
                  (local.tee $*tmp/799
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
              (local.tee $*tmp/800
               (local.get $*cursor/253))
              (local.get $*end/252))
             (then
              (local.set $*p/434
               (local.get $*cursor/253))
              (local.set $next_char/280
               (i32.load16_u offset=8
                (i32.add
                 (local.get $*data/250)
                 (i32.shl
                  (local.get $*p/434)
                  (i32.const 1)))))
              (local.set $*cursor/253
               (i32.add
                (local.tee $*tmp/801
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
        (br $outer/858))
       (br $loop:267)))
     (else
      (br $join:259))))
   (br $outer/857))
  (if (result i32)
   (i32.eq
    (local.get $accept_state/254)
    (i32.const 0))
   (then
    (call $moonbit.decref
     (local.get $pkg/0/248))
    (block $outer/866 (result i32) (result i32) (result i32)
     (block $join:261
      (local.set $*tmp/776
       (i64.extend_i32_s
        (local.tee $*tmp/779
         (i32.add
          (local.tee $*tmp/780
           (local.get $match_tag_saver_0/256))
          (i32.const 1)))))
      (local.set $*tmp/777
       (i64.extend_i32_s
        (local.tee $*tmp/778
         (local.get $match_end/255))))
      (call $moonbit.incref
       (local.get $*data/250))
      (call $String::sub
       (local.get $*data/250)
       (local.get $*tmp/776)
       (local.get $*tmp/777))
      (local.set $*obj/2/867)
      (local.set $*obj/1/867)
      (local.set $*obj/0/867)
      (if (result i32) (result i32) (result i32)
       (then
        (local.get $*obj/0/867)
        (local.get $*obj/1/867)
        (local.set $*ok/2/781
         (local.get $*obj/2/867))
        (local.set $*ok/1/781)
        (local.tee $*ok/0/781)
        (local.get $*ok/1/781)
        (local.get $*ok/2/781))
       (else
        (local.set $*try_err/262
         (local.tee $*err/782
          (local.get $*obj/0/867)))
        (br $join:261)))
      (br $outer/866))
     (call $moonbit.decref
      (local.get $*try_err/262))
     (unreachable))
    (local.set $package_name/2/260)
    (local.set $package_name/1/260)
    (local.set $package_name/0/260)
    (block $outer/864 (result i32) (result i32) (result i32)
     (block $join:264
      (local.set $*tmp/771
       (i64.extend_i32_s
        (local.get $*start/251)))
      (local.set $*tmp/772
       (i64.extend_i32_s
        (local.tee $*tmp/773
         (local.get $match_tag_saver_0/256))))
      (call $String::sub
       (local.get $*data/250)
       (local.get $*tmp/771)
       (local.get $*tmp/772))
      (local.set $*obj/2/865)
      (local.set $*obj/1/865)
      (local.set $*obj/0/865)
      (if (result i32) (result i32) (result i32)
       (then
        (local.get $*obj/0/865)
        (local.get $*obj/1/865)
        (local.set $*ok/2/774
         (local.get $*obj/2/865))
        (local.set $*ok/1/774)
        (local.tee $*ok/0/774)
        (local.get $*ok/1/774)
        (local.get $*ok/2/774))
       (else
        (local.set $*try_err/265
         (local.tee $*err/775
          (local.get $*obj/0/865)))
        (br $join:264)))
      (br $outer/864))
     (call $moonbit.decref
      (local.get $*try_err/265))
     (unreachable))
    (local.set $module_name/2/263)
    (local.set $module_name/1/263)
    (local.set $module_name/0/263)
    (i32.store offset=4
     (local.tee $ptr/863
      (call $moonbit.gc.malloc
       (i32.const 12)))
     (i32.const 2097409))
    (i32.store offset=16
     (local.get $ptr/863)
     (local.get $package_name/0/260))
    (i32.store offset=8
     (local.get $ptr/863)
     (local.get $package_name/1/260))
    (i32.store offset=12
     (local.get $ptr/863)
     (local.get $package_name/2/260))
    (local.set $Some/770
     (local.get $ptr/863))
    (i32.store offset=4
     (local.tee $ptr/862
      (call $moonbit.gc.malloc
       (i32.const 16)))
     (i32.const 2097664))
    (i32.store offset=20
     (local.get $ptr/862)
     (local.get $Some/770))
    (i32.store offset=16
     (local.get $ptr/862)
     (local.get $module_name/0/263))
    (i32.store offset=8
     (local.get $ptr/862)
     (local.get $module_name/1/263))
    (i32.store offset=12
     (local.get $ptr/862)
     (local.get $module_name/2/263))
    (local.get $ptr/862))
   (else
    (call $moonbit.decref
     (local.get $*data/250))
    (local.set $None/783
     (i32.const 10000))
    (i32.store offset=4
     (local.tee $ptr/861
      (call $moonbit.gc.malloc
       (i32.const 16)))
     (i32.const 2097664))
    (i32.store offset=20
     (local.get $ptr/861)
     (local.get $None/783))
    (i32.store offset=16
     (local.get $ptr/861)
     (local.get $pkg/0/248))
    (i32.store offset=8
     (local.get $ptr/861)
     (local.get $pkg/1/248))
    (i32.store offset=12
     (local.get $ptr/861)
     (local.get $pkg/2/248))
    (local.get $ptr/861))))
 (local.tee $*bind/258)
 (i32.load offset=16)
 (i32.load offset=8
  (local.get $*bind/258))
 (local.set $*field/2/816
  (i32.load offset=12
   (local.get $*bind/258)))
 (local.set $*field/1/816)
 (local.tee $*field/0/816)
 (local.get $*field/1/816)
 (local.set $*module_name/2/281
  (local.get $*field/2/816))
 (local.set $*module_name/1/281)
 (local.set $*module_name/0/281)
 (local.set $*field/815
  (i32.load offset=20
   (local.get $*bind/258)))
 (if
  (i32.gt_s
   (local.tee $*cnt/841
    (i32.load
     (local.get $*bind/258)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/842
    (i32.sub
     (local.get $*cnt/841)
     (i32.const 1)))
   (i32.store
    (local.get $*bind/258)
    (local.get $*new_cnt/842))
   (call $moonbit.incref
    (local.get $*field/815))
   (call $moonbit.incref
    (local.get $*module_name/0/281)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/841)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*bind/258)))
    (else))))
 (if
  (i32.eq
   (local.tee $*tag/856
    (call $moonbit.get_tag
     (local.tee $*package_name/282
      (local.get $*field/815))))
   (i32.const 1))
  (then
   (i32.load offset=16
    (local.tee $*Some/283
     (local.get $*package_name/282)))
   (i32.load offset=8
    (local.get $*Some/283))
   (local.set $*field/2/814
    (i32.load offset=12
     (local.get $*Some/283)))
   (local.set $*field/1/814)
   (local.set $*field/0/814)
   (if
    (i32.gt_s
     (local.tee $*cnt/843
      (i32.load
       (local.get $*Some/283)))
     (i32.const 1))
    (then
     (local.set $*new_cnt/844
      (i32.sub
       (local.get $*cnt/843)
       (i32.const 1)))
     (i32.store
      (local.get $*Some/283)
      (local.get $*new_cnt/844))
     (call $moonbit.incref
      (local.get $*field/0/814)))
    (else
     (if
      (i32.eq
       (local.get $*cnt/843)
       (i32.const 1))
      (then
       (call $moonbit.free
        (local.get $*Some/283)))
      (else))))
   (local.get $*field/0/814)
   (local.get $*field/1/814)
   (local.set $*pkg_name/2/284
    (local.get $*field/2/814))
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
   (local.set $*bind/1/763
    (local.get $logger/1/285))
   (local.set $*bind/0/763)
   (if
    (local.get $*bind/1/763)
    (then
     (call $moonbit.incref
      (local.get $*bind/1/763)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
     (local.get $*bind/1/763)
     (i32.const 47)
     (i32.load offset=20
      (local.get $*bind/0/763)))))
  (else
   (call $moonbit.decref
    (local.get $*package_name/282))))
 (i32.load offset=60
  (local.get $self/249))
 (i32.load offset=16
  (local.get $self/249))
 (local.set $*field/2/813
  (i32.load offset=20
   (local.get $self/249)))
 (local.set $*field/1/813)
 (local.tee $*field/0/813)
 (local.get $*field/1/813)
 (local.set $filename/2/765
  (local.get $*field/2/813))
 (local.set $filename/1/765)
 (local.tee $filename/0/765)
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
   (local.get $filename/0/765)
   (local.get $filename/1/765)
   (local.get $filename/2/765)
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
 (local.set $*field/2/812
  (i32.load offset=28
   (local.get $self/249)))
 (local.set $*field/1/812)
 (local.tee $*field/0/812)
 (local.get $*field/1/812)
 (local.set $start_line/2/766
  (local.get $*field/2/812))
 (local.set $start_line/1/766)
 (local.tee $start_line/0/766)
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
   (local.get $start_line/0/766)
   (local.get $start_line/1/766)
   (local.get $start_line/2/766)
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
 (local.set $*field/2/811
  (i32.load offset=36
   (local.get $self/249)))
 (local.set $*field/1/811)
 (local.tee $*field/0/811)
 (local.get $*field/1/811)
 (local.set $start_column/2/767
  (local.get $*field/2/811))
 (local.set $start_column/1/767)
 (local.tee $start_column/0/767)
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
   (local.get $start_column/0/767)
   (local.get $start_column/1/767)
   (local.get $start_column/2/767)
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
 (local.set $*field/2/810
  (i32.load offset=44
   (local.get $self/249)))
 (local.set $*field/1/810)
 (local.tee $*field/0/810)
 (local.get $*field/1/810)
 (local.set $end_line/2/768
  (local.get $*field/2/810))
 (local.set $end_line/1/768)
 (local.tee $end_line/0/768)
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
   (local.get $end_line/0/768)
   (local.get $end_line/1/768)
   (local.get $end_line/2/768)
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
 (local.set $*field/2/809
  (i32.load offset=52
   (local.get $self/249)))
 (local.set $*field/1/809)
 (local.set $*field/0/809)
 (if
  (i32.gt_s
   (local.tee $*cnt/845
    (i32.load
     (local.get $self/249)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/851
    (i32.sub
     (local.get $*cnt/845)
     (i32.const 1)))
   (i32.store
    (local.get $self/249)
    (local.get $*new_cnt/851))
   (call $moonbit.incref
    (local.get $*field/0/809)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/845)
     (i32.const 1))
    (then
     (i32.load offset=72
      (local.get $self/249))
     (i32.load offset=40
      (local.get $self/249))
     (local.set $*field/2/850
      (i32.load offset=44
       (local.get $self/249)))
     (local.set $*field/1/850)
     (local.tee $*field/0/850)
     (call $moonbit.decref)
     (i32.load offset=68
      (local.get $self/249))
     (i32.load offset=32
      (local.get $self/249))
     (local.set $*field/2/849
      (i32.load offset=36
       (local.get $self/249)))
     (local.set $*field/1/849)
     (local.tee $*field/0/849)
     (call $moonbit.decref)
     (i32.load offset=64
      (local.get $self/249))
     (i32.load offset=24
      (local.get $self/249))
     (local.set $*field/2/848
      (i32.load offset=28
       (local.get $self/249)))
     (local.set $*field/1/848)
     (local.tee $*field/0/848)
     (call $moonbit.decref)
     (i32.load offset=60
      (local.get $self/249))
     (i32.load offset=16
      (local.get $self/249))
     (local.set $*field/2/847
      (i32.load offset=20
       (local.get $self/249)))
     (local.set $*field/1/847)
     (local.tee $*field/0/847)
     (call $moonbit.decref)
     (i32.load offset=56
      (local.get $self/249))
     (i32.load offset=8
      (local.get $self/249))
     (local.set $*field/2/846
      (i32.load offset=12
       (local.get $self/249)))
     (local.set $*field/1/846)
     (local.tee $*field/0/846)
     (call $moonbit.decref)
     (call $moonbit.free
      (local.get $self/249)))
    (else))))
 (local.get $*field/0/809)
 (local.get $*field/1/809)
 (local.set $end_column/2/769
  (local.get $*field/2/809))
 (local.set $end_column/1/769)
 (local.set $end_column/0/769)
 (if
  (local.get $logger/1/285)
  (then
   (call $moonbit.incref
    (local.get $logger/1/285)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/285)
   (local.get $end_column/0/769)
   (local.get $end_column/1/769)
   (local.get $end_column/2/769)
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
 (local.set $*bind/1/764
  (local.get $logger/1/285))
 (local.set $*bind/0/764)
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
  (local.get $*bind/1/764)
  (local.get $*module_name/0/281)
  (local.get $*module_name/1/281)
  (local.get $*module_name/2/281)
  (i32.load offset=16
   (local.get $*bind/0/764))))
(func $moonbitlang/core/builtin.println|String| (param $input/247 i32) (result i32)
 (call $moonbit.println
  (local.get $input/247))
 (call $moonbit.decref
  (local.get $input/247))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/245 i32) (param $logger/0/244 i32) (param $logger/1/244 i32) (result i32)
 (local $*tmp/762 i32)
 (local.set $*tmp/762
  (call $Int::to_string.inner
   (local.get $self/245)
   (i32.const 10)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/244)
  (local.get $*tmp/762)
  (i32.load offset=8
   (local.get $logger/0/244))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/242 i32) (param $str/0/243 i32) (param $str/1/243 i32) (param $str/2/243 i32) (result i32)
 (local $*tmp/743 i32)
 (local $len/744 i32)
 (local $*tmp/745 i32)
 (local $*tmp/746 i32)
 (local $end/747 i32)
 (local $start/748 i32)
 (local $data/749 i32)
 (local $len/750 i32)
 (local $str/751 i32)
 (local $start/752 i32)
 (local $*tmp/753 i32)
 (local $end/754 i32)
 (local $start/755 i32)
 (local $*tmp/756 i32)
 (local $len/757 i32)
 (local $*tmp/758 i32)
 (local $*tmp/759 i32)
 (local $end/760 i32)
 (local $start/761 i32)
 (local $*field/819 i32)
 (local $*field/820 i32)
 (local $*field/821 i32)
 (local.set $len/744
  (i32.load offset=8
   (local.get $self/242)))
 (local.set $end/747
  (local.get $str/2/243))
 (local.set $start/748
  (local.get $str/1/243))
 (local.set $*tmp/745
  (i32.mul
   (local.tee $*tmp/746
    (i32.sub
     (local.get $end/747)
     (local.get $start/748)))
   (i32.const 2)))
 (local.set $*tmp/743
  (i32.add
   (local.get $len/744)
   (local.get $*tmp/745)))
 (call $moonbit.incref
  (local.get $self/242))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/242)
   (local.get $*tmp/743)))
 (local.set $data/749
  (local.tee $*field/821
   (i32.load offset=12
    (local.get $self/242))))
 (local.set $len/750
  (i32.load offset=8
   (local.get $self/242)))
 (local.set $str/751
  (local.tee $*field/820
   (local.get $str/0/243)))
 (local.set $start/752
  (local.get $str/1/243))
 (local.set $end/754
  (local.get $str/2/243))
 (local.set $start/755
  (local.get $str/1/243))
 (local.set $*tmp/753
  (i32.sub
   (local.get $end/754)
   (local.get $start/755)))
 (call $moonbit.incref
  (local.get $str/751))
 (call $moonbit.incref
  (local.get $data/749))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/749)
   (local.get $len/750)
   (local.get $str/751)
   (local.get $start/752)
   (local.get $*tmp/753)))
 (local.set $len/757
  (i32.load offset=8
   (local.get $self/242)))
 (local.set $end/760
  (local.get $str/2/243))
 (local.set $*field/819
  (local.get $str/1/243))
 (call $moonbit.decref
  (local.get $str/0/243))
 (local.set $start/761
  (local.get $*field/819))
 (local.set $*tmp/758
  (i32.mul
   (local.tee $*tmp/759
    (i32.sub
     (local.get $end/760)
     (local.get $start/761)))
   (i32.const 2)))
 (local.set $*tmp/756
  (i32.add
   (local.get $len/757)
   (local.get $*tmp/758)))
 (i32.store offset=8
  (local.get $self/242)
  (local.get $*tmp/756))
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
 (local $*tmp/739 i32)
 (local $*tmp/740 i32)
 (local $*tmp/741 i32)
 (local $*tmp/742 i32)
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
    (local.tee $*tmp/742
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
    (local.set $*tmp/739
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
        (local.get $*tmp/739)))
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
      (local.set $*tmp/740
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
          (local.get $*tmp/740)))
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
      (local.set $*tmp/741
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
          (local.get $*tmp/741)))
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
 (local $*tmp/736 i32)
 (local $*tmp/737 i32)
 (local $*tmp/738 i32)
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
    (local.tee $*tmp/736
     (local.get $num/220))
    (i32.const 0))
   (then
    (local.set $count/223
     (i32.add
      (local.tee $*tmp/737
       (local.get $count/223))
      (i32.const 1)))
    (local.set $num/220
     (i32.div_u
      (local.tee $*tmp/738
       (local.get $num/220))
      (local.get $base/221)))
    (br $loop:224))
   (else)))
 (local.get $count/223))
(func $moonbitlang/core/builtin.hex_count32 (param $value/217 i32) (result i32)
 (local $leading_zeros/218 i32)
 (local $*tmp/734 i32)
 (local $*tmp/735 i32)
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
    (local.tee $*tmp/734
     (i32.div_s
      (local.tee $*tmp/735
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
 (local $*tmp/726 i32)
 (local $*tmp/727 i32)
 (local $*tmp/728 i32)
 (local $*tmp/729 i32)
 (local $*tmp/730 i32)
 (local $*tmp/731 i32)
 (local $*tmp/732 i32)
 (local $*tmp/733 i32)
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
    (local.tee $*tmp/677
     (local.get $num/193))
    (i32.const 10000))
   (then
    (local.set $t/198
     (i32.div_u
      (local.tee $*tmp/700
       (local.get $num/193))
      (i32.const 10000)))
    (local.set $r/199
     (local.tee $*tmp/698
      (i32.rem_u
       (local.tee $*tmp/699
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
      (local.tee $*tmp/678
       (local.get $offset/195))
      (i32.const 4)))
    (local.set $*tmp/697
     (i32.div_s
      (local.get $d1/200)
      (i32.const 10)))
    (local.set $d1_hi/202
     (i32.and
      (local.tee $*tmp/696
       (i32.add
        (i32.const 48)
        (local.get $*tmp/697)))
      (i32.const 65535)))
    (local.set $*tmp/695
     (i32.rem_s
      (local.get $d1/200)
      (i32.const 10)))
    (local.set $d1_lo/203
     (i32.and
      (local.tee $*tmp/694
       (i32.add
        (i32.const 48)
        (local.get $*tmp/695)))
      (i32.const 65535)))
    (local.set $*tmp/693
     (i32.div_s
      (local.get $d2/201)
      (i32.const 10)))
    (local.set $d2_hi/204
     (i32.and
      (local.tee $*tmp/692
       (i32.add
        (i32.const 48)
        (local.get $*tmp/693)))
      (i32.const 65535)))
    (local.set $*tmp/691
     (i32.rem_s
      (local.get $d2/201)
      (i32.const 10)))
    (local.set $d2_lo/205
     (i32.and
      (local.tee $*tmp/690
       (i32.add
        (i32.const 48)
        (local.get $*tmp/691)))
      (i32.const 65535)))
    (local.set $*tmp/680
     (local.get $offset/195))
    (local.set $*tmp/679
     (i32.add
      (local.get $digit_start/197)
      (local.get $*tmp/680)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/679)
       (i32.const 1)))
     (local.get $d1_hi/202))
    (local.set $*tmp/683
     (local.get $offset/195))
    (local.set $*tmp/681
     (i32.add
      (local.tee $*tmp/682
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/683)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/681)
       (i32.const 1)))
     (local.get $d1_lo/203))
    (local.set $*tmp/686
     (local.get $offset/195))
    (local.set $*tmp/684
     (i32.add
      (local.tee $*tmp/685
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/686)))
      (i32.const 2)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/684)
       (i32.const 1)))
     (local.get $d2_hi/204))
    (local.set $*tmp/689
     (local.get $offset/195))
    (local.set $*tmp/687
     (i32.add
      (local.tee $*tmp/688
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/689)))
      (i32.const 3)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/687)
       (i32.const 1)))
     (local.get $d2_lo/205))
    (br $loop:207))
   (else)))
 (local.set $remaining/208
  (local.tee $*tmp/733
   (local.get $num/193)))
 (loop $loop:213
  (if
   (i32.ge_s
    (local.tee $*tmp/701
     (local.get $remaining/208))
    (i32.const 100))
   (then
    (local.set $t/209
     (i32.div_s
      (local.tee $*tmp/713
       (local.get $remaining/208))
      (i32.const 100)))
    (local.set $d/210
     (i32.rem_s
      (local.tee $*tmp/712
       (local.get $remaining/208))
      (i32.const 100)))
    (local.set $remaining/208
     (local.get $t/209))
    (local.set $offset/195
     (i32.sub
      (local.tee $*tmp/702
       (local.get $offset/195))
      (i32.const 2)))
    (local.set $*tmp/711
     (i32.div_s
      (local.get $d/210)
      (i32.const 10)))
    (local.set $d_hi/211
     (i32.and
      (local.tee $*tmp/710
       (i32.add
        (i32.const 48)
        (local.get $*tmp/711)))
      (i32.const 65535)))
    (local.set $*tmp/709
     (i32.rem_s
      (local.get $d/210)
      (i32.const 10)))
    (local.set $d_lo/212
     (i32.and
      (local.tee $*tmp/708
       (i32.add
        (i32.const 48)
        (local.get $*tmp/709)))
      (i32.const 65535)))
    (local.set $*tmp/704
     (local.get $offset/195))
    (local.set $*tmp/703
     (i32.add
      (local.get $digit_start/197)
      (local.get $*tmp/704)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/703)
       (i32.const 1)))
     (local.get $d_hi/211))
    (local.set $*tmp/707
     (local.get $offset/195))
    (local.set $*tmp/705
     (i32.add
      (local.tee $*tmp/706
       (i32.add
        (local.get $digit_start/197)
        (local.get $*tmp/707)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/206)
      (i32.shl
       (local.get $*tmp/705)
       (i32.const 1)))
     (local.get $d_lo/212))
    (br $loop:213))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.tee $*tmp/714
    (local.get $remaining/208))
   (i32.const 10))
  (then
   (local.set $offset/195
    (i32.sub
     (local.tee $*tmp/715
      (local.get $offset/195))
     (i32.const 2)))
   (local.set $*tmp/725
    (i32.div_s
     (local.tee $*tmp/726
      (local.get $remaining/208))
     (i32.const 10)))
   (local.set $d_hi/214
    (i32.and
     (local.tee $*tmp/724
      (i32.add
       (i32.const 48)
       (local.get $*tmp/725)))
     (i32.const 65535)))
   (local.set $*tmp/722
    (i32.rem_s
     (local.tee $*tmp/723
      (local.get $remaining/208))
     (i32.const 10)))
   (local.set $d_lo/215
    (i32.and
     (local.tee $*tmp/721
      (i32.add
       (i32.const 48)
       (local.get $*tmp/722)))
     (i32.const 65535)))
   (local.set $*tmp/717
    (local.get $offset/195))
   (local.set $*tmp/716
    (i32.add
     (local.get $digit_start/197)
     (local.get $*tmp/717)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/206)
     (i32.shl
      (local.get $*tmp/716)
      (i32.const 1)))
    (local.get $d_hi/214))
   (local.set $*tmp/720
    (local.get $offset/195))
   (local.set $*tmp/718
    (i32.add
     (local.tee $*tmp/719
      (i32.add
       (local.get $digit_start/197)
       (local.get $*tmp/720)))
     (i32.const 1)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/206)
     (i32.shl
      (local.get $*tmp/718)
      (i32.const 1)))
    (local.get $d_lo/215))
   (call $moonbit.decref
    (local.get $buffer/206))
   (i32.const 0))
  (else
   (local.set $*tmp/732
    (local.tee $offset/195
     (i32.sub
      (local.tee $*tmp/727
       (local.get $offset/195))
      (i32.const 1))))
   (local.set $*tmp/728
    (i32.add
     (local.get $digit_start/197)
     (local.get $*tmp/732)))
   (local.set $*tmp/731
    (local.get $remaining/208))
   (local.set $*tmp/729
    (i32.and
     (local.tee $*tmp/730
      (i32.add
       (i32.const 48)
       (local.get $*tmp/731)))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/206)
     (i32.shl
      (local.get $*tmp/728)
      (i32.const 1)))
    (local.get $*tmp/729))
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
 (local $*tmp/669 i32)
 (local $*tmp/670 i32)
 (local $*tmp/671 i32)
 (local $*tmp/672 i32)
 (local $*tmp/673 i32)
 (local $*tmp/674 i32)
 (local $*tmp/675 i32)
 (local $*tmp/676 i32)
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
 (local.set $*tmp/657
  (i32.sub
   (local.get $radix/184)
   (i32.const 1)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/656
    (i32.and
     (local.get $radix/184)
     (local.get $*tmp/657)))
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
      (local.tee $*tmp/658
       (local.get $n/181))
      (i32.const 0))
     (then
      (local.set $offset/178
       (i32.sub
        (local.tee $*tmp/659
         (local.get $offset/178))
        (i32.const 1)))
      (local.set $digit/187
       (local.tee $*tmp/665
        (i32.and
         (local.tee $*tmp/666
          (local.get $n/181))
         (local.get $mask/186))))
      (local.set $*tmp/663
       (local.get $offset/178))
      (local.set $*tmp/660
       (i32.add
        (local.get $digit_start/180)
        (local.get $*tmp/663)))
      (local.set $*tmp/661
       (i32.and
        (local.tee $*tmp/662
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
         (local.get $*tmp/660)
         (i32.const 1)))
       (local.get $*tmp/661))
      (local.set $n/181
       (i32.shr_u
        (local.tee $*tmp/664
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
      (local.tee $*tmp/667
       (local.get $n/181))
      (i32.const 0))
     (then
      (local.set $offset/178
       (i32.sub
        (local.tee $*tmp/668
         (local.get $offset/178))
        (i32.const 1)))
      (local.set $q/190
       (i32.div_u
        (local.tee $*tmp/676
         (local.get $n/181))
        (local.get $base/183)))
      (local.set $*tmp/674
       (local.get $n/181))
      (local.set $*tmp/675
       (i32.mul
        (local.get $q/190)
        (local.get $base/183)))
      (local.set $digit/191
       (local.tee $*tmp/673
        (i32.sub
         (local.get $*tmp/674)
         (local.get $*tmp/675))))
      (local.set $*tmp/672
       (local.get $offset/178))
      (local.set $*tmp/669
       (i32.add
        (local.get $digit_start/180)
        (local.get $*tmp/672)))
      (local.set $*tmp/670
       (i32.and
        (local.tee $*tmp/671
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
         (local.get $*tmp/669)
         (i32.const 1)))
       (local.get $*tmp/670))
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
 (local $*tmp/648 i32)
 (local $*tmp/649 i32)
 (local $*tmp/650 i32)
 (local $*tmp/651 i32)
 (local $*tmp/652 i32)
 (local $*tmp/653 i32)
 (local $*tmp/654 i32)
 (local $*tmp/655 i32)
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
    (local.tee $*tmp/637
     (local.get $offset/167))
    (i32.const 2))
   (then
    (local.set $offset/167
     (i32.sub
      (local.tee $*tmp/638
       (local.get $offset/167))
      (i32.const 2)))
    (local.set $hi/173
     (i32.div_s
      (local.tee $byte_val/172
       (local.tee $*tmp/649
        (i32.and
         (local.tee $*tmp/650
          (local.get $n/170))
         (i32.const 255))))
      (i32.const 16)))
    (local.set $lo/174
     (i32.rem_s
      (local.get $byte_val/172)
      (i32.const 16)))
    (local.set $*tmp/642
     (local.get $offset/167))
    (local.set $*tmp/639
     (i32.add
      (local.get $digit_start/169)
      (local.get $*tmp/642)))
    (local.set $*tmp/640
     (i32.and
      (local.tee $*tmp/641
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
       (local.get $*tmp/639)
       (i32.const 1)))
     (local.get $*tmp/640))
    (local.set $*tmp/647
     (local.get $offset/167))
    (local.set $*tmp/643
     (i32.add
      (local.tee $*tmp/646
       (i32.add
        (local.get $digit_start/169)
        (local.get $*tmp/647)))
      (i32.const 1)))
    (local.set $*tmp/644
     (i32.and
      (local.tee $*tmp/645
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
       (local.get $*tmp/643)
       (i32.const 1)))
     (local.get $*tmp/644))
    (local.set $n/170
     (i32.shr_u
      (local.tee $*tmp/648
       (local.get $n/170))
      (i32.const 8)))
    (br $loop:176))
   (else)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/651
    (local.get $offset/167))
   (i32.const 1))
  (then
   (local.set $nibble/177
    (local.tee $*tmp/654
     (i32.and
      (local.tee $*tmp/655
       (local.get $n/170))
      (i32.const 15))))
   (local.set $*tmp/652
    (i32.and
     (local.tee $*tmp/653
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
    (local.get $*tmp/652))
   (call $moonbit.decref
    (local.get $buffer/175))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $buffer/175))
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/166 i32) (result i32)
 (local $logger/165 i32)
 (local $*tmp/0/636 i32)
 (local $*tmp/1/636 i32)
 (call $moonbit.incref
  (local.tee $logger/165
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/636
  (local.get $logger/165))
 (local.set $*tmp/0/636)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/166)
   (local.get $*tmp/0/636)
   (local.get $*tmp/1/636)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/165)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/164 i32) (result i32)
 (local $logger/163 i32)
 (local $*tmp/0/635 i32)
 (local $*tmp/1/635 i32)
 (call $moonbit.incref
  (local.tee $logger/163
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/635
  (local.get $logger/163))
 (local.set $*tmp/0/635)
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/164)
   (local.get $*tmp/0/635)
   (local.get $*tmp/1/635)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/163)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/154 i32) (param $value/157 i32) (param $start/158 i32) (param $len/159 i32) (result i32)
 (local $*try_err/156 i32)
 (local $*tmp/0/628 i32)
 (local $*tmp/1/628 i32)
 (local $*tmp/2/628 i32)
 (local $*tmp/629 i64)
 (local $*tmp/630 i32)
 (local $*ok/0/631 i32)
 (local $*ok/1/631 i32)
 (local $*ok/2/631 i32)
 (local $*err/632 i32)
 (local $*obj/0/869 i32)
 (local $*obj/1/869 i32)
 (local $*obj/2/869 i32)
 (block $outer/868 (result i32) (result i32) (result i32)
  (block $join:155
   (local.set $*tmp/629
    (i64.extend_i32_s
     (local.tee $*tmp/630
      (i32.add
       (local.get $start/158)
       (local.get $len/159)))))
   (call $String::sub.inner
    (local.get $value/157)
    (local.get $start/158)
    (local.get $*tmp/629))
   (local.set $*obj/2/869)
   (local.set $*obj/1/869)
   (local.set $*obj/0/869)
   (if (result i32) (result i32) (result i32)
    (then
     (local.get $*obj/0/869)
     (local.get $*obj/1/869)
     (local.set $*ok/2/631
      (local.get $*obj/2/869))
     (local.set $*ok/1/631)
     (local.tee $*ok/0/631)
     (local.get $*ok/1/631)
     (local.get $*ok/2/631))
    (else
     (local.set $*try_err/156
      (local.tee $*err/632
       (local.get $*obj/0/869)))
     (br $join:155)))
   (br $outer/868))
  (call $moonbit.decref
   (local.get $*try_err/156))
  (unreachable))
 (local.set $*tmp/2/628)
 (local.set $*tmp/1/628)
 (local.set $*tmp/0/628)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.get $self/154)
  (local.get $*tmp/0/628)
  (local.get $*tmp/1/628)
  (local.get $*tmp/2/628)))
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
 (local $*p/386 i32)
 (local $*p/389 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/624 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/625 i32)
 (local $*tmp/0/626 i32)
 (local $*tmp/1/626 i32)
 (local $*tmp/2/626 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/627 i32)
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
      (local.set $*p/386
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/142)
         (i32.shl
          (local.get $start/147)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/386))
       (then
        (i32.le_s
         (local.get $*p/386)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/142))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/624
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/624)
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
      (local.set $*p/389
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/142)
         (i32.shl
          (local.get $end/143)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/389))
       (then
        (i32.le_s
         (local.get $*p/389)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/142))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/625
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/625)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (local.get $self/142)
   (local.get $start/147)
   (local.set $*tmp/2/626
    (local.get $end/143))
   (local.set $*tmp/1/626)
   (local.set $*tmp/0/626)
   (i32.const 1)
   (local.get $*tmp/0/626)
   (local.get $*tmp/1/626)
   (local.get $*tmp/2/626))
  (else
   (call $moonbit.decref
    (local.get $self/142))
   (local.set $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/627
    (i32.const 10312))
   (i32.const 0)
   (local.get $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/627)
   (i32.const 0)
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/139 i32) (param $str/140 i32) (result i32)
 (local $*tmp/613 i32)
 (local $len/614 i32)
 (local $*tmp/615 i32)
 (local $*tmp/616 i32)
 (local $data/617 i32)
 (local $len/618 i32)
 (local $*tmp/619 i32)
 (local $*tmp/620 i32)
 (local $len/621 i32)
 (local $*tmp/622 i32)
 (local $*tmp/623 i32)
 (local $*tmp/825 i32)
 (local $*field/826 i32)
 (local.set $len/614
  (i32.load offset=8
   (local.get $self/139)))
 (local.set $*tmp/615
  (i32.mul
   (local.tee $*tmp/616
    (call $moonbit.array_length
     (local.get $str/140)))
   (i32.const 2)))
 (local.set $*tmp/613
  (i32.add
   (local.get $len/614)
   (local.get $*tmp/615)))
 (call $moonbit.incref
  (local.get $self/139))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/139)
   (local.get $*tmp/613)))
 (local.set $data/617
  (local.tee $*field/826
   (i32.load offset=12
    (local.get $self/139))))
 (local.set $len/618
  (i32.load offset=8
   (local.get $self/139)))
 (local.set $*tmp/619
  (call $moonbit.array_length
   (local.get $str/140)))
 (call $moonbit.incref
  (local.get $data/617))
 (call $moonbit.incref
  (local.get $str/140))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/617)
   (local.get $len/618)
   (local.get $str/140)
   (i32.const 0)
   (local.get $*tmp/619)))
 (local.set $len/621
  (i32.load offset=8
   (local.get $self/139)))
 (local.set $*tmp/825
  (call $moonbit.array_length
   (local.get $str/140)))
 (call $moonbit.decref
  (local.get $str/140))
 (local.set $*tmp/622
  (i32.mul
   (local.tee $*tmp/623
    (local.get $*tmp/825))
   (i32.const 2)))
 (local.set $*tmp/620
  (i32.add
   (local.get $len/621)
   (local.get $*tmp/622)))
 (i32.store offset=8
  (local.get $self/139)
  (local.get $*tmp/620))
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
 (local $*p/380 i32)
 (local $*p/383 i32)
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
 (local $*arr/870 i32)
 (local $*idx/871 i32)
 (local $*arr/872 i32)
 (local $*idx/873 i32)
 (local.set $*tmp/612
  (i32.mul
   (local.get $length/127)
   (i32.const 2)))
 (local.set $e1/125
  (i32.sub
   (local.tee $*tmp/611
    (i32.add
     (local.get $bytes_offset/126)
     (local.get $*tmp/612)))
   (i32.const 1)))
 (local.set $e2/128
  (i32.sub
   (local.tee $*tmp/610
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
      (local.set $*tmp/602
       (i32.and
        (local.tee $*tmp/603
         (local.tee $*p/380
          (i32.and
           (local.tee $c/137
            (local.tee $*tmp/607
             (i32.load16_u offset=8
              (i32.add
               (local.get $str/133)
               (i32.shl
                (local.get $i/135)
                (i32.const 1))))))
           (i32.const 255))))
        (i32.const 255)))
      (local.get $self/131)
      (local.set $*idx/873
       (local.get $j/136))
      (local.set $*arr/872)
      (call $moonbit.check_range
       (local.get $*idx/873)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/872))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/872)
        (local.get $*idx/873))
       (local.get $*tmp/602))
      (local.set $*tmp/604
       (i32.add
        (local.get $j/136)
        (i32.const 1)))
      (local.set $*tmp/605
       (i32.and
        (local.tee $*tmp/606
         (local.tee $*p/383
          (i32.shr_u
           (local.get $c/137)
           (i32.const 8))))
        (i32.const 255)))
      (local.get $self/131)
      (local.set $*idx/871
       (local.get $*tmp/604))
      (local.set $*arr/870)
      (call $moonbit.check_range
       (local.get $*idx/871)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/870))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/870)
        (local.get $*idx/871))
       (local.get $*tmp/605))
      (local.set $*tmp/608
       (i32.add
        (local.get $i/135)
        (i32.const 1)))
      (local.set $*tmp/609
       (i32.add
        (local.get $j/136)
        (i32.const 2)))
      (local.get $*tmp/608)
      (local.get $*tmp/609)
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
 (local $*p/326 i32)
 (local $*p/329 i32)
 (local $*p/332 i32)
 (local $*p/335 i32)
 (local $*p/338 i32)
 (local $*p/341 i32)
 (local $*p/344 i32)
 (local $*p/347 i32)
 (local $*p/350 i32)
 (local $*p/353 i32)
 (local $*p/356 i32)
 (local $*p/359 i32)
 (local $*p/362 i32)
 (local $*p/365 i32)
 (local $*p/368 i32)
 (local $*p/371 i32)
 (local $*p/374 i32)
 (local $*p/377 i32)
 (local $*tmp/521 i64)
 (local $*tmp/522 i64)
 (local $*tmp/523 i32)
 (local $*tmp/524 i32)
 (local $*tmp/525 i32)
 (local $*ok/0/526 i32)
 (local $*ok/1/526 i32)
 (local $*ok/2/526 i32)
 (local $*err/527 i32)
 (local $*tmp/528 i64)
 (local $*tmp/529 i64)
 (local $*tmp/530 i32)
 (local $*tmp/531 i32)
 (local $*tmp/532 i32)
 (local $*ok/0/533 i32)
 (local $*ok/1/533 i32)
 (local $*ok/2/533 i32)
 (local $*err/534 i32)
 (local $*tmp/535 i64)
 (local $*tmp/536 i64)
 (local $*tmp/537 i32)
 (local $*tmp/538 i32)
 (local $*tmp/539 i32)
 (local $*ok/0/540 i32)
 (local $*ok/1/540 i32)
 (local $*ok/2/540 i32)
 (local $*err/541 i32)
 (local $*tmp/542 i64)
 (local $*tmp/543 i64)
 (local $*tmp/544 i32)
 (local $*tmp/545 i32)
 (local $*ok/0/546 i32)
 (local $*ok/1/546 i32)
 (local $*ok/2/546 i32)
 (local $*err/547 i32)
 (local $*tmp/548 i64)
 (local $*tmp/549 i64)
 (local $*tmp/550 i32)
 (local $*tmp/551 i32)
 (local $*tmp/552 i32)
 (local $*ok/0/553 i32)
 (local $*ok/1/553 i32)
 (local $*ok/2/553 i32)
 (local $*err/554 i32)
 (local $*tmp/555 i64)
 (local $*tmp/556 i64)
 (local $*tmp/557 i32)
 (local $*tmp/558 i32)
 (local $*tmp/559 i32)
 (local $*ok/0/560 i32)
 (local $*ok/1/560 i32)
 (local $*ok/2/560 i32)
 (local $*err/561 i32)
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
 (local $*tmp/591 i32)
 (local $*tmp/592 i32)
 (local $*tmp/593 i32)
 (local $*tmp/594 i32)
 (local $*tmp/595 i32)
 (local $*tmp/596 i32)
 (local $*tmp/597 i32)
 (local $*tmp/598 i32)
 (local $end/599 i32)
 (local $start/600 i32)
 (local $*tmp/601 i32)
 (local $*field/827 i32)
 (local $*field/828 i32)
 (local $ptr/900 i32)
 (local $*obj/0/902 i32)
 (local $*obj/1/902 i32)
 (local $*obj/2/902 i32)
 (local $*obj/0/904 i32)
 (local $*obj/1/904 i32)
 (local $*obj/2/904 i32)
 (local $*obj/0/906 i32)
 (local $*obj/1/906 i32)
 (local $*obj/2/906 i32)
 (local $*obj/0/908 i32)
 (local $*obj/1/908 i32)
 (local $*obj/2/908 i32)
 (local $*obj/0/910 i32)
 (local $*obj/1/910 i32)
 (local $*obj/2/910 i32)
 (local $*obj/0/912 i32)
 (local $*obj/1/912 i32)
 (local $*obj/2/912 i32)
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
 (local.set $*tmp/601
  (call $moonbit.array_length
   (local.get $repr/48)))
 (local.get $repr/48)
 (i32.const 0)
 (local.set $*bind/2/47
  (local.get $*tmp/601))
 (local.set $*bind/1/47)
 (local.tee $*bind/0/47)
 (local.tee $*field/828)
 (local.set $*data/49)
 (local.set $*start/50
  (local.get $*bind/1/47))
 (local.set $end/599
  (local.get $*bind/2/47))
 (local.set $start/600
  (local.tee $*field/827
   (local.get $*bind/1/47)))
 (local.set $*tmp/598
  (i32.sub
   (local.get $end/599)
   (local.get $start/600)))
 (local.set $*end/51
  (i32.add
   (local.get $*start/50)
   (local.get $*tmp/598)))
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
     (local.tee $*tmp/588
      (local.get $*cursor/52))
     (local.get $*end/51))
    (then
     (local.set $*p/326
      (local.get $*cursor/52))
     (local.set $next_char/117
      (i32.load16_u offset=8
       (i32.add
        (local.get $*data/49)
        (i32.shl
         (local.get $*p/326)
         (i32.const 1)))))
     (local.set $*cursor/52
      (i32.add
       (local.tee $*tmp/589
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
            (local.tee $*tmp/590
             (local.get $*cursor/52))
            (local.get $*end/51))
           (then
            (block $outer/874 (result i32)
             (block $join:118
              (local.set $*p/329
               (local.get $*cursor/52))
              (local.set $next_char/120
               (i32.load16_u offset=8
                (i32.add
                 (local.get $*data/49)
                 (i32.shl
                  (local.get $*p/329)
                  (i32.const 1)))))
              (local.set $*cursor/52
               (i32.add
                (local.tee $*tmp/591
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
                      (local.tee $*tmp/592
                       (local.get $*cursor/52))
                      (local.get $*end/51))
                     (then
                      (block $outer/875 (result i32)
                       (block $join:121
                        (local.set $*p/332
                         (local.get $*cursor/52))
                        (local.set $next_char/122
                         (i32.load16_u offset=8
                          (i32.add
                           (local.get $*data/49)
                           (i32.shl
                            (local.get $*p/332)
                            (i32.const 1)))))
                        (local.set $*cursor/52
                         (i32.add
                          (local.tee $*tmp/593
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
                        (br $outer/875))
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
                      (local.tee $*tmp/594
                       (local.get $*cursor/52))
                      (local.get $*end/51))
                     (then
                      (local.set $*p/335
                       (local.get $*cursor/52))
                      (local.set $next_char/123
                       (i32.load16_u offset=8
                        (i32.add
                         (local.get $*data/49)
                         (i32.shl
                          (local.get $*p/335)
                          (i32.const 1)))))
                      (local.set $*cursor/52
                       (i32.add
                        (local.tee $*tmp/595
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
                    (local.tee $*tmp/596
                     (local.get $*cursor/52))
                    (local.get $*end/51))
                   (then
                    (local.set $*p/338
                     (local.get $*cursor/52))
                    (local.set $next_char/124
                     (i32.load16_u offset=8
                      (i32.add
                       (local.get $*data/49)
                       (i32.shl
                        (local.get $*p/338)
                        (i32.const 1)))))
                    (local.set $*cursor/52
                     (i32.add
                      (local.tee $*tmp/597
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
              (br $outer/874))
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
   (block $outer/876 (result i32)
    (block $join:90
     (block $outer/877 (result i32)
      (block $join:94
       (block $switch_int/888 (result i32)
        (block $switch_default/889
         (block $switch_int_1/891
          (block $switch_int_7/897
           (block $switch_int_6/896
            (block $switch_int_5/895
             (block $switch_int_4/894
              (block $switch_int_8/898
               (block $switch_int_0/890
                (block $switch_int_2/892
                 (block $switch_int_3/893
                  (local.get $dispatch_19/89)
                  (br_table
                   $switch_int_0/890
                   $switch_int_1/891
                   $switch_int_2/892
                   $switch_int_3/893
                   $switch_int_4/894
                   $switch_int_5/895
                   $switch_int_6/896
                   $switch_int_7/897
                   $switch_int_8/898
                   $switch_default/889
                   ))
                 (local.set $tag_1_2/63
                  (local.get $tag_1_1/62))
                 (local.set $tag_1_1/62
                  (local.get $tag_1/61))
                 (local.set $tag_1/61
                  (local.get $*cursor/52))
                 (if (result i32)
                  (i32.lt_s
                   (local.tee $*tmp/564
                    (local.get $*cursor/52))
                   (local.get $*end/51))
                  (then
                   (block $outer/878 (result i32)
                    (block $join:95
                     (local.set $*p/341
                      (local.get $*cursor/52))
                     (local.set $next_char/96
                      (i32.load16_u offset=8
                       (i32.add
                        (local.get $*data/49)
                        (i32.shl
                         (local.get $*p/341)
                         (i32.const 1)))))
                     (local.set $*cursor/52
                      (i32.add
                       (local.tee $*tmp/565
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
                             (local.tee $*tmp/566
                              (local.get $*cursor/52))
                             (local.get $*end/51))
                            (then
                             (block $outer/879 (result i32)
                              (block $join:97
                               (local.set $*p/344
                                (local.get $*cursor/52))
                               (local.set $next_char/98
                                (i32.load16_u offset=8
                                 (i32.add
                                  (local.get $*data/49)
                                  (i32.shl
                                   (local.get $*p/344)
                                   (i32.const 1)))))
                               (local.set $*cursor/52
                                (i32.add
                                 (local.tee $*tmp/567
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
                               (br $outer/879))
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
                     (br $outer/878))
                    (i32.const 0)
                    (br $loop:92)))
                  (else
                   (br $join:68)))
                 (br $switch_int/888))
                (local.set $tag_1/61
                 (local.get $*cursor/52))
                (local.set $tag_2/65
                 (local.get $*cursor/52))
                (if (result i32)
                 (i32.lt_s
                  (local.tee $*tmp/568
                   (local.get $*cursor/52))
                  (local.get $*end/51))
                 (then
                  (block $outer/880 (result i32)
                   (block $join:99
                    (local.set $*p/347
                     (local.get $*cursor/52))
                    (local.set $next_char/100
                     (i32.load16_u offset=8
                      (i32.add
                       (local.get $*data/49)
                       (i32.shl
                        (local.get $*p/347)
                        (i32.const 1)))))
                    (local.set $*cursor/52
                     (i32.add
                      (local.tee $*tmp/569
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
                    (br $outer/880))
                   (i32.const 0)
                   (br $loop:92)))
                 (else
                  (br $join:68)))
                (br $switch_int/888))
               (local.set $tag_1/61
                (local.get $*cursor/52))
               (if (result i32)
                (i32.lt_s
                 (local.tee $*tmp/570
                  (local.get $*cursor/52))
                 (local.get $*end/51))
                (then
                 (block $outer/881 (result i32)
                  (block $join:101
                   (local.set $*p/350
                    (local.get $*cursor/52))
                   (local.set $next_char/102
                    (i32.load16_u offset=8
                     (i32.add
                      (local.get $*data/49)
                      (i32.shl
                       (local.get $*p/350)
                       (i32.const 1)))))
                   (local.set $*cursor/52
                    (i32.add
                     (local.tee $*tmp/571
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
                   (br $outer/881))
                  (i32.const 0)
                  (br $loop:92)))
                (else
                 (br $join:68)))
               (br $switch_int/888))
              (if (result i32)
               (i32.lt_s
                (local.tee $*tmp/572
                 (local.get $*cursor/52))
                (local.get $*end/51))
               (then
                (local.set $*p/353
                 (local.get $*cursor/52))
                (local.set $next_char/103
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/49)
                   (i32.shl
                    (local.get $*p/353)
                    (i32.const 1)))))
                (local.set $*cursor/52
                 (i32.add
                  (local.tee $*tmp/573
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
              (br $switch_int/888))
             (local.set $tag_1/61
              (local.get $*cursor/52))
             (local.set $tag_4/67
              (local.get $*cursor/52))
             (if (result i32)
              (i32.lt_s
               (local.tee $*tmp/574
                (local.get $*cursor/52))
               (local.get $*end/51))
              (then
               (block $outer/882 (result i32)
                (block $join:104
                 (local.set $*p/356
                  (local.get $*cursor/52))
                 (local.set $next_char/105
                  (i32.load16_u offset=8
                   (i32.add
                    (local.get $*data/49)
                    (i32.shl
                     (local.get $*p/356)
                     (i32.const 1)))))
                 (local.set $*cursor/52
                  (i32.add
                   (local.tee $*tmp/575
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
                         (local.tee $*tmp/576
                          (local.get $*cursor/52))
                         (local.get $*end/51))
                        (then
                         (block $outer/883 (result i32)
                          (block $join:106
                           (local.set $*p/359
                            (local.get $*cursor/52))
                           (local.set $next_char/107
                            (i32.load16_u offset=8
                             (i32.add
                              (local.get $*data/49)
                              (i32.shl
                               (local.get $*p/359)
                               (i32.const 1)))))
                           (local.set $*cursor/52
                            (i32.add
                             (local.tee $*tmp/577
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
                                   (local.tee $*tmp/578
                                    (local.get $*cursor/52))
                                   (local.get $*end/51))
                                  (then
                                   (block $outer/884 (result i32)
                                    (block $join:108
                                     (local.set $*p/362
                                      (local.get $*cursor/52))
                                     (local.set $next_char/109
                                      (i32.load16_u offset=8
                                       (i32.add
                                        (local.get $*data/49)
                                        (i32.shl
                                         (local.get $*p/362)
                                         (i32.const 1)))))
                                     (local.set $*cursor/52
                                      (i32.add
                                       (local.tee $*tmp/579
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
                                     (br $outer/884))
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
                           (br $outer/883))
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
                 (br $outer/882))
                (i32.const 0)
                (br $loop:92)))
              (else
               (br $join:68)))
             (br $switch_int/888))
            (local.set $tag_1/61
             (local.get $*cursor/52))
            (local.set $tag_2/65
             (local.get $*cursor/52))
            (if (result i32)
             (i32.lt_s
              (local.tee $*tmp/580
               (local.get $*cursor/52))
              (local.get $*end/51))
             (then
              (block $outer/885 (result i32)
               (block $join:110
                (local.set $*p/365
                 (local.get $*cursor/52))
                (local.set $next_char/111
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/49)
                   (i32.shl
                    (local.get $*p/365)
                    (i32.const 1)))))
                (local.set $*cursor/52
                 (i32.add
                  (local.tee $*tmp/581
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
                (br $outer/885))
               (i32.const 0)
               (br $loop:92)))
             (else
              (br $join:94)))
            (br $switch_int/888))
           (local.set $tag_1/61
            (local.get $*cursor/52))
           (local.set $tag_2/65
            (local.get $*cursor/52))
           (local.set $tag_3/64
            (local.get $*cursor/52))
           (if (result i32)
            (i32.lt_s
             (local.tee $*tmp/582
              (local.get $*cursor/52))
             (local.get $*end/51))
            (then
             (block $outer/886 (result i32)
              (block $join:112
               (local.set $*p/368
                (local.get $*cursor/52))
               (local.set $next_char/113
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $*data/49)
                  (i32.shl
                   (local.get $*p/368)
                   (i32.const 1)))))
               (local.set $*cursor/52
                (i32.add
                 (local.tee $*tmp/583
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
               (br $outer/886))
              (i32.const 0)
              (br $loop:92)))
            (else
             (br $join:68)))
           (br $switch_int/888))
          (if (result i32)
           (i32.lt_s
            (local.tee $*tmp/584
             (local.get $*cursor/52))
            (local.get $*end/51))
           (then
            (local.set $*p/371
             (local.get $*cursor/52))
            (local.set $next_char/114
             (i32.load16_u offset=8
              (i32.add
               (local.get $*data/49)
               (i32.shl
                (local.get $*p/371)
                (i32.const 1)))))
            (local.set $*cursor/52
             (i32.add
              (local.tee $*tmp/585
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
          (br $switch_int/888))
         (local.set $tag_1_1/62
          (local.get $tag_1/61))
         (local.set $tag_1/61
          (local.get $*cursor/52))
         (if (result i32)
          (i32.lt_s
           (local.tee $*tmp/586
            (local.get $*cursor/52))
           (local.get $*end/51))
          (then
           (block $outer/887 (result i32)
            (block $join:115
             (local.set $*p/374
              (local.get $*cursor/52))
             (local.set $next_char/116
              (i32.load16_u offset=8
               (i32.add
                (local.get $*data/49)
                (i32.shl
                 (local.get $*p/374)
                 (i32.const 1)))))
             (local.set $*cursor/52
              (i32.add
               (local.tee $*tmp/587
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
             (br $outer/887))
            (i32.const 0)
            (br $loop:92)))
          (else
           (br $join:68)))
         (br $switch_int/888))
        (br $join:68))
       (br $outer/877))
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
     (br $outer/876))
    (local.set $tag_1_1/62
     (local.get $tag_1_2/63))
    (local.set $tag_1/61
     (local.get $*cursor/52))
    (local.set $tag_2/65
     (local.get $tag_2_1/66))
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/562
       (local.get $*cursor/52))
      (local.get $*end/51))
     (then
      (block $outer/899 (result i32)
       (block $join:91
        (local.set $*p/377
         (local.get $*cursor/52))
        (local.set $next_char/93
         (i32.load16_u offset=8
          (i32.add
           (local.get $*data/49)
           (i32.shl
            (local.get $*p/377)
            (i32.const 1)))))
        (local.set $*cursor/52
         (i32.add
          (local.tee $*tmp/563
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
        (br $outer/899))
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
   (block $outer/911 (result i32) (result i32) (result i32)
    (block $join:70
     (local.set $*tmp/555
      (i64.extend_i32_s
       (local.tee $*tmp/558
        (i32.add
         (local.tee $*tmp/559
          (local.get $match_tag_saver_1/56))
         (i32.const 1)))))
     (local.set $*tmp/556
      (i64.extend_i32_s
       (local.tee $*tmp/557
        (local.get $match_tag_saver_2/57))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/555)
      (local.get $*tmp/556))
     (local.set $*obj/2/912)
     (local.set $*obj/1/912)
     (local.set $*obj/0/912)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/912)
       (local.get $*obj/1/912)
       (local.set $*ok/2/560
        (local.get $*obj/2/912))
       (local.set $*ok/1/560)
       (local.tee $*ok/0/560)
       (local.get $*ok/1/560)
       (local.get $*ok/2/560))
      (else
       (local.set $*try_err/71
        (local.tee $*err/561
         (local.get $*obj/0/912)))
       (br $join:70)))
     (br $outer/911))
    (call $moonbit.decref
     (local.get $*try_err/71))
    (unreachable))
   (local.set $start_line/2/69)
   (local.set $start_line/1/69)
   (local.set $start_line/0/69)
   (block $outer/909 (result i32) (result i32) (result i32)
    (block $join:73
     (local.set $*tmp/548
      (i64.extend_i32_s
       (local.tee $*tmp/551
        (i32.add
         (local.tee $*tmp/552
          (local.get $match_tag_saver_2/57))
         (i32.const 1)))))
     (local.set $*tmp/549
      (i64.extend_i32_s
       (local.tee $*tmp/550
        (local.get $match_tag_saver_3/58))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/548)
      (local.get $*tmp/549))
     (local.set $*obj/2/910)
     (local.set $*obj/1/910)
     (local.set $*obj/0/910)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/910)
       (local.get $*obj/1/910)
       (local.set $*ok/2/553
        (local.get $*obj/2/910))
       (local.set $*ok/1/553)
       (local.tee $*ok/0/553)
       (local.get $*ok/1/553)
       (local.get $*ok/2/553))
      (else
       (local.set $*try_err/74
        (local.tee $*err/554
         (local.get $*obj/0/910)))
       (br $join:73)))
     (br $outer/909))
    (call $moonbit.decref
     (local.get $*try_err/74))
    (unreachable))
   (local.set $start_column/2/72)
   (local.set $start_column/1/72)
   (local.set $start_column/0/72)
   (block $outer/907 (result i32) (result i32) (result i32)
    (block $join:76
     (local.set $*tmp/542
      (i64.extend_i32_s
       (local.tee $*tmp/545
        (i32.add
         (local.get $*start/50)
         (i32.const 1)))))
     (local.set $*tmp/543
      (i64.extend_i32_s
       (local.tee $*tmp/544
        (local.get $match_tag_saver_0/55))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/542)
      (local.get $*tmp/543))
     (local.set $*obj/2/908)
     (local.set $*obj/1/908)
     (local.set $*obj/0/908)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/908)
       (local.get $*obj/1/908)
       (local.set $*ok/2/546
        (local.get $*obj/2/908))
       (local.set $*ok/1/546)
       (local.tee $*ok/0/546)
       (local.get $*ok/1/546)
       (local.get $*ok/2/546))
      (else
       (local.set $*try_err/77
        (local.tee $*err/547
         (local.get $*obj/0/908)))
       (br $join:76)))
     (br $outer/907))
    (call $moonbit.decref
     (local.get $*try_err/77))
    (unreachable))
   (local.set $pkg/2/75)
   (local.set $pkg/1/75)
   (local.set $pkg/0/75)
   (block $outer/905 (result i32) (result i32) (result i32)
    (block $join:79
     (local.set $*tmp/535
      (i64.extend_i32_s
       (local.tee $*tmp/538
        (i32.add
         (local.tee $*tmp/539
          (local.get $match_tag_saver_0/55))
         (i32.const 1)))))
     (local.set $*tmp/536
      (i64.extend_i32_s
       (local.tee $*tmp/537
        (local.get $match_tag_saver_1/56))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/535)
      (local.get $*tmp/536))
     (local.set $*obj/2/906)
     (local.set $*obj/1/906)
     (local.set $*obj/0/906)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/906)
       (local.get $*obj/1/906)
       (local.set $*ok/2/540
        (local.get $*obj/2/906))
       (local.set $*ok/1/540)
       (local.tee $*ok/0/540)
       (local.get $*ok/1/540)
       (local.get $*ok/2/540))
      (else
       (local.set $*try_err/80
        (local.tee $*err/541
         (local.get $*obj/0/906)))
       (br $join:79)))
     (br $outer/905))
    (call $moonbit.decref
     (local.get $*try_err/80))
    (unreachable))
   (local.set $filename/2/78)
   (local.set $filename/1/78)
   (local.set $filename/0/78)
   (block $outer/903 (result i32) (result i32) (result i32)
    (block $join:82
     (local.set $*tmp/528
      (i64.extend_i32_s
       (local.tee $*tmp/531
        (i32.add
         (local.tee $*tmp/532
          (local.get $match_tag_saver_3/58))
         (i32.const 1)))))
     (local.set $*tmp/529
      (i64.extend_i32_s
       (local.tee $*tmp/530
        (local.get $match_tag_saver_4/59))))
     (call $moonbit.incref
      (local.get $*data/49))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/528)
      (local.get $*tmp/529))
     (local.set $*obj/2/904)
     (local.set $*obj/1/904)
     (local.set $*obj/0/904)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/904)
       (local.get $*obj/1/904)
       (local.set $*ok/2/533
        (local.get $*obj/2/904))
       (local.set $*ok/1/533)
       (local.tee $*ok/0/533)
       (local.get $*ok/1/533)
       (local.get $*ok/2/533))
      (else
       (local.set $*try_err/83
        (local.tee $*err/534
         (local.get $*obj/0/904)))
       (br $join:82)))
     (br $outer/903))
    (call $moonbit.decref
     (local.get $*try_err/83))
    (unreachable))
   (local.set $end_line/2/81)
   (local.set $end_line/1/81)
   (local.set $end_line/0/81)
   (block $outer/901 (result i32) (result i32) (result i32)
    (block $join:85
     (local.set $*tmp/521
      (i64.extend_i32_s
       (local.tee $*tmp/524
        (i32.add
         (local.tee $*tmp/525
          (local.get $match_tag_saver_4/59))
         (i32.const 1)))))
     (local.set $*tmp/522
      (i64.extend_i32_s
       (local.tee $*tmp/523
        (local.get $match_end/54))))
     (call $String::sub
      (local.get $*data/49)
      (local.get $*tmp/521)
      (local.get $*tmp/522))
     (local.set $*obj/2/902)
     (local.set $*obj/1/902)
     (local.set $*obj/0/902)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/902)
       (local.get $*obj/1/902)
       (local.set $*ok/2/526
        (local.get $*obj/2/902))
       (local.set $*ok/1/526)
       (local.tee $*ok/0/526)
       (local.get $*ok/1/526)
       (local.get $*ok/2/526))
      (else
       (local.set $*try_err/86
        (local.tee $*err/527
         (local.get $*obj/0/902)))
       (br $join:85)))
     (br $outer/901))
    (call $moonbit.decref
     (local.get $*try_err/86))
    (unreachable))
   (local.set $end_column/2/84)
   (local.set $end_column/1/84)
   (local.set $end_column/0/84)
   (i32.store offset=4
    (local.tee $ptr/900
     (call $moonbit.gc.malloc
      (i32.const 72)))
    (i32.const 7341568))
   (i32.store offset=76
    (local.get $ptr/900)
    (local.get $end_column/0/84))
   (i32.store offset=48
    (local.get $ptr/900)
    (local.get $end_column/1/84))
   (i32.store offset=52
    (local.get $ptr/900)
    (local.get $end_column/2/84))
   (i32.store offset=72
    (local.get $ptr/900)
    (local.get $end_line/0/81))
   (i32.store offset=40
    (local.get $ptr/900)
    (local.get $end_line/1/81))
   (i32.store offset=44
    (local.get $ptr/900)
    (local.get $end_line/2/81))
   (i32.store offset=68
    (local.get $ptr/900)
    (local.get $start_column/0/72))
   (i32.store offset=32
    (local.get $ptr/900)
    (local.get $start_column/1/72))
   (i32.store offset=36
    (local.get $ptr/900)
    (local.get $start_column/2/72))
   (i32.store offset=64
    (local.get $ptr/900)
    (local.get $start_line/0/69))
   (i32.store offset=24
    (local.get $ptr/900)
    (local.get $start_line/1/69))
   (i32.store offset=28
    (local.get $ptr/900)
    (local.get $start_line/2/69))
   (i32.store offset=60
    (local.get $ptr/900)
    (local.get $filename/0/78))
   (i32.store offset=16
    (local.get $ptr/900)
    (local.get $filename/1/78))
   (i32.store offset=20
    (local.get $ptr/900)
    (local.get $filename/2/78))
   (i32.store offset=56
    (local.get $ptr/900)
    (local.get $pkg/0/75))
   (i32.store offset=8
    (local.get $ptr/900)
    (local.get $pkg/1/75))
   (i32.store offset=12
    (local.get $ptr/900)
    (local.get $pkg/2/75))
   (local.get $ptr/900))
  (else
   (call $moonbit.decref
    (local.get $*data/49))
   (unreachable))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/41 i32) (param $ch/43 i32) (result i32)
 (local $inc/42 i32)
 (local $*tmp/515 i32)
 (local $len/516 i32)
 (local $*tmp/517 i32)
 (local $len/518 i32)
 (local $data/519 i32)
 (local $len/520 i32)
 (local $*field/830 i32)
 (local.set $*tmp/515
  (i32.add
   (local.tee $len/516
    (i32.load offset=8
     (local.get $self/41)))
   (i32.const 4)))
 (call $moonbit.incref
  (local.get $self/41))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/41)
   (local.get $*tmp/515)))
 (local.set $data/519
  (local.tee $*field/830
   (i32.load offset=12
    (local.get $self/41))))
 (local.set $len/520
  (i32.load offset=8
   (local.get $self/41)))
 (call $moonbit.incref
  (local.get $data/519))
 (local.set $inc/42
  (call $FixedArray::set_utf16le_char
   (local.get $data/519)
   (local.get $len/520)
   (local.get $ch/43)))
 (local.set $*tmp/517
  (i32.add
   (local.tee $len/518
    (i32.load offset=8
     (local.get $self/41)))
   (local.get $inc/42)))
 (i32.store offset=8
  (local.get $self/41)
  (local.get $*tmp/517))
 (call $moonbit.decref
  (local.get $self/41))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/36 i32) (param $required/37 i32) (result i32)
 (local $current_len/35 i32)
 (local $new_data/40 i32)
 (local $*tmp/509 i32)
 (local $*tmp/510 i32)
 (local $data/511 i32)
 (local $len/512 i32)
 (local $*tmp/513 i32)
 (local $data/514 i32)
 (local $*old/831 i32)
 (local $*field/832 i32)
 (local $*tmp/833 i32)
 (local $*field/834 i32)
 (local $enough_space/38 i32)
 (local.set $current_len/35
  (local.tee $*tmp/833
   (call $moonbit.array_length
    (local.tee $data/514
     (local.tee $*field/834
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
    (local.tee $*tmp/509
     (local.get $enough_space/38))
    (local.get $required/37))
   (then
    (local.set $enough_space/38
     (i32.mul
      (local.tee $*tmp/510
       (local.get $enough_space/38))
      (i32.const 2)))
    (br $loop:39))
   (else)))
 (local.set $new_data/40
  (call $moonbit.bytes_make
   (local.tee $*tmp/513
    (local.get $enough_space/38))
   (i32.const 0)))
 (local.set $data/511
  (local.tee $*field/832
   (i32.load offset=12
    (local.get $self/36))))
 (local.set $len/512
  (i32.load offset=8
   (local.get $self/36)))
 (call $moonbit.incref
  (local.get $data/511))
 (call $moonbit.incref
  (local.get $new_data/40))
 (drop
  (call $FixedArray::unsafe_blit|Byte|
   (local.get $new_data/40)
   (i32.const 0)
   (local.get $data/511)
   (i32.const 0)
   (local.get $len/512)))
 (call $moonbit.decref
  (local.tee $*old/831
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
 (local $*p/300 i32)
 (local $*p/303 i32)
 (local $*p/306 i32)
 (local $*p/309 i32)
 (local $*p/312 i32)
 (local $*p/315 i32)
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
 (local $*tmp/501 i32)
 (local $*tmp/502 i32)
 (local $*tmp/503 i32)
 (local $*tmp/504 i32)
 (local $*tmp/505 i32)
 (local $*tmp/506 i32)
 (local $*tmp/507 i32)
 (local $*tmp/508 i32)
 (local $*arr/913 i32)
 (local $*idx/914 i32)
 (local $*arr/915 i32)
 (local $*idx/916 i32)
 (local $*arr/917 i32)
 (local $*idx/918 i32)
 (local $*arr/919 i32)
 (local $*idx/920 i32)
 (local $*arr/921 i32)
 (local $*idx/922 i32)
 (local $*arr/923 i32)
 (local $*idx/924 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/28
    (local.tee $*tmp/508
     (local.get $value/29)))
   (i32.const 65536))
  (then
   (local.set $*tmp/490
    (i32.and
     (local.tee $*tmp/491
      (local.tee $*p/300
       (i32.and
        (local.get $code/28)
        (i32.const 255))))
     (i32.const 255)))
   (local.get $self/30)
   (local.set $*idx/916
    (local.get $offset/31))
   (local.set $*arr/915)
   (call $moonbit.check_range
    (local.get $*idx/916)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/915))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/915)
     (local.get $*idx/916))
    (local.get $*tmp/490))
   (local.set $*tmp/492
    (i32.add
     (local.get $offset/31)
     (i32.const 1)))
   (local.set $*tmp/493
    (i32.and
     (local.tee $*tmp/494
      (local.tee $*p/303
       (i32.shr_u
        (local.get $code/28)
        (i32.const 8))))
     (i32.const 255)))
   (local.get $self/30)
   (local.set $*idx/914
    (local.get $*tmp/492))
   (local.set $*arr/913)
   (call $moonbit.check_range
    (local.get $*idx/914)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/913))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/913)
     (local.get $*idx/914))
    (local.get $*tmp/493))
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
       (local.tee $*tmp/507
        (i32.shr_u
         (local.tee $hi/32
          (i32.sub
           (local.get $code/28)
           (i32.const 65536)))
         (i32.const 10)))
       (i32.const 55296)))
     (local.set $hi/34
      (i32.or
       (local.tee $*tmp/506
        (i32.and
         (local.get $hi/32)
         (i32.const 1023)))
       (i32.const 56320)))
     (local.set $*tmp/495
      (i32.and
       (local.tee $*tmp/496
        (local.tee $*p/306
         (i32.and
          (local.get $lo/33)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/924
      (local.get $offset/31))
     (local.set $*arr/923)
     (call $moonbit.check_range
      (local.get $*idx/924)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/923))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/923)
       (local.get $*idx/924))
      (local.get $*tmp/495))
     (local.set $*tmp/497
      (i32.add
       (local.get $offset/31)
       (i32.const 1)))
     (local.set $*tmp/498
      (i32.and
       (local.tee $*tmp/499
        (local.tee $*p/309
         (i32.shr_u
          (local.get $lo/33)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/922
      (local.get $*tmp/497))
     (local.set $*arr/921)
     (call $moonbit.check_range
      (local.get $*idx/922)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/921))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/921)
       (local.get $*idx/922))
      (local.get $*tmp/498))
     (local.set $*tmp/500
      (i32.add
       (local.get $offset/31)
       (i32.const 2)))
     (local.set $*tmp/501
      (i32.and
       (local.tee $*tmp/502
        (local.tee $*p/312
         (i32.and
          (local.get $hi/34)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/920
      (local.get $*tmp/500))
     (local.set $*arr/919)
     (call $moonbit.check_range
      (local.get $*idx/920)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/919))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/919)
       (local.get $*idx/920))
      (local.get $*tmp/501))
     (local.set $*tmp/503
      (i32.add
       (local.get $offset/31)
       (i32.const 3)))
     (local.set $*tmp/504
      (i32.and
       (local.tee $*tmp/505
        (local.tee $*p/315
         (i32.shr_u
          (local.get $hi/34)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/30)
     (local.set $*idx/918
      (local.get $*tmp/503))
     (local.set $*arr/917)
     (call $moonbit.check_range
      (local.get $*idx/918)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/917))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/917)
       (local.get $*idx/918))
      (local.get $*tmp/504))
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
 (local $*tmp/484 i32)
 (local $*tmp/485 i64)
 (local $len/486 i32)
 (local $data/487 i32)
 (local $*field/835 i32)
 (local $*field/836 i32)
 (call $moonbit.incref
  (local.tee $data/487
   (local.tee $*field/836
    (i32.load offset=12
     (local.get $self/25)))))
 (local.set $*tmp/484
  (local.get $data/487))
 (local.set $*field/835
  (i32.load offset=8
   (local.get $self/25)))
 (call $moonbit.decref
  (local.get $self/25))
 (local.set $*tmp/485
  (i64.extend_i32_s
   (local.tee $len/486
    (local.get $*field/835))))
 (call $Bytes::to_unchecked_string.inner
  (local.get $*tmp/484)
  (i32.const 0)
  (local.get $*tmp/485)))
(func $Bytes::to_unchecked_string.inner (param $self/20 i32) (param $offset/24 i32) (param $length/22 i64) (result i32)
 (local $len/19 i32)
 (local $length/21 i32)
 (local $*Some/23 i64)
 (local $*tmp/483 i32)
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
       (local.tee $*tmp/483
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
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/444 i32) (param $*param/445 i32) (param $*param/446 i32) (result i32)
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/444)
  (local.get $*param/445)
  (local.get $*param/446)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/17 i32) (result i32)
 (local $initial/16 i32)
 (local $data/18 i32)
 (local $ptr/925 i32)
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
  (local.tee $ptr/925
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/925)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/925)
  (local.get $data/18))
 (local.get $ptr/925))
(func $FixedArray::unsafe_blit|Byte| (param $dst/7 i32) (param $dst_offset/9 i32) (param $src/8 i32) (param $src_offset/10 i32) (param $len/12 i32) (result i32)
 (local $i/11 i32)
 (local $i/14 i32)
 (local $*tmp/474 i32)
 (local $*tmp/475 i32)
 (local $*tmp/476 i32)
 (local $*tmp/477 i32)
 (local $*tmp/478 i32)
 (local $*tmp/479 i32)
 (local $*tmp/480 i32)
 (local $*tmp/481 i32)
 (local $*tmp/482 i32)
 (local $*arr/926 i32)
 (local $*idx/927 i32)
 (local $*arr/928 i32)
 (local $*idx/929 i32)
 (local $*arr/930 i32)
 (local $*idx/931 i32)
 (local $*arr/932 i32)
 (local $*idx/933 i32)
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
      (local.set $*tmp/474
       (i32.add
        (local.get $dst_offset/9)
        (local.get $i/11)))
      (local.set $*tmp/476
       (i32.add
        (local.get $src_offset/10)
        (local.get $i/11)))
      (local.get $src/8)
      (local.set $*idx/929
       (local.get $*tmp/476))
      (local.set $*arr/928)
      (call $moonbit.check_range
       (local.get $*idx/929)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/928))
        (i32.const 1)))
      (local.set $*tmp/475
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/928)
         (local.get $*idx/929))))
      (local.get $dst/7)
      (local.set $*idx/927
       (local.get $*tmp/474))
      (local.set $*arr/926)
      (call $moonbit.check_range
       (local.get $*idx/927)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/926))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/926)
        (local.get $*idx/927))
       (local.get $*tmp/475))
      (local.tee $*tmp/477
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
   (local.tee $*tmp/482
    (i32.sub
     (local.get $len/12)
     (i32.const 1)))
   (loop $loop:15 (param i32)
    (local.tee $i/14)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/478
       (i32.add
        (local.get $dst_offset/9)
        (local.get $i/14)))
      (local.set $*tmp/480
       (i32.add
        (local.get $src_offset/10)
        (local.get $i/14)))
      (local.get $src/8)
      (local.set $*idx/933
       (local.get $*tmp/480))
      (local.set $*arr/932)
      (call $moonbit.check_range
       (local.get $*idx/933)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/932))
        (i32.const 1)))
      (local.set $*tmp/479
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/932)
         (local.get $*idx/933))))
      (local.get $dst/7)
      (local.set $*idx/931
       (local.get $*tmp/478))
      (local.set $*arr/930)
      (call $moonbit.check_range
       (local.get $*idx/931)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/930))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/930)
        (local.get $*idx/931))
       (local.get $*tmp/479))
      (local.tee $*tmp/481
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
 (local $*tmp/470 i32)
 (local $*tmp/471 i32)
 (local $*tmp/472 i32)
 (local $*tmp/473 i32)
 (local.set $*tmp/472
  (call $moonbit.add_string
   (local.get $string/5)
   (i32.const 10504)))
 (local.set $*tmp/473
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/6)))
 (call $moonbitlang/core/abort.abort|Int|
  (local.tee $*tmp/470
   (call $moonbit.add_string
    (local.tee $*tmp/471
     (call $moonbit.add_string
      (local.get $*tmp/472)
      (local.get $*tmp/473)))
    (i32.const 10488)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/3 i32) (param $loc/4 i32) (result i32)
 (local $*tmp/466 i32)
 (local $*tmp/467 i32)
 (local $*tmp/468 i32)
 (local $*tmp/469 i32)
 (local.set $*tmp/468
  (call $moonbit.add_string
   (local.get $string/3)
   (i32.const 10504)))
 (local.set $*tmp/469
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/4)))
 (call $moonbitlang/core/abort.abort|Unit|
  (local.tee $*tmp/466
   (call $moonbit.add_string
    (local.tee $*tmp/467
     (call $moonbit.add_string
      (local.get $*tmp/468)
      (local.get $*tmp/469)))
    (i32.const 10488)))))
(func $moonbitlang/core/abort.abort|Int| (param $msg/2 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/2))
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/1 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/1))
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/460 i32) (param $*param/459 i32) (result i32)
 (local $*self/458 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/458
   (local.get $*obj_ptr/460))
  (local.get $*param/459)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/457 i32) (param $*param/0/456 i32) (param $*param/1/456 i32) (param $*param/2/456 i32) (result i32)
 (local $*self/455 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/455
   (local.get $*obj_ptr/457))
  (local.get $*param/0/456)
  (local.get $*param/1/456)
  (local.get $*param/2/456)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (param $*obj_ptr/454 i32) (param $*param/451 i32) (param $*param/452 i32) (param $*param/453 i32) (result i32)
 (local $*self/450 i32)
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/450
   (local.get $*obj_ptr/454))
  (local.get $*param/451)
  (local.get $*param/452)
  (local.get $*param/453)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/449 i32) (param $*param/448 i32) (result i32)
 (local $*self/447 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/447
   (local.get $*obj_ptr/449))
  (local.get $*param/448)))
(func $*main*/1
 (local $int_box/292 i32)
 (local $str_box/293 i32)
 (local $*tmp/461 i32)
 (local $*tmp/462 i32)
 (local $value/463 i32)
 (local $*tmp/464 i32)
 (local $value/465 i32)
 (local $*field/837 i32)
 (local $*field/838 i32)
 (local $*cnt/852 i32)
 (local $*new_cnt/853 i32)
 (local.set $int_box/292
  (call $@username/moonbit_examples/cmd/generics.Box::new|Int|
   (i32.const 42)))
 (local.set $str_box/293
  (call $@username/moonbit_examples/cmd/generics.Box::new|String|
   (i32.const 10632)))
 (local.set $*field/838
  (i32.load offset=8
   (local.get $int_box/292)))
 (call $moonbit.decref
  (local.get $int_box/292))
 (local.set $*tmp/462
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $value/463
    (local.get $*field/838))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/461
    (call $moonbit.add_string
     (i32.const 10584)
     (local.get $*tmp/462)))))
 (local.set $*field/837
  (i32.load offset=8
   (local.get $str_box/293)))
 (if
  (i32.gt_s
   (local.tee $*cnt/852
    (i32.load
     (local.get $str_box/293)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/853
    (i32.sub
     (local.get $*cnt/852)
     (i32.const 1)))
   (i32.store
    (local.get $str_box/293)
    (local.get $*new_cnt/853))
   (call $moonbit.incref
    (local.get $*field/837)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/852)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $str_box/293)))
    (else))))
 (local.set $value/465
  (local.get $*field/837))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/464
    (call $moonbit.add_string
     (i32.const 10528)
     (local.get $value/465))))))
(export "_start" (func $*main*/1))