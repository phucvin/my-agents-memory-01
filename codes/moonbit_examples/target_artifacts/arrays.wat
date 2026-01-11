(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data  (memory $moonbit.memory) (offset (i32.const 10000)) "\FF\FF\FF\FF\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\02\00\00P,\00 \00\00\00\00\00\FF\FF\FF\FF\01\00\00P]\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P[\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P0\00\00\00\00\00\00\00\FF\FF\FF\FF4\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\002\003\009\00:\005\00-\002\003\009\00:\004\004\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00Pr\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\FF\FF\FF\FF$\00\00P0\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF0\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\008\00:\005\00-\002\009\008\00:\003\001\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\11\00\00PC\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P\0A\00\00\00\00\00\00\00\FF\FF\FF\FF\06\00\00P\0A\00 \00 \00a\00t\00 \00\00\00\00\00\FF\FF\FF\FF\0F\00\00PD\00o\00u\00b\00l\00e\00d\00 \00a\00r\00r\00a\00y\00:\00 \00\00\00\FF\FF\FF\FF\00\00\00`\00\00\00\00\00\00\00\00\FF\FF\FF\FF\17\00\00PS\00u\00m\00 \00o\00f\00 \00a\00r\00r\00a\00y\00 \00e\00l\00e\00m\00e\00n\00t\00s\00:\00 \00\00\00\FF\FF\FF\FF\10\00\00PO\00r\00i\00g\00i\00n\00a\00l\00 \00a\00r\00r\00a\00y\00:\00 \00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\00\04\10\00\01\00\00\00\02\00\00\00\03\00\00\00\04\00\00\00")
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
    (i32.const 10760)
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
   (i32.const 10760)
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
(type $<>=>Option<Int>
 (func
  (param i32)
  (result i64)))
(table $moonbit.global 5 5 funcref )
(elem
 (table $moonbit.global) (offset (i32.const 0))
 funcref
 (ref.func $ArrayView::iter|Int|.*p.fn/1)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder|)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger)
 (ref.func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger))
(global $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id
 i32
 (i32.const 10736)
)
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/342 i32) (param $logger/0/343 i32) (param $logger/1/343 i32) (result i32)
 (local $*tmp/909 i32)
 (local $*tmp/910 i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (local.tee $*tmp/909
   (call $@moonbitlang/core/builtin.SourceLocRepr::parse
    (local.tee $*tmp/910
     (local.get $self/342))))
  (local.get $logger/0/343)
  (local.get $logger/1/343)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/305 i32) (param $logger/0/341 i32) (param $logger/1/341 i32) (result i32)
 (local $pkg/0/304 i32)
 (local $pkg/1/304 i32)
 (local $pkg/2/304 i32)
 (local $*data/306 i32)
 (local $*start/307 i32)
 (local $*end/308 i32)
 (local $*bind/314 i32)
 (local $package_name/0/316 i32)
 (local $package_name/1/316 i32)
 (local $package_name/2/316 i32)
 (local $*try_err/318 i32)
 (local $module_name/0/319 i32)
 (local $module_name/1/319 i32)
 (local $module_name/2/319 i32)
 (local $*try_err/321 i32)
 (local $next_char/324 i32)
 (local $next_char/327 i32)
 (local $next_char/330 i32)
 (local $next_char/331 i32)
 (local $next_char/332 i32)
 (local $next_char/333 i32)
 (local $next_char/334 i32)
 (local $next_char/335 i32)
 (local $next_char/336 i32)
 (local $*module_name/0/337 i32)
 (local $*module_name/1/337 i32)
 (local $*module_name/2/337 i32)
 (local $*package_name/338 i32)
 (local $*Some/339 i32)
 (local $*pkg_name/0/340 i32)
 (local $*pkg_name/1/340 i32)
 (local $*pkg_name/2/340 i32)
 (local $*p/478 i32)
 (local $*p/481 i32)
 (local $*p/484 i32)
 (local $*p/487 i32)
 (local $*p/490 i32)
 (local $*p/493 i32)
 (local $*p/496 i32)
 (local $*p/499 i32)
 (local $*p/502 i32)
 (local $*bind/0/867 i32)
 (local $*bind/1/867 i32)
 (local $*bind/0/868 i32)
 (local $*bind/1/868 i32)
 (local $filename/0/869 i32)
 (local $filename/1/869 i32)
 (local $filename/2/869 i32)
 (local $start_line/0/870 i32)
 (local $start_line/1/870 i32)
 (local $start_line/2/870 i32)
 (local $start_column/0/871 i32)
 (local $start_column/1/871 i32)
 (local $start_column/2/871 i32)
 (local $end_line/0/872 i32)
 (local $end_line/1/872 i32)
 (local $end_line/2/872 i32)
 (local $end_column/0/873 i32)
 (local $end_column/1/873 i32)
 (local $end_column/2/873 i32)
 (local $Some/874 i32)
 (local $*tmp/875 i64)
 (local $*tmp/876 i64)
 (local $*tmp/877 i32)
 (local $*ok/0/878 i32)
 (local $*ok/1/878 i32)
 (local $*ok/2/878 i32)
 (local $*err/879 i32)
 (local $*tmp/880 i64)
 (local $*tmp/881 i64)
 (local $*tmp/882 i32)
 (local $*tmp/883 i32)
 (local $*tmp/884 i32)
 (local $*ok/0/885 i32)
 (local $*ok/1/885 i32)
 (local $*ok/2/885 i32)
 (local $*err/886 i32)
 (local $None/887 i32)
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
 (local $end/907 i32)
 (local $start/908 i32)
 (local $*field/0/911 i32)
 (local $*field/1/911 i32)
 (local $*field/2/911 i32)
 (local $*field/0/912 i32)
 (local $*field/1/912 i32)
 (local $*field/2/912 i32)
 (local $*field/0/913 i32)
 (local $*field/1/913 i32)
 (local $*field/2/913 i32)
 (local $*field/0/914 i32)
 (local $*field/1/914 i32)
 (local $*field/2/914 i32)
 (local $*field/0/915 i32)
 (local $*field/1/915 i32)
 (local $*field/2/915 i32)
 (local $*field/0/916 i32)
 (local $*field/1/916 i32)
 (local $*field/2/916 i32)
 (local $*field/917 i32)
 (local $*field/0/918 i32)
 (local $*field/1/918 i32)
 (local $*field/2/918 i32)
 (local $*field/919 i32)
 (local $*field/0/920 i32)
 (local $*field/1/920 i32)
 (local $*field/2/920 i32)
 (local $*cnt/957 i32)
 (local $*new_cnt/958 i32)
 (local $*cnt/959 i32)
 (local $*new_cnt/960 i32)
 (local $*cnt/961 i32)
 (local $*field/0/962 i32)
 (local $*field/1/962 i32)
 (local $*field/2/962 i32)
 (local $*field/0/963 i32)
 (local $*field/1/963 i32)
 (local $*field/2/963 i32)
 (local $*field/0/964 i32)
 (local $*field/1/964 i32)
 (local $*field/2/964 i32)
 (local $*field/0/965 i32)
 (local $*field/1/965 i32)
 (local $*field/2/965 i32)
 (local $*field/0/966 i32)
 (local $*field/1/966 i32)
 (local $*field/2/966 i32)
 (local $*new_cnt/967 i32)
 (local $*tag/974 i32)
 (local $ptr/979 i32)
 (local $ptr/980 i32)
 (local $ptr/981 i32)
 (local $*obj/0/983 i32)
 (local $*obj/1/983 i32)
 (local $*obj/2/983 i32)
 (local $*obj/0/985 i32)
 (local $*obj/1/985 i32)
 (local $*obj/2/985 i32)
 (local $*cursor/309 i32)
 (local $accept_state/310 i32)
 (local $match_end/311 i32)
 (local $match_tag_saver_0/312 i32)
 (local $tag_0/313 i32)
 (i32.load offset=56
  (local.get $self/305))
 (i32.load offset=8
  (local.get $self/305))
 (local.set $*field/2/920
  (i32.load offset=12
   (local.get $self/305)))
 (local.set $*field/1/920)
 (local.tee $*field/0/920)
 (local.get $*field/1/920)
 (local.set $pkg/2/304
  (local.get $*field/2/920))
 (local.set $pkg/1/304)
 (local.tee $pkg/0/304)
 (local.tee $*field/919)
 (local.set $*data/306)
 (local.set $*start/307
  (local.get $pkg/1/304))
 (local.set $end/907
  (local.get $pkg/2/304))
 (local.set $start/908
  (local.get $pkg/1/304))
 (local.set $*tmp/906
  (i32.sub
   (local.get $end/907)
   (local.get $start/908)))
 (local.set $*end/308
  (i32.add
   (local.get $*start/307)
   (local.get $*tmp/906)))
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
 (block $outer/975 (result i32)
  (block $join:315
   (call $moonbit.incref
    (local.get $*data/306))
   (call $moonbit.incref
    (local.get $pkg/0/304))
   (loop $loop:323 (result i32)
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/888
       (local.get $*cursor/309))
      (local.get $*end/308))
     (then
      (block $outer/976 (result i32)
       (block $join:322
        (local.set $*p/478
         (local.get $*cursor/309))
        (local.set $next_char/324
         (i32.load16_u offset=8
          (i32.add
           (local.get $*data/306)
           (i32.shl
            (local.get $*p/478)
            (i32.const 1)))))
        (local.set $*cursor/309
         (i32.add
          (local.tee $*tmp/889
           (local.get $*cursor/309))
          (i32.const 1)))
        (if (result i32)
         (i32.lt_s
          (local.get $next_char/324)
          (i32.const 55296))
         (then
          (if (result i32)
           (i32.lt_s
            (local.get $next_char/324)
            (i32.const 47))
           (then
            (br $join:322))
           (else
            (if (result i32)
             (i32.gt_s
              (local.get $next_char/324)
              (i32.const 47))
             (then
              (br $join:322))
             (else
              (loop $loop:326 (result i32)
               (local.set $tag_0/313
                (local.get $*cursor/309))
               (if (result i32)
                (i32.lt_s
                 (local.tee $*tmp/890
                  (local.get $*cursor/309))
                 (local.get $*end/308))
                (then
                 (block $outer/977 (result i32)
                  (block $join:325
                   (local.set $*p/481
                    (local.get $*cursor/309))
                   (local.set $next_char/327
                    (i32.load16_u offset=8
                     (i32.add
                      (local.get $*data/306)
                      (i32.shl
                       (local.get $*p/481)
                       (i32.const 1)))))
                   (local.set $*cursor/309
                    (i32.add
                     (local.tee $*tmp/891
                      (local.get $*cursor/309))
                     (i32.const 1)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/327)
                     (i32.const 55296))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/327)
                       (i32.const 47))
                      (then
                       (br $join:325))
                      (else
                       (if (result i32)
                        (i32.gt_s
                         (local.get $next_char/327)
                         (i32.const 47))
                        (then
                         (br $join:325))
                        (else
                         (loop $loop:329 (result i32)
                          (if (result i32)
                           (i32.lt_s
                            (local.tee $*tmp/892
                             (local.get $*cursor/309))
                            (local.get $*end/308))
                           (then
                            (block $outer/978 (result i32)
                             (block $join:328
                              (local.set $*p/484
                               (local.get $*cursor/309))
                              (local.set $next_char/330
                               (i32.load16_u offset=8
                                (i32.add
                                 (local.get $*data/306)
                                 (i32.shl
                                  (local.get $*p/484)
                                  (i32.const 1)))))
                              (local.set $*cursor/309
                               (i32.add
                                (local.tee $*tmp/893
                                 (local.get $*cursor/309))
                                (i32.const 1)))
                              (if (result i32)
                               (i32.lt_s
                                (local.get $next_char/330)
                                (i32.const 56319))
                               (then
                                (if (result i32)
                                 (i32.lt_s
                                  (local.get $next_char/330)
                                  (i32.const 55296))
                                 (then
                                  (br $join:328))
                                 (else
                                  (if (result i32)
                                   (i32.lt_s
                                    (local.tee $*tmp/894
                                     (local.get $*cursor/309))
                                    (local.get $*end/308))
                                   (then
                                    (local.set $*p/487
                                     (local.get $*cursor/309))
                                    (local.set $next_char/331
                                     (i32.load16_u offset=8
                                      (i32.add
                                       (local.get $*data/306)
                                       (i32.shl
                                        (local.get $*p/487)
                                        (i32.const 1)))))
                                    (local.set $*cursor/309
                                     (i32.add
                                      (local.tee $*tmp/895
                                       (local.get $*cursor/309))
                                      (i32.const 1)))
                                    (if (result i32)
                                     (i32.lt_s
                                      (local.get $next_char/331)
                                      (i32.const 56320))
                                     (then
                                      (br $join:315))
                                     (else
                                      (if (result i32)
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
                                (if (result i32)
                                 (i32.gt_s
                                  (local.get $next_char/330)
                                  (i32.const 56319))
                                 (then
                                  (if (result i32)
                                   (i32.lt_s
                                    (local.get $next_char/330)
                                    (i32.const 65536))
                                   (then
                                    (br $join:328))
                                   (else
                                    (br $join:315))))
                                 (else
                                  (if (result i32)
                                   (i32.lt_s
                                    (local.tee $*tmp/896
                                     (local.get $*cursor/309))
                                    (local.get $*end/308))
                                   (then
                                    (local.set $*p/490
                                     (local.get $*cursor/309))
                                    (local.set $next_char/332
                                     (i32.load16_u offset=8
                                      (i32.add
                                       (local.get $*data/306)
                                       (i32.shl
                                        (local.get $*p/490)
                                        (i32.const 1)))))
                                    (local.set $*cursor/309
                                     (i32.add
                                      (local.tee $*tmp/897
                                       (local.get $*cursor/309))
                                      (i32.const 1)))
                                    (if (result i32)
                                     (i32.lt_s
                                      (local.get $next_char/332)
                                      (i32.const 56320))
                                     (then
                                      (br $join:315))
                                     (else
                                      (if (result i32)
                                       (i32.gt_s
                                        (local.get $next_char/332)
                                        (i32.const 57343))
                                       (then
                                        (br $join:315))
                                       (else
                                        (br $loop:329))))))
                                   (else
                                    (br $join:315)))))))
                              (br $outer/978))
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
                     (if (result i32)
                      (i32.gt_s
                       (local.get $next_char/327)
                       (i32.const 56318))
                      (then
                       (if (result i32)
                        (i32.lt_s
                         (local.get $next_char/327)
                         (i32.const 57344))
                        (then
                         (if (result i32)
                          (i32.lt_s
                           (local.tee $*tmp/898
                            (local.get $*cursor/309))
                           (local.get $*end/308))
                          (then
                           (local.set $*p/493
                            (local.get $*cursor/309))
                           (local.set $next_char/333
                            (i32.load16_u offset=8
                             (i32.add
                              (local.get $*data/306)
                              (i32.shl
                               (local.get $*p/493)
                               (i32.const 1)))))
                           (local.set $*cursor/309
                            (i32.add
                             (local.tee $*tmp/899
                              (local.get $*cursor/309))
                             (i32.const 1)))
                           (if (result i32)
                            (i32.lt_s
                             (local.get $next_char/333)
                             (i32.const 56320))
                            (then
                             (br $join:315))
                            (else
                             (if (result i32)
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
                         (if (result i32)
                          (i32.gt_s
                           (local.get $next_char/327)
                           (i32.const 65535))
                          (then
                           (br $join:315))
                          (else
                           (br $join:325))))))
                      (else
                       (if (result i32)
                        (i32.lt_s
                         (local.tee $*tmp/900
                          (local.get $*cursor/309))
                         (local.get $*end/308))
                        (then
                         (local.set $*p/496
                          (local.get $*cursor/309))
                         (local.set $next_char/334
                          (i32.load16_u offset=8
                           (i32.add
                            (local.get $*data/306)
                            (i32.shl
                             (local.get $*p/496)
                             (i32.const 1)))))
                         (local.set $*cursor/309
                          (i32.add
                           (local.tee $*tmp/901
                            (local.get $*cursor/309))
                           (i32.const 1)))
                         (if (result i32)
                          (i32.lt_s
                           (local.get $next_char/334)
                           (i32.const 56320))
                          (then
                           (br $join:315))
                          (else
                           (if (result i32)
                            (i32.gt_s
                             (local.get $next_char/334)
                             (i32.const 65535))
                            (then
                             (br $join:315))
                            (else
                             (br $loop:326))))))
                        (else
                         (br $join:315)))))))
                   (br $outer/977))
                  (br $loop:326)))
                (else
                 (br $join:315)))))))))
         (else
          (if (result i32)
           (i32.gt_s
            (local.get $next_char/324)
            (i32.const 56318))
           (then
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/324)
              (i32.const 57344))
             (then
              (if (result i32)
               (i32.lt_s
                (local.tee $*tmp/902
                 (local.get $*cursor/309))
                (local.get $*end/308))
               (then
                (local.set $*p/499
                 (local.get $*cursor/309))
                (local.set $next_char/335
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/306)
                   (i32.shl
                    (local.get $*p/499)
                    (i32.const 1)))))
                (local.set $*cursor/309
                 (i32.add
                  (local.tee $*tmp/903
                   (local.get $*cursor/309))
                  (i32.const 1)))
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/335)
                  (i32.const 56320))
                 (then
                  (br $join:315))
                 (else
                  (if (result i32)
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
              (if (result i32)
               (i32.gt_s
                (local.get $next_char/324)
                (i32.const 65535))
               (then
                (br $join:315))
               (else
                (br $join:322))))))
           (else
            (if (result i32)
             (i32.lt_s
              (local.tee $*tmp/904
               (local.get $*cursor/309))
              (local.get $*end/308))
             (then
              (local.set $*p/502
               (local.get $*cursor/309))
              (local.set $next_char/336
               (i32.load16_u offset=8
                (i32.add
                 (local.get $*data/306)
                 (i32.shl
                  (local.get $*p/502)
                  (i32.const 1)))))
              (local.set $*cursor/309
               (i32.add
                (local.tee $*tmp/905
                 (local.get $*cursor/309))
                (i32.const 1)))
              (if (result i32)
               (i32.lt_s
                (local.get $next_char/336)
                (i32.const 56320))
               (then
                (br $join:315))
               (else
                (if (result i32)
                 (i32.gt_s
                  (local.get $next_char/336)
                  (i32.const 65535))
                 (then
                  (br $join:315))
                 (else
                  (br $loop:323))))))
             (else
              (br $join:315)))))))
        (br $outer/976))
       (br $loop:323)))
     (else
      (br $join:315))))
   (br $outer/975))
  (if (result i32)
   (i32.eq
    (local.get $accept_state/310)
    (i32.const 0))
   (then
    (call $moonbit.decref
     (local.get $pkg/0/304))
    (block $outer/984 (result i32) (result i32) (result i32)
     (block $join:317
      (local.set $*tmp/880
       (i64.extend_i32_s
        (local.tee $*tmp/883
         (i32.add
          (local.tee $*tmp/884
           (local.get $match_tag_saver_0/312))
          (i32.const 1)))))
      (local.set $*tmp/881
       (i64.extend_i32_s
        (local.tee $*tmp/882
         (local.get $match_end/311))))
      (call $moonbit.incref
       (local.get $*data/306))
      (call $String::sub
       (local.get $*data/306)
       (local.get $*tmp/880)
       (local.get $*tmp/881))
      (local.set $*obj/2/985)
      (local.set $*obj/1/985)
      (local.set $*obj/0/985)
      (if (result i32) (result i32) (result i32)
       (then
        (local.get $*obj/0/985)
        (local.get $*obj/1/985)
        (local.set $*ok/2/885
         (local.get $*obj/2/985))
        (local.set $*ok/1/885)
        (local.tee $*ok/0/885)
        (local.get $*ok/1/885)
        (local.get $*ok/2/885))
       (else
        (local.set $*try_err/318
         (local.tee $*err/886
          (local.get $*obj/0/985)))
        (br $join:317)))
      (br $outer/984))
     (call $moonbit.decref
      (local.get $*try_err/318))
     (unreachable))
    (local.set $package_name/2/316)
    (local.set $package_name/1/316)
    (local.set $package_name/0/316)
    (block $outer/982 (result i32) (result i32) (result i32)
     (block $join:320
      (local.set $*tmp/875
       (i64.extend_i32_s
        (local.get $*start/307)))
      (local.set $*tmp/876
       (i64.extend_i32_s
        (local.tee $*tmp/877
         (local.get $match_tag_saver_0/312))))
      (call $String::sub
       (local.get $*data/306)
       (local.get $*tmp/875)
       (local.get $*tmp/876))
      (local.set $*obj/2/983)
      (local.set $*obj/1/983)
      (local.set $*obj/0/983)
      (if (result i32) (result i32) (result i32)
       (then
        (local.get $*obj/0/983)
        (local.get $*obj/1/983)
        (local.set $*ok/2/878
         (local.get $*obj/2/983))
        (local.set $*ok/1/878)
        (local.tee $*ok/0/878)
        (local.get $*ok/1/878)
        (local.get $*ok/2/878))
       (else
        (local.set $*try_err/321
         (local.tee $*err/879
          (local.get $*obj/0/983)))
        (br $join:320)))
      (br $outer/982))
     (call $moonbit.decref
      (local.get $*try_err/321))
     (unreachable))
    (local.set $module_name/2/319)
    (local.set $module_name/1/319)
    (local.set $module_name/0/319)
    (i32.store offset=4
     (local.tee $ptr/981
      (call $moonbit.gc.malloc
       (i32.const 12)))
     (i32.const 2097409))
    (i32.store offset=16
     (local.get $ptr/981)
     (local.get $package_name/0/316))
    (i32.store offset=8
     (local.get $ptr/981)
     (local.get $package_name/1/316))
    (i32.store offset=12
     (local.get $ptr/981)
     (local.get $package_name/2/316))
    (local.set $Some/874
     (local.get $ptr/981))
    (i32.store offset=4
     (local.tee $ptr/980
      (call $moonbit.gc.malloc
       (i32.const 16)))
     (i32.const 2097664))
    (i32.store offset=20
     (local.get $ptr/980)
     (local.get $Some/874))
    (i32.store offset=16
     (local.get $ptr/980)
     (local.get $module_name/0/319))
    (i32.store offset=8
     (local.get $ptr/980)
     (local.get $module_name/1/319))
    (i32.store offset=12
     (local.get $ptr/980)
     (local.get $module_name/2/319))
    (local.get $ptr/980))
   (else
    (call $moonbit.decref
     (local.get $*data/306))
    (local.set $None/887
     (i32.const 10000))
    (i32.store offset=4
     (local.tee $ptr/979
      (call $moonbit.gc.malloc
       (i32.const 16)))
     (i32.const 2097664))
    (i32.store offset=20
     (local.get $ptr/979)
     (local.get $None/887))
    (i32.store offset=16
     (local.get $ptr/979)
     (local.get $pkg/0/304))
    (i32.store offset=8
     (local.get $ptr/979)
     (local.get $pkg/1/304))
    (i32.store offset=12
     (local.get $ptr/979)
     (local.get $pkg/2/304))
    (local.get $ptr/979))))
 (local.tee $*bind/314)
 (i32.load offset=16)
 (i32.load offset=8
  (local.get $*bind/314))
 (local.set $*field/2/918
  (i32.load offset=12
   (local.get $*bind/314)))
 (local.set $*field/1/918)
 (local.tee $*field/0/918)
 (local.get $*field/1/918)
 (local.set $*module_name/2/337
  (local.get $*field/2/918))
 (local.set $*module_name/1/337)
 (local.set $*module_name/0/337)
 (local.set $*field/917
  (i32.load offset=20
   (local.get $*bind/314)))
 (if
  (i32.gt_s
   (local.tee $*cnt/957
    (i32.load
     (local.get $*bind/314)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/958
    (i32.sub
     (local.get $*cnt/957)
     (i32.const 1)))
   (i32.store
    (local.get $*bind/314)
    (local.get $*new_cnt/958))
   (call $moonbit.incref
    (local.get $*field/917))
   (call $moonbit.incref
    (local.get $*module_name/0/337)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/957)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*bind/314)))
    (else))))
 (if
  (i32.eq
   (local.tee $*tag/974
    (call $moonbit.get_tag
     (local.tee $*package_name/338
      (local.get $*field/917))))
   (i32.const 1))
  (then
   (i32.load offset=16
    (local.tee $*Some/339
     (local.get $*package_name/338)))
   (i32.load offset=8
    (local.get $*Some/339))
   (local.set $*field/2/916
    (i32.load offset=12
     (local.get $*Some/339)))
   (local.set $*field/1/916)
   (local.set $*field/0/916)
   (if
    (i32.gt_s
     (local.tee $*cnt/959
      (i32.load
       (local.get $*Some/339)))
     (i32.const 1))
    (then
     (local.set $*new_cnt/960
      (i32.sub
       (local.get $*cnt/959)
       (i32.const 1)))
     (i32.store
      (local.get $*Some/339)
      (local.get $*new_cnt/960))
     (call $moonbit.incref
      (local.get $*field/0/916)))
    (else
     (if
      (i32.eq
       (local.get $*cnt/959)
       (i32.const 1))
      (then
       (call $moonbit.free
        (local.get $*Some/339)))
      (else))))
   (local.get $*field/0/916)
   (local.get $*field/1/916)
   (local.set $*pkg_name/2/340
    (local.get $*field/2/916))
   (local.set $*pkg_name/1/340)
   (local.set $*pkg_name/0/340)
   (if
    (local.get $logger/1/341)
    (then
     (call $moonbit.incref
      (local.get $logger/1/341)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
     (local.get $logger/1/341)
     (local.get $*pkg_name/0/340)
     (local.get $*pkg_name/1/340)
     (local.get $*pkg_name/2/340)
     (i32.load offset=16
      (local.get $logger/0/341))))
   (local.get $logger/0/341)
   (local.set $*bind/1/867
    (local.get $logger/1/341))
   (local.set $*bind/0/867)
   (if
    (local.get $*bind/1/867)
    (then
     (call $moonbit.incref
      (local.get $*bind/1/867)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
     (local.get $*bind/1/867)
     (i32.const 47)
     (i32.load offset=20
      (local.get $*bind/0/867)))))
  (else
   (call $moonbit.decref
    (local.get $*package_name/338))))
 (i32.load offset=60
  (local.get $self/305))
 (i32.load offset=16
  (local.get $self/305))
 (local.set $*field/2/915
  (i32.load offset=20
   (local.get $self/305)))
 (local.set $*field/1/915)
 (local.tee $*field/0/915)
 (local.get $*field/1/915)
 (local.set $filename/2/869
  (local.get $*field/2/915))
 (local.set $filename/1/869)
 (local.tee $filename/0/869)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/341)
   (local.get $filename/0/869)
   (local.get $filename/1/869)
   (local.get $filename/2/869)
   (i32.load offset=16
    (local.get $logger/0/341))))
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/341)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/341))))
 (i32.load offset=64
  (local.get $self/305))
 (i32.load offset=24
  (local.get $self/305))
 (local.set $*field/2/914
  (i32.load offset=28
   (local.get $self/305)))
 (local.set $*field/1/914)
 (local.tee $*field/0/914)
 (local.get $*field/1/914)
 (local.set $start_line/2/870
  (local.get $*field/2/914))
 (local.set $start_line/1/870)
 (local.tee $start_line/0/870)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/341)
   (local.get $start_line/0/870)
   (local.get $start_line/1/870)
   (local.get $start_line/2/870)
   (i32.load offset=16
    (local.get $logger/0/341))))
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/341)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/341))))
 (i32.load offset=68
  (local.get $self/305))
 (i32.load offset=32
  (local.get $self/305))
 (local.set $*field/2/913
  (i32.load offset=36
   (local.get $self/305)))
 (local.set $*field/1/913)
 (local.tee $*field/0/913)
 (local.get $*field/1/913)
 (local.set $start_column/2/871
  (local.get $*field/2/913))
 (local.set $start_column/1/871)
 (local.tee $start_column/0/871)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/341)
   (local.get $start_column/0/871)
   (local.get $start_column/1/871)
   (local.get $start_column/2/871)
   (i32.load offset=16
    (local.get $logger/0/341))))
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/341)
   (i32.const 45)
   (i32.load offset=20
    (local.get $logger/0/341))))
 (i32.load offset=72
  (local.get $self/305))
 (i32.load offset=40
  (local.get $self/305))
 (local.set $*field/2/912
  (i32.load offset=44
   (local.get $self/305)))
 (local.set $*field/1/912)
 (local.tee $*field/0/912)
 (local.get $*field/1/912)
 (local.set $end_line/2/872
  (local.get $*field/2/912))
 (local.set $end_line/1/872)
 (local.tee $end_line/0/872)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/341)
   (local.get $end_line/0/872)
   (local.get $end_line/1/872)
   (local.get $end_line/2/872)
   (i32.load offset=16
    (local.get $logger/0/341))))
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/341)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/341))))
 (i32.load offset=76
  (local.get $self/305))
 (i32.load offset=48
  (local.get $self/305))
 (local.set $*field/2/911
  (i32.load offset=52
   (local.get $self/305)))
 (local.set $*field/1/911)
 (local.set $*field/0/911)
 (if
  (i32.gt_s
   (local.tee $*cnt/961
    (i32.load
     (local.get $self/305)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/967
    (i32.sub
     (local.get $*cnt/961)
     (i32.const 1)))
   (i32.store
    (local.get $self/305)
    (local.get $*new_cnt/967))
   (call $moonbit.incref
    (local.get $*field/0/911)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/961)
     (i32.const 1))
    (then
     (i32.load offset=72
      (local.get $self/305))
     (i32.load offset=40
      (local.get $self/305))
     (local.set $*field/2/966
      (i32.load offset=44
       (local.get $self/305)))
     (local.set $*field/1/966)
     (local.tee $*field/0/966)
     (call $moonbit.decref)
     (i32.load offset=68
      (local.get $self/305))
     (i32.load offset=32
      (local.get $self/305))
     (local.set $*field/2/965
      (i32.load offset=36
       (local.get $self/305)))
     (local.set $*field/1/965)
     (local.tee $*field/0/965)
     (call $moonbit.decref)
     (i32.load offset=64
      (local.get $self/305))
     (i32.load offset=24
      (local.get $self/305))
     (local.set $*field/2/964
      (i32.load offset=28
       (local.get $self/305)))
     (local.set $*field/1/964)
     (local.tee $*field/0/964)
     (call $moonbit.decref)
     (i32.load offset=60
      (local.get $self/305))
     (i32.load offset=16
      (local.get $self/305))
     (local.set $*field/2/963
      (i32.load offset=20
       (local.get $self/305)))
     (local.set $*field/1/963)
     (local.tee $*field/0/963)
     (call $moonbit.decref)
     (i32.load offset=56
      (local.get $self/305))
     (i32.load offset=8
      (local.get $self/305))
     (local.set $*field/2/962
      (i32.load offset=12
       (local.get $self/305)))
     (local.set $*field/1/962)
     (local.tee $*field/0/962)
     (call $moonbit.decref)
     (call $moonbit.free
      (local.get $self/305)))
    (else))))
 (local.get $*field/0/911)
 (local.get $*field/1/911)
 (local.set $end_column/2/873
  (local.get $*field/2/911))
 (local.set $end_column/1/873)
 (local.set $end_column/0/873)
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/341)
   (local.get $end_column/0/873)
   (local.get $end_column/1/873)
   (local.get $end_column/2/873)
   (i32.load offset=16
    (local.get $logger/0/341))))
 (if
  (local.get $logger/1/341)
  (then
   (call $moonbit.incref
    (local.get $logger/1/341)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/341)
   (i32.const 64)
   (i32.load offset=20
    (local.get $logger/0/341))))
 (local.get $logger/0/341)
 (local.set $*bind/1/868
  (local.get $logger/1/341))
 (local.set $*bind/0/868)
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
  (local.get $*bind/1/868)
  (local.get $*module_name/0/337)
  (local.get $*module_name/1/337)
  (local.get $*module_name/2/337)
  (i32.load offset=16
   (local.get $*bind/0/868))))
(func $moonbitlang/core/builtin.println|String| (param $input/303 i32) (result i32)
 (call $moonbit.println
  (local.get $input/303))
 (call $moonbit.decref
  (local.get $input/303))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int| (param $self/302 i32) (param $logger/0/301 i32) (param $logger/1/301 i32) (result i32)
 (local $*tmp/866 i32)
 (local.set $*tmp/866
  (call $@moonbitlang/core/builtin.Array::iter|Int|
   (local.get $self/302)))
 (call $@moonbitlang/core/builtin.Logger::write_iter.inner|Int|
  (local.get $logger/0/301)
  (local.get $logger/1/301)
  (local.get $*tmp/866)
  (i32.const 10048)
  (i32.const 10032)
  (i32.const 10016)
  (i32.const 0)))
(func $@moonbitlang/core/builtin.Array::iter|Int| (param $self/300 i32) (result i32)
 (local $*tmp/0/863 i32)
 (local $*tmp/1/863 i32)
 (local $*tmp/2/863 i32)
 (local $buf/864 i32)
 (local $len/865 i32)
 (local $*field/921 i32)
 (local $*field/922 i32)
 (local $*cnt/968 i32)
 (local $*new_cnt/969 i32)
 (local.set $buf/864
  (local.tee $*field/922
   (i32.load offset=12
    (local.get $self/300))))
 (local.set $*field/921
  (i32.load offset=8
   (local.get $self/300)))
 (if
  (i32.gt_s
   (local.tee $*cnt/968
    (i32.load
     (local.get $self/300)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/969
    (i32.sub
     (local.get $*cnt/968)
     (i32.const 1)))
   (i32.store
    (local.get $self/300)
    (local.get $*new_cnt/969))
   (call $moonbit.incref
    (local.get $buf/864)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/968)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $self/300)))
    (else))))
 (local.set $len/865
  (local.get $*field/921))
 (local.get $buf/864)
 (i32.const 0)
 (local.set $*tmp/2/863
  (local.get $len/865))
 (local.set $*tmp/1/863)
 (local.tee $*tmp/0/863)
 (local.get $*tmp/1/863)
 (local.get $*tmp/2/863)
 (call $@moonbitlang/core/builtin.ArrayView::iter|Int|))
(func $@moonbitlang/core/builtin.ArrayView::iter|Int| (param $self/0/298 i32) (param $self/1/298 i32) (param $self/2/298 i32) (result i32)
 (local $i/297 i32)
 (local $*p/467 i32)
 (local $*ptr/986 i32)
 (local $ptr/987 i32)
 (i32.store offset=4
  (local.tee $ptr/987
   (call $moonbit.gc.malloc
    (i32.const 4)))
  (i32.const 1572864))
 (i32.store offset=8
  (local.get $ptr/987)
  (i32.const 0))
 (local.set $i/297
  (local.get $ptr/987))
 (i32.store offset=4
  (local.tee $*ptr/986
   (call $moonbit.gc.malloc
    (i32.const 20)))
  (i32.const 2621952))
 (i32.store offset=8
  (local.get $*ptr/986)
  (i32.const 0))
 (i32.store offset=24
  (local.get $*ptr/986)
  (local.get $i/297))
 (i32.store offset=20
  (local.get $*ptr/986)
  (local.get $self/0/298))
 (i32.store offset=12
  (local.get $*ptr/986)
  (local.get $self/1/298))
 (i32.store offset=16
  (local.get $*ptr/986)
  (local.get $self/2/298))
 (local.tee $*p/467
  (local.get $*ptr/986)))
(func $ArrayView::iter|Int|.*p.fn/1 (param $*env/851 i32) (result i64)
 (local $i/297 i32)
 (local $self/0/298 i32)
 (local $self/1/298 i32)
 (local $self/2/298 i32)
 (local $elem/299 i32)
 (local $*casted_env/852 i32)
 (local $val/853 i32)
 (local $*tmp/854 i32)
 (local $end/855 i32)
 (local $start/856 i32)
 (local $*tmp/857 i32)
 (local $val/858 i32)
 (local $buf/859 i32)
 (local $*tmp/860 i32)
 (local $start/861 i32)
 (local $val/862 i32)
 (local $*tmp/923 i32)
 (local $*field/924 i32)
 (local $*field/925 i32)
 (local $*field/0/926 i32)
 (local $*field/1/926 i32)
 (local $*field/2/926 i32)
 (local $*field/927 i32)
 (local $*cnt/970 i32)
 (local $*new_cnt/971 i32)
 (local.set $i/297
  (local.tee $*field/927
   (i32.load offset=24
    (local.tee $*casted_env/852
     (local.get $*env/851)))))
 (i32.load offset=20
  (local.get $*casted_env/852))
 (i32.load offset=12
  (local.get $*casted_env/852))
 (local.set $*field/2/926
  (i32.load offset=16
   (local.get $*casted_env/852)))
 (local.set $*field/1/926)
 (local.set $*field/0/926)
 (if
  (i32.gt_s
   (local.tee $*cnt/970
    (i32.load
     (local.get $*casted_env/852)))
   (i32.const 1))
  (then
   (local.set $*new_cnt/971
    (i32.sub
     (local.get $*cnt/970)
     (i32.const 1)))
   (i32.store
    (local.get $*casted_env/852)
    (local.get $*new_cnt/971))
   (call $moonbit.incref
    (local.get $i/297))
   (call $moonbit.incref
    (local.get $*field/0/926)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/970)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*casted_env/852)))
    (else))))
 (local.get $*field/0/926)
 (local.get $*field/1/926)
 (local.set $self/2/298
  (local.get $*field/2/926))
 (local.set $self/1/298)
 (local.set $self/0/298)
 (local.set $val/853
  (i32.load offset=8
   (local.get $i/297)))
 (local.set $end/855
  (local.get $self/2/298))
 (local.set $start/856
  (local.get $self/1/298))
 (local.set $*tmp/854
  (i32.sub
   (local.get $end/855)
   (local.get $start/856)))
 (if (result i64)
  (i32.lt_s
   (local.get $val/853)
   (local.get $*tmp/854))
  (then
   (local.set $buf/859
    (local.tee $*field/925
     (local.get $self/0/298)))
   (local.set $start/861
    (local.tee $*field/924
     (local.get $self/1/298)))
   (local.set $val/862
    (i32.load offset=8
     (local.get $i/297)))
   (local.set $*tmp/860
    (i32.add
     (local.get $start/861)
     (local.get $val/862)))
   (local.set $*tmp/923
    (i32.load offset=8
     (i32.add
      (local.get $buf/859)
      (i32.shl
       (local.get $*tmp/860)
       (i32.const 2)))))
   (call $moonbit.decref
    (local.get $buf/859))
   (local.set $elem/299
    (local.get $*tmp/923))
   (local.set $*tmp/857
    (i32.add
     (local.tee $val/858
      (i32.load offset=8
       (local.get $i/297)))
     (i32.const 1)))
   (i32.store offset=8
    (local.get $i/297)
    (local.get $*tmp/857))
   (call $moonbit.decref
    (local.get $i/297))
   (i64.extend_i32_s
    (local.get $elem/299)))
  (else
   (call $moonbit.decref
    (local.get $self/0/298))
   (call $moonbit.decref
    (local.get $i/297))
   (i64.const 4294967296))))
(func $@moonbitlang/core/builtin.Show::Int::output (param $self/295 i32) (param $logger/0/294 i32) (param $logger/1/294 i32) (result i32)
 (local $*tmp/850 i32)
 (local.set $*tmp/850
  (call $Int::to_string.inner
   (local.get $self/295)
   (i32.const 10)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/294)
  (local.get $*tmp/850)
  (i32.load offset=8
   (local.get $logger/0/294))))
(func $@moonbitlang/core/builtin.Iter::next|Int| (param $self/293 i32) (result i64)
 (local $*func/292 i32)
 (call_indirect $moonbit.global (type $<>=>Option<Int>)
  (local.tee $*func/292
   (local.get $self/293))
  (i32.load offset=8
   (local.get $*func/292))))
(func $@moonbitlang/core/builtin.Array::push|Int| (param $self/289 i32) (param $value/291 i32) (result i32)
 (local $length/290 i32)
 (local $len/845 i32)
 (local $*tmp/846 i32)
 (local $buf/847 i32)
 (local $buf/848 i32)
 (local $*tmp/849 i32)
 (local $*field/928 i32)
 (local $*tmp/929 i32)
 (local $*field/930 i32)
 (local.set $len/845
  (i32.load offset=8
   (local.get $self/289)))
 (local.set $*tmp/846
  (local.tee $*tmp/929
   (call $moonbit.array_length
    (local.tee $buf/847
     (local.tee $*field/930
      (i32.load offset=12
       (local.get $self/289)))))))
 (if
  (i32.eq
   (local.get $len/845)
   (local.get $*tmp/846))
  (then
   (call $moonbit.incref
    (local.get $self/289))
   (drop
    (call $@moonbitlang/core/builtin.Array::realloc|Int|
     (local.get $self/289))))
  (else))
 (local.set $length/290
  (i32.load offset=8
   (local.get $self/289)))
 (i32.store offset=8
  (i32.add
   (local.tee $buf/848
    (local.tee $*field/928
     (i32.load offset=12
      (local.get $self/289))))
   (i32.shl
    (local.get $length/290)
    (i32.const 2)))
  (local.get $value/291))
 (local.set $*tmp/849
  (i32.add
   (local.get $length/290)
   (i32.const 1)))
 (i32.store offset=8
  (local.get $self/289)
  (local.get $*tmp/849))
 (call $moonbit.decref
  (local.get $self/289))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Array::realloc|Int| (param $self/287 i32) (result i32)
 (local $old_cap/286 i32)
 (local $new_cap/288 i32)
 (local.set $new_cap/288
  (if (result i32)
   (i32.eq
    (local.tee $old_cap/286
     (i32.load offset=8
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
(func $@moonbitlang/core/builtin.Array::resize_buffer|Int| (param $self/283 i32) (param $new_capacity/281 i32) (result i32)
 (local $new_buf/280 i32)
 (local $old_buf/282 i32)
 (local $old_cap/284 i32)
 (local $copy_len/285 i32)
 (local $*old/931 i32)
 (local $*field/932 i32)
 (local.set $new_buf/280
  (call $moonbit.i32_array_make_raw
   (local.get $new_capacity/281)))
 (local.set $copy_len/285
  (if (result i32)
   (i32.lt_s
    (local.tee $old_cap/284
     (call $moonbit.array_length
      (local.tee $old_buf/282
       (local.tee $*field/932
        (i32.load offset=12
         (local.get $self/283))))))
    (local.get $new_capacity/281))
   (then
    (local.get $old_cap/284))
   (else
    (local.get $new_capacity/281))))
 (call $moonbit.incref
  (local.get $old_buf/282))
 (call $moonbit.incref
  (local.get $new_buf/280))
 (drop
  (call $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int|
   (local.get $new_buf/280)
   (i32.const 0)
   (local.get $old_buf/282)
   (i32.const 0)
   (local.get $copy_len/285)))
 (call $moonbit.decref
  (local.tee $*old/931
   (i32.load offset=12
    (local.get $self/283))))
 (i32.store offset=12
  (local.get $self/283)
  (local.get $new_buf/280))
 (call $moonbit.decref
  (local.get $self/283))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/278 i32) (param $str/0/279 i32) (param $str/1/279 i32) (param $str/2/279 i32) (result i32)
 (local $*tmp/826 i32)
 (local $len/827 i32)
 (local $*tmp/828 i32)
 (local $*tmp/829 i32)
 (local $end/830 i32)
 (local $start/831 i32)
 (local $data/832 i32)
 (local $len/833 i32)
 (local $str/834 i32)
 (local $start/835 i32)
 (local $*tmp/836 i32)
 (local $end/837 i32)
 (local $start/838 i32)
 (local $*tmp/839 i32)
 (local $len/840 i32)
 (local $*tmp/841 i32)
 (local $*tmp/842 i32)
 (local $end/843 i32)
 (local $start/844 i32)
 (local $*field/933 i32)
 (local $*field/934 i32)
 (local $*field/935 i32)
 (local.set $len/827
  (i32.load offset=8
   (local.get $self/278)))
 (local.set $end/830
  (local.get $str/2/279))
 (local.set $start/831
  (local.get $str/1/279))
 (local.set $*tmp/828
  (i32.mul
   (local.tee $*tmp/829
    (i32.sub
     (local.get $end/830)
     (local.get $start/831)))
   (i32.const 2)))
 (local.set $*tmp/826
  (i32.add
   (local.get $len/827)
   (local.get $*tmp/828)))
 (call $moonbit.incref
  (local.get $self/278))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/278)
   (local.get $*tmp/826)))
 (local.set $data/832
  (local.tee $*field/935
   (i32.load offset=12
    (local.get $self/278))))
 (local.set $len/833
  (i32.load offset=8
   (local.get $self/278)))
 (local.set $str/834
  (local.tee $*field/934
   (local.get $str/0/279)))
 (local.set $start/835
  (local.get $str/1/279))
 (local.set $end/837
  (local.get $str/2/279))
 (local.set $start/838
  (local.get $str/1/279))
 (local.set $*tmp/836
  (i32.sub
   (local.get $end/837)
   (local.get $start/838)))
 (call $moonbit.incref
  (local.get $str/834))
 (call $moonbit.incref
  (local.get $data/832))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/832)
   (local.get $len/833)
   (local.get $str/834)
   (local.get $start/835)
   (local.get $*tmp/836)))
 (local.set $len/840
  (i32.load offset=8
   (local.get $self/278)))
 (local.set $end/843
  (local.get $str/2/279))
 (local.set $*field/933
  (local.get $str/1/279))
 (call $moonbit.decref
  (local.get $str/0/279))
 (local.set $start/844
  (local.get $*field/933))
 (local.set $*tmp/841
  (i32.mul
   (local.tee $*tmp/842
    (i32.sub
     (local.get $end/843)
     (local.get $start/844)))
   (i32.const 2)))
 (local.set $*tmp/839
  (i32.add
   (local.get $len/840)
   (local.get $*tmp/841)))
 (i32.store offset=8
  (local.get $self/278)
  (local.get $*tmp/839))
 (call $moonbit.decref
  (local.get $self/278))
 (i32.const 0))
(func $Int::to_string.inner (param $self/260 i32) (param $radix/259 i32) (result i32)
 (local $is_negative/261 i32)
 (local $num/262 i32)
 (local $buffer/263 i32)
 (local $digit_len/264 i32)
 (local $total_len/265 i32)
 (local $buffer/266 i32)
 (local $digit_start/267 i32)
 (local $digit_len/268 i32)
 (local $total_len/269 i32)
 (local $buffer/270 i32)
 (local $digit_start/271 i32)
 (local $digit_len/272 i32)
 (local $total_len/273 i32)
 (local $buffer/274 i32)
 (local $digit_start/275 i32)
 (local $*tmp/820 i32)
 (local $*tmp/821 i32)
 (local $*tmp/822 i32)
 (local $*tmp/823 i32)
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
     (i32.const 10200)
     (i32.const 10080))))
  (else))
 (if
  (i32.eq
   (local.get $self/260)
   (i32.const 0))
  (then
   (i32.const 10064)
   (return))
  (else))
 (local.set $num/262
  (if (result i32)
   (local.tee $is_negative/261
    (i32.lt_s
     (local.get $self/260)
     (i32.const 0)))
   (then
    (local.tee $*tmp/823
     (i32.sub
      (i32.const 0)
      (local.get $self/260))))
   (else
    (local.get $self/260))))
 (local.set $buffer/263
  (if (result i32)
   (i32.eq
    (local.get $radix/259)
    (i32.const 10))
   (then
    (local.set $digit_len/264
     (call $moonbitlang/core/builtin.dec_count32
      (local.get $num/262)))
    (local.set $*tmp/820
     (if (result i32)
      (local.get $is_negative/261)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (local.set $buffer/266
     (call $moonbit.int16_array_make
      (local.tee $total_len/265
       (i32.add
        (local.get $digit_len/264)
        (local.get $*tmp/820)))
      (i32.const 0)))
    (local.set $digit_start/267
     (if (result i32)
      (local.get $is_negative/261)
      (then
       (i32.const 1))
      (else
       (i32.const 0))))
    (call $moonbit.incref
     (local.get $buffer/266))
    (drop
     (call $moonbitlang/core/builtin.int_to_string_dec
      (local.get $buffer/266)
      (local.get $num/262)
      (local.get $digit_start/267)
      (local.get $total_len/265)))
    (local.get $buffer/266))
   (else
    (if (result i32)
     (i32.eq
      (local.get $radix/259)
      (i32.const 16))
     (then
      (local.set $digit_len/268
       (call $moonbitlang/core/builtin.hex_count32
        (local.get $num/262)))
      (local.set $*tmp/821
       (if (result i32)
        (local.get $is_negative/261)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/270
       (call $moonbit.int16_array_make
        (local.tee $total_len/269
         (i32.add
          (local.get $digit_len/268)
          (local.get $*tmp/821)))
        (i32.const 0)))
      (local.set $digit_start/271
       (if (result i32)
        (local.get $is_negative/261)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/270))
      (drop
       (call $moonbitlang/core/builtin.int_to_string_hex
        (local.get $buffer/270)
        (local.get $num/262)
        (local.get $digit_start/271)
        (local.get $total_len/269)))
      (local.get $buffer/270))
     (else
      (local.set $digit_len/272
       (call $moonbitlang/core/builtin.radix_count32
        (local.get $num/262)
        (local.get $radix/259)))
      (local.set $*tmp/822
       (if (result i32)
        (local.get $is_negative/261)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (local.set $buffer/274
       (call $moonbit.int16_array_make
        (local.tee $total_len/273
         (i32.add
          (local.get $digit_len/272)
          (local.get $*tmp/822)))
        (i32.const 0)))
      (local.set $digit_start/275
       (if (result i32)
        (local.get $is_negative/261)
        (then
         (i32.const 1))
        (else
         (i32.const 0))))
      (call $moonbit.incref
       (local.get $buffer/274))
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
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/263)
     (i32.shl
      (i32.const 0)
      (i32.const 1)))
    (i32.const 45)))
  (else))
 (local.get $buffer/263))
(func $moonbitlang/core/builtin.radix_count32 (param $value/253 i32) (param $radix/256 i32) (result i32)
 (local $base/255 i32)
 (local $*tmp/817 i32)
 (local $*tmp/818 i32)
 (local $*tmp/819 i32)
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
    (local.tee $*tmp/817
     (local.get $num/254))
    (i32.const 0))
   (then
    (local.set $count/257
     (i32.add
      (local.tee $*tmp/818
       (local.get $count/257))
      (i32.const 1)))
    (local.set $num/254
     (i32.div_u
      (local.tee $*tmp/819
       (local.get $num/254))
      (local.get $base/255)))
    (br $loop:258))
   (else)))
 (local.get $count/257))
(func $moonbitlang/core/builtin.hex_count32 (param $value/251 i32) (result i32)
 (local $leading_zeros/252 i32)
 (local $*tmp/815 i32)
 (local $*tmp/816 i32)
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
    (local.tee $*tmp/815
     (i32.div_s
      (local.tee $*tmp/816
       (i32.sub
        (i32.const 31)
        (local.get $leading_zeros/252)))
      (i32.const 4)))
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
(func $moonbitlang/core/builtin.int_to_string_dec (param $buffer/240 i32) (param $num/228 i32) (param $digit_start/231 i32) (param $total_len/230 i32) (result i32)
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
    (local.tee $*tmp/758
     (local.get $num/227))
    (i32.const 10000))
   (then
    (local.set $t/232
     (i32.div_u
      (local.tee $*tmp/781
       (local.get $num/227))
      (i32.const 10000)))
    (local.set $r/233
     (local.tee $*tmp/779
      (i32.rem_u
       (local.tee $*tmp/780
        (local.get $num/227))
       (i32.const 10000))))
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
      (local.tee $*tmp/759
       (local.get $offset/229))
      (i32.const 4)))
    (local.set $*tmp/778
     (i32.div_s
      (local.get $d1/234)
      (i32.const 10)))
    (local.set $d1_hi/236
     (i32.and
      (local.tee $*tmp/777
       (i32.add
        (i32.const 48)
        (local.get $*tmp/778)))
      (i32.const 65535)))
    (local.set $*tmp/776
     (i32.rem_s
      (local.get $d1/234)
      (i32.const 10)))
    (local.set $d1_lo/237
     (i32.and
      (local.tee $*tmp/775
       (i32.add
        (i32.const 48)
        (local.get $*tmp/776)))
      (i32.const 65535)))
    (local.set $*tmp/774
     (i32.div_s
      (local.get $d2/235)
      (i32.const 10)))
    (local.set $d2_hi/238
     (i32.and
      (local.tee $*tmp/773
       (i32.add
        (i32.const 48)
        (local.get $*tmp/774)))
      (i32.const 65535)))
    (local.set $*tmp/772
     (i32.rem_s
      (local.get $d2/235)
      (i32.const 10)))
    (local.set $d2_lo/239
     (i32.and
      (local.tee $*tmp/771
       (i32.add
        (i32.const 48)
        (local.get $*tmp/772)))
      (i32.const 65535)))
    (local.set $*tmp/761
     (local.get $offset/229))
    (local.set $*tmp/760
     (i32.add
      (local.get $digit_start/231)
      (local.get $*tmp/761)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/240)
      (i32.shl
       (local.get $*tmp/760)
       (i32.const 1)))
     (local.get $d1_hi/236))
    (local.set $*tmp/764
     (local.get $offset/229))
    (local.set $*tmp/762
     (i32.add
      (local.tee $*tmp/763
       (i32.add
        (local.get $digit_start/231)
        (local.get $*tmp/764)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/240)
      (i32.shl
       (local.get $*tmp/762)
       (i32.const 1)))
     (local.get $d1_lo/237))
    (local.set $*tmp/767
     (local.get $offset/229))
    (local.set $*tmp/765
     (i32.add
      (local.tee $*tmp/766
       (i32.add
        (local.get $digit_start/231)
        (local.get $*tmp/767)))
      (i32.const 2)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/240)
      (i32.shl
       (local.get $*tmp/765)
       (i32.const 1)))
     (local.get $d2_hi/238))
    (local.set $*tmp/770
     (local.get $offset/229))
    (local.set $*tmp/768
     (i32.add
      (local.tee $*tmp/769
       (i32.add
        (local.get $digit_start/231)
        (local.get $*tmp/770)))
      (i32.const 3)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/240)
      (i32.shl
       (local.get $*tmp/768)
       (i32.const 1)))
     (local.get $d2_lo/239))
    (br $loop:241))
   (else)))
 (local.set $remaining/242
  (local.tee $*tmp/814
   (local.get $num/227)))
 (loop $loop:247
  (if
   (i32.ge_s
    (local.tee $*tmp/782
     (local.get $remaining/242))
    (i32.const 100))
   (then
    (local.set $t/243
     (i32.div_s
      (local.tee $*tmp/794
       (local.get $remaining/242))
      (i32.const 100)))
    (local.set $d/244
     (i32.rem_s
      (local.tee $*tmp/793
       (local.get $remaining/242))
      (i32.const 100)))
    (local.set $remaining/242
     (local.get $t/243))
    (local.set $offset/229
     (i32.sub
      (local.tee $*tmp/783
       (local.get $offset/229))
      (i32.const 2)))
    (local.set $*tmp/792
     (i32.div_s
      (local.get $d/244)
      (i32.const 10)))
    (local.set $d_hi/245
     (i32.and
      (local.tee $*tmp/791
       (i32.add
        (i32.const 48)
        (local.get $*tmp/792)))
      (i32.const 65535)))
    (local.set $*tmp/790
     (i32.rem_s
      (local.get $d/244)
      (i32.const 10)))
    (local.set $d_lo/246
     (i32.and
      (local.tee $*tmp/789
       (i32.add
        (i32.const 48)
        (local.get $*tmp/790)))
      (i32.const 65535)))
    (local.set $*tmp/785
     (local.get $offset/229))
    (local.set $*tmp/784
     (i32.add
      (local.get $digit_start/231)
      (local.get $*tmp/785)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/240)
      (i32.shl
       (local.get $*tmp/784)
       (i32.const 1)))
     (local.get $d_hi/245))
    (local.set $*tmp/788
     (local.get $offset/229))
    (local.set $*tmp/786
     (i32.add
      (local.tee $*tmp/787
       (i32.add
        (local.get $digit_start/231)
        (local.get $*tmp/788)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/240)
      (i32.shl
       (local.get $*tmp/786)
       (i32.const 1)))
     (local.get $d_lo/246))
    (br $loop:247))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.tee $*tmp/795
    (local.get $remaining/242))
   (i32.const 10))
  (then
   (local.set $offset/229
    (i32.sub
     (local.tee $*tmp/796
      (local.get $offset/229))
     (i32.const 2)))
   (local.set $*tmp/806
    (i32.div_s
     (local.tee $*tmp/807
      (local.get $remaining/242))
     (i32.const 10)))
   (local.set $d_hi/248
    (i32.and
     (local.tee $*tmp/805
      (i32.add
       (i32.const 48)
       (local.get $*tmp/806)))
     (i32.const 65535)))
   (local.set $*tmp/803
    (i32.rem_s
     (local.tee $*tmp/804
      (local.get $remaining/242))
     (i32.const 10)))
   (local.set $d_lo/249
    (i32.and
     (local.tee $*tmp/802
      (i32.add
       (i32.const 48)
       (local.get $*tmp/803)))
     (i32.const 65535)))
   (local.set $*tmp/798
    (local.get $offset/229))
   (local.set $*tmp/797
    (i32.add
     (local.get $digit_start/231)
     (local.get $*tmp/798)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/240)
     (i32.shl
      (local.get $*tmp/797)
      (i32.const 1)))
    (local.get $d_hi/248))
   (local.set $*tmp/801
    (local.get $offset/229))
   (local.set $*tmp/799
    (i32.add
     (local.tee $*tmp/800
      (i32.add
       (local.get $digit_start/231)
       (local.get $*tmp/801)))
     (i32.const 1)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/240)
     (i32.shl
      (local.get $*tmp/799)
      (i32.const 1)))
    (local.get $d_lo/249))
   (call $moonbit.decref
    (local.get $buffer/240))
   (i32.const 0))
  (else
   (local.set $*tmp/813
    (local.tee $offset/229
     (i32.sub
      (local.tee $*tmp/808
       (local.get $offset/229))
      (i32.const 1))))
   (local.set $*tmp/809
    (i32.add
     (local.get $digit_start/231)
     (local.get $*tmp/813)))
   (local.set $*tmp/812
    (local.get $remaining/242))
   (local.set $*tmp/810
    (i32.and
     (local.tee $*tmp/811
      (i32.add
       (i32.const 48)
       (local.get $*tmp/812)))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/240)
     (i32.shl
      (local.get $*tmp/809)
      (i32.const 1)))
    (local.get $*tmp/810))
   (call $moonbit.decref
    (local.get $buffer/240))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_generic (param $buffer/222 i32) (param $num/216 i32) (param $digit_start/214 i32) (param $total_len/213 i32) (param $radix/218 i32) (result i32)
 (local $base/217 i32)
 (local $shift/219 i32)
 (local $mask/220 i32)
 (local $digit/221 i32)
 (local $q/224 i32)
 (local $digit/225 i32)
 (local $*tmp/737 i32)
 (local $*tmp/738 i32)
 (local $*tmp/739 i32)
 (local $*tmp/740 i32)
 (local $*tmp/741 i32)
 (local $*tmp/742 i32)
 (local $*tmp/743 i32)
 (local $*tmp/744 i32)
 (local $*tmp/745 i32)
 (local $*tmp/746 i32)
 (local $*tmp/747 i32)
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
 (local.set $*tmp/738
  (i32.sub
   (local.get $radix/218)
   (i32.const 1)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/737
    (i32.and
     (local.get $radix/218)
     (local.get $*tmp/738)))
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
      (local.tee $*tmp/739
       (local.get $n/215))
      (i32.const 0))
     (then
      (local.set $offset/212
       (i32.sub
        (local.tee $*tmp/740
         (local.get $offset/212))
        (i32.const 1)))
      (local.set $digit/221
       (local.tee $*tmp/746
        (i32.and
         (local.tee $*tmp/747
          (local.get $n/215))
         (local.get $mask/220))))
      (local.set $*tmp/744
       (local.get $offset/212))
      (local.set $*tmp/741
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/744)))
      (local.set $*tmp/742
       (i32.and
        (local.tee $*tmp/743
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10272)
           (i32.shl
            (local.get $digit/221)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/222)
        (i32.shl
         (local.get $*tmp/741)
         (i32.const 1)))
       (local.get $*tmp/742))
      (local.set $n/215
       (i32.shr_u
        (local.tee $*tmp/745
         (local.get $n/215))
        (local.get $shift/219)))
      (br $loop:223))
     (else
      (call $moonbit.decref
       (local.get $buffer/222)))))
   (i32.const 0))
  (else
   (loop $loop:226
    (if
     (i32.gt_u
      (local.tee $*tmp/748
       (local.get $n/215))
      (i32.const 0))
     (then
      (local.set $offset/212
       (i32.sub
        (local.tee $*tmp/749
         (local.get $offset/212))
        (i32.const 1)))
      (local.set $q/224
       (i32.div_u
        (local.tee $*tmp/757
         (local.get $n/215))
        (local.get $base/217)))
      (local.set $*tmp/755
       (local.get $n/215))
      (local.set $*tmp/756
       (i32.mul
        (local.get $q/224)
        (local.get $base/217)))
      (local.set $digit/225
       (local.tee $*tmp/754
        (i32.sub
         (local.get $*tmp/755)
         (local.get $*tmp/756))))
      (local.set $*tmp/753
       (local.get $offset/212))
      (local.set $*tmp/750
       (i32.add
        (local.get $digit_start/214)
        (local.get $*tmp/753)))
      (local.set $*tmp/751
       (i32.and
        (local.tee $*tmp/752
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10272)
           (i32.shl
            (local.get $digit/225)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/222)
        (i32.shl
         (local.get $*tmp/750)
         (i32.const 1)))
       (local.get $*tmp/751))
      (local.set $n/215
       (local.get $q/224))
      (br $loop:226))
     (else
      (call $moonbit.decref
       (local.get $buffer/222)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int_to_string_hex (param $buffer/209 i32) (param $num/205 i32) (param $digit_start/203 i32) (param $total_len/202 i32) (result i32)
 (local $byte_val/206 i32)
 (local $hi/207 i32)
 (local $lo/208 i32)
 (local $nibble/211 i32)
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
 (local $*tmp/734 i32)
 (local $*tmp/735 i32)
 (local $*tmp/736 i32)
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
    (local.tee $*tmp/718
     (local.get $offset/201))
    (i32.const 2))
   (then
    (local.set $offset/201
     (i32.sub
      (local.tee $*tmp/719
       (local.get $offset/201))
      (i32.const 2)))
    (local.set $hi/207
     (i32.div_s
      (local.tee $byte_val/206
       (local.tee $*tmp/730
        (i32.and
         (local.tee $*tmp/731
          (local.get $n/204))
         (i32.const 255))))
      (i32.const 16)))
    (local.set $lo/208
     (i32.rem_s
      (local.get $byte_val/206)
      (i32.const 16)))
    (local.set $*tmp/723
     (local.get $offset/201))
    (local.set $*tmp/720
     (i32.add
      (local.get $digit_start/203)
      (local.get $*tmp/723)))
    (local.set $*tmp/721
     (i32.and
      (local.tee $*tmp/722
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10272)
         (i32.shl
          (local.get $hi/207)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/209)
      (i32.shl
       (local.get $*tmp/720)
       (i32.const 1)))
     (local.get $*tmp/721))
    (local.set $*tmp/728
     (local.get $offset/201))
    (local.set $*tmp/724
     (i32.add
      (local.tee $*tmp/727
       (i32.add
        (local.get $digit_start/203)
        (local.get $*tmp/728)))
      (i32.const 1)))
    (local.set $*tmp/725
     (i32.and
      (local.tee $*tmp/726
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10272)
         (i32.shl
          (local.get $lo/208)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/209)
      (i32.shl
       (local.get $*tmp/724)
       (i32.const 1)))
     (local.get $*tmp/725))
    (local.set $n/204
     (i32.shr_u
      (local.tee $*tmp/729
       (local.get $n/204))
      (i32.const 8)))
    (br $loop:210))
   (else)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/732
    (local.get $offset/201))
   (i32.const 1))
  (then
   (local.set $nibble/211
    (local.tee $*tmp/735
     (i32.and
      (local.tee $*tmp/736
       (local.get $n/204))
      (i32.const 15))))
   (local.set $*tmp/733
    (i32.and
     (local.tee $*tmp/734
      (i32.load16_u offset=8
       (i32.add
        (i32.const 10272)
        (i32.shl
         (local.get $nibble/211)
         (i32.const 1)))))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/209)
     (i32.shl
      (local.get $digit_start/203)
      (i32.const 1)))
    (local.get $*tmp/733))
   (call $moonbit.decref
    (local.get $buffer/209))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $buffer/209))
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::write_iter.inner|Int| (param $self/0/186 i32) (param $self/1/186 i32) (param $iter/190 i32) (param $prefix/187 i32) (param $suffix/200 i32) (param $sep/193 i32) (param $trailing/188 i32) (result i32)
 (local $*bind/189 i64)
 (local $*Some/191 i64)
 (local $*x/192 i32)
 (local $*bind/196 i64)
 (local $*Some/197 i64)
 (local $*x/198 i32)
 (local $first/195 i32)
 (if
  (local.get $self/1/186)
  (then
   (call $moonbit.incref
    (local.get $self/1/186)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
   (local.get $self/1/186)
   (local.get $prefix/187)
   (i32.load offset=8
    (local.get $self/0/186))))
 (if
  (local.get $trailing/188)
  (then
   (loop $loop:194
    (call $moonbit.incref
     (local.get $iter/190))
    (if
     (i64.eq
      (local.tee $*bind/189
       (call $@moonbitlang/core/builtin.Iter::next|Int|
        (local.get $iter/190)))
      (i64.const 4294967296))
     (then
      (call $moonbit.decref
       (local.get $sep/193))
      (call $moonbit.decref
       (local.get $iter/190)))
     (else
      (local.set $*x/192
       (i32.wrap_i64
        (local.tee $*Some/191
         (local.get $*bind/189))))
      (if
       (local.get $self/1/186)
       (then
        (call $moonbit.incref
         (local.get $self/1/186)))
       (else))
      (drop
       (call $@moonbitlang/core/builtin.Logger::write_object|Int|
        (local.get $self/0/186)
        (local.get $self/1/186)
        (local.get $*x/192)))
      (call $moonbit.incref
       (local.get $sep/193))
      (if
       (local.get $self/1/186)
       (then
        (call $moonbit.incref
         (local.get $self/1/186)))
       (else))
      (drop
       (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
        (local.get $self/1/186)
        (local.get $sep/193)
        (i32.load offset=8
         (local.get $self/0/186))))
      (br $loop:194)))))
  (else
   (local.set $first/195
    (i32.const 1))
   (loop $loop:199
    (call $moonbit.incref
     (local.get $iter/190))
    (if
     (i64.eq
      (local.tee $*bind/196
       (call $@moonbitlang/core/builtin.Iter::next|Int|
        (local.get $iter/190)))
      (i64.const 4294967296))
     (then
      (call $moonbit.decref
       (local.get $sep/193))
      (call $moonbit.decref
       (local.get $iter/190)))
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
        (call $moonbit.incref
         (local.get $sep/193))
        (if
         (local.get $self/1/186)
         (then
          (call $moonbit.incref
           (local.get $self/1/186)))
         (else))
        (drop
         (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
          (local.get $self/1/186)
          (local.get $sep/193)
          (i32.load offset=8
           (local.get $self/0/186))))))
      (if
       (local.get $self/1/186)
       (then
        (call $moonbit.incref
         (local.get $self/1/186)))
       (else))
      (drop
       (call $@moonbitlang/core/builtin.Logger::write_object|Int|
        (local.get $self/0/186)
        (local.get $self/1/186)
        (local.get $*x/198)))
      (br $loop:199))))))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $self/1/186)
  (local.get $suffix/200)
  (i32.load offset=8
   (local.get $self/0/186))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/185 i32) (result i32)
 (local $logger/184 i32)
 (local $*tmp/0/717 i32)
 (local $*tmp/1/717 i32)
 (call $moonbit.incref
  (local.tee $logger/184
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/717
  (local.get $logger/184))
 (local.set $*tmp/0/717)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/185)
   (local.get $*tmp/0/717)
   (local.get $*tmp/1/717)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/184)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int| (param $self/183 i32) (result i32)
 (local $logger/182 i32)
 (local $*tmp/0/716 i32)
 (local $*tmp/1/716 i32)
 (call $moonbit.incref
  (local.tee $logger/182
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/716
  (local.get $logger/182))
 (local.set $*tmp/0/716)
 (drop
  (call $@moonbitlang/core/builtin.Show::Int::output
   (local.get $self/183)
   (local.get $*tmp/0/716)
   (local.get $*tmp/1/716)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/182)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>| (param $self/181 i32) (result i32)
 (local $logger/180 i32)
 (local $*tmp/0/715 i32)
 (local $*tmp/1/715 i32)
 (call $moonbit.incref
  (local.tee $logger/180
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/715
  (local.get $logger/180))
 (local.set $*tmp/0/715)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.Array::output|Int|
   (local.get $self/181)
   (local.get $*tmp/0/715)
   (local.get $*tmp/1/715)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/180)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/171 i32) (param $value/174 i32) (param $start/175 i32) (param $len/176 i32) (result i32)
 (local $*try_err/173 i32)
 (local $*tmp/0/708 i32)
 (local $*tmp/1/708 i32)
 (local $*tmp/2/708 i32)
 (local $*tmp/709 i64)
 (local $*tmp/710 i32)
 (local $*ok/0/711 i32)
 (local $*ok/1/711 i32)
 (local $*ok/2/711 i32)
 (local $*err/712 i32)
 (local $*obj/0/989 i32)
 (local $*obj/1/989 i32)
 (local $*obj/2/989 i32)
 (block $outer/988 (result i32) (result i32) (result i32)
  (block $join:172
   (local.set $*tmp/709
    (i64.extend_i32_s
     (local.tee $*tmp/710
      (i32.add
       (local.get $start/175)
       (local.get $len/176)))))
   (call $String::sub.inner
    (local.get $value/174)
    (local.get $start/175)
    (local.get $*tmp/709))
   (local.set $*obj/2/989)
   (local.set $*obj/1/989)
   (local.set $*obj/0/989)
   (if (result i32) (result i32) (result i32)
    (then
     (local.get $*obj/0/989)
     (local.get $*obj/1/989)
     (local.set $*ok/2/711
      (local.get $*obj/2/989))
     (local.set $*ok/1/711)
     (local.tee $*ok/0/711)
     (local.get $*ok/1/711)
     (local.get $*ok/2/711))
    (else
     (local.set $*try_err/173
      (local.tee $*err/712
       (local.get $*obj/0/989)))
     (br $join:172)))
   (br $outer/988))
  (call $moonbit.decref
   (local.get $*try_err/173))
  (unreachable))
 (local.set $*tmp/2/708)
 (local.set $*tmp/1/708)
 (local.set $*tmp/0/708)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.get $self/171)
  (local.get $*tmp/0/708)
  (local.get $*tmp/1/708)
  (local.get $*tmp/2/708)))
(func $String::sub (param $self/169 i32) (param $start.opt/167 i64) (param $end/170 i64) (result i32) (result i32) (result i32) (result i32)
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
(func $String::sub.inner (param $self/159 i32) (param $start/165 i32) (param $end/161 i64) (result i32) (result i32) (result i32) (result i32)
 (local $len/158 i32)
 (local $end/160 i32)
 (local $*Some/162 i64)
 (local $*end/163 i32)
 (local $start/164 i32)
 (local $*p/447 i32)
 (local $*p/450 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/704 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/705 i32)
 (local $*tmp/0/706 i32)
 (local $*tmp/1/706 i32)
 (local $*tmp/2/706 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/707 i32)
 (local.set $len/158
  (call $moonbit.array_length
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
 (if (result i32) (result i32) (result i32) (result i32)
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
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/159)
         (i32.shl
          (local.get $start/164)
          (i32.const 1)))))
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
     (call $moonbit.decref
      (local.get $self/159))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/704
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/704)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $end/160)
      (local.get $len/158))
     (then
      (local.set $*p/450
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/159)
         (i32.shl
          (local.get $end/160)
          (i32.const 1)))))
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
     (call $moonbit.decref
      (local.get $self/159))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/705
      (i32.const 10000))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/705)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (local.get $self/159)
   (local.get $start/164)
   (local.set $*tmp/2/706
    (local.get $end/160))
   (local.set $*tmp/1/706)
   (local.set $*tmp/0/706)
   (i32.const 1)
   (local.get $*tmp/0/706)
   (local.get $*tmp/1/706)
   (local.get $*tmp/2/706))
  (else
   (call $moonbit.decref
    (local.get $self/159))
   (local.set $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/707
    (i32.const 10360))
   (i32.const 0)
   (local.get $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/707)
   (i32.const 0)
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/156 i32) (param $str/157 i32) (result i32)
 (local $*tmp/693 i32)
 (local $len/694 i32)
 (local $*tmp/695 i32)
 (local $*tmp/696 i32)
 (local $data/697 i32)
 (local $len/698 i32)
 (local $*tmp/699 i32)
 (local $*tmp/700 i32)
 (local $len/701 i32)
 (local $*tmp/702 i32)
 (local $*tmp/703 i32)
 (local $*tmp/940 i32)
 (local $*field/941 i32)
 (local.set $len/694
  (i32.load offset=8
   (local.get $self/156)))
 (local.set $*tmp/695
  (i32.mul
   (local.tee $*tmp/696
    (call $moonbit.array_length
     (local.get $str/157)))
   (i32.const 2)))
 (local.set $*tmp/693
  (i32.add
   (local.get $len/694)
   (local.get $*tmp/695)))
 (call $moonbit.incref
  (local.get $self/156))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/156)
   (local.get $*tmp/693)))
 (local.set $data/697
  (local.tee $*field/941
   (i32.load offset=12
    (local.get $self/156))))
 (local.set $len/698
  (i32.load offset=8
   (local.get $self/156)))
 (local.set $*tmp/699
  (call $moonbit.array_length
   (local.get $str/157)))
 (call $moonbit.incref
  (local.get $data/697))
 (call $moonbit.incref
  (local.get $str/157))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/697)
   (local.get $len/698)
   (local.get $str/157)
   (i32.const 0)
   (local.get $*tmp/699)))
 (local.set $len/701
  (i32.load offset=8
   (local.get $self/156)))
 (local.set $*tmp/940
  (call $moonbit.array_length
   (local.get $str/157)))
 (call $moonbit.decref
  (local.get $str/157))
 (local.set $*tmp/702
  (i32.mul
   (local.tee $*tmp/703
    (local.get $*tmp/940))
   (i32.const 2)))
 (local.set $*tmp/700
  (i32.add
   (local.get $len/701)
   (local.get $*tmp/702)))
 (i32.store offset=8
  (local.get $self/156)
  (local.get $*tmp/700))
 (call $moonbit.decref
  (local.get $self/156))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/148 i32) (param $bytes_offset/143 i32) (param $str/150 i32) (param $str_offset/146 i32) (param $length/144 i32) (result i32)
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
 (local $*arr/990 i32)
 (local $*idx/991 i32)
 (local $*arr/992 i32)
 (local $*idx/993 i32)
 (local.set $*tmp/692
  (i32.mul
   (local.get $length/144)
   (i32.const 2)))
 (local.set $e1/142
  (i32.sub
   (local.tee $*tmp/691
    (i32.add
     (local.get $bytes_offset/143)
     (local.get $*tmp/692)))
   (i32.const 1)))
 (local.set $e2/145
  (i32.sub
   (local.tee $*tmp/690
    (i32.add
     (local.get $str_offset/146)
     (local.get $length/144)))
   (i32.const 1)))
 (local.set $len1/147
  (call $moonbit.array_length
   (local.get $self/148)))
 (local.set $len2/149
  (call $moonbit.array_length
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
      (local.set $*tmp/682
       (i32.and
        (local.tee $*tmp/683
         (local.tee $*p/441
          (i32.and
           (local.tee $c/154
            (local.tee $*tmp/687
             (i32.load16_u offset=8
              (i32.add
               (local.get $str/150)
               (i32.shl
                (local.get $i/152)
                (i32.const 1))))))
           (i32.const 255))))
        (i32.const 255)))
      (local.get $self/148)
      (local.set $*idx/993
       (local.get $j/153))
      (local.set $*arr/992)
      (call $moonbit.check_range
       (local.get $*idx/993)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/992))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/992)
        (local.get $*idx/993))
       (local.get $*tmp/682))
      (local.set $*tmp/684
       (i32.add
        (local.get $j/153)
        (i32.const 1)))
      (local.set $*tmp/685
       (i32.and
        (local.tee $*tmp/686
         (local.tee $*p/444
          (i32.shr_u
           (local.get $c/154)
           (i32.const 8))))
        (i32.const 255)))
      (local.get $self/148)
      (local.set $*idx/991
       (local.get $*tmp/684))
      (local.set $*arr/990)
      (call $moonbit.check_range
       (local.get $*idx/991)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/990))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/990)
        (local.get $*idx/991))
       (local.get $*tmp/685))
      (local.set $*tmp/688
       (i32.add
        (local.get $i/152)
        (i32.const 1)))
      (local.set $*tmp/689
       (i32.add
        (local.get $j/153)
        (i32.const 2)))
      (local.get $*tmp/688)
      (local.get $*tmp/689)
      (br $loop:155))
     (else
      (call $moonbit.decref
       (local.get $str/150))
      (call $moonbit.decref
       (local.get $self/148)))))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $str/150))
   (call $moonbit.decref
    (local.get $self/148))
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/65 i32) (result i32)
 (local $*bind/0/64 i32)
 (local $*bind/1/64 i32)
 (local $*bind/2/64 i32)
 (local $*data/66 i32)
 (local $*start/67 i32)
 (local $*end/68 i32)
 (local $start_line/0/86 i32)
 (local $start_line/1/86 i32)
 (local $start_line/2/86 i32)
 (local $*try_err/88 i32)
 (local $start_column/0/89 i32)
 (local $start_column/1/89 i32)
 (local $start_column/2/89 i32)
 (local $*try_err/91 i32)
 (local $pkg/0/92 i32)
 (local $pkg/1/92 i32)
 (local $pkg/2/92 i32)
 (local $*try_err/94 i32)
 (local $filename/0/95 i32)
 (local $filename/1/95 i32)
 (local $filename/2/95 i32)
 (local $*try_err/97 i32)
 (local $end_line/0/98 i32)
 (local $end_line/1/98 i32)
 (local $end_line/2/98 i32)
 (local $*try_err/100 i32)
 (local $end_column/0/101 i32)
 (local $end_column/1/101 i32)
 (local $end_column/2/101 i32)
 (local $*try_err/103 i32)
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
 (local $*tmp/601 i64)
 (local $*tmp/602 i64)
 (local $*tmp/603 i32)
 (local $*tmp/604 i32)
 (local $*tmp/605 i32)
 (local $*ok/0/606 i32)
 (local $*ok/1/606 i32)
 (local $*ok/2/606 i32)
 (local $*err/607 i32)
 (local $*tmp/608 i64)
 (local $*tmp/609 i64)
 (local $*tmp/610 i32)
 (local $*tmp/611 i32)
 (local $*tmp/612 i32)
 (local $*ok/0/613 i32)
 (local $*ok/1/613 i32)
 (local $*ok/2/613 i32)
 (local $*err/614 i32)
 (local $*tmp/615 i64)
 (local $*tmp/616 i64)
 (local $*tmp/617 i32)
 (local $*tmp/618 i32)
 (local $*tmp/619 i32)
 (local $*ok/0/620 i32)
 (local $*ok/1/620 i32)
 (local $*ok/2/620 i32)
 (local $*err/621 i32)
 (local $*tmp/622 i64)
 (local $*tmp/623 i64)
 (local $*tmp/624 i32)
 (local $*tmp/625 i32)
 (local $*ok/0/626 i32)
 (local $*ok/1/626 i32)
 (local $*ok/2/626 i32)
 (local $*err/627 i32)
 (local $*tmp/628 i64)
 (local $*tmp/629 i64)
 (local $*tmp/630 i32)
 (local $*tmp/631 i32)
 (local $*tmp/632 i32)
 (local $*ok/0/633 i32)
 (local $*ok/1/633 i32)
 (local $*ok/2/633 i32)
 (local $*err/634 i32)
 (local $*tmp/635 i64)
 (local $*tmp/636 i64)
 (local $*tmp/637 i32)
 (local $*tmp/638 i32)
 (local $*tmp/639 i32)
 (local $*ok/0/640 i32)
 (local $*ok/1/640 i32)
 (local $*ok/2/640 i32)
 (local $*err/641 i32)
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
 (local $*tmp/677 i32)
 (local $*tmp/678 i32)
 (local $end/679 i32)
 (local $start/680 i32)
 (local $*tmp/681 i32)
 (local $*field/942 i32)
 (local $*field/943 i32)
 (local $ptr/1020 i32)
 (local $*obj/0/1022 i32)
 (local $*obj/1/1022 i32)
 (local $*obj/2/1022 i32)
 (local $*obj/0/1024 i32)
 (local $*obj/1/1024 i32)
 (local $*obj/2/1024 i32)
 (local $*obj/0/1026 i32)
 (local $*obj/1/1026 i32)
 (local $*obj/2/1026 i32)
 (local $*obj/0/1028 i32)
 (local $*obj/1/1028 i32)
 (local $*obj/2/1028 i32)
 (local $*obj/0/1030 i32)
 (local $*obj/1/1030 i32)
 (local $*obj/2/1030 i32)
 (local $*obj/0/1032 i32)
 (local $*obj/1/1032 i32)
 (local $*obj/2/1032 i32)
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
 (local.set $*tmp/681
  (call $moonbit.array_length
   (local.get $repr/65)))
 (local.get $repr/65)
 (i32.const 0)
 (local.set $*bind/2/64
  (local.get $*tmp/681))
 (local.set $*bind/1/64)
 (local.tee $*bind/0/64)
 (local.tee $*field/943)
 (local.set $*data/66)
 (local.set $*start/67
  (local.get $*bind/1/64))
 (local.set $end/679
  (local.get $*bind/2/64))
 (local.set $start/680
  (local.tee $*field/942
   (local.get $*bind/1/64)))
 (local.set $*tmp/678
  (i32.sub
   (local.get $end/679)
   (local.get $start/680)))
 (local.set $*end/68
  (i32.add
   (local.get $*start/67)
   (local.get $*tmp/678)))
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
  (block $join:104
   (if (result i32)
    (i32.lt_s
     (local.tee $*tmp/668
      (local.get $*cursor/69))
     (local.get $*end/68))
    (then
     (local.set $*p/387
      (local.get $*cursor/69))
     (local.set $next_char/134
      (i32.load16_u offset=8
       (i32.add
        (local.get $*data/66)
        (i32.shl
         (local.get $*p/387)
         (i32.const 1)))))
     (local.set $*cursor/69
      (i32.add
       (local.tee $*tmp/669
        (local.get $*cursor/69))
       (i32.const 1)))
     (if (result i32)
      (i32.lt_s
       (local.get $next_char/134)
       (i32.const 65))
      (then
       (if (result i32)
        (i32.lt_s
         (local.get $next_char/134)
         (i32.const 64))
        (then
         (br $join:85))
        (else
         (loop $loop:136 (result i32)
          (local.set $tag_0/77
           (local.get $*cursor/69))
          (if (result i32)
           (i32.lt_s
            (local.tee $*tmp/670
             (local.get $*cursor/69))
            (local.get $*end/68))
           (then
            (block $outer/994 (result i32)
             (block $join:135
              (local.set $*p/390
               (local.get $*cursor/69))
              (local.set $next_char/137
               (i32.load16_u offset=8
                (i32.add
                 (local.get $*data/66)
                 (i32.shl
                  (local.get $*p/390)
                  (i32.const 1)))))
              (local.set $*cursor/69
               (i32.add
                (local.tee $*tmp/671
                 (local.get $*cursor/69))
                (i32.const 1)))
              (if (result i32)
               (i32.lt_s
                (local.get $next_char/137)
                (i32.const 55296))
               (then
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/137)
                  (i32.const 58))
                 (then
                  (br $join:135))
                 (else
                  (if (result i32)
                   (i32.gt_s
                    (local.get $next_char/137)
                    (i32.const 58))
                   (then
                    (br $join:135))
                   (else
                    (if (result i32)
                     (i32.lt_s
                      (local.tee $*tmp/672
                       (local.get $*cursor/69))
                      (local.get $*end/68))
                     (then
                      (block $outer/995 (result i32)
                       (block $join:138
                        (local.set $*p/393
                         (local.get $*cursor/69))
                        (local.set $next_char/139
                         (i32.load16_u offset=8
                          (i32.add
                           (local.get $*data/66)
                           (i32.shl
                            (local.get $*p/393)
                            (i32.const 1)))))
                        (local.set $*cursor/69
                         (i32.add
                          (local.tee $*tmp/673
                           (local.get $*cursor/69))
                          (i32.const 1)))
                        (if (result i32)
                         (i32.lt_s
                          (local.get $next_char/139)
                          (i32.const 56319))
                         (then
                          (if (result i32)
                           (i32.lt_s
                            (local.get $next_char/139)
                            (i32.const 55296))
                           (then
                            (br $join:138))
                           (else
                            (local.set $join_dispatch_19/105
                             (i32.const 7))
                            (br $join:104))))
                         (else
                          (if (result i32)
                           (i32.gt_s
                            (local.get $next_char/139)
                            (i32.const 56319))
                           (then
                            (if (result i32)
                             (i32.lt_s
                              (local.get $next_char/139)
                              (i32.const 65536))
                             (then
                              (br $join:138))
                             (else
                              (br $join:85))))
                           (else
                            (local.set $join_dispatch_19/105
                             (i32.const 8))
                            (br $join:104)))))
                        (br $outer/995))
                       (local.set $join_dispatch_19/105
                        (i32.const 0))
                       (br $join:104)))
                     (else
                      (br $join:85))))))))
               (else
                (if (result i32)
                 (i32.gt_s
                  (local.get $next_char/137)
                  (i32.const 56318))
                 (then
                  (if (result i32)
                   (i32.lt_s
                    (local.get $next_char/137)
                    (i32.const 57344))
                   (then
                    (if (result i32)
                     (i32.lt_s
                      (local.tee $*tmp/674
                       (local.get $*cursor/69))
                      (local.get $*end/68))
                     (then
                      (local.set $*p/396
                       (local.get $*cursor/69))
                      (local.set $next_char/140
                       (i32.load16_u offset=8
                        (i32.add
                         (local.get $*data/66)
                         (i32.shl
                          (local.get $*p/396)
                          (i32.const 1)))))
                      (local.set $*cursor/69
                       (i32.add
                        (local.tee $*tmp/675
                         (local.get $*cursor/69))
                        (i32.const 1)))
                      (if (result i32)
                       (i32.lt_s
                        (local.get $next_char/140)
                        (i32.const 56320))
                       (then
                        (br $join:85))
                       (else
                        (if (result i32)
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
                    (if (result i32)
                     (i32.gt_s
                      (local.get $next_char/137)
                      (i32.const 65535))
                     (then
                      (br $join:85))
                     (else
                      (br $join:135))))))
                 (else
                  (if (result i32)
                   (i32.lt_s
                    (local.tee $*tmp/676
                     (local.get $*cursor/69))
                    (local.get $*end/68))
                   (then
                    (local.set $*p/399
                     (local.get $*cursor/69))
                    (local.set $next_char/141
                     (i32.load16_u offset=8
                      (i32.add
                       (local.get $*data/66)
                       (i32.shl
                        (local.get $*p/399)
                        (i32.const 1)))))
                    (local.set $*cursor/69
                     (i32.add
                      (local.tee $*tmp/677
                       (local.get $*cursor/69))
                      (i32.const 1)))
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/141)
                      (i32.const 56320))
                     (then
                      (br $join:85))
                     (else
                      (if (result i32)
                       (i32.gt_s
                        (local.get $next_char/141)
                        (i32.const 65535))
                       (then
                        (br $join:85))
                       (else
                        (br $loop:136))))))
                   (else
                    (br $join:85)))))))
              (br $outer/994))
             (br $loop:136)))
           (else
            (br $join:85)))))))
      (else
       (br $join:85))))
    (else
     (br $join:85)))
   (return))
  (local.get $join_dispatch_19/105)
  (loop $loop:109 (param i32) (result i32)
   (local.set $dispatch_19/106)
   (block $outer/996 (result i32)
    (block $join:107
     (block $outer/997 (result i32)
      (block $join:111
       (block $switch_int/1008 (result i32)
        (block $switch_default/1009
         (block $switch_int_1/1011
          (block $switch_int_7/1017
           (block $switch_int_6/1016
            (block $switch_int_5/1015
             (block $switch_int_4/1014
              (block $switch_int_8/1018
               (block $switch_int_0/1010
                (block $switch_int_2/1012
                 (block $switch_int_3/1013
                  (local.get $dispatch_19/106)
                  (br_table
                   $switch_int_0/1010
                   $switch_int_1/1011
                   $switch_int_2/1012
                   $switch_int_3/1013
                   $switch_int_4/1014
                   $switch_int_5/1015
                   $switch_int_6/1016
                   $switch_int_7/1017
                   $switch_int_8/1018
                   $switch_default/1009
                   ))
                 (local.set $tag_1_2/80
                  (local.get $tag_1_1/79))
                 (local.set $tag_1_1/79
                  (local.get $tag_1/78))
                 (local.set $tag_1/78
                  (local.get $*cursor/69))
                 (if (result i32)
                  (i32.lt_s
                   (local.tee $*tmp/644
                    (local.get $*cursor/69))
                   (local.get $*end/68))
                  (then
                   (block $outer/998 (result i32)
                    (block $join:112
                     (local.set $*p/402
                      (local.get $*cursor/69))
                     (local.set $next_char/113
                      (i32.load16_u offset=8
                       (i32.add
                        (local.get $*data/66)
                        (i32.shl
                         (local.get $*p/402)
                         (i32.const 1)))))
                     (local.set $*cursor/69
                      (i32.add
                       (local.tee $*tmp/645
                        (local.get $*cursor/69))
                       (i32.const 1)))
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/113)
                       (i32.const 55296))
                      (then
                       (if (result i32)
                        (i32.lt_s
                         (local.get $next_char/113)
                         (i32.const 58))
                        (then
                         (if (result i32)
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
                           (if (result i32)
                            (i32.lt_s
                             (local.tee $*tmp/646
                              (local.get $*cursor/69))
                             (local.get $*end/68))
                            (then
                             (block $outer/999 (result i32)
                              (block $join:114
                               (local.set $*p/405
                                (local.get $*cursor/69))
                               (local.set $next_char/115
                                (i32.load16_u offset=8
                                 (i32.add
                                  (local.get $*data/66)
                                  (i32.shl
                                   (local.get $*p/405)
                                   (i32.const 1)))))
                               (local.set $*cursor/69
                                (i32.add
                                 (local.tee $*tmp/647
                                  (local.get $*cursor/69))
                                 (i32.const 1)))
                               (if (result i32)
                                (i32.lt_s
                                 (local.get $next_char/115)
                                 (i32.const 59))
                                (then
                                 (if (result i32)
                                  (i32.lt_s
                                   (local.get $next_char/115)
                                   (i32.const 46))
                                  (then
                                   (if (result i32)
                                    (i32.lt_s
                                     (local.get $next_char/115)
                                     (i32.const 45))
                                    (then
                                     (br $join:114))
                                    (else
                                     (br $join:107))))
                                  (else
                                   (if (result i32)
                                    (i32.gt_s
                                     (local.get $next_char/115)
                                     (i32.const 47))
                                    (then
                                     (if (result i32)
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
                                 (if (result i32)
                                  (i32.gt_s
                                   (local.get $next_char/115)
                                   (i32.const 55295))
                                  (then
                                   (if (result i32)
                                    (i32.lt_s
                                     (local.get $next_char/115)
                                     (i32.const 57344))
                                    (then
                                     (if (result i32)
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
                                     (if (result i32)
                                      (i32.gt_s
                                       (local.get $next_char/115)
                                       (i32.const 65535))
                                      (then
                                       (br $join:85))
                                      (else
                                       (br $join:114))))))
                                  (else
                                   (br $join:114)))))
                               (br $outer/999))
                              (i32.const 0)
                              (br $loop:109)))
                            (else
                             (br $join:85))))))
                        (else
                         (if (result i32)
                          (i32.gt_s
                           (local.get $next_char/113)
                           (i32.const 58))
                          (then
                           (br $join:112))
                          (else
                           (i32.const 1)
                           (br $loop:109))))))
                      (else
                       (if (result i32)
                        (i32.gt_s
                         (local.get $next_char/113)
                         (i32.const 56318))
                        (then
                         (if (result i32)
                          (i32.lt_s
                           (local.get $next_char/113)
                           (i32.const 57344))
                          (then
                           (i32.const 8)
                           (br $loop:109))
                          (else
                           (if (result i32)
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
                     (br $outer/998))
                    (i32.const 0)
                    (br $loop:109)))
                  (else
                   (br $join:85)))
                 (br $switch_int/1008))
                (local.set $tag_1/78
                 (local.get $*cursor/69))
                (local.set $tag_2/82
                 (local.get $*cursor/69))
                (if (result i32)
                 (i32.lt_s
                  (local.tee $*tmp/648
                   (local.get $*cursor/69))
                  (local.get $*end/68))
                 (then
                  (block $outer/1000 (result i32)
                   (block $join:116
                    (local.set $*p/408
                     (local.get $*cursor/69))
                    (local.set $next_char/117
                     (i32.load16_u offset=8
                      (i32.add
                       (local.get $*data/66)
                       (i32.shl
                        (local.get $*p/408)
                        (i32.const 1)))))
                    (local.set $*cursor/69
                     (i32.add
                      (local.tee $*tmp/649
                       (local.get $*cursor/69))
                      (i32.const 1)))
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/117)
                      (i32.const 55296))
                     (then
                      (if (result i32)
                       (i32.lt_s
                        (local.get $next_char/117)
                        (i32.const 58))
                       (then
                        (if (result i32)
                         (i32.lt_s
                          (local.get $next_char/117)
                          (i32.const 48))
                         (then
                          (br $join:116))
                         (else
                          (i32.const 2)
                          (br $loop:109))))
                       (else
                        (if (result i32)
                         (i32.gt_s
                          (local.get $next_char/117)
                          (i32.const 58))
                         (then
                          (br $join:116))
                         (else
                          (i32.const 3)
                          (br $loop:109))))))
                     (else
                      (if (result i32)
                       (i32.gt_s
                        (local.get $next_char/117)
                        (i32.const 56318))
                       (then
                        (if (result i32)
                         (i32.lt_s
                          (local.get $next_char/117)
                          (i32.const 57344))
                         (then
                          (i32.const 8)
                          (br $loop:109))
                         (else
                          (if (result i32)
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
                    (br $outer/1000))
                   (i32.const 0)
                   (br $loop:109)))
                 (else
                  (br $join:85)))
                (br $switch_int/1008))
               (local.set $tag_1/78
                (local.get $*cursor/69))
               (if (result i32)
                (i32.lt_s
                 (local.tee $*tmp/650
                  (local.get $*cursor/69))
                 (local.get $*end/68))
                (then
                 (block $outer/1001 (result i32)
                  (block $join:118
                   (local.set $*p/411
                    (local.get $*cursor/69))
                   (local.set $next_char/119
                    (i32.load16_u offset=8
                     (i32.add
                      (local.get $*data/66)
                      (i32.shl
                       (local.get $*p/411)
                       (i32.const 1)))))
                   (local.set $*cursor/69
                    (i32.add
                     (local.tee $*tmp/651
                      (local.get $*cursor/69))
                     (i32.const 1)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/119)
                     (i32.const 55296))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/119)
                       (i32.const 58))
                      (then
                       (br $join:118))
                      (else
                       (if (result i32)
                        (i32.gt_s
                         (local.get $next_char/119)
                         (i32.const 58))
                        (then
                         (br $join:118))
                        (else
                         (i32.const 1)
                         (br $loop:109))))))
                    (else
                     (if (result i32)
                      (i32.gt_s
                       (local.get $next_char/119)
                       (i32.const 56318))
                      (then
                       (if (result i32)
                        (i32.lt_s
                         (local.get $next_char/119)
                         (i32.const 57344))
                        (then
                         (i32.const 8)
                         (br $loop:109))
                        (else
                         (if (result i32)
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
                   (br $outer/1001))
                  (i32.const 0)
                  (br $loop:109)))
                (else
                 (br $join:85)))
               (br $switch_int/1008))
              (if (result i32)
               (i32.lt_s
                (local.tee $*tmp/652
                 (local.get $*cursor/69))
                (local.get $*end/68))
               (then
                (local.set $*p/414
                 (local.get $*cursor/69))
                (local.set $next_char/120
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/66)
                   (i32.shl
                    (local.get $*p/414)
                    (i32.const 1)))))
                (local.set $*cursor/69
                 (i32.add
                  (local.tee $*tmp/653
                   (local.get $*cursor/69))
                  (i32.const 1)))
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/120)
                  (i32.const 56320))
                 (then
                  (br $join:85))
                 (else
                  (if (result i32)
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
              (br $switch_int/1008))
             (local.set $tag_1/78
              (local.get $*cursor/69))
             (local.set $tag_4/84
              (local.get $*cursor/69))
             (if (result i32)
              (i32.lt_s
               (local.tee $*tmp/654
                (local.get $*cursor/69))
               (local.get $*end/68))
              (then
               (block $outer/1002 (result i32)
                (block $join:121
                 (local.set $*p/417
                  (local.get $*cursor/69))
                 (local.set $next_char/122
                  (i32.load16_u offset=8
                   (i32.add
                    (local.get $*data/66)
                    (i32.shl
                     (local.get $*p/417)
                     (i32.const 1)))))
                 (local.set $*cursor/69
                  (i32.add
                   (local.tee $*tmp/655
                    (local.get $*cursor/69))
                   (i32.const 1)))
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/122)
                   (i32.const 55296))
                  (then
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/122)
                     (i32.const 58))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/122)
                       (i32.const 48))
                      (then
                       (br $join:121))
                      (else
                       (i32.const 4)
                       (br $loop:109))))
                    (else
                     (if (result i32)
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
                       (if (result i32)
                        (i32.lt_s
                         (local.tee $*tmp/656
                          (local.get $*cursor/69))
                         (local.get $*end/68))
                        (then
                         (block $outer/1003 (result i32)
                          (block $join:123
                           (local.set $*p/420
                            (local.get $*cursor/69))
                           (local.set $next_char/124
                            (i32.load16_u offset=8
                             (i32.add
                              (local.get $*data/66)
                              (i32.shl
                               (local.get $*p/420)
                               (i32.const 1)))))
                           (local.set $*cursor/69
                            (i32.add
                             (local.tee $*tmp/657
                              (local.get $*cursor/69))
                             (i32.const 1)))
                           (if (result i32)
                            (i32.lt_s
                             (local.get $next_char/124)
                             (i32.const 55296))
                            (then
                             (if (result i32)
                              (i32.lt_s
                               (local.get $next_char/124)
                               (i32.const 58))
                              (then
                               (if (result i32)
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
                                 (if (result i32)
                                  (i32.lt_s
                                   (local.tee $*tmp/658
                                    (local.get $*cursor/69))
                                   (local.get $*end/68))
                                  (then
                                   (block $outer/1004 (result i32)
                                    (block $join:125
                                     (local.set $*p/423
                                      (local.get $*cursor/69))
                                     (local.set $next_char/126
                                      (i32.load16_u offset=8
                                       (i32.add
                                        (local.get $*data/66)
                                        (i32.shl
                                         (local.get $*p/423)
                                         (i32.const 1)))))
                                     (local.set $*cursor/69
                                      (i32.add
                                       (local.tee $*tmp/659
                                        (local.get $*cursor/69))
                                       (i32.const 1)))
                                     (if (result i32)
                                      (i32.lt_s
                                       (local.get $next_char/126)
                                       (i32.const 55296))
                                      (then
                                       (if (result i32)
                                        (i32.lt_s
                                         (local.get $next_char/126)
                                         (i32.const 58))
                                        (then
                                         (if (result i32)
                                          (i32.lt_s
                                           (local.get $next_char/126)
                                           (i32.const 48))
                                          (then
                                           (br $join:125))
                                          (else
                                           (i32.const 5)
                                           (br $loop:109))))
                                        (else
                                         (if (result i32)
                                          (i32.gt_s
                                           (local.get $next_char/126)
                                           (i32.const 58))
                                          (then
                                           (br $join:125))
                                          (else
                                           (i32.const 3)
                                           (br $loop:109))))))
                                      (else
                                       (if (result i32)
                                        (i32.gt_s
                                         (local.get $next_char/126)
                                         (i32.const 56318))
                                        (then
                                         (if (result i32)
                                          (i32.lt_s
                                           (local.get $next_char/126)
                                           (i32.const 57344))
                                          (then
                                           (i32.const 8)
                                           (br $loop:109))
                                          (else
                                           (if (result i32)
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
                                     (br $outer/1004))
                                    (i32.const 0)
                                    (br $loop:109)))
                                  (else
                                   (br $join:111))))))
                              (else
                               (if (result i32)
                                (i32.gt_s
                                 (local.get $next_char/124)
                                 (i32.const 58))
                                (then
                                 (br $join:123))
                                (else
                                 (i32.const 1)
                                 (br $loop:109))))))
                            (else
                             (if (result i32)
                              (i32.gt_s
                               (local.get $next_char/124)
                               (i32.const 56318))
                              (then
                               (if (result i32)
                                (i32.lt_s
                                 (local.get $next_char/124)
                                 (i32.const 57344))
                                (then
                                 (i32.const 8)
                                 (br $loop:109))
                                (else
                                 (if (result i32)
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
                           (br $outer/1003))
                          (i32.const 0)
                          (br $loop:109)))
                        (else
                         (br $join:85))))))))
                  (else
                   (if (result i32)
                    (i32.gt_s
                     (local.get $next_char/122)
                     (i32.const 56318))
                    (then
                     (if (result i32)
                      (i32.lt_s
                       (local.get $next_char/122)
                       (i32.const 57344))
                      (then
                       (i32.const 8)
                       (br $loop:109))
                      (else
                       (if (result i32)
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
                 (br $outer/1002))
                (i32.const 0)
                (br $loop:109)))
              (else
               (br $join:85)))
             (br $switch_int/1008))
            (local.set $tag_1/78
             (local.get $*cursor/69))
            (local.set $tag_2/82
             (local.get $*cursor/69))
            (if (result i32)
             (i32.lt_s
              (local.tee $*tmp/660
               (local.get $*cursor/69))
              (local.get $*end/68))
             (then
              (block $outer/1005 (result i32)
               (block $join:127
                (local.set $*p/426
                 (local.get $*cursor/69))
                (local.set $next_char/128
                 (i32.load16_u offset=8
                  (i32.add
                   (local.get $*data/66)
                   (i32.shl
                    (local.get $*p/426)
                    (i32.const 1)))))
                (local.set $*cursor/69
                 (i32.add
                  (local.tee $*tmp/661
                   (local.get $*cursor/69))
                  (i32.const 1)))
                (if (result i32)
                 (i32.lt_s
                  (local.get $next_char/128)
                  (i32.const 55296))
                 (then
                  (if (result i32)
                   (i32.lt_s
                    (local.get $next_char/128)
                    (i32.const 58))
                   (then
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/128)
                      (i32.const 48))
                     (then
                      (br $join:127))
                     (else
                      (i32.const 5)
                      (br $loop:109))))
                   (else
                    (if (result i32)
                     (i32.gt_s
                      (local.get $next_char/128)
                      (i32.const 58))
                     (then
                      (br $join:127))
                     (else
                      (i32.const 3)
                      (br $loop:109))))))
                 (else
                  (if (result i32)
                   (i32.gt_s
                    (local.get $next_char/128)
                    (i32.const 56318))
                   (then
                    (if (result i32)
                     (i32.lt_s
                      (local.get $next_char/128)
                      (i32.const 57344))
                     (then
                      (i32.const 8)
                      (br $loop:109))
                     (else
                      (if (result i32)
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
                (br $outer/1005))
               (i32.const 0)
               (br $loop:109)))
             (else
              (br $join:111)))
            (br $switch_int/1008))
           (local.set $tag_1/78
            (local.get $*cursor/69))
           (local.set $tag_2/82
            (local.get $*cursor/69))
           (local.set $tag_3/81
            (local.get $*cursor/69))
           (if (result i32)
            (i32.lt_s
             (local.tee $*tmp/662
              (local.get $*cursor/69))
             (local.get $*end/68))
            (then
             (block $outer/1006 (result i32)
              (block $join:129
               (local.set $*p/429
                (local.get $*cursor/69))
               (local.set $next_char/130
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $*data/66)
                  (i32.shl
                   (local.get $*p/429)
                   (i32.const 1)))))
               (local.set $*cursor/69
                (i32.add
                 (local.tee $*tmp/663
                  (local.get $*cursor/69))
                 (i32.const 1)))
               (if (result i32)
                (i32.lt_s
                 (local.get $next_char/130)
                 (i32.const 59))
                (then
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/130)
                   (i32.const 46))
                  (then
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/130)
                     (i32.const 45))
                    (then
                     (br $join:129))
                    (else
                     (br $join:107))))
                  (else
                   (if (result i32)
                    (i32.gt_s
                     (local.get $next_char/130)
                     (i32.const 47))
                    (then
                     (if (result i32)
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
                 (if (result i32)
                  (i32.gt_s
                   (local.get $next_char/130)
                   (i32.const 55295))
                  (then
                   (if (result i32)
                    (i32.lt_s
                     (local.get $next_char/130)
                     (i32.const 57344))
                    (then
                     (if (result i32)
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
                     (if (result i32)
                      (i32.gt_s
                       (local.get $next_char/130)
                       (i32.const 65535))
                      (then
                       (br $join:85))
                      (else
                       (br $join:129))))))
                  (else
                   (br $join:129)))))
               (br $outer/1006))
              (i32.const 0)
              (br $loop:109)))
            (else
             (br $join:85)))
           (br $switch_int/1008))
          (if (result i32)
           (i32.lt_s
            (local.tee $*tmp/664
             (local.get $*cursor/69))
            (local.get $*end/68))
           (then
            (local.set $*p/432
             (local.get $*cursor/69))
            (local.set $next_char/131
             (i32.load16_u offset=8
              (i32.add
               (local.get $*data/66)
               (i32.shl
                (local.get $*p/432)
                (i32.const 1)))))
            (local.set $*cursor/69
             (i32.add
              (local.tee $*tmp/665
               (local.get $*cursor/69))
              (i32.const 1)))
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/131)
              (i32.const 56320))
             (then
              (br $join:85))
             (else
              (if (result i32)
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
          (br $switch_int/1008))
         (local.set $tag_1_1/79
          (local.get $tag_1/78))
         (local.set $tag_1/78
          (local.get $*cursor/69))
         (if (result i32)
          (i32.lt_s
           (local.tee $*tmp/666
            (local.get $*cursor/69))
           (local.get $*end/68))
          (then
           (block $outer/1007 (result i32)
            (block $join:132
             (local.set $*p/435
              (local.get $*cursor/69))
             (local.set $next_char/133
              (i32.load16_u offset=8
               (i32.add
                (local.get $*data/66)
                (i32.shl
                 (local.get $*p/435)
                 (i32.const 1)))))
             (local.set $*cursor/69
              (i32.add
               (local.tee $*tmp/667
                (local.get $*cursor/69))
               (i32.const 1)))
             (if (result i32)
              (i32.lt_s
               (local.get $next_char/133)
               (i32.const 55296))
              (then
               (if (result i32)
                (i32.lt_s
                 (local.get $next_char/133)
                 (i32.const 58))
                (then
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/133)
                   (i32.const 48))
                  (then
                   (br $join:132))
                  (else
                   (i32.const 2)
                   (br $loop:109))))
                (else
                 (if (result i32)
                  (i32.gt_s
                   (local.get $next_char/133)
                   (i32.const 58))
                  (then
                   (br $join:132))
                  (else
                   (i32.const 1)
                   (br $loop:109))))))
              (else
               (if (result i32)
                (i32.gt_s
                 (local.get $next_char/133)
                 (i32.const 56318))
                (then
                 (if (result i32)
                  (i32.lt_s
                   (local.get $next_char/133)
                   (i32.const 57344))
                  (then
                   (i32.const 8)
                   (br $loop:109))
                  (else
                   (if (result i32)
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
             (br $outer/1007))
            (i32.const 0)
            (br $loop:109)))
          (else
           (br $join:85)))
         (br $switch_int/1008))
        (br $join:85))
       (br $outer/997))
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
     (br $outer/996))
    (local.set $tag_1_1/79
     (local.get $tag_1_2/80))
    (local.set $tag_1/78
     (local.get $*cursor/69))
    (local.set $tag_2/82
     (local.get $tag_2_1/83))
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/642
       (local.get $*cursor/69))
      (local.get $*end/68))
     (then
      (block $outer/1019 (result i32)
       (block $join:108
        (local.set $*p/438
         (local.get $*cursor/69))
        (local.set $next_char/110
         (i32.load16_u offset=8
          (i32.add
           (local.get $*data/66)
           (i32.shl
            (local.get $*p/438)
            (i32.const 1)))))
        (local.set $*cursor/69
         (i32.add
          (local.tee $*tmp/643
           (local.get $*cursor/69))
          (i32.const 1)))
        (if (result i32)
         (i32.lt_s
          (local.get $next_char/110)
          (i32.const 55296))
         (then
          (if (result i32)
           (i32.lt_s
            (local.get $next_char/110)
            (i32.const 58))
           (then
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/110)
              (i32.const 48))
             (then
              (br $join:108))
             (else
              (i32.const 4)
              (br $loop:109))))
           (else
            (if (result i32)
             (i32.gt_s
              (local.get $next_char/110)
              (i32.const 58))
             (then
              (br $join:108))
             (else
              (i32.const 1)
              (br $loop:109))))))
         (else
          (if (result i32)
           (i32.gt_s
            (local.get $next_char/110)
            (i32.const 56318))
           (then
            (if (result i32)
             (i32.lt_s
              (local.get $next_char/110)
              (i32.const 57344))
             (then
              (i32.const 8)
              (br $loop:109))
             (else
              (if (result i32)
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
        (br $outer/1019))
       (i32.const 0)
       (br $loop:109)))
     (else
      (br $join:85)))))
  (return))
 (if (result i32)
  (i32.eq
   (local.get $accept_state/70)
   (i32.const 0))
  (then
   (block $outer/1031 (result i32) (result i32) (result i32)
    (block $join:87
     (local.set $*tmp/635
      (i64.extend_i32_s
       (local.tee $*tmp/638
        (i32.add
         (local.tee $*tmp/639
          (local.get $match_tag_saver_1/73))
         (i32.const 1)))))
     (local.set $*tmp/636
      (i64.extend_i32_s
       (local.tee $*tmp/637
        (local.get $match_tag_saver_2/74))))
     (call $moonbit.incref
      (local.get $*data/66))
     (call $String::sub
      (local.get $*data/66)
      (local.get $*tmp/635)
      (local.get $*tmp/636))
     (local.set $*obj/2/1032)
     (local.set $*obj/1/1032)
     (local.set $*obj/0/1032)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/1032)
       (local.get $*obj/1/1032)
       (local.set $*ok/2/640
        (local.get $*obj/2/1032))
       (local.set $*ok/1/640)
       (local.tee $*ok/0/640)
       (local.get $*ok/1/640)
       (local.get $*ok/2/640))
      (else
       (local.set $*try_err/88
        (local.tee $*err/641
         (local.get $*obj/0/1032)))
       (br $join:87)))
     (br $outer/1031))
    (call $moonbit.decref
     (local.get $*try_err/88))
    (unreachable))
   (local.set $start_line/2/86)
   (local.set $start_line/1/86)
   (local.set $start_line/0/86)
   (block $outer/1029 (result i32) (result i32) (result i32)
    (block $join:90
     (local.set $*tmp/628
      (i64.extend_i32_s
       (local.tee $*tmp/631
        (i32.add
         (local.tee $*tmp/632
          (local.get $match_tag_saver_2/74))
         (i32.const 1)))))
     (local.set $*tmp/629
      (i64.extend_i32_s
       (local.tee $*tmp/630
        (local.get $match_tag_saver_3/75))))
     (call $moonbit.incref
      (local.get $*data/66))
     (call $String::sub
      (local.get $*data/66)
      (local.get $*tmp/628)
      (local.get $*tmp/629))
     (local.set $*obj/2/1030)
     (local.set $*obj/1/1030)
     (local.set $*obj/0/1030)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/1030)
       (local.get $*obj/1/1030)
       (local.set $*ok/2/633
        (local.get $*obj/2/1030))
       (local.set $*ok/1/633)
       (local.tee $*ok/0/633)
       (local.get $*ok/1/633)
       (local.get $*ok/2/633))
      (else
       (local.set $*try_err/91
        (local.tee $*err/634
         (local.get $*obj/0/1030)))
       (br $join:90)))
     (br $outer/1029))
    (call $moonbit.decref
     (local.get $*try_err/91))
    (unreachable))
   (local.set $start_column/2/89)
   (local.set $start_column/1/89)
   (local.set $start_column/0/89)
   (block $outer/1027 (result i32) (result i32) (result i32)
    (block $join:93
     (local.set $*tmp/622
      (i64.extend_i32_s
       (local.tee $*tmp/625
        (i32.add
         (local.get $*start/67)
         (i32.const 1)))))
     (local.set $*tmp/623
      (i64.extend_i32_s
       (local.tee $*tmp/624
        (local.get $match_tag_saver_0/72))))
     (call $moonbit.incref
      (local.get $*data/66))
     (call $String::sub
      (local.get $*data/66)
      (local.get $*tmp/622)
      (local.get $*tmp/623))
     (local.set $*obj/2/1028)
     (local.set $*obj/1/1028)
     (local.set $*obj/0/1028)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/1028)
       (local.get $*obj/1/1028)
       (local.set $*ok/2/626
        (local.get $*obj/2/1028))
       (local.set $*ok/1/626)
       (local.tee $*ok/0/626)
       (local.get $*ok/1/626)
       (local.get $*ok/2/626))
      (else
       (local.set $*try_err/94
        (local.tee $*err/627
         (local.get $*obj/0/1028)))
       (br $join:93)))
     (br $outer/1027))
    (call $moonbit.decref
     (local.get $*try_err/94))
    (unreachable))
   (local.set $pkg/2/92)
   (local.set $pkg/1/92)
   (local.set $pkg/0/92)
   (block $outer/1025 (result i32) (result i32) (result i32)
    (block $join:96
     (local.set $*tmp/615
      (i64.extend_i32_s
       (local.tee $*tmp/618
        (i32.add
         (local.tee $*tmp/619
          (local.get $match_tag_saver_0/72))
         (i32.const 1)))))
     (local.set $*tmp/616
      (i64.extend_i32_s
       (local.tee $*tmp/617
        (local.get $match_tag_saver_1/73))))
     (call $moonbit.incref
      (local.get $*data/66))
     (call $String::sub
      (local.get $*data/66)
      (local.get $*tmp/615)
      (local.get $*tmp/616))
     (local.set $*obj/2/1026)
     (local.set $*obj/1/1026)
     (local.set $*obj/0/1026)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/1026)
       (local.get $*obj/1/1026)
       (local.set $*ok/2/620
        (local.get $*obj/2/1026))
       (local.set $*ok/1/620)
       (local.tee $*ok/0/620)
       (local.get $*ok/1/620)
       (local.get $*ok/2/620))
      (else
       (local.set $*try_err/97
        (local.tee $*err/621
         (local.get $*obj/0/1026)))
       (br $join:96)))
     (br $outer/1025))
    (call $moonbit.decref
     (local.get $*try_err/97))
    (unreachable))
   (local.set $filename/2/95)
   (local.set $filename/1/95)
   (local.set $filename/0/95)
   (block $outer/1023 (result i32) (result i32) (result i32)
    (block $join:99
     (local.set $*tmp/608
      (i64.extend_i32_s
       (local.tee $*tmp/611
        (i32.add
         (local.tee $*tmp/612
          (local.get $match_tag_saver_3/75))
         (i32.const 1)))))
     (local.set $*tmp/609
      (i64.extend_i32_s
       (local.tee $*tmp/610
        (local.get $match_tag_saver_4/76))))
     (call $moonbit.incref
      (local.get $*data/66))
     (call $String::sub
      (local.get $*data/66)
      (local.get $*tmp/608)
      (local.get $*tmp/609))
     (local.set $*obj/2/1024)
     (local.set $*obj/1/1024)
     (local.set $*obj/0/1024)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/1024)
       (local.get $*obj/1/1024)
       (local.set $*ok/2/613
        (local.get $*obj/2/1024))
       (local.set $*ok/1/613)
       (local.tee $*ok/0/613)
       (local.get $*ok/1/613)
       (local.get $*ok/2/613))
      (else
       (local.set $*try_err/100
        (local.tee $*err/614
         (local.get $*obj/0/1024)))
       (br $join:99)))
     (br $outer/1023))
    (call $moonbit.decref
     (local.get $*try_err/100))
    (unreachable))
   (local.set $end_line/2/98)
   (local.set $end_line/1/98)
   (local.set $end_line/0/98)
   (block $outer/1021 (result i32) (result i32) (result i32)
    (block $join:102
     (local.set $*tmp/601
      (i64.extend_i32_s
       (local.tee $*tmp/604
        (i32.add
         (local.tee $*tmp/605
          (local.get $match_tag_saver_4/76))
         (i32.const 1)))))
     (local.set $*tmp/602
      (i64.extend_i32_s
       (local.tee $*tmp/603
        (local.get $match_end/71))))
     (call $String::sub
      (local.get $*data/66)
      (local.get $*tmp/601)
      (local.get $*tmp/602))
     (local.set $*obj/2/1022)
     (local.set $*obj/1/1022)
     (local.set $*obj/0/1022)
     (if (result i32) (result i32) (result i32)
      (then
       (local.get $*obj/0/1022)
       (local.get $*obj/1/1022)
       (local.set $*ok/2/606
        (local.get $*obj/2/1022))
       (local.set $*ok/1/606)
       (local.tee $*ok/0/606)
       (local.get $*ok/1/606)
       (local.get $*ok/2/606))
      (else
       (local.set $*try_err/103
        (local.tee $*err/607
         (local.get $*obj/0/1022)))
       (br $join:102)))
     (br $outer/1021))
    (call $moonbit.decref
     (local.get $*try_err/103))
    (unreachable))
   (local.set $end_column/2/101)
   (local.set $end_column/1/101)
   (local.set $end_column/0/101)
   (i32.store offset=4
    (local.tee $ptr/1020
     (call $moonbit.gc.malloc
      (i32.const 72)))
    (i32.const 7341568))
   (i32.store offset=76
    (local.get $ptr/1020)
    (local.get $end_column/0/101))
   (i32.store offset=48
    (local.get $ptr/1020)
    (local.get $end_column/1/101))
   (i32.store offset=52
    (local.get $ptr/1020)
    (local.get $end_column/2/101))
   (i32.store offset=72
    (local.get $ptr/1020)
    (local.get $end_line/0/98))
   (i32.store offset=40
    (local.get $ptr/1020)
    (local.get $end_line/1/98))
   (i32.store offset=44
    (local.get $ptr/1020)
    (local.get $end_line/2/98))
   (i32.store offset=68
    (local.get $ptr/1020)
    (local.get $start_column/0/89))
   (i32.store offset=32
    (local.get $ptr/1020)
    (local.get $start_column/1/89))
   (i32.store offset=36
    (local.get $ptr/1020)
    (local.get $start_column/2/89))
   (i32.store offset=64
    (local.get $ptr/1020)
    (local.get $start_line/0/86))
   (i32.store offset=24
    (local.get $ptr/1020)
    (local.get $start_line/1/86))
   (i32.store offset=28
    (local.get $ptr/1020)
    (local.get $start_line/2/86))
   (i32.store offset=60
    (local.get $ptr/1020)
    (local.get $filename/0/95))
   (i32.store offset=16
    (local.get $ptr/1020)
    (local.get $filename/1/95))
   (i32.store offset=20
    (local.get $ptr/1020)
    (local.get $filename/2/95))
   (i32.store offset=56
    (local.get $ptr/1020)
    (local.get $pkg/0/92))
   (i32.store offset=8
    (local.get $ptr/1020)
    (local.get $pkg/1/92))
   (i32.store offset=12
    (local.get $ptr/1020)
    (local.get $pkg/2/92))
   (local.get $ptr/1020))
  (else
   (call $moonbit.decref
    (local.get $*data/66))
   (unreachable))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/57 i32) (param $ch/59 i32) (result i32)
 (local $inc/58 i32)
 (local $*tmp/595 i32)
 (local $len/596 i32)
 (local $*tmp/597 i32)
 (local $len/598 i32)
 (local $data/599 i32)
 (local $len/600 i32)
 (local $*field/946 i32)
 (local.set $*tmp/595
  (i32.add
   (local.tee $len/596
    (i32.load offset=8
     (local.get $self/57)))
   (i32.const 4)))
 (call $moonbit.incref
  (local.get $self/57))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/57)
   (local.get $*tmp/595)))
 (local.set $data/599
  (local.tee $*field/946
   (i32.load offset=12
    (local.get $self/57))))
 (local.set $len/600
  (i32.load offset=8
   (local.get $self/57)))
 (call $moonbit.incref
  (local.get $data/599))
 (local.set $inc/58
  (call $FixedArray::set_utf16le_char
   (local.get $data/599)
   (local.get $len/600)
   (local.get $ch/59)))
 (local.set $*tmp/597
  (i32.add
   (local.tee $len/598
    (i32.load offset=8
     (local.get $self/57)))
   (local.get $inc/58)))
 (i32.store offset=8
  (local.get $self/57)
  (local.get $*tmp/597))
 (call $moonbit.decref
  (local.get $self/57))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/52 i32) (param $required/53 i32) (result i32)
 (local $current_len/51 i32)
 (local $new_data/56 i32)
 (local $*tmp/589 i32)
 (local $*tmp/590 i32)
 (local $data/591 i32)
 (local $len/592 i32)
 (local $*tmp/593 i32)
 (local $data/594 i32)
 (local $*old/947 i32)
 (local $*field/948 i32)
 (local $*tmp/949 i32)
 (local $*field/950 i32)
 (local $enough_space/54 i32)
 (local.set $current_len/51
  (local.tee $*tmp/949
   (call $moonbit.array_length
    (local.tee $data/594
     (local.tee $*field/950
      (i32.load offset=12
       (local.get $self/52)))))))
 (if
  (i32.le_s
   (local.get $required/53)
   (local.get $current_len/51))
  (then
   (call $moonbit.decref
    (local.get $self/52))
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/54
  (local.get $current_len/51))
 (loop $loop:55
  (if
   (i32.lt_s
    (local.tee $*tmp/589
     (local.get $enough_space/54))
    (local.get $required/53))
   (then
    (local.set $enough_space/54
     (i32.mul
      (local.tee $*tmp/590
       (local.get $enough_space/54))
      (i32.const 2)))
    (br $loop:55))
   (else)))
 (local.set $new_data/56
  (call $moonbit.bytes_make
   (local.tee $*tmp/593
    (local.get $enough_space/54))
   (i32.const 0)))
 (local.set $data/591
  (local.tee $*field/948
   (i32.load offset=12
    (local.get $self/52))))
 (local.set $len/592
  (i32.load offset=8
   (local.get $self/52)))
 (call $moonbit.incref
  (local.get $data/591))
 (call $moonbit.incref
  (local.get $new_data/56))
 (drop
  (call $FixedArray::unsafe_blit|Byte|
   (local.get $new_data/56)
   (i32.const 0)
   (local.get $data/591)
   (i32.const 0)
   (local.get $len/592)))
 (call $moonbit.decref
  (local.tee $*old/947
   (i32.load offset=12
    (local.get $self/52))))
 (i32.store offset=12
  (local.get $self/52)
  (local.get $new_data/56))
 (call $moonbit.decref
  (local.get $self/52))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/46 i32) (param $offset/47 i32) (param $value/45 i32) (result i32)
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
 (local $*arr/1033 i32)
 (local $*idx/1034 i32)
 (local $*arr/1035 i32)
 (local $*idx/1036 i32)
 (local $*arr/1037 i32)
 (local $*idx/1038 i32)
 (local $*arr/1039 i32)
 (local $*idx/1040 i32)
 (local $*arr/1041 i32)
 (local $*idx/1042 i32)
 (local $*arr/1043 i32)
 (local $*idx/1044 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/44
    (local.tee $*tmp/588
     (local.get $value/45)))
   (i32.const 65536))
  (then
   (local.set $*tmp/570
    (i32.and
     (local.tee $*tmp/571
      (local.tee $*p/361
       (i32.and
        (local.get $code/44)
        (i32.const 255))))
     (i32.const 255)))
   (local.get $self/46)
   (local.set $*idx/1036
    (local.get $offset/47))
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
    (local.get $*tmp/570))
   (local.set $*tmp/572
    (i32.add
     (local.get $offset/47)
     (i32.const 1)))
   (local.set $*tmp/573
    (i32.and
     (local.tee $*tmp/574
      (local.tee $*p/364
       (i32.shr_u
        (local.get $code/44)
        (i32.const 8))))
     (i32.const 255)))
   (local.get $self/46)
   (local.set $*idx/1034
    (local.get $*tmp/572))
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
    (local.get $*tmp/573))
   (call $moonbit.decref
    (local.get $self/46))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/44)
     (i32.const 1114112))
    (then
     (local.set $lo/49
      (i32.or
       (local.tee $*tmp/587
        (i32.shr_u
         (local.tee $hi/48
          (i32.sub
           (local.get $code/44)
           (i32.const 65536)))
         (i32.const 10)))
       (i32.const 55296)))
     (local.set $hi/50
      (i32.or
       (local.tee $*tmp/586
        (i32.and
         (local.get $hi/48)
         (i32.const 1023)))
       (i32.const 56320)))
     (local.set $*tmp/575
      (i32.and
       (local.tee $*tmp/576
        (local.tee $*p/367
         (i32.and
          (local.get $lo/49)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/46)
     (local.set $*idx/1044
      (local.get $offset/47))
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
      (local.get $*tmp/575))
     (local.set $*tmp/577
      (i32.add
       (local.get $offset/47)
       (i32.const 1)))
     (local.set $*tmp/578
      (i32.and
       (local.tee $*tmp/579
        (local.tee $*p/370
         (i32.shr_u
          (local.get $lo/49)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/46)
     (local.set $*idx/1042
      (local.get $*tmp/577))
     (local.set $*arr/1041)
     (call $moonbit.check_range
      (local.get $*idx/1042)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1041))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1041)
       (local.get $*idx/1042))
      (local.get $*tmp/578))
     (local.set $*tmp/580
      (i32.add
       (local.get $offset/47)
       (i32.const 2)))
     (local.set $*tmp/581
      (i32.and
       (local.tee $*tmp/582
        (local.tee $*p/373
         (i32.and
          (local.get $hi/50)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/46)
     (local.set $*idx/1040
      (local.get $*tmp/580))
     (local.set $*arr/1039)
     (call $moonbit.check_range
      (local.get $*idx/1040)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1039))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1039)
       (local.get $*idx/1040))
      (local.get $*tmp/581))
     (local.set $*tmp/583
      (i32.add
       (local.get $offset/47)
       (i32.const 3)))
     (local.set $*tmp/584
      (i32.and
       (local.tee $*tmp/585
        (local.tee $*p/376
         (i32.shr_u
          (local.get $hi/50)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/46)
     (local.set $*idx/1038
      (local.get $*tmp/583))
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
      (local.get $*tmp/584))
     (call $moonbit.decref
      (local.get $self/46))
     (i32.const 4))
    (else
     (call $moonbit.decref
      (local.get $self/46))
     (call $moonbitlang/core/builtin.abort|Int|
      (i32.const 10488)
      (i32.const 10376)))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/41 i32) (result i32)
 (local $*tmp/564 i32)
 (local $*tmp/565 i64)
 (local $len/566 i32)
 (local $data/567 i32)
 (local $*field/951 i32)
 (local $*field/952 i32)
 (call $moonbit.incref
  (local.tee $data/567
   (local.tee $*field/952
    (i32.load offset=12
     (local.get $self/41)))))
 (local.set $*tmp/564
  (local.get $data/567))
 (local.set $*field/951
  (i32.load offset=8
   (local.get $self/41)))
 (call $moonbit.decref
  (local.get $self/41))
 (local.set $*tmp/565
  (i64.extend_i32_s
   (local.tee $len/566
    (local.get $*field/951))))
 (call $Bytes::to_unchecked_string.inner
  (local.get $*tmp/564)
  (i32.const 0)
  (local.get $*tmp/565)))
(func $Bytes::to_unchecked_string.inner (param $self/36 i32) (param $offset/40 i32) (param $length/38 i64) (result i32)
 (local $len/35 i32)
 (local $length/37 i32)
 (local $*Some/39 i64)
 (local $*tmp/563 i32)
 (local.set $len/35
  (call $moonbit.array_length
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
 (if (result i32)
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
       (local.tee $*tmp/563
        (i32.add
         (local.get $offset/40)
         (local.get $length/37)))
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
   (call $moonbit.decref
    (local.get $self/36))
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/505 i32) (param $*param/506 i32) (param $*param/507 i32) (result i32)
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/505)
  (local.get $*param/506)
  (local.get $*param/507)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/33 i32) (result i32)
 (local $initial/32 i32)
 (local $data/34 i32)
 (local $ptr/1045 i32)
 (local.set $data/34
  (call $moonbit.bytes_make
   (local.tee $initial/32
    (if (result i32)
     (i32.lt_s
      (local.get $size_hint/33)
      (i32.const 1))
     (then
      (i32.const 1))
     (else
      (local.get $size_hint/33))))
   (i32.const 0)))
 (i32.store offset=4
  (local.tee $ptr/1045
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1045)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/1045)
  (local.get $data/34))
 (local.get $ptr/1045))
(func $@moonbitlang/core/builtin.UninitializedArray::unsafe_blit|Int| (param $dst/27 i32) (param $dst_offset/28 i32) (param $src/29 i32) (param $src_offset/30 i32) (param $len/31 i32) (result i32)
 (call $FixedArray::unsafe_blit|@moonbitlang/core/builtin.UnsafeMaybeUninit<Int>|
  (local.get $dst/27)
  (local.get $dst_offset/28)
  (local.get $src/29)
  (local.get $src_offset/30)
  (local.get $len/31)))
(func $FixedArray::unsafe_blit|@moonbitlang/core/builtin.UnsafeMaybeUninit<Int>| (param $dst/18 i32) (param $dst_offset/20 i32) (param $src/19 i32) (param $src_offset/21 i32) (param $len/23 i32) (result i32)
 (local $i/22 i32)
 (local $i/25 i32)
 (local $*tmp/554 i32)
 (local $*tmp/555 i32)
 (local $*tmp/556 i32)
 (local $*tmp/557 i32)
 (local $*tmp/558 i32)
 (local $*tmp/559 i32)
 (local $*tmp/560 i32)
 (local $*tmp/561 i32)
 (local $*tmp/562 i32)
 (local $*arr/1046 i32)
 (local $*idx/1047 i32)
 (local $*arr/1048 i32)
 (local $*idx/1049 i32)
 (local $*arr/1050 i32)
 (local $*idx/1051 i32)
 (local $*arr/1052 i32)
 (local $*idx/1053 i32)
 (if (result i32)
  (if (result i32)
   (i32.eq
    (local.get $dst/18)
    (local.get $src/19))
   (then
    (i32.lt_s
     (local.get $dst_offset/20)
     (local.get $src_offset/21)))
   (else
    (i32.const 0)))
  (then
   (i32.const 0)
   (loop $loop:24 (param i32)
    (local.tee $i/22)
    (local.get $len/23)
    (i32.lt_s)
    (if
     (then
      (local.set $*tmp/554
       (i32.add
        (local.get $dst_offset/20)
        (local.get $i/22)))
      (local.set $*tmp/556
       (i32.add
        (local.get $src_offset/21)
        (local.get $i/22)))
      (local.get $src/19)
      (local.set $*idx/1049
       (local.get $*tmp/556))
      (local.set $*arr/1048)
      (call $moonbit.check_range
       (local.get $*idx/1049)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1048))
        (i32.const 1)))
      (local.set $*tmp/555
       (i32.load offset=8
        (i32.add
         (local.get $*arr/1048)
         (i32.shl
          (local.get $*idx/1049)
          (i32.const 2)))))
      (local.get $dst/18)
      (local.set $*idx/1047
       (local.get $*tmp/554))
      (local.set $*arr/1046)
      (call $moonbit.check_range
       (local.get $*idx/1047)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1046))
        (i32.const 1)))
      (i32.store offset=8
       (i32.add
        (local.get $*arr/1046)
        (i32.shl
         (local.get $*idx/1047)
         (i32.const 2)))
       (local.get $*tmp/555))
      (local.tee $*tmp/557
       (i32.add
        (local.get $i/22)
        (i32.const 1)))
      (br $loop:24))
     (else
      (call $moonbit.decref
       (local.get $src/19))
      (call $moonbit.decref
       (local.get $dst/18)))))
   (i32.const 0))
  (else
   (local.tee $*tmp/562
    (i32.sub
     (local.get $len/23)
     (i32.const 1)))
   (loop $loop:26 (param i32)
    (local.tee $i/25)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/558
       (i32.add
        (local.get $dst_offset/20)
        (local.get $i/25)))
      (local.set $*tmp/560
       (i32.add
        (local.get $src_offset/21)
        (local.get $i/25)))
      (local.get $src/19)
      (local.set $*idx/1053
       (local.get $*tmp/560))
      (local.set $*arr/1052)
      (call $moonbit.check_range
       (local.get $*idx/1053)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1052))
        (i32.const 1)))
      (local.set $*tmp/559
       (i32.load offset=8
        (i32.add
         (local.get $*arr/1052)
         (i32.shl
          (local.get $*idx/1053)
          (i32.const 2)))))
      (local.get $dst/18)
      (local.set $*idx/1051
       (local.get $*tmp/558))
      (local.set $*arr/1050)
      (call $moonbit.check_range
       (local.get $*idx/1051)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1050))
        (i32.const 1)))
      (i32.store offset=8
       (i32.add
        (local.get $*arr/1050)
        (i32.shl
         (local.get $*idx/1051)
         (i32.const 2)))
       (local.get $*tmp/559))
      (local.tee $*tmp/561
       (i32.sub
        (local.get $i/25)
        (i32.const 1)))
      (br $loop:26))
     (else
      (call $moonbit.decref
       (local.get $src/19))
      (call $moonbit.decref
       (local.get $dst/18)))))
   (i32.const 0))))
(func $FixedArray::unsafe_blit|Byte| (param $dst/9 i32) (param $dst_offset/11 i32) (param $src/10 i32) (param $src_offset/12 i32) (param $len/14 i32) (result i32)
 (local $i/13 i32)
 (local $i/16 i32)
 (local $*tmp/545 i32)
 (local $*tmp/546 i32)
 (local $*tmp/547 i32)
 (local $*tmp/548 i32)
 (local $*tmp/549 i32)
 (local $*tmp/550 i32)
 (local $*tmp/551 i32)
 (local $*tmp/552 i32)
 (local $*tmp/553 i32)
 (local $*arr/1054 i32)
 (local $*idx/1055 i32)
 (local $*arr/1056 i32)
 (local $*idx/1057 i32)
 (local $*arr/1058 i32)
 (local $*idx/1059 i32)
 (local $*arr/1060 i32)
 (local $*idx/1061 i32)
 (if (result i32)
  (if (result i32)
   (i32.eq
    (local.get $dst/9)
    (local.get $src/10))
   (then
    (i32.lt_s
     (local.get $dst_offset/11)
     (local.get $src_offset/12)))
   (else
    (i32.const 0)))
  (then
   (i32.const 0)
   (loop $loop:15 (param i32)
    (local.tee $i/13)
    (local.get $len/14)
    (i32.lt_s)
    (if
     (then
      (local.set $*tmp/545
       (i32.add
        (local.get $dst_offset/11)
        (local.get $i/13)))
      (local.set $*tmp/547
       (i32.add
        (local.get $src_offset/12)
        (local.get $i/13)))
      (local.get $src/10)
      (local.set $*idx/1057
       (local.get $*tmp/547))
      (local.set $*arr/1056)
      (call $moonbit.check_range
       (local.get $*idx/1057)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1056))
        (i32.const 1)))
      (local.set $*tmp/546
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1056)
         (local.get $*idx/1057))))
      (local.get $dst/9)
      (local.set $*idx/1055
       (local.get $*tmp/545))
      (local.set $*arr/1054)
      (call $moonbit.check_range
       (local.get $*idx/1055)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1054))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1054)
        (local.get $*idx/1055))
       (local.get $*tmp/546))
      (local.tee $*tmp/548
       (i32.add
        (local.get $i/13)
        (i32.const 1)))
      (br $loop:15))
     (else
      (call $moonbit.decref
       (local.get $src/10))
      (call $moonbit.decref
       (local.get $dst/9)))))
   (i32.const 0))
  (else
   (local.tee $*tmp/553
    (i32.sub
     (local.get $len/14)
     (i32.const 1)))
   (loop $loop:17 (param i32)
    (local.tee $i/16)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/549
       (i32.add
        (local.get $dst_offset/11)
        (local.get $i/16)))
      (local.set $*tmp/551
       (i32.add
        (local.get $src_offset/12)
        (local.get $i/16)))
      (local.get $src/10)
      (local.set $*idx/1061
       (local.get $*tmp/551))
      (local.set $*arr/1060)
      (call $moonbit.check_range
       (local.get $*idx/1061)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1060))
        (i32.const 1)))
      (local.set $*tmp/550
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1060)
         (local.get $*idx/1061))))
      (local.get $dst/9)
      (local.set $*idx/1059
       (local.get $*tmp/549))
      (local.set $*arr/1058)
      (call $moonbit.check_range
       (local.get $*idx/1059)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1058))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1058)
        (local.get $*idx/1059))
       (local.get $*tmp/550))
      (local.tee $*tmp/552
       (i32.sub
        (local.get $i/16)
        (i32.const 1)))
      (br $loop:17))
     (else
      (call $moonbit.decref
       (local.get $src/10))
      (call $moonbit.decref
       (local.get $dst/9)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/7 i32) (param $loc/8 i32) (result i32)
 (local $*tmp/541 i32)
 (local $*tmp/542 i32)
 (local $*tmp/543 i32)
 (local $*tmp/544 i32)
 (local.set $*tmp/543
  (call $moonbit.add_string
   (local.get $string/7)
   (i32.const 10552)))
 (local.set $*tmp/544
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/8)))
 (call $moonbitlang/core/abort.abort|Unit|
  (local.tee $*tmp/541
   (call $moonbit.add_string
    (local.tee $*tmp/542
     (call $moonbit.add_string
      (local.get $*tmp/543)
      (local.get $*tmp/544)))
    (i32.const 10536)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/5 i32) (param $loc/6 i32) (result i32)
 (local $*tmp/537 i32)
 (local $*tmp/538 i32)
 (local $*tmp/539 i32)
 (local $*tmp/540 i32)
 (local.set $*tmp/539
  (call $moonbit.add_string
   (local.get $string/5)
   (i32.const 10552)))
 (local.set $*tmp/540
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/6)))
 (call $moonbitlang/core/abort.abort|Int|
  (local.tee $*tmp/537
   (call $moonbit.add_string
    (local.tee $*tmp/538
     (call $moonbit.add_string
      (local.get $*tmp/539)
      (local.get $*tmp/540)))
    (i32.const 10536)))))
(func $@moonbitlang/core/builtin.Logger::write_object|Int| (param $self/0/4 i32) (param $self/1/4 i32) (param $obj/3 i32) (result i32)
 (call $@moonbitlang/core/builtin.Show::Int::output
  (local.get $obj/3)
  (local.get $self/0/4)
  (local.get $self/1/4)))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/2 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/2))
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/1 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/1))
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/521 i32) (param $*param/520 i32) (result i32)
 (local $*self/519 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/519
   (local.get $*obj_ptr/521))
  (local.get $*param/520)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/518 i32) (param $*param/0/517 i32) (param $*param/1/517 i32) (param $*param/2/517 i32) (result i32)
 (local $*self/516 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/516
   (local.get $*obj_ptr/518))
  (local.get $*param/0/517)
  (local.get $*param/1/517)
  (local.get $*param/2/517)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (param $*obj_ptr/515 i32) (param $*param/512 i32) (param $*param/513 i32) (param $*param/514 i32) (result i32)
 (local $*self/511 i32)
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/511
   (local.get $*obj_ptr/515))
  (local.get $*param/512)
  (local.get $*param/513)
  (local.get $*param/514)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/510 i32) (param $*param/509 i32) (result i32)
 (local $*self/508 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/508
   (local.get $*obj_ptr/510))
  (local.get $*param/509)))
(func $*main*/2
 (local $arr/344 i32)
 (local $*len/346 i32)
 (local $*i/347 i32)
 (local $x/348 i32)
 (local $doubled/350 i32)
 (local $*len/351 i32)
 (local $*i/352 i32)
 (local $x/353 i32)
 (local $*tmp/522 i32)
 (local $*tmp/523 i32)
 (local $*tmp/524 i32)
 (local $buf/525 i32)
 (local $*tmp/526 i32)
 (local $*tmp/527 i32)
 (local $*tmp/528 i32)
 (local $*tmp/529 i32)
 (local $*tmp/530 i32)
 (local $buf/531 i32)
 (local $*tmp/532 i32)
 (local $*tmp/533 i32)
 (local $*tmp/534 i32)
 (local $*tmp/535 i32)
 (local $*tmp/536 i32)
 (local $*tmp/953 i32)
 (local $*field/954 i32)
 (local $*tmp/955 i32)
 (local $*field/956 i32)
 (local $ptr/1062 i32)
 (local $ptr/1063 i32)
 (local $*ptr/1064 i32)
 (local $sum/345 i32)
 (i32.store offset=8
  (local.tee $*ptr/1064
   (call $moonbit.i32_array_make_raw
    (i32.const 5)))
  (i32.const 1))
 (i32.store offset=12
  (local.get $*ptr/1064)
  (i32.const 2))
 (i32.store offset=16
  (local.get $*ptr/1064)
  (i32.const 3))
 (i32.store offset=20
  (local.get $*ptr/1064)
  (i32.const 4))
 (i32.store offset=24
  (local.get $*ptr/1064)
  (i32.const 5))
 (local.set $*tmp/536
  (local.get $*ptr/1064))
 (i32.store offset=4
  (local.tee $ptr/1063
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1063)
  (i32.const 5))
 (i32.store offset=12
  (local.get $ptr/1063)
  (local.get $*tmp/536))
 (call $moonbit.incref
  (local.tee $arr/344
   (local.get $ptr/1063)))
 (local.set $*tmp/523
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
   (local.get $arr/344)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/522
    (call $moonbit.add_string
     (i32.const 10688)
     (local.get $*tmp/523)))))
 (local.set $sum/345
  (i32.const 0))
 (local.set $*len/346
  (i32.load offset=8
   (local.get $arr/344)))
 (i32.const 0)
 (loop $loop:349 (param i32)
  (local.tee $*i/347)
  (local.get $*len/346)
  (i32.lt_s)
  (if
   (then
    (local.set $x/348
     (local.tee $*tmp/955
      (i32.load offset=8
       (i32.add
        (local.tee $buf/525
         (local.tee $*field/956
          (i32.load offset=12
           (local.get $arr/344))))
        (i32.shl
         (local.get $*i/347)
         (i32.const 2))))))
    (local.set $sum/345
     (i32.add
      (local.tee $*tmp/524
       (local.get $sum/345))
      (local.get $x/348)))
    (local.tee $*tmp/526
     (i32.add
      (local.get $*i/347)
      (i32.const 1)))
    (br $loop:349))
   (else)))
 (local.set $*tmp/528
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Int|
   (local.tee $*tmp/529
    (local.get $sum/345))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/527
    (call $moonbit.add_string
     (i32.const 10632)
     (local.get $*tmp/528)))))
 (local.set $*tmp/535
  (i32.const 10616))
 (i32.store offset=4
  (local.tee $ptr/1062
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1062)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/1062)
  (local.get $*tmp/535))
 (local.set $doubled/350
  (local.get $ptr/1062))
 (local.set $*len/351
  (i32.load offset=8
   (local.get $arr/344)))
 (i32.const 0)
 (loop $loop:354 (param i32)
  (local.tee $*i/352)
  (local.get $*len/351)
  (i32.lt_s)
  (if
   (then
    (local.set $*tmp/530
     (i32.mul
      (local.tee $x/353
       (local.tee $*tmp/953
        (i32.load offset=8
         (i32.add
          (local.tee $buf/531
           (local.tee $*field/954
            (i32.load offset=12
             (local.get $arr/344))))
          (i32.shl
           (local.get $*i/352)
           (i32.const 2))))))
      (i32.const 2)))
    (call $moonbit.incref
     (local.get $doubled/350))
    (drop
     (call $@moonbitlang/core/builtin.Array::push|Int|
      (local.get $doubled/350)
      (local.get $*tmp/530)))
    (local.tee $*tmp/532
     (i32.add
      (local.get $*i/352)
      (i32.const 1)))
    (br $loop:354))
   (else
    (call $moonbit.decref
     (local.get $arr/344)))))
 (local.set $*tmp/534
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.Array<Int>|
   (local.get $doubled/350)))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/533
    (call $moonbit.add_string
     (i32.const 10576)
     (local.get $*tmp/534))))))
(export "_start" (func $*main*/2))