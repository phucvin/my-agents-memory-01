(import "spectest" "print_char"
 (func $printc (param $i i32)))
(data  (memory $moonbit.memory) (offset (i32.const 10000)) "\FF\FF\FF\FF\01\00\00P0\00\00\00\00\00\00\00\FF\FF\FF\FF:\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00d\00o\00u\00b\00l\00e\00/\00i\00n\00t\00e\00r\00n\00a\00l\00/\00r\00y\00u\00:\00r\00y\00u\00.\00m\00b\00t\00:\001\001\006\00:\003\00-\001\001\006\00:\004\005\00\00\00\00\00\FF\FF\FF\FF\19\00\00PI\00l\00l\00e\00g\00a\00l\00A\00r\00g\00u\00m\00e\00n\00t\00E\00x\00c\00e\00p\00t\00i\00o\00n\00 \00\00\00\00\00\00\00\FF\FF\FF\FF\03\00\00P0\00.\000\00\00\00\FF\FF\FF\FF\08\00\00PI\00n\00f\00i\00n\00i\00t\00y\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P-\00\00\00\00\00\00\00\FF\FF\FF\FF\00\00\00P\00\00\00\00\00\00\00\00\FF\FF\FF\FF\03\00\00PN\00a\00N\00\00\00\FF\FF\FF\FF\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\003\006\006\00:\005\00-\003\006\006\00:\003\003\00\00\00\00\00\00\00\FF\FF\FF\FF\13\00\00PI\00n\00v\00a\00l\00i\00d\00 \00s\00t\00a\00r\00t\00 \00i\00n\00d\00e\00x\00\00\00\FF\FF\FF\FF1\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\004\009\001\00:\009\00-\004\009\001\00:\004\000\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00Pi\00n\00v\00a\00l\00i\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00 \00p\00a\00i\00r\00\00\00\00\00\FF\FF\FF\FF4\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00t\00o\00_\00s\00t\00r\00i\00n\00g\00.\00m\00b\00t\00:\006\006\003\00:\005\00-\006\006\003\00:\004\004\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00Pr\00a\00d\00i\00x\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\FF\FF\FF\FF$\00\00P0\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF5\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00s\00t\00r\00i\00n\00g\00v\00i\00e\00w\00.\00m\00b\00t\00:\001\001\001\00:\005\00-\001\001\001\00:\003\006\00\00\00\00\00\00\00\FF\FF\FF\FF\16\00\00PI\00n\00v\00a\00l\00i\00d\00 \00i\00n\00d\00e\00x\00 \00f\00o\00r\00 \00V\00i\00e\00w\00\00\00\00\00\FF\FF\FF\FF0\00\00P@\00m\00o\00o\00n\00b\00i\00t\00l\00a\00n\00g\00/\00c\00o\00r\00e\00/\00b\00u\00i\00l\00t\00i\00n\00:\00b\00y\00t\00e\00s\00.\00m\00b\00t\00:\002\009\000\00:\005\00-\002\009\000\00:\003\001\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\11\00\00PC\00h\00a\00r\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P\0A\00\00\00\00\00\00\00\FF\FF\FF\FF\06\00\00P\0A\00 \00 \00a\00t\00 \00\00\00\00\00\FF\FF\FF\FF\13\00\00PA\00r\00e\00a\00 \00o\00f\00 \00r\00e\00c\00t\00a\00n\00g\00l\00e\00:\00 \00\00\00\FF\FF\FF\FF\10\00\00PA\00r\00e\00a\00 \00o\00f\00 \00c\00i\00r\00c\00l\00e\00:\00 \00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\00\04\10\00\00\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\FF\FF\FF\FF\01\00\00P:\00\00\00\00\00\00\00\FF\FF\FF\FF\01\00\00P/\00\00\00\00\00\00\00\FF\FF\FF\FF\1E\00\00@\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00 4Pe\C0_\C9\A6R\BB\13\CB\AE\C4@\C2\18\06\C8\DFq\00\D5\A8|\F5o\0F\DAX\FC'\13nGV5}$ e\02\C7\E7h\E4\8C\A4\1D\E9\E6\02h\D7\CD9ayw\FC\C2@[\EF\16y\8C\DEC\FF\A7Q\F9\91\F3\B2x\F5\BD\BE\11\E8W\E9\D6\E8\BE\E8{\B0T\AC\8F\84\8Du\1B\EA#\A4\99\E9\F9\D3\8B\B7\A3q@a\DA>\15\CE\E3>\CBs\F9H\08\8C\97\B4'\D5\1Bp\10\A2\BF\EF\B9\EB\852\15M\B4M\B4\9B\BBo\19\96\B6\07l\F8\E7\EE\AD6\D9\B4\F5\915\AE\13\22\22\18\AFNjhM\91\DA\AA=O@t\1E\9F\BD\9E\E0\06\A1\C0\98W\C2\A7\FD\A4\0E\90\17\0E}Iqs\E3 \8F\B2 \D8v\05\14;\12\85=t4\81\13C\B0\AD)z_'\F45\1C\FF\FF\FF\FF\13\00\00@TETTEU\05\04\00\10\04\10\14\04@\00\00\00\01@UU\15AT\04\00\00D\00\01\00\00\00\00@A\00\00DPDEPT\00UUTUeQ\00@\00@\01\00\00\01\00\05\01\00\11TQQTUU\05\00\00\00\00\FF\FF\FF\FF\1A\00\00@\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\10\00\00\00\00\00\00\00\00\B94\032\B7\F4\AD\14\10\DB\1A\B3\08\92T\0E\0D0}\95\14G\BA\1Af\08\8FM&\AD\C6m\F5\98\BF\85\E2\B7E\11\CA\96\85=\92\BD\1D\EB\FC\A1\18`\DC\EFR\16<\92\AE\22\0B\B8\C1\B4\83\9D-[\05b\DA\1C0L~\8FN\8B\B2[\16\F4R\9F\8BV\A5\12\FB\D4\82vC\ED\8A\F0\8F\E7\F91\15e\19\18P\F1\9B\D9J\13\EE\B4(L\F0\A6\86\C1%\1F\03_\C2p\CB\9EI\16\E6B\88\9CD\EB \14\B0e\086\ADn\A5\85\85\F0\CA\14\E2\FD\03\1A\0B\89\99y\D5\B1=\09\D8\DA\97:5\EB\CF\10\AC6?^s\BB8\CF>gR\FAD\AF\BA\15\FF\FF\FF\FF\15\00\00@\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00@\95YiYUUTU\15UUV\04\05\15A\10TU@EQUD@EPDPUUE\00@\00@@\04D\96eUVUE@ETQA\15@U\91UUUU@Q\05\01\00\00\FF\FF\FF\FF\1A\00\00@\01\00\00\00\00\00\00\00\05\00\00\00\00\00\00\00\19\00\00\00\00\00\00\00}\00\00\00\00\00\00\00q\02\00\00\00\00\00\005\0C\00\00\00\00\00\00\09=\00\00\00\00\00\00-1\01\00\00\00\00\00\E1\F5\05\00\00\00\00\00e\CD\1D\00\00\00\00\00\F9\02\95\00\00\00\00\00\DD\0E\E9\02\00\00\00\00QJ\8D\0E\00\00\00\00\95s\C2H\00\00\00\00\E9A\CCk\01\00\00\00\8DI\FD\1A\07\00\00\00\C1o\F2\86#\00\00\00\C5.\BC\A2\B1\00\00\00\D9\E9\AC-x\03\00\00=\91`\E4X\11\00\001\D6\E2u\BCV\00\00\F5.nM\AE\B1\01\00\C9\EA&\83gx\08\00\ED\95\C2\8F\05Z*\00\A1\ED\CC\CE\1B\C2\D3\00%\A4\00\0A\8B\CA\22\04\FF\FF\FF\FF\00\00(\00\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF\00\00 \00\00\00\00\00\00\00\14@\FF\FF\FF\FF\01\000\00\00\00\00\00\00\00\10@\00\00\00\00\00\00\18@")
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
    (i32.const 12392)
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
   (i32.const 12392)
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
 (i32.const 11416)
)
(global $moonbitlang/core/builtin.parse.*bind|5401
 i32
 (i32.const 11440)
)
(global $moonbitlang/core/builtin.parse.*bind|5440
 i32
 (i32.const 11440)
)
(global $moonbitlang/core/builtin.parse.*bind|5434
 i32
 (i32.const 10256)
)
(global $moonbitlang/core/builtin.parse.*bind|5421
 i32
 (i32.const 11440)
)
(global $moonbitlang/core/builtin.parse.*bind|5415
 i32
 (i32.const 11440)
)
(global $moonbitlang/core/builtin.output.*bind|8190
 i32
 (i32.const 11456)
)
(global $moonbitlang/core/builtin.output.*bind|8184
 i32
 (i32.const 11456)
)
(global $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/56
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/builtin.brute_force_find.constr/70
 (mut i64)
 (i64.const 0)
)
(global $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2
 i32
 (i32.const 11472)
)
(global $moonbitlang/core/double/internal/ryu.gPOW5_INV_OFFSETS
 i32
 (i32.const 11720)
)
(global $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2
 i32
 (i32.const 11804)
)
(global $moonbitlang/core/double/internal/ryu.gPOW5_OFFSETS
 i32
 (i32.const 12020)
)
(global $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE
 i32
 (i32.const 12112)
)
(global $moonbitlang/core/double/internal/ryu.ryu_to_string.record/514
 i32
 (i32.const 12328)
)
(global $username/moonbit_examples/cmd/enum.*main.c/537
 i32
 (i32.const 12348)
)
(global $username/moonbit_examples/cmd/enum.*main.r/538
 i32
 (i32.const 12364)
)
(func $username/moonbit_examples/cmd/enum.area (param $shape/531 i32) (result f64)
 (local $*Circle/532 i32)
 (local $*r/533 f64)
 (local $*Rectangle/534 i32)
 (local $*w/535 f64)
 (local $*h/536 f64)
 (local $*tmp/1643 f64)
 (local $*field/1644 f64)
 (local $*field/1645 f64)
 (local $*tag/1740 i32)
 (if (result f64)
  (i32.eq
   (local.tee $*tag/1740
    (call $moonbit.get_tag
     (local.get $shape/531)))
   (i32.const 0))
  (then
   (local.set $*field/1644
    (f64.load offset=8
     (local.tee $*Circle/532
      (local.get $shape/531))))
   (call $moonbit.decref
    (local.get $*Circle/532))
   (local.set $*r/533
    (local.get $*field/1644))
   (f64.mul
    (local.tee $*tmp/1643
     (f64.mul
      (f64.const 0x1.921f9f01b866ep+1)
      (local.get $*r/533)))
    (local.get $*r/533)))
  (else
   (local.set $*w/535
    (f64.load offset=8
     (local.tee $*Rectangle/534
      (local.get $shape/531))))
   (local.set $*field/1645
    (f64.load offset=16
     (local.get $*Rectangle/534)))
   (call $moonbit.decref
    (local.get $*Rectangle/534))
   (local.set $*h/536
    (local.get $*field/1645))
   (f64.mul
    (local.get $*w/535)
    (local.get $*h/536)))))
(func $@moonbitlang/core/builtin.Show::Double::output (param $self/530 f64) (param $logger/0/529 i32) (param $logger/1/529 i32) (result i32)
 (local $*tmp/1642 i32)
 (local.set $*tmp/1642
  (call $Double::to_string
   (local.get $self/530)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/529)
  (local.get $*tmp/1642)
  (i32.load offset=8
   (local.get $logger/0/529))))
(func $Double::to_string (param $self/528 f64) (result i32)
 (call $moonbitlang/core/double/internal/ryu.ryu_to_string
  (local.get $self/528)))
(func $moonbitlang/core/double/internal/ryu.ryu_to_string (param $val/515 f64) (result i32)
 (local $bits/516 i64)
 (local $ieeeSign/517 i32)
 (local $ieeeMantissa/518 i64)
 (local $ieeeExponent/519 i32)
 (local $small/521 i32)
 (local $*Some/522 i32)
 (local $*f/523 i32)
 (local $q/525 i64)
 (local $r/526 i64)
 (local $*tmp/1626 i32)
 (local $*tmp/1627 i32)
 (local $*tmp/1628 i32)
 (local $*tmp/1629 i32)
 (local $exponent/1630 i32)
 (local $*tmp/1631 i32)
 (local $mantissa/1632 i64)
 (local $*tmp/1633 i64)
 (local $*tmp/1634 i32)
 (local $mantissa/1635 i64)
 (local $*tmp/1636 i32)
 (local $*tmp/1637 i32)
 (local $*tmp/1638 i64)
 (local $*tmp/1639 i64)
 (local $*tmp/1640 i64)
 (local $*tmp/1641 i64)
 (local $*field/1646 i32)
 (local $*field/1647 i64)
 (local $*field/1648 i64)
 (local $ptr/1741 i32)
 (local $v/520 i32)
 (local $x/524 i32)
 (if
  (f64.eq
   (local.get $val/515)
   (f64.const 0x0p+0))
  (then
   (i32.const 10000)
   (return))
  (else))
 (local.tee $*tmp/1640
  (i64.and
   (local.tee $*tmp/1641
    (i64.shr_u
     (local.tee $bits/516
      (i64.reinterpret_f64
       (local.get $val/515)))
     (i64.extend_i32_s
      (i32.const 63))))
   (i64.const 1)))
 (local.set $ieeeSign/517
  (i64.ne
   (i64.const 0)))
 (local.set $ieeeMantissa/518
  (i64.and
   (local.get $bits/516)
   (i64.const 4503599627370495)))
 (if
  (if (result i32)
   (i32.eq
    (local.tee $ieeeExponent/519
     (i32.wrap_i64
      (local.tee $*tmp/1638
       (i64.and
        (local.tee $*tmp/1639
         (i64.shr_u
          (local.get $bits/516)
          (i64.extend_i32_s
           (i32.const 52))))
        (i64.const 2047)))))
    (i32.const 2047))
   (then
    (i32.const 1))
   (else
    (if (result i32)
     (i32.eq
      (local.get $ieeeExponent/519)
      (i32.const 0))
     (then
      (i64.eq
       (local.get $ieeeMantissa/518)
       (i64.const 0)))
     (else
      (i32.const 0)))))
  (then
   (local.get $ieeeExponent/519)
   (local.set $*tmp/1626
    (i32.ne
     (i32.const 0)))
   (local.get $ieeeMantissa/518)
   (local.set $*tmp/1627
    (i64.ne
     (i64.const 0)))
   (call $moonbitlang/core/double/internal/ryu.copy_special_str
    (local.get $ieeeSign/517)
    (local.get $*tmp/1626)
    (local.get $*tmp/1627))
   (return))
  (else))
 (local.set $v/520
  (global.get $moonbitlang/core/double/internal/ryu.ryu_to_string.record/514))
 (if
  (i32.eq
   (local.tee $small/521
    (call $moonbitlang/core/double/internal/ryu.d2d_small_int
     (local.get $ieeeMantissa/518)
     (local.get $ieeeExponent/519)))
   (i32.const 0))
  (then
   (if
    (local.get $small/521)
    (then
     (call $moonbit.decref
      (local.get $small/521)))
    (else))
   (local.set $*tmp/1628
    (local.get $ieeeExponent/519))
   (local.set $v/520
    (call $moonbitlang/core/double/internal/ryu.d2d
     (local.get $ieeeMantissa/518)
     (local.get $*tmp/1628))))
  (else
   (local.set $x/524
    (local.tee $*f/523
     (local.tee $*Some/522
      (local.get $small/521))))
   (block $break:527
    (loop $loop:527
     (local.set $q/525
      (i64.div_u
       (local.tee $mantissa/1635
        (local.tee $*field/1648
         (i64.load offset=8
          (local.tee $*tmp/1636
           (local.get $x/524)))))
       (i64.const 10)))
     (local.set $mantissa/1632
      (local.tee $*field/1647
       (i64.load offset=8
        (local.tee $*tmp/1634
         (local.get $x/524)))))
     (local.set $*tmp/1633
      (i64.mul
       (i64.const 10)
       (local.get $q/525)))
     (local.tee $r/526
      (i64.sub
       (local.get $mantissa/1632)
       (local.get $*tmp/1633)))
     (if
      (i64.ne
       (i64.const 0))
      (then
       (br $break:527))
      (else))
     (local.set $*field/1646
      (i32.load offset=16
       (local.tee $*tmp/1631
        (local.get $x/524))))
     (call $moonbit.decref
      (local.get $*tmp/1631))
     (local.set $*tmp/1629
      (i32.add
       (local.tee $exponent/1630
        (local.get $*field/1646))
       (i32.const 1)))
     (i32.store offset=4
      (local.tee $ptr/1741
       (call $moonbit.gc.malloc
        (i32.const 12)))
      (i32.const 2621440))
     (i32.store offset=16
      (local.get $ptr/1741)
      (local.get $*tmp/1629))
     (i64.store offset=8
      (local.get $ptr/1741)
      (local.get $q/525))
     (local.set $x/524
      (local.get $ptr/1741))
     (br $loop:527)))
   (local.set $v/520
    (local.get $x/524))))
 (call $moonbitlang/core/double/internal/ryu.to_chars
  (local.tee $*tmp/1637
   (local.get $v/520))
  (local.get $ieeeSign/517)))
(func $moonbitlang/core/double/internal/ryu.d2d_small_int (param $ieeeMantissa/509 i64) (param $ieeeExponent/511 i32) (result i32)
 (local $m2/508 i64)
 (local $e2/510 i32)
 (local $mask/512 i64)
 (local $fraction/513 i64)
 (local $*tmp/1620 i32)
 (local $*tmp/1621 i64)
 (local $*tmp/1622 i32)
 (local $*tmp/1623 i64)
 (local $*tmp/1624 i32)
 (local $*tmp/1625 i32)
 (local $ptr/1742 i32)
 (local.set $m2/508
  (i64.or
   (i64.const 4503599627370496)
   (local.get $ieeeMantissa/509)))
 (if
  (i32.gt_s
   (local.tee $e2/510
    (i32.sub
     (local.tee $*tmp/1625
      (i32.sub
       (local.get $ieeeExponent/511)
       (i32.const 1023)))
     (i32.const 52)))
   (i32.const 0))
  (then
   (i32.const 0)
   (return))
  (else))
 (if
  (i32.lt_s
   (local.get $e2/510)
   (i32.const -52))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $*tmp/1624
  (i32.sub
   (i32.const 0)
   (local.get $e2/510)))
 (local.set $mask/512
  (i64.sub
   (local.tee $*tmp/1623
    (i64.shl
     (i64.const 1)
     (i64.extend_i32_s
      (local.get $*tmp/1624))))
   (i64.const 1)))
 (local.tee $fraction/513
  (i64.and
   (local.get $m2/508)
   (local.get $mask/512)))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.set $*tmp/1622
  (i32.sub
   (i32.const 0)
   (local.get $e2/510)))
 (local.set $*tmp/1621
  (i64.shr_u
   (local.get $m2/508)
   (i64.extend_i32_s
    (local.get $*tmp/1622))))
 (i32.store offset=4
  (local.tee $ptr/1742
   (call $moonbit.gc.malloc
    (i32.const 12)))
  (i32.const 2621440))
 (i32.store offset=16
  (local.get $ptr/1742)
  (i32.const 0))
 (i64.store offset=8
  (local.get $ptr/1742)
  (local.get $*tmp/1621))
 (local.tee $*tmp/1620
  (local.get $ptr/1742)))
(func $moonbitlang/core/double/internal/ryu.to_chars (param $v/482 i32) (param $sign/480 i32) (result i32)
 (local $result/478 i32)
 (local $olength/483 i32)
 (local $scientificNotation/485 i32)
 (local $*end41/486 i32)
 (local $i/487 i32)
 (local $c/488 i64)
 (local $a/490 i32)
 (local $b/491 i32)
 (local $c/492 i32)
 (local $a/493 i32)
 (local $b/494 i32)
 (local $i/495 i32)
 (local $current/497 i32)
 (local $i/498 i32)
 (local $i/500 i32)
 (local $*end64/502 i32)
 (local $i/503 i32)
 (local $i/506 i32)
 (local $*tmp/1489 i32)
 (local $*tmp/1490 i32)
 (local $*tmp/1491 i64)
 (local $*tmp/1492 i32)
 (local $*tmp/1493 i32)
 (local $*tmp/1494 i32)
 (local $*tmp/1495 i32)
 (local $*tmp/1496 i32)
 (local $*tmp/1497 i32)
 (local $*tmp/1498 i64)
 (local $*tmp/1499 i32)
 (local $*tmp/1500 i32)
 (local $*tmp/1501 i32)
 (local $*tmp/1502 i32)
 (local $*tmp/1503 i32)
 (local $*tmp/1504 i32)
 (local $*tmp/1505 i64)
 (local $*tmp/1506 i32)
 (local $*tmp/1507 i32)
 (local $*tmp/1508 i32)
 (local $*tmp/1509 i32)
 (local $*tmp/1510 i32)
 (local $*tmp/1511 i32)
 (local $*tmp/1512 i32)
 (local $*tmp/1513 i32)
 (local $*tmp/1514 i32)
 (local $*tmp/1515 i32)
 (local $*tmp/1516 i32)
 (local $*tmp/1517 i32)
 (local $*tmp/1518 i32)
 (local $*tmp/1519 i32)
 (local $*tmp/1520 i32)
 (local $*tmp/1521 i32)
 (local $*tmp/1522 i32)
 (local $*tmp/1523 i32)
 (local $*tmp/1524 i32)
 (local $*tmp/1525 i32)
 (local $*tmp/1526 i32)
 (local $*tmp/1527 i32)
 (local $*tmp/1528 i32)
 (local $*tmp/1529 i32)
 (local $*tmp/1530 i32)
 (local $*tmp/1531 i32)
 (local $*tmp/1532 i32)
 (local $*tmp/1533 i32)
 (local $*tmp/1534 i32)
 (local $*tmp/1535 i32)
 (local $*tmp/1536 i32)
 (local $*tmp/1537 i32)
 (local $*tmp/1538 i32)
 (local $*tmp/1539 i32)
 (local $*tmp/1540 i32)
 (local $*tmp/1541 i32)
 (local $*tmp/1542 i32)
 (local $*tmp/1543 i32)
 (local $*tmp/1544 i32)
 (local $*tmp/1545 i32)
 (local $*tmp/1546 i32)
 (local $*tmp/1547 i32)
 (local $*tmp/1548 i32)
 (local $*tmp/1549 i32)
 (local $*tmp/1550 i32)
 (local $*tmp/1551 i32)
 (local $*tmp/1552 i32)
 (local $*tmp/1553 i32)
 (local $*tmp/1554 i32)
 (local $*tmp/1555 i32)
 (local $*tmp/1556 i32)
 (local $*tmp/1557 i32)
 (local $*tmp/1558 i32)
 (local $*tmp/1559 i32)
 (local $*tmp/1560 i32)
 (local $*tmp/1561 i32)
 (local $*tmp/1562 i32)
 (local $*tmp/1563 i32)
 (local $*tmp/1564 i32)
 (local $*tmp/1565 i32)
 (local $*tmp/1566 i64)
 (local $*tmp/1567 i64)
 (local $*tmp/1568 i32)
 (local $*tmp/1569 i32)
 (local $*tmp/1570 i64)
 (local $*tmp/1571 i32)
 (local $*tmp/1572 i32)
 (local $*tmp/1573 i32)
 (local $*tmp/1574 i32)
 (local $*tmp/1575 i32)
 (local $*tmp/1576 i32)
 (local $*tmp/1577 i32)
 (local $*tmp/1578 i32)
 (local $*tmp/1579 i64)
 (local $*tmp/1580 i64)
 (local $*tmp/1581 i32)
 (local $*tmp/1582 i32)
 (local $*tmp/1583 i32)
 (local $*tmp/1584 i64)
 (local $*tmp/1585 i32)
 (local $*tmp/1586 i32)
 (local $*tmp/1587 i32)
 (local $*tmp/1588 i32)
 (local $*tmp/1589 i32)
 (local $*tmp/1590 i32)
 (local $*tmp/1591 i32)
 (local $*tmp/1592 i32)
 (local $*tmp/1593 i32)
 (local $*tmp/1594 i32)
 (local $*tmp/1595 i32)
 (local $*tmp/1596 i32)
 (local $*tmp/1597 i32)
 (local $*tmp/1598 i32)
 (local $*tmp/1599 i32)
 (local $*tmp/1600 i32)
 (local $*tmp/1601 i32)
 (local $*tmp/1602 i32)
 (local $*tmp/1603 i64)
 (local $*tmp/1604 i64)
 (local $*tmp/1605 i32)
 (local $*tmp/1606 i32)
 (local $*tmp/1607 i32)
 (local $*tmp/1608 i64)
 (local $*tmp/1609 i32)
 (local $*tmp/1610 i32)
 (local $*tmp/1611 i32)
 (local $*tmp/1612 i32)
 (local $*tmp/1613 i32)
 (local $*tmp/1614 i32)
 (local $*tmp/1615 i32)
 (local $*tmp/1616 i32)
 (local $*tmp/1617 i32)
 (local $exponent/1618 i32)
 (local $*tmp/1619 i64)
 (local $*field/1649 i32)
 (local $*arr/1743 i32)
 (local $*idx/1744 i32)
 (local $*arr/1745 i32)
 (local $*idx/1746 i32)
 (local $*arr/1747 i32)
 (local $*idx/1748 i32)
 (local $*arr/1749 i32)
 (local $*idx/1750 i32)
 (local $*arr/1751 i32)
 (local $*idx/1752 i32)
 (local $*arr/1753 i32)
 (local $*idx/1754 i32)
 (local $*arr/1755 i32)
 (local $*idx/1756 i32)
 (local $*arr/1757 i32)
 (local $*idx/1758 i32)
 (local $*arr/1759 i32)
 (local $*idx/1760 i32)
 (local $*arr/1761 i32)
 (local $*idx/1762 i32)
 (local $*arr/1763 i32)
 (local $*idx/1764 i32)
 (local $*arr/1765 i32)
 (local $*idx/1766 i32)
 (local $*arr/1767 i32)
 (local $*idx/1768 i32)
 (local $*arr/1769 i32)
 (local $*idx/1770 i32)
 (local $*arr/1771 i32)
 (local $*idx/1772 i32)
 (local $*arr/1773 i32)
 (local $*idx/1774 i32)
 (local $*arr/1775 i32)
 (local $*idx/1776 i32)
 (local $*arr/1777 i32)
 (local $*idx/1778 i32)
 (local $*arr/1779 i32)
 (local $*idx/1780 i32)
 (local $*arr/1781 i32)
 (local $*idx/1782 i32)
 (local $*arr/1783 i32)
 (local $*idx/1784 i32)
 (local $index/479 i32)
 (local $output/481 i64)
 (local $exp/484 i32)
 (local $current/505 i32)
 (local.set $result/478
  (call $moonbit.bytes_make
   (i32.const 25)
   (i32.const 0)))
 (local.set $index/479
  (i32.const 0))
 (if
  (local.get $sign/480)
  (then
   (local.set $*tmp/1489
    (local.get $index/479))
   (local.get $result/478)
   (local.set $*idx/1784
    (local.get $*tmp/1489))
   (local.set $*arr/1783)
   (call $moonbit.check_range
    (local.get $*idx/1784)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1783))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1783)
     (local.get $*idx/1784))
    (i32.const 45))
   (local.set $index/479
    (i32.add
     (local.tee $*tmp/1490
      (local.get $index/479))
     (i32.const 1))))
  (else))
 (local.set $olength/483
  (call $moonbitlang/core/double/internal/ryu.decimal_length17
   (local.tee $*tmp/1619
    (local.tee $output/481
     (i64.load offset=8
      (local.get $v/482))))))
 (local.set $*field/1649
  (i32.load offset=16
   (local.get $v/482)))
 (call $moonbit.decref
  (local.get $v/482))
 (if (result i32)
  (local.tee $scientificNotation/485
   (i32.eqz
    (local.tee $*tmp/1614
     (if (result i32)
      (i32.ge_s
       (local.tee $*tmp/1616
        (local.tee $exp/484
         (i32.sub
          (local.tee $*tmp/1617
           (i32.add
            (local.tee $exponent/1618
             (local.get $*field/1649))
            (local.get $olength/483)))
          (i32.const 1))))
       (i32.const -6))
      (then
       (i32.lt_s
        (local.tee $*tmp/1615
         (local.get $exp/484))
        (i32.const 21)))
      (else
       (i32.const 0))))))
  (then
   (local.set $*end41/486
    (i32.sub
     (local.get $olength/483)
     (i32.const 1)))
   (i32.const 0)
   (loop $loop:489 (param i32)
    (local.tee $i/487)
    (local.get $*end41/486)
    (i32.lt_s)
    (if
     (then
      (local.set $c/488
       (i64.rem_u
        (local.tee $*tmp/1498
         (local.get $output/481))
        (i64.const 10)))
      (local.set $output/481
       (i64.div_u
        (local.tee $*tmp/1491
         (local.get $output/481))
        (i64.const 10)))
      (local.set $*tmp/1492
       (i32.sub
        (local.tee $*tmp/1496
         (i32.add
          (local.tee $*tmp/1497
           (local.get $index/479))
          (local.get $olength/483)))
        (local.get $i/487)))
      (local.set $*tmp/1495
       (i32.wrap_i64
        (local.get $c/488)))
      (local.set $*tmp/1493
       (i32.and
        (local.tee $*tmp/1494
         (i32.add
          (i32.const 48)
          (local.get $*tmp/1495)))
        (i32.const 255)))
      (local.get $result/478)
      (local.set $*idx/1766
       (local.get $*tmp/1492))
      (local.set $*arr/1765)
      (call $moonbit.check_range
       (local.get $*idx/1766)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1765))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1765)
        (local.get $*idx/1766))
       (local.get $*tmp/1493))
      (local.tee $*tmp/1499
       (i32.add
        (local.get $i/487)
        (i32.const 1)))
      (br $loop:489))
     (else)))
   (local.set $*tmp/1500
    (local.get $index/479))
   (local.set $*tmp/1503
    (i32.rem_s
     (local.tee $*tmp/1504
      (i32.wrap_i64
       (local.tee $*tmp/1505
        (local.get $output/481))))
     (i32.const 10)))
   (local.set $*tmp/1501
    (i32.and
     (local.tee $*tmp/1502
      (i32.add
       (i32.const 48)
       (local.get $*tmp/1503)))
     (i32.const 255)))
   (local.get $result/478)
   (local.set $*idx/1764
    (local.get $*tmp/1500))
   (local.set $*arr/1763)
   (call $moonbit.check_range
    (local.get $*idx/1764)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1763))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1763)
     (local.get $*idx/1764))
    (local.get $*tmp/1501))
   (if
    (i32.gt_s
     (local.get $olength/483)
     (i32.const 1))
    (then
     (local.set $*tmp/1506
      (i32.add
       (local.tee $*tmp/1507
        (local.get $index/479))
       (i32.const 1)))
     (local.get $result/478)
     (local.set $*idx/1762
      (local.get $*tmp/1506))
     (local.set $*arr/1761)
     (call $moonbit.check_range
      (local.get $*idx/1762)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1761))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1761)
       (local.get $*idx/1762))
      (i32.const 46)))
    (else
     (local.set $index/479
      (i32.sub
       (local.tee $*tmp/1508
        (local.get $index/479))
       (i32.const 1)))))
   (local.set $*tmp/1509
    (local.get $index/479))
   (local.set $*tmp/1510
    (i32.add
     (local.get $olength/483)
     (i32.const 1)))
   (local.set $*tmp/1511
    (local.tee $index/479
     (i32.add
      (local.get $*tmp/1509)
      (local.get $*tmp/1510))))
   (local.get $result/478)
   (local.set $*idx/1760
    (local.get $*tmp/1511))
   (local.set $*arr/1759)
   (call $moonbit.check_range
    (local.get $*idx/1760)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1759))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1759)
     (local.get $*idx/1760))
    (i32.const 101))
   (local.set $index/479
    (i32.add
     (local.tee $*tmp/1512
      (local.get $index/479))
     (i32.const 1)))
   (if
    (i32.lt_s
     (local.tee $*tmp/1513
      (local.get $exp/484))
     (i32.const 0))
    (then
     (local.set $*tmp/1514
      (local.get $index/479))
     (local.get $result/478)
     (local.set $*idx/1756
      (local.get $*tmp/1514))
     (local.set $*arr/1755)
     (call $moonbit.check_range
      (local.get $*idx/1756)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1755))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1755)
       (local.get $*idx/1756))
      (i32.const 45))
     (local.set $index/479
      (i32.add
       (local.tee $*tmp/1515
        (local.get $index/479))
       (i32.const 1)))
     (local.set $*tmp/1516
      (local.get $exp/484))
     (local.set $exp/484
      (i32.sub
       (i32.const 0)
       (local.get $*tmp/1516))))
    (else
     (local.set $*tmp/1517
      (local.get $index/479))
     (local.get $result/478)
     (local.set $*idx/1758
      (local.get $*tmp/1517))
     (local.set $*arr/1757)
     (call $moonbit.check_range
      (local.get $*idx/1758)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1757))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1757)
       (local.get $*idx/1758))
      (i32.const 43))
     (local.set $index/479
      (i32.add
       (local.tee $*tmp/1518
        (local.get $index/479))
       (i32.const 1)))))
   (if
    (i32.ge_s
     (local.tee $*tmp/1519
      (local.get $exp/484))
     (i32.const 100))
    (then
     (local.set $a/490
      (i32.div_s
       (local.tee $*tmp/1535
        (local.get $exp/484))
       (i32.const 100)))
     (local.set $b/491
      (i32.rem_s
       (local.tee $*tmp/1533
        (i32.div_s
         (local.tee $*tmp/1534
          (local.get $exp/484))
         (i32.const 10)))
       (i32.const 10)))
     (local.set $c/492
      (i32.rem_s
       (local.tee $*tmp/1532
        (local.get $exp/484))
       (i32.const 10)))
     (local.set $*tmp/1520
      (local.get $index/479))
     (local.set $*tmp/1521
      (i32.and
       (local.tee $*tmp/1522
        (i32.add
         (i32.const 48)
         (local.get $a/490)))
       (i32.const 255)))
     (local.get $result/478)
     (local.set $*idx/1748
      (local.get $*tmp/1520))
     (local.set $*arr/1747)
     (call $moonbit.check_range
      (local.get $*idx/1748)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1747))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1747)
       (local.get $*idx/1748))
      (local.get $*tmp/1521))
     (local.set $*tmp/1523
      (i32.add
       (local.tee $*tmp/1526
        (local.get $index/479))
       (i32.const 1)))
     (local.set $*tmp/1524
      (i32.and
       (local.tee $*tmp/1525
        (i32.add
         (i32.const 48)
         (local.get $b/491)))
       (i32.const 255)))
     (local.get $result/478)
     (local.set $*idx/1746
      (local.get $*tmp/1523))
     (local.set $*arr/1745)
     (call $moonbit.check_range
      (local.get $*idx/1746)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1745))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1745)
       (local.get $*idx/1746))
      (local.get $*tmp/1524))
     (local.set $*tmp/1527
      (i32.add
       (local.tee $*tmp/1530
        (local.get $index/479))
       (i32.const 2)))
     (local.set $*tmp/1528
      (i32.and
       (local.tee $*tmp/1529
        (i32.add
         (i32.const 48)
         (local.get $c/492)))
       (i32.const 255)))
     (local.get $result/478)
     (local.set $*idx/1744
      (local.get $*tmp/1527))
     (local.set $*arr/1743)
     (call $moonbit.check_range
      (local.get $*idx/1744)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1743))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1743)
       (local.get $*idx/1744))
      (local.get $*tmp/1528))
     (local.set $index/479
      (i32.add
       (local.tee $*tmp/1531
        (local.get $index/479))
       (i32.const 3))))
    (else
     (if
      (i32.ge_s
       (local.tee $*tmp/1536
        (local.get $exp/484))
       (i32.const 10))
      (then
       (local.set $a/493
        (i32.div_s
         (local.tee $*tmp/1546
          (local.get $exp/484))
         (i32.const 10)))
       (local.set $b/494
        (i32.rem_s
         (local.tee $*tmp/1545
          (local.get $exp/484))
         (i32.const 10)))
       (local.set $*tmp/1537
        (local.get $index/479))
       (local.set $*tmp/1538
        (i32.and
         (local.tee $*tmp/1539
          (i32.add
           (i32.const 48)
           (local.get $a/493)))
         (i32.const 255)))
       (local.get $result/478)
       (local.set $*idx/1752
        (local.get $*tmp/1537))
       (local.set $*arr/1751)
       (call $moonbit.check_range
        (local.get $*idx/1752)
        (i32.const 0)
        (i32.sub
         (call $moonbit.array_length
          (local.get $*arr/1751))
         (i32.const 1)))
       (i32.store8 offset=8
        (i32.add
         (local.get $*arr/1751)
         (local.get $*idx/1752))
        (local.get $*tmp/1538))
       (local.set $*tmp/1540
        (i32.add
         (local.tee $*tmp/1543
          (local.get $index/479))
         (i32.const 1)))
       (local.set $*tmp/1541
        (i32.and
         (local.tee $*tmp/1542
          (i32.add
           (i32.const 48)
           (local.get $b/494)))
         (i32.const 255)))
       (local.get $result/478)
       (local.set $*idx/1750
        (local.get $*tmp/1540))
       (local.set $*arr/1749)
       (call $moonbit.check_range
        (local.get $*idx/1750)
        (i32.const 0)
        (i32.sub
         (call $moonbit.array_length
          (local.get $*arr/1749))
         (i32.const 1)))
       (i32.store8 offset=8
        (i32.add
         (local.get $*arr/1749)
         (local.get $*idx/1750))
        (local.get $*tmp/1541))
       (local.set $index/479
        (i32.add
         (local.tee $*tmp/1544
          (local.get $index/479))
         (i32.const 2))))
      (else
       (local.set $*tmp/1547
        (local.get $index/479))
       (local.set $*tmp/1550
        (local.get $exp/484))
       (local.set $*tmp/1548
        (i32.and
         (local.tee $*tmp/1549
          (i32.add
           (i32.const 48)
           (local.get $*tmp/1550)))
         (i32.const 255)))
       (local.get $result/478)
       (local.set $*idx/1754
        (local.get $*tmp/1547))
       (local.set $*arr/1753)
       (call $moonbit.check_range
        (local.get $*idx/1754)
        (i32.const 0)
        (i32.sub
         (call $moonbit.array_length
          (local.get $*arr/1753))
         (i32.const 1)))
       (i32.store8 offset=8
        (i32.add
         (local.get $*arr/1753)
         (local.get $*idx/1754))
        (local.get $*tmp/1548))
       (local.set $index/479
        (i32.add
         (local.tee $*tmp/1551
          (local.get $index/479))
         (i32.const 1)))))))
   (local.set $*tmp/1552
    (local.get $index/479))
   (call $moonbitlang/core/double/internal/ryu.string_from_bytes
    (local.get $result/478)
    (i32.const 0)
    (local.get $*tmp/1552)))
  (else
   (if
    (i32.lt_s
     (local.tee $*tmp/1553
      (local.get $exp/484))
     (i32.const 0))
    (then
     (local.set $*tmp/1554
      (local.get $index/479))
     (local.get $result/478)
     (local.set $*idx/1774
      (local.get $*tmp/1554))
     (local.set $*arr/1773)
     (call $moonbit.check_range
      (local.get $*idx/1774)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1773))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1773)
       (local.get $*idx/1774))
      (i32.const 48))
     (local.set $*tmp/1556
      (local.tee $index/479
       (i32.add
        (local.tee $*tmp/1555
         (local.get $index/479))
        (i32.const 1))))
     (local.get $result/478)
     (local.set $*idx/1772
      (local.get $*tmp/1556))
     (local.set $*arr/1771)
     (call $moonbit.check_range
      (local.get $*idx/1772)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1771))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1771)
       (local.get $*idx/1772))
      (i32.const 46))
     (local.set $index/479
      (i32.add
       (local.tee $*tmp/1557
        (local.get $index/479))
       (i32.const 1)))
     (i32.const -1)
     (loop $loop:496 (param i32)
      (local.set $i/495)
      (local.set $*tmp/1558
       (local.get $exp/484))
      (if
       (i32.gt_s
        (local.get $i/495)
        (local.get $*tmp/1558))
       (then
        (local.set $*tmp/1559
         (local.get $index/479))
        (local.get $result/478)
        (local.set $*idx/1770
         (local.get $*tmp/1559))
        (local.set $*arr/1769)
        (call $moonbit.check_range
         (local.get $*idx/1770)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1769))
          (i32.const 1)))
        (i32.store8 offset=8
         (i32.add
          (local.get $*arr/1769)
          (local.get $*idx/1770))
         (i32.const 48))
        (local.set $index/479
         (i32.add
          (local.tee $*tmp/1560
           (local.get $index/479))
          (i32.const 1)))
        (local.tee $*tmp/1561
         (i32.sub
          (local.get $i/495)
          (i32.const 1)))
        (br $loop:496))
       (else)))
     (local.set $current/497
      (local.get $index/479))
     (i32.const 0)
     (loop $loop:499 (param i32)
      (local.tee $i/498)
      (local.get $olength/483)
      (i32.lt_s)
      (if
       (then
        (local.set $*tmp/1562
         (i32.sub
          (local.tee $*tmp/1568
           (i32.sub
            (local.tee $*tmp/1569
             (i32.add
              (local.get $current/497)
              (local.get $olength/483)))
            (local.get $i/498)))
          (i32.const 1)))
        (local.set $*tmp/1565
         (i32.wrap_i64
          (local.tee $*tmp/1566
           (i64.rem_u
            (local.tee $*tmp/1567
             (local.get $output/481))
            (i64.const 10)))))
        (local.set $*tmp/1563
         (i32.and
          (local.tee $*tmp/1564
           (i32.add
            (i32.const 48)
            (local.get $*tmp/1565)))
          (i32.const 255)))
        (local.get $result/478)
        (local.set $*idx/1768
         (local.get $*tmp/1562))
        (local.set $*arr/1767)
        (call $moonbit.check_range
         (local.get $*idx/1768)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1767))
          (i32.const 1)))
        (i32.store8 offset=8
         (i32.add
          (local.get $*arr/1767)
          (local.get $*idx/1768))
         (local.get $*tmp/1563))
        (local.set $output/481
         (i64.div_u
          (local.tee $*tmp/1570
           (local.get $output/481))
          (i64.const 10)))
        (local.set $index/479
         (i32.add
          (local.tee $*tmp/1571
           (local.get $index/479))
          (i32.const 1)))
        (local.tee $*tmp/1572
         (i32.add
          (local.get $i/498)
          (i32.const 1)))
        (br $loop:499))
       (else))))
    (else
     (if
      (i32.ge_s
       (local.tee $*tmp/1573
        (i32.add
         (local.tee $*tmp/1574
          (local.get $exp/484))
         (i32.const 1)))
       (local.get $olength/483))
      (then
       (i32.const 0)
       (loop $loop:501 (param i32)
        (local.tee $i/500)
        (local.get $olength/483)
        (i32.lt_s)
        (if
         (then
          (local.set $*tmp/1575
           (i32.sub
            (local.tee $*tmp/1581
             (i32.sub
              (local.tee $*tmp/1582
               (i32.add
                (local.tee $*tmp/1583
                 (local.get $index/479))
                (local.get $olength/483)))
              (local.get $i/500)))
            (i32.const 1)))
          (local.set $*tmp/1578
           (i32.wrap_i64
            (local.tee $*tmp/1579
             (i64.rem_u
              (local.tee $*tmp/1580
               (local.get $output/481))
              (i64.const 10)))))
          (local.set $*tmp/1576
           (i32.and
            (local.tee $*tmp/1577
             (i32.add
              (i32.const 48)
              (local.get $*tmp/1578)))
            (i32.const 255)))
          (local.get $result/478)
          (local.set $*idx/1778
           (local.get $*tmp/1575))
          (local.set $*arr/1777)
          (call $moonbit.check_range
           (local.get $*idx/1778)
           (i32.const 0)
           (i32.sub
            (call $moonbit.array_length
             (local.get $*arr/1777))
            (i32.const 1)))
          (i32.store8 offset=8
           (i32.add
            (local.get $*arr/1777)
            (local.get $*idx/1778))
           (local.get $*tmp/1576))
          (local.set $output/481
           (i64.div_u
            (local.tee $*tmp/1584
             (local.get $output/481))
            (i64.const 10)))
          (local.tee $*tmp/1585
           (i32.add
            (local.get $i/500)
            (i32.const 1)))
          (br $loop:501))
         (else)))
       (local.set $index/479
        (i32.add
         (local.tee $*tmp/1586
          (local.get $index/479))
         (local.get $olength/483)))
       (local.set $*end64/502
        (i32.add
         (local.tee $*tmp/1590
          (local.get $exp/484))
         (i32.const 1)))
       (local.get $olength/483)
       (loop $loop:504 (param i32)
        (local.tee $i/503)
        (local.get $*end64/502)
        (i32.lt_s)
        (if
         (then
          (local.set $*tmp/1587
           (local.get $index/479))
          (local.get $result/478)
          (local.set $*idx/1776
           (local.get $*tmp/1587))
          (local.set $*arr/1775)
          (call $moonbit.check_range
           (local.get $*idx/1776)
           (i32.const 0)
           (i32.sub
            (call $moonbit.array_length
             (local.get $*arr/1775))
            (i32.const 1)))
          (i32.store8 offset=8
           (i32.add
            (local.get $*arr/1775)
            (local.get $*idx/1776))
           (i32.const 48))
          (local.set $index/479
           (i32.add
            (local.tee $*tmp/1588
             (local.get $index/479))
            (i32.const 1)))
          (local.tee $*tmp/1589
           (i32.add
            (local.get $i/503)
            (i32.const 1)))
          (br $loop:504))
         (else))))
      (else
       (local.set $current/505
        (i32.add
         (local.tee $*tmp/1612
          (local.get $index/479))
         (i32.const 1)))
       (i32.const 0)
       (loop $loop:507 (param i32)
        (local.tee $i/506)
        (local.get $olength/483)
        (i32.lt_s)
        (if
         (then
          (local.set $*tmp/1591
           (i32.sub
            (local.tee $*tmp/1593
             (i32.sub
              (local.get $olength/483)
              (local.get $i/506)))
            (i32.const 1)))
          (local.set $*tmp/1592
           (local.get $exp/484))
          (if
           (i32.eq
            (local.get $*tmp/1591)
            (local.get $*tmp/1592))
           (then
            (local.set $*tmp/1594
             (i32.sub
              (local.tee $*tmp/1595
               (i32.sub
                (local.tee $*tmp/1596
                 (i32.add
                  (local.tee $*tmp/1597
                   (local.get $current/505))
                  (local.get $olength/483)))
                (local.get $i/506)))
              (i32.const 1)))
            (local.get $result/478)
            (local.set $*idx/1782
             (local.get $*tmp/1594))
            (local.set $*arr/1781)
            (call $moonbit.check_range
             (local.get $*idx/1782)
             (i32.const 0)
             (i32.sub
              (call $moonbit.array_length
               (local.get $*arr/1781))
              (i32.const 1)))
            (i32.store8 offset=8
             (i32.add
              (local.get $*arr/1781)
              (local.get $*idx/1782))
             (i32.const 46))
            (local.set $current/505
             (i32.sub
              (local.tee $*tmp/1598
               (local.get $current/505))
              (i32.const 1))))
           (else))
          (local.set $*tmp/1599
           (i32.sub
            (local.tee $*tmp/1605
             (i32.sub
              (local.tee $*tmp/1606
               (i32.add
                (local.tee $*tmp/1607
                 (local.get $current/505))
                (local.get $olength/483)))
              (local.get $i/506)))
            (i32.const 1)))
          (local.set $*tmp/1602
           (i32.wrap_i64
            (local.tee $*tmp/1603
             (i64.rem_u
              (local.tee $*tmp/1604
               (local.get $output/481))
              (i64.const 10)))))
          (local.set $*tmp/1600
           (i32.and
            (local.tee $*tmp/1601
             (i32.add
              (i32.const 48)
              (local.get $*tmp/1602)))
            (i32.const 255)))
          (local.get $result/478)
          (local.set $*idx/1780
           (local.get $*tmp/1599))
          (local.set $*arr/1779)
          (call $moonbit.check_range
           (local.get $*idx/1780)
           (i32.const 0)
           (i32.sub
            (call $moonbit.array_length
             (local.get $*arr/1779))
            (i32.const 1)))
          (i32.store8 offset=8
           (i32.add
            (local.get $*arr/1779)
            (local.get $*idx/1780))
           (local.get $*tmp/1600))
          (local.set $output/481
           (i64.div_u
            (local.tee $*tmp/1608
             (local.get $output/481))
            (i64.const 10)))
          (local.tee $*tmp/1609
           (i32.add
            (local.get $i/506)
            (i32.const 1)))
          (br $loop:507))
         (else)))
       (local.set $*tmp/1610
        (local.get $index/479))
       (local.set $*tmp/1611
        (i32.add
         (local.get $olength/483)
         (i32.const 1)))
       (local.set $index/479
        (i32.add
         (local.get $*tmp/1610)
         (local.get $*tmp/1611)))))))
   (local.set $*tmp/1613
    (local.get $index/479))
   (call $moonbitlang/core/double/internal/ryu.string_from_bytes
    (local.get $result/478)
    (i32.const 0)
    (local.get $*tmp/1613)))))
(func $moonbitlang/core/double/internal/ryu.d2d (param $ieeeMantissa/424 i64) (param $ieeeExponent/423 i32) (result i32)
 (local $even/425 i32)
 (local $mv/426 i64)
 (local $mmShift/427 i32)
 (local $q/434 i32)
 (local $k/435 i32)
 (local $i/436 i32)
 (local $pow5/0/437 i64)
 (local $pow5/1/437 i64)
 (local $*bind/0/438 i64)
 (local $*bind/1/438 i64)
 (local $*bind/2/438 i64)
 (local $*vrOut/439 i64)
 (local $*vpOut/440 i64)
 (local $*vmOut/441 i64)
 (local $mvMod5/442 i32)
 (local $q/443 i32)
 (local $i/444 i32)
 (local $k/445 i32)
 (local $j/446 i32)
 (local $pow5/0/447 i64)
 (local $pow5/1/447 i64)
 (local $*bind/0/448 i64)
 (local $*bind/1/448 i64)
 (local $*bind/2/448 i64)
 (local $*vrOut/449 i64)
 (local $*vpOut/450 i64)
 (local $*vmOut/451 i64)
 (local $vpDiv10/455 i64)
 (local $vmDiv10/456 i64)
 (local $vmMod10/458 i32)
 (local $vrDiv10/459 i64)
 (local $vrMod10/460 i32)
 (local $vmDiv10/461 i64)
 (local $vmMod10/462 i32)
 (local $vpDiv10/464 i64)
 (local $vrDiv10/465 i64)
 (local $vrMod10/466 i32)
 (local $vpDiv100/468 i64)
 (local $vmDiv100/469 i64)
 (local $vrDiv100/470 i64)
 (local $vrMod100/471 i32)
 (local $vpDiv10/472 i64)
 (local $vmDiv10/473 i64)
 (local $vrDiv10/475 i64)
 (local $vrMod10/476 i32)
 (local $exp/477 i32)
 (local $*p/738 i32)
 (local $*p/741 i32)
 (local $*p/748 i32)
 (local $*p/751 i32)
 (local $*p/754 i32)
 (local $*p/763 i32)
 (local $*p/766 i32)
 (local $*tmp/1375 i32)
 (local $*tmp/1376 i32)
 (local $*tmp/1377 i32)
 (local $*tmp/1378 i32)
 (local $*tmp/1379 i64)
 (local $*tmp/1380 i64)
 (local $*tmp/1381 i64)
 (local $*tmp/1382 i64)
 (local $*tmp/1383 i64)
 (local $*tmp/1384 i64)
 (local $*tmp/1385 i32)
 (local $*tmp/1386 i32)
 (local $*tmp/1387 i32)
 (local $*tmp/1388 i64)
 (local $*tmp/1389 i64)
 (local $*tmp/1390 i32)
 (local $*tmp/1391 i32)
 (local $*tmp/1392 i32)
 (local $*tmp/1393 i32)
 (local $*tmp/1394 i32)
 (local $*tmp/1395 i32)
 (local $*tmp/1396 i32)
 (local $*tmp/1397 i32)
 (local $*tmp/1398 i32)
 (local $*tmp/1399 i32)
 (local $*tmp/1400 i32)
 (local $*tmp/1401 i32)
 (local $*tmp/1402 i32)
 (local $*tmp/1403 i32)
 (local $*tmp/1404 i32)
 (local $*tmp/1405 i32)
 (local $*tmp/1406 i32)
 (local $*tmp/1407 i64)
 (local $*tmp/1408 i64)
 (local $*tmp/1409 i64)
 (local $*tmp/1410 i64)
 (local $*tmp/1411 i64)
 (local $*tmp/1412 i32)
 (local $*tmp/1413 i32)
 (local $*tmp/1414 i32)
 (local $*tmp/1415 i32)
 (local $*tmp/1416 i32)
 (local $*tmp/1417 i32)
 (local $*tmp/1418 i32)
 (local $*tmp/1419 i32)
 (local $*tmp/1420 i32)
 (local $*tmp/1421 i32)
 (local $*tmp/1422 i32)
 (local $*tmp/1423 i32)
 (local $*tmp/1424 i32)
 (local $*tmp/1425 i32)
 (local $*tmp/1426 i32)
 (local $*tmp/1427 i32)
 (local $*tmp/1428 i32)
 (local $*tmp/1429 i32)
 (local $*tmp/1430 i32)
 (local $*tmp/1431 i32)
 (local $*tmp/1432 i64)
 (local $*tmp/1433 i64)
 (local $*tmp/1434 i32)
 (local $*tmp/1435 i32)
 (local $*tmp/1436 i32)
 (local $*tmp/1437 i64)
 (local $*tmp/1438 i64)
 (local $*tmp/1439 i64)
 (local $*tmp/1440 i32)
 (local $*tmp/1441 i32)
 (local $*tmp/1442 i32)
 (local $*tmp/1443 i32)
 (local $*tmp/1444 i32)
 (local $*tmp/1445 i64)
 (local $*tmp/1446 i64)
 (local $*tmp/1447 i64)
 (local $*tmp/1448 i32)
 (local $*tmp/1449 i32)
 (local $*tmp/1450 i32)
 (local $*tmp/1451 i64)
 (local $*tmp/1452 i64)
 (local $*tmp/1453 i64)
 (local $*tmp/1454 i64)
 (local $*tmp/1455 i32)
 (local $*tmp/1456 i64)
 (local $*tmp/1457 i64)
 (local $*tmp/1458 i64)
 (local $*tmp/1459 i32)
 (local $*tmp/1460 i32)
 (local $*tmp/1461 i64)
 (local $*tmp/1462 i64)
 (local $*tmp/1463 i32)
 (local $*tmp/1464 i32)
 (local $*tmp/1465 i32)
 (local $*tmp/1466 i32)
 (local $*tmp/1467 i64)
 (local $*tmp/1468 i64)
 (local $*tmp/1469 i32)
 (local $*tmp/1470 i32)
 (local $*tmp/1471 i32)
 (local $*tmp/1472 i32)
 (local $*tmp/1473 i64)
 (local $*tmp/1474 i64)
 (local $*tmp/1475 i64)
 (local $*tmp/1476 i64)
 (local $*tmp/1477 i64)
 (local $*tmp/1478 i64)
 (local $*tmp/1479 i64)
 (local $*tmp/1480 i64)
 (local $*tmp/1481 i64)
 (local $*tmp/1482 i64)
 (local $*tmp/1483 i64)
 (local $*tmp/1484 i32)
 (local $*tmp/1485 i32)
 (local $*tmp/1486 i64)
 (local $*tmp/1487 i64)
 (local $*tmp/1488 i64)
 (local $ptr/1785 i32)
 (local $e2/421 i32)
 (local $m2/422 i64)
 (local $vr/428 i64)
 (local $vp/429 i64)
 (local $vm/430 i64)
 (local $e10/431 i32)
 (local $vmIsTrailingZeros/432 i32)
 (local $vrIsTrailingZeros/433 i32)
 (local $removed/452 i32)
 (local $lastRemovedDigit/453 i32)
 (local $output/454 i64)
 (local $roundUp/467 i32)
 (local.set $e2/421
  (i32.const 0))
 (local.set $m2/422
  (i64.const 0))
 (if
  (i32.eq
   (local.get $ieeeExponent/423)
   (i32.const 0))
  (then
   (local.set $e2/421
    (i32.const -1076))
   (local.set $m2/422
    (local.get $ieeeMantissa/424)))
  (else
   (local.set $e2/421
    (i32.sub
     (local.tee $*tmp/1375
      (i32.sub
       (local.tee $*tmp/1376
        (i32.sub
         (local.tee $*tmp/1377
          (local.get $ieeeExponent/423))
         (i32.const 1023)))
       (i32.const 52)))
     (i32.const 2)))
   (local.set $m2/422
    (i64.or
     (i64.const 4503599627370496)
     (local.get $ieeeMantissa/424)))))
 (local.set $even/425
  (i64.eq
   (local.tee $*tmp/1487
    (i64.and
     (local.tee $*tmp/1488
      (local.get $m2/422))
     (i64.const 1)))
   (i64.const 0)))
 (local.set $*tmp/1486
  (local.get $m2/422))
 (local.set $mv/426
  (i64.mul
   (i64.const 4)
   (local.get $*tmp/1486)))
 (local.get $ieeeMantissa/424)
 (local.set $mmShift/427
  (if (result i32)
   (i64.ne
    (i64.const 0))
   (then
    (i32.const 1))
   (else
    (i32.le_u
     (local.get $ieeeExponent/423)
     (i32.const 1)))))
 (local.set $vr/428
  (i64.const 0))
 (local.set $vp/429
  (i64.const 0))
 (local.set $vm/430
  (i64.const 0))
 (local.set $e10/431
  (i32.const 0))
 (local.set $vmIsTrailingZeros/432
  (i32.const 0))
 (local.set $vrIsTrailingZeros/433
  (i32.const 0))
 (if
  (i32.ge_s
   (local.tee $*tmp/1378
    (local.get $e2/421))
   (i32.const 0))
  (then
   (local.set $*tmp/1399
    (local.tee $*tmp/1402
     (i32.shr_u
      (local.tee $*tmp/1403
       (local.tee $*tmp/1404
        (i32.mul
         (local.tee $*p/738
          (local.get $e2/421))
         (i32.const 78913))))
      (i32.const 18))))
   (local.set $*tmp/1400
    (if (result i32)
     (local.tee $*p/741
      (i32.gt_s
       (local.tee $*tmp/1401
        (local.get $e2/421))
       (i32.const 3)))
     (then
      (i32.const 1))
     (else
      (i32.const 0))))
   (local.set $e10/431
    (local.tee $q/434
     (i32.sub
      (local.get $*tmp/1399)
      (local.get $*tmp/1400))))
   (local.set $*tmp/1394
    (i32.add
     (local.tee $*tmp/1395
      (local.tee $*tmp/1396
       (i32.shr_u
        (local.tee $*tmp/1397
         (local.tee $*tmp/1398
          (i32.mul
           (local.get $q/434)
           (i32.const 1217359))))
        (i32.const 19))))
     (i32.const 1)))
   (local.set $k/435
    (i32.sub
     (local.tee $*tmp/1393
      (i32.add
       (i32.const 125)
       (local.get $*tmp/1394)))
     (i32.const 1)))
   (local.set $*tmp/1392
    (local.get $e2/421))
   (local.set $i/436
    (i32.add
     (local.tee $*tmp/1390
      (i32.add
       (local.tee $*tmp/1391
        (i32.sub
         (i32.const 0)
         (local.get $*tmp/1392)))
       (local.get $q/434)))
     (local.get $k/435)))
   (call $moonbitlang/core/double/internal/ryu.double_computeInvPow5
    (local.get $q/434))
   (local.set $pow5/1/437)
   (local.set $pow5/0/437)
   (call $moonbitlang/core/double/internal/ryu.mulShiftAll64
    (local.tee $*tmp/1389
     (local.get $m2/422))
    (local.get $pow5/0/437)
    (local.get $pow5/1/437)
    (local.get $i/436)
    (local.get $mmShift/427))
   (local.set $*bind/2/438)
   (local.set $*bind/1/438)
   (local.tee $*bind/0/438)
   (local.set $*vrOut/439)
   (local.set $*vpOut/440
    (local.get $*bind/1/438))
   (local.set $*vmOut/441
    (local.get $*bind/2/438))
   (local.set $vr/428
    (local.get $*vrOut/439))
   (local.set $vp/429
    (local.get $*vpOut/440))
   (local.set $vm/430
    (local.get $*vmOut/441))
   (if
    (i32.le_s
     (local.get $q/434)
     (i32.const 21))
    (then
     (local.set $*tmp/1385
      (i32.wrap_i64
       (local.get $mv/426)))
     (local.set $*tmp/1387
      (i32.wrap_i64
       (local.tee $*tmp/1388
        (i64.div_u
         (local.get $mv/426)
         (i64.const 5)))))
     (local.set $*tmp/1386
      (i32.mul
       (i32.const 5)
       (local.get $*tmp/1387)))
     (if
      (i32.eq
       (local.tee $mvMod5/442
        (i32.sub
         (local.get $*tmp/1385)
         (local.get $*tmp/1386)))
       (i32.const 0))
      (then
       (local.set $vrIsTrailingZeros/433
        (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
         (local.get $mv/426)
         (local.get $q/434))))
      (else
       (if
        (local.get $even/425)
        (then
         (local.set $*tmp/1380
          (i64.sub
           (local.get $mv/426)
           (i64.const 1)))
         (local.set $*tmp/1381
          (if (result i64)
           (local.get $mmShift/427)
           (then
            (i64.const 1))
           (else
            (i64.const 0))))
         (local.set $vmIsTrailingZeros/432
          (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
           (local.tee $*tmp/1379
            (i64.sub
             (local.get $*tmp/1380)
             (local.get $*tmp/1381)))
           (local.get $q/434))))
        (else
         (local.set $*tmp/1382
          (local.get $vp/429))
         (local.set $*tmp/1383
          (if (result i64)
           (local.tee $*p/748
            (call $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5
             (local.tee $*tmp/1384
              (i64.add
               (local.get $mv/426)
               (i64.const 2)))
             (local.get $q/434)))
           (then
            (i64.const 1))
           (else
            (i64.const 0))))
         (local.set $vp/429
          (i64.sub
           (local.get $*tmp/1382)
           (local.get $*tmp/1383))))))))
    (else)))
  (else
   (local.set $*tmp/1426
    (local.get $e2/421))
   (local.set $*tmp/1419
    (local.tee $*tmp/1423
     (i32.shr_u
      (local.tee $*tmp/1424
       (local.tee $*tmp/1425
        (i32.mul
         (local.tee $*p/751
          (i32.sub
           (i32.const 0)
           (local.get $*tmp/1426)))
         (i32.const 732923))))
      (i32.const 20))))
   (local.set $*tmp/1422
    (local.get $e2/421))
   (local.set $*tmp/1420
    (if (result i32)
     (local.tee $*p/754
      (i32.gt_s
       (local.tee $*tmp/1421
        (i32.sub
         (i32.const 0)
         (local.get $*tmp/1422)))
       (i32.const 1)))
     (then
      (i32.const 1))
     (else
      (i32.const 0))))
   (local.set $q/443
    (i32.sub
     (local.get $*tmp/1419)
     (local.get $*tmp/1420)))
   (local.set $*tmp/1405
    (local.get $e2/421))
   (local.set $e10/431
    (i32.add
     (local.get $q/443)
     (local.get $*tmp/1405)))
   (local.set $*tmp/1418
    (local.get $e2/421))
   (local.set $k/445
    (i32.sub
     (local.tee $*tmp/1412
      (i32.add
       (local.tee $*tmp/1413
        (local.tee $*tmp/1414
         (i32.shr_u
          (local.tee $*tmp/1415
           (local.tee $*tmp/1416
            (i32.mul
             (local.tee $i/444
              (i32.sub
               (local.tee $*tmp/1417
                (i32.sub
                 (i32.const 0)
                 (local.get $*tmp/1418)))
               (local.get $q/443)))
             (i32.const 1217359))))
          (i32.const 19))))
       (i32.const 1)))
     (i32.const 125)))
   (local.set $j/446
    (i32.sub
     (local.get $q/443)
     (local.get $k/445)))
   (call $moonbitlang/core/double/internal/ryu.double_computePow5
    (local.get $i/444))
   (local.set $pow5/1/447)
   (local.set $pow5/0/447)
   (call $moonbitlang/core/double/internal/ryu.mulShiftAll64
    (local.tee $*tmp/1411
     (local.get $m2/422))
    (local.get $pow5/0/447)
    (local.get $pow5/1/447)
    (local.get $j/446)
    (local.get $mmShift/427))
   (local.set $*bind/2/448)
   (local.set $*bind/1/448)
   (local.tee $*bind/0/448)
   (local.set $*vrOut/449)
   (local.set $*vpOut/450
    (local.get $*bind/1/448))
   (local.set $*vmOut/451
    (local.get $*bind/2/448))
   (local.set $vr/428
    (local.get $*vrOut/449))
   (local.set $vp/429
    (local.get $*vpOut/450))
   (local.set $vm/430
    (local.get $*vmOut/451))
   (if
    (i32.le_s
     (local.get $q/443)
     (i32.const 1))
    (then
     (local.set $vrIsTrailingZeros/433
      (i32.const 1))
     (if
      (local.get $even/425)
      (then
       (local.set $vmIsTrailingZeros/432
        (i32.eq
         (local.tee $*tmp/1406
          (if (result i32)
           (local.get $mmShift/427)
           (then
            (i32.const 1))
           (else
            (i32.const 0))))
         (i32.const 1))))
      (else
       (local.set $vp/429
        (i64.sub
         (local.tee $*tmp/1407
          (local.get $vp/429))
         (i64.const 1))))))
    (else
     (if
      (i32.lt_s
       (local.get $q/443)
       (i32.const 63))
      (then
       (local.set $*tmp/1409
        (i64.sub
         (local.tee $*tmp/1410
          (i64.shl
           (i64.const 1)
           (i64.extend_i32_s
            (local.get $q/443))))
         (i64.const 1)))
       (local.set $vrIsTrailingZeros/433
        (i64.eq
         (local.tee $*tmp/1408
          (i64.and
           (local.get $mv/426)
           (local.get $*tmp/1409)))
         (i64.const 0))))
      (else))))))
 (local.set $removed/452
  (i32.const 0))
 (local.set $lastRemovedDigit/453
  (i32.const 0))
 (local.set $output/454
  (i64.const 0))
 (if
  (if (result i32)
   (local.get $vmIsTrailingZeros/432)
   (then
    (i32.const 1))
   (else
    (local.get $vrIsTrailingZeros/433)))
  (then
   (block $break:457
    (loop $loop:457
     (local.set $vpDiv10/455
      (i64.div_u
       (local.tee $*tmp/1439
        (local.get $vp/429))
       (i64.const 10)))
     (local.set $vmDiv10/456
      (i64.div_u
       (local.tee $*tmp/1438
        (local.get $vm/430))
       (i64.const 10)))
     (if
      (i64.le_u
       (local.get $vpDiv10/455)
       (local.get $vmDiv10/456))
      (then
       (br $break:457))
      (else))
     (local.set $*tmp/1434
      (i32.wrap_i64
       (local.tee $*tmp/1437
        (local.get $vm/430))))
     (local.set $*tmp/1436
      (i32.wrap_i64
       (local.get $vmDiv10/456)))
     (local.set $*tmp/1435
      (i32.mul
       (i32.const 10)
       (local.get $*tmp/1436)))
     (local.set $vmMod10/458
      (i32.sub
       (local.get $*tmp/1434)
       (local.get $*tmp/1435)))
     (local.set $vrDiv10/459
      (i64.div_u
       (local.tee $*tmp/1433
        (local.get $vr/428))
       (i64.const 10)))
     (local.set $*tmp/1429
      (i32.wrap_i64
       (local.tee $*tmp/1432
        (local.get $vr/428))))
     (local.set $*tmp/1431
      (i32.wrap_i64
       (local.get $vrDiv10/459)))
     (local.set $*tmp/1430
      (i32.mul
       (i32.const 10)
       (local.get $*tmp/1431)))
     (local.set $vrMod10/460
      (i32.sub
       (local.get $*tmp/1429)
       (local.get $*tmp/1430)))
     (local.set $vmIsTrailingZeros/432
      (if (result i32)
       (local.get $vmIsTrailingZeros/432)
       (then
        (i32.eq
         (local.get $vmMod10/458)
         (i32.const 0)))
       (else
        (i32.const 0))))
     (local.set $vrIsTrailingZeros/433
      (if (result i32)
       (local.get $vrIsTrailingZeros/433)
       (then
        (i32.eq
         (local.tee $*tmp/1427
          (local.get $lastRemovedDigit/453))
         (i32.const 0)))
       (else
        (i32.const 0))))
     (local.set $lastRemovedDigit/453
      (local.get $vrMod10/460))
     (local.set $vr/428
      (local.get $vrDiv10/459))
     (local.set $vp/429
      (local.get $vpDiv10/455))
     (local.set $vm/430
      (local.get $vmDiv10/456))
     (local.set $removed/452
      (i32.add
       (local.tee $*tmp/1428
        (local.get $removed/452))
       (i32.const 1)))
     (br $loop:457)))
   (if
    (local.get $vmIsTrailingZeros/432)
    (then
     (block $break:463
      (loop $loop:463
       (local.set $vmDiv10/461
        (i64.div_u
         (local.tee $*tmp/1452
          (local.get $vm/430))
         (i64.const 10)))
       (local.set $*tmp/1448
        (i32.wrap_i64
         (local.tee $*tmp/1451
          (local.get $vm/430))))
       (local.set $*tmp/1450
        (i32.wrap_i64
         (local.get $vmDiv10/461)))
       (local.set $*tmp/1449
        (i32.mul
         (i32.const 10)
         (local.get $*tmp/1450)))
       (local.tee $vmMod10/462
        (i32.sub
         (local.get $*tmp/1448)
         (local.get $*tmp/1449)))
       (if
        (i32.ne
         (i32.const 0))
        (then
         (br $break:463))
        (else))
       (local.set $vpDiv10/464
        (i64.div_u
         (local.tee $*tmp/1447
          (local.get $vp/429))
         (i64.const 10)))
       (local.set $vrDiv10/465
        (i64.div_u
         (local.tee $*tmp/1446
          (local.get $vr/428))
         (i64.const 10)))
       (local.set $*tmp/1442
        (i32.wrap_i64
         (local.tee $*tmp/1445
          (local.get $vr/428))))
       (local.set $*tmp/1444
        (i32.wrap_i64
         (local.get $vrDiv10/465)))
       (local.set $*tmp/1443
        (i32.mul
         (i32.const 10)
         (local.get $*tmp/1444)))
       (local.set $vrMod10/466
        (i32.sub
         (local.get $*tmp/1442)
         (local.get $*tmp/1443)))
       (local.set $vrIsTrailingZeros/433
        (if (result i32)
         (local.get $vrIsTrailingZeros/433)
         (then
          (i32.eq
           (local.tee $*tmp/1440
            (local.get $lastRemovedDigit/453))
           (i32.const 0)))
         (else
          (i32.const 0))))
       (local.set $lastRemovedDigit/453
        (local.get $vrMod10/466))
       (local.set $vr/428
        (local.get $vrDiv10/465))
       (local.set $vp/429
        (local.get $vpDiv10/464))
       (local.set $vm/430
        (local.get $vmDiv10/461))
       (local.set $removed/452
        (i32.add
         (local.tee $*tmp/1441
          (local.get $removed/452))
         (i32.const 1)))
       (br $loop:463))))
    (else))
   (if
    (if (result i32)
     (local.get $vrIsTrailingZeros/433)
     (then
      (if (result i32)
       (i32.eq
        (local.tee $*tmp/1455
         (local.get $lastRemovedDigit/453))
        (i32.const 5))
       (then
        (i64.eq
         (local.tee $*tmp/1453
          (i64.rem_u
           (local.tee $*tmp/1454
            (local.get $vr/428))
           (i64.const 2)))
         (i64.const 0)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (local.set $lastRemovedDigit/453
      (i32.const 4)))
    (else))
   (local.set $*tmp/1456
    (local.get $vr/428))
   (local.set $*tmp/1461
    (local.get $vr/428))
   (local.set $*tmp/1462
    (local.get $vm/430))
   (local.set $*tmp/1457
    (local.tee $*tmp/1458
     (if (result i64)
      (local.tee $*p/763
       (if (result i32)
        (if (result i32)
         (i64.eq
          (local.get $*tmp/1461)
          (local.get $*tmp/1462))
         (then
          (if (result i32)
           (i32.eqz
            (local.get $even/425))
           (then
            (i32.const 1))
           (else
            (i32.eqz
             (local.tee $*tmp/1460
              (local.get $vmIsTrailingZeros/432))))))
         (else
          (i32.const 0)))
        (then
         (i32.const 1))
        (else
         (i32.ge_s
          (local.tee $*tmp/1459
           (local.get $lastRemovedDigit/453))
          (i32.const 5)))))
      (then
       (i64.const 1))
      (else
       (i64.const 0)))))
   (local.set $output/454
    (i64.add
     (local.get $*tmp/1456)
     (local.get $*tmp/1457))))
  (else
   (local.set $roundUp/467
    (i32.const 0))
   (local.set $vpDiv100/468
    (i64.div_u
     (local.tee $*tmp/1482
      (local.get $vp/429))
     (i64.const 100)))
   (local.set $vmDiv100/469
    (i64.div_u
     (local.tee $*tmp/1481
      (local.get $vm/430))
     (i64.const 100)))
   (if
    (i64.gt_u
     (local.get $vpDiv100/468)
     (local.get $vmDiv100/469))
    (then
     (local.set $vrDiv100/470
      (i64.div_u
       (local.tee $*tmp/1468
        (local.get $vr/428))
       (i64.const 100)))
     (local.set $*tmp/1464
      (i32.wrap_i64
       (local.tee $*tmp/1467
        (local.get $vr/428))))
     (local.set $*tmp/1466
      (i32.wrap_i64
       (local.get $vrDiv100/470)))
     (local.set $*tmp/1465
      (i32.mul
       (i32.const 100)
       (local.get $*tmp/1466)))
     (local.set $roundUp/467
      (i32.ge_s
       (local.tee $vrMod100/471
        (i32.sub
         (local.get $*tmp/1464)
         (local.get $*tmp/1465)))
       (i32.const 50)))
     (local.set $vr/428
      (local.get $vrDiv100/470))
     (local.set $vp/429
      (local.get $vpDiv100/468))
     (local.set $vm/430
      (local.get $vmDiv100/469))
     (local.set $removed/452
      (i32.add
       (local.tee $*tmp/1463
        (local.get $removed/452))
       (i32.const 2))))
    (else))
   (block $break:474
    (loop $loop:474
     (local.set $vpDiv10/472
      (i64.div_u
       (local.tee $*tmp/1476
        (local.get $vp/429))
       (i64.const 10)))
     (local.set $vmDiv10/473
      (i64.div_u
       (local.tee $*tmp/1475
        (local.get $vm/430))
       (i64.const 10)))
     (if
      (i64.le_u
       (local.get $vpDiv10/472)
       (local.get $vmDiv10/473))
      (then
       (br $break:474))
      (else))
     (local.set $vrDiv10/475
      (i64.div_u
       (local.tee $*tmp/1474
        (local.get $vr/428))
       (i64.const 10)))
     (local.set $*tmp/1470
      (i32.wrap_i64
       (local.tee $*tmp/1473
        (local.get $vr/428))))
     (local.set $*tmp/1472
      (i32.wrap_i64
       (local.get $vrDiv10/475)))
     (local.set $*tmp/1471
      (i32.mul
       (i32.const 10)
       (local.get $*tmp/1472)))
     (local.set $roundUp/467
      (i32.ge_s
       (local.tee $vrMod10/476
        (i32.sub
         (local.get $*tmp/1470)
         (local.get $*tmp/1471)))
       (i32.const 5)))
     (local.set $vr/428
      (local.get $vrDiv10/475))
     (local.set $vp/429
      (local.get $vpDiv10/472))
     (local.set $vm/430
      (local.get $vmDiv10/473))
     (local.set $removed/452
      (i32.add
       (local.tee $*tmp/1469
        (local.get $removed/452))
       (i32.const 1)))
     (br $loop:474)))
   (local.set $*tmp/1477
    (local.get $vr/428))
   (local.set $*tmp/1479
    (local.get $vr/428))
   (local.set $*tmp/1480
    (local.get $vm/430))
   (local.set $*tmp/1478
    (if (result i64)
     (local.tee $*p/766
      (if (result i32)
       (i64.eq
        (local.get $*tmp/1479)
        (local.get $*tmp/1480))
       (then
        (i32.const 1))
       (else
        (local.get $roundUp/467))))
     (then
      (i64.const 1))
     (else
      (i64.const 0))))
   (local.set $output/454
    (i64.add
     (local.get $*tmp/1477)
     (local.get $*tmp/1478)))))
 (local.set $*tmp/1484
  (local.get $e10/431))
 (local.set $*tmp/1485
  (local.get $removed/452))
 (local.set $exp/477
  (i32.add
   (local.get $*tmp/1484)
   (local.get $*tmp/1485)))
 (local.set $*tmp/1483
  (local.get $output/454))
 (i32.store offset=4
  (local.tee $ptr/1785
   (call $moonbit.gc.malloc
    (i32.const 12)))
  (i32.const 2621440))
 (i32.store offset=16
  (local.get $ptr/1785)
  (local.get $exp/477))
 (i64.store offset=8
  (local.get $ptr/1785)
  (local.get $*tmp/1483))
 (local.get $ptr/1785))
(func $moonbitlang/core/double/internal/ryu.decimal_length17 (param $v/420 i64) (result i32)
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000000000000))
  (then
   (i32.const 17)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000000000000))
  (then
   (i32.const 16)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000000000000))
  (then
   (i32.const 15)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000000000))
  (then
   (i32.const 14)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000000000))
  (then
   (i32.const 13)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000000000))
  (then
   (i32.const 12)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000000))
  (then
   (i32.const 11)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000000))
  (then
   (i32.const 10)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000000))
  (then
   (i32.const 9)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000000))
  (then
   (i32.const 8)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000000))
  (then
   (i32.const 7)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100000))
  (then
   (i32.const 6)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10000))
  (then
   (i32.const 5)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 1000))
  (then
   (i32.const 4)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 100))
  (then
   (i32.const 3)
   (return))
  (else))
 (if
  (i64.ge_u
   (local.get $v/420)
   (i64.const 10))
  (then
   (i32.const 2)
   (return))
  (else))
 (i32.const 1))
(func $moonbitlang/core/double/internal/ryu.double_computeInvPow5 (param $i/403 i32) (result i64) (result i64)
 (local $base/402 i32)
 (local $base2/404 i32)
 (local $offset/405 i32)
 (local $mul0/406 i64)
 (local $mul1/407 i64)
 (local $m/408 i64)
 (local $*bind/0/409 i64)
 (local $*bind/1/409 i64)
 (local $*low1/410 i64)
 (local $*high1/411 i64)
 (local $*bind/0/412 i64)
 (local $*bind/1/412 i64)
 (local $*low0/413 i64)
 (local $*high0/414 i64)
 (local $sum/415 i64)
 (local $delta/417 i32)
 (local $a/418 i64)
 (local $b/419 i64)
 (local $*p/715 i32)
 (local $*p/718 i32)
 (local $*p/729 i32)
 (local $*p/732 i32)
 (local $*p/735 i64)
 (local $*tmp/1344 i64)
 (local $*tmp/1345 i64)
 (local $*tmp/1346 i64)
 (local $*tmp/1347 i32)
 (local $*tmp/1348 i64)
 (local $*tmp/1349 i64)
 (local $*tmp/1350 i32)
 (local $*tmp/1351 i32)
 (local $*tmp/1352 i32)
 (local $*tmp/1353 i32)
 (local $*tmp/1354 i32)
 (local $*tmp/1355 i64)
 (local $*tmp/1356 i64)
 (local $*tmp/1357 i64)
 (local $*tmp/1358 i32)
 (local $*tmp/1359 i32)
 (local $*tmp/1360 i32)
 (local $*tmp/1361 i32)
 (local $*tmp/1362 i32)
 (local $*tmp/1363 i32)
 (local $*tmp/1364 i32)
 (local $*tmp/1365 i32)
 (local $*tmp/1366 i32)
 (local $*tmp/1367 i32)
 (local $*tmp/1368 i32)
 (local $*tmp/1369 i32)
 (local $*tmp/1370 i32)
 (local $*tmp/1371 i32)
 (local $*tmp/1372 i32)
 (local $*tmp/1373 i32)
 (local $*tmp/1374 i32)
 (local $*tmp/1650 i32)
 (local $*tmp/1651 i64)
 (local $*tmp/1652 i64)
 (local $*tmp/1653 i64)
 (local $*arr/1786 i32)
 (local $*idx/1787 i32)
 (local $*arr/1788 i32)
 (local $*idx/1789 i32)
 (local $*arr/1790 i32)
 (local $*idx/1791 i32)
 (local $*arr/1792 i32)
 (local $*idx/1793 i32)
 (local $high1/416 i64)
 (local.set $offset/405
  (i32.sub
   (local.tee $base2/404
    (i32.mul
     (local.tee $base/402
      (i32.div_s
       (local.tee $*tmp/1373
        (i32.sub
         (local.tee $*tmp/1374
          (i32.add
           (local.get $i/403)
           (i32.const 26)))
         (i32.const 1)))
       (i32.const 26)))
     (i32.const 26)))
   (local.get $i/403)))
 (local.set $*p/715
  (i32.mul
   (local.get $base/402)
   (i32.const 2)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
 (local.tee $*tmp/1372
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
 (local.set $*idx/1793
  (local.get $*p/715))
 (local.set $*arr/1792)
 (call $moonbit.check_range
  (local.get $*idx/1793)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1792))
   (i32.const 1)))
 (local.set $*tmp/1653
  (i64.load offset=8
   (i32.add
    (local.get $*arr/1792)
    (i32.shl
     (local.get $*idx/1793)
     (i32.const 3)))))
 (call $moonbit.decref
  (local.get $*tmp/1372))
 (local.set $mul0/406
  (local.get $*tmp/1653))
 (local.set $*p/718
  (i32.add
   (local.tee $*tmp/1371
    (i32.mul
     (local.get $base/402)
     (i32.const 2)))
   (i32.const 1)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
 (local.tee $*tmp/1370
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_INV_SPLIT2))
 (local.set $*idx/1791
  (local.get $*p/718))
 (local.set $*arr/1790)
 (call $moonbit.check_range
  (local.get $*idx/1791)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1790))
   (i32.const 1)))
 (local.set $*tmp/1652
  (i64.load offset=8
   (i32.add
    (local.get $*arr/1790)
    (i32.shl
     (local.get $*idx/1791)
     (i32.const 3)))))
 (call $moonbit.decref
  (local.get $*tmp/1370))
 (local.set $mul1/407
  (local.get $*tmp/1652))
 (if
  (i32.eq
   (local.get $offset/405)
   (i32.const 0))
  (then
   (local.get $mul0/406)
   (local.get $mul1/407)
   (return))
  (else))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
 (local.tee $*tmp/1369
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
 (local.set $*idx/1789
  (local.get $offset/405))
 (local.set $*arr/1788)
 (call $moonbit.check_range
  (local.get $*idx/1789)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1788))
   (i32.const 1)))
 (local.set $*tmp/1651
  (i64.load offset=8
   (i32.add
    (local.get $*arr/1788)
    (i32.shl
     (local.get $*idx/1789)
     (i32.const 3)))))
 (call $moonbit.decref
  (local.get $*tmp/1369))
 (call $moonbitlang/core/double/internal/ryu.umul128
  (local.tee $m/408
   (local.get $*tmp/1651))
  (local.get $mul1/407))
 (local.set $*bind/1/409)
 (local.tee $*bind/0/409)
 (local.set $*low1/410)
 (local.set $*high1/411
  (local.get $*bind/1/409))
 (call $moonbitlang/core/double/internal/ryu.umul128
  (local.get $m/408)
  (local.get $mul0/406))
 (local.set $*bind/1/412)
 (local.tee $*bind/0/412)
 (local.set $*low0/413)
 (local.set $sum/415
  (i64.add
   (local.tee $*high0/414
    (local.get $*bind/1/412))
   (local.get $*low1/410)))
 (local.set $high1/416
  (local.get $*high1/411))
 (if
  (i64.lt_u
   (local.get $sum/415)
   (local.get $*high0/414))
  (then
   (local.set $high1/416
    (i64.add
     (local.tee $*tmp/1344
      (local.get $high1/416))
     (i64.const 1))))
  (else))
 (local.set $*tmp/1359
  (i32.add
   (local.tee $*tmp/1365
    (local.tee $*tmp/1366
     (i32.shr_u
      (local.tee $*tmp/1367
       (local.tee $*tmp/1368
        (i32.mul
         (local.get $base2/404)
         (i32.const 1217359))))
      (i32.const 19))))
   (i32.const 1)))
 (local.set $*tmp/1360
  (i32.add
   (local.tee $*tmp/1361
    (local.tee $*tmp/1362
     (i32.shr_u
      (local.tee $*tmp/1363
       (local.tee $*tmp/1364
        (i32.mul
         (local.get $i/403)
         (i32.const 1217359))))
      (i32.const 19))))
   (i32.const 1)))
 (local.set $delta/417
  (i32.sub
   (local.get $*tmp/1359)
   (local.get $*tmp/1360)))
 (local.set $*tmp/1358
  (i32.sub
   (i32.const 64)
   (local.get $delta/417)))
 (local.set $*tmp/1356
  (i64.shl
   (local.get $sum/415)
   (i64.extend_i32_s
    (local.get $*tmp/1358))))
 (local.set $*tmp/1357
  (i64.shr_u
   (local.get $*low0/413)
   (i64.extend_i32_s
    (local.get $delta/417))))
 (local.set $*tmp/1348
  (i64.add
   (local.tee $*tmp/1355
    (i64.or
     (local.get $*tmp/1356)
     (local.get $*tmp/1357)))
   (i64.const 1)))
 (local.set $*p/729
  (i32.div_s
   (local.get $i/403)
   (i32.const 16)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gPOW5_INV_OFFSETS))
 (local.tee $*tmp/1354
  (global.get $moonbitlang/core/double/internal/ryu.gPOW5_INV_OFFSETS))
 (local.set $*idx/1787
  (local.get $*p/729))
 (local.set $*arr/1786)
 (call $moonbit.check_range
  (local.get $*idx/1787)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1786))
   (i32.const 1)))
 (local.set $*tmp/1650
  (i32.load offset=8
   (i32.add
    (local.get $*arr/1786)
    (i32.shl
     (local.get $*idx/1787)
     (i32.const 2)))))
 (call $moonbit.decref
  (local.get $*tmp/1354))
 (local.set $*tmp/1351
  (local.get $*tmp/1650))
 (local.set $*tmp/1352
  (i32.shl
   (local.tee $*tmp/1353
    (i32.rem_s
     (local.get $i/403)
     (i32.const 16)))
   (i32.const 1)))
 (local.set $*tmp/1349
  (i64.extend_i32_u
   (local.tee $*p/732
    (i32.and
     (local.tee $*tmp/1350
      (i32.shr_u
       (local.get $*tmp/1351)
       (local.get $*tmp/1352)))
     (i32.const 3)))))
 (local.set $a/418
  (i64.add
   (local.get $*tmp/1348)
   (local.get $*tmp/1349)))
 (local.set $*p/735
  (local.get $high1/416))
 (local.set $*tmp/1347
  (i32.sub
   (i32.const 64)
   (local.get $delta/417)))
 (local.set $*tmp/1345
  (i64.shl
   (local.get $*p/735)
   (i64.extend_i32_s
    (local.get $*tmp/1347))))
 (local.set $*tmp/1346
  (i64.shr_u
   (local.get $sum/415)
   (i64.extend_i32_s
    (local.get $delta/417))))
 (local.set $b/419
  (i64.or
   (local.get $*tmp/1345)
   (local.get $*tmp/1346)))
 (local.get $a/418)
 (local.get $b/419))
(func $moonbitlang/core/double/internal/ryu.double_computePow5 (param $i/385 i32) (result i64) (result i64)
 (local $base/384 i32)
 (local $base2/386 i32)
 (local $offset/387 i32)
 (local $mul0/388 i64)
 (local $mul1/389 i64)
 (local $m/390 i64)
 (local $*bind/0/391 i64)
 (local $*bind/1/391 i64)
 (local $*low1/392 i64)
 (local $*high1/393 i64)
 (local $*bind/0/394 i64)
 (local $*bind/1/394 i64)
 (local $*low0/395 i64)
 (local $*high0/396 i64)
 (local $sum/397 i64)
 (local $delta/399 i32)
 (local $a/400 i64)
 (local $b/401 i64)
 (local $*p/692 i32)
 (local $*p/695 i32)
 (local $*p/706 i32)
 (local $*p/709 i32)
 (local $*p/712 i64)
 (local $*tmp/1316 i64)
 (local $*tmp/1317 i64)
 (local $*tmp/1318 i64)
 (local $*tmp/1319 i32)
 (local $*tmp/1320 i64)
 (local $*tmp/1321 i64)
 (local $*tmp/1322 i32)
 (local $*tmp/1323 i32)
 (local $*tmp/1324 i32)
 (local $*tmp/1325 i32)
 (local $*tmp/1326 i32)
 (local $*tmp/1327 i64)
 (local $*tmp/1328 i64)
 (local $*tmp/1329 i32)
 (local $*tmp/1330 i32)
 (local $*tmp/1331 i32)
 (local $*tmp/1332 i32)
 (local $*tmp/1333 i32)
 (local $*tmp/1334 i32)
 (local $*tmp/1335 i32)
 (local $*tmp/1336 i32)
 (local $*tmp/1337 i32)
 (local $*tmp/1338 i32)
 (local $*tmp/1339 i32)
 (local $*tmp/1340 i32)
 (local $*tmp/1341 i32)
 (local $*tmp/1342 i32)
 (local $*tmp/1343 i32)
 (local $*tmp/1654 i32)
 (local $*tmp/1655 i64)
 (local $*tmp/1656 i64)
 (local $*tmp/1657 i64)
 (local $*arr/1794 i32)
 (local $*idx/1795 i32)
 (local $*arr/1796 i32)
 (local $*idx/1797 i32)
 (local $*arr/1798 i32)
 (local $*idx/1799 i32)
 (local $*arr/1800 i32)
 (local $*idx/1801 i32)
 (local $high1/398 i64)
 (local.set $base2/386
  (i32.mul
   (local.tee $base/384
    (i32.div_s
     (local.get $i/385)
     (i32.const 26)))
   (i32.const 26)))
 (local.set $offset/387
  (i32.sub
   (local.get $i/385)
   (local.get $base2/386)))
 (local.set $*p/692
  (i32.mul
   (local.get $base/384)
   (i32.const 2)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
 (local.tee $*tmp/1343
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
 (local.set $*idx/1801
  (local.get $*p/692))
 (local.set $*arr/1800)
 (call $moonbit.check_range
  (local.get $*idx/1801)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1800))
   (i32.const 1)))
 (local.set $*tmp/1657
  (i64.load offset=8
   (i32.add
    (local.get $*arr/1800)
    (i32.shl
     (local.get $*idx/1801)
     (i32.const 3)))))
 (call $moonbit.decref
  (local.get $*tmp/1343))
 (local.set $mul0/388
  (local.get $*tmp/1657))
 (local.set $*p/695
  (i32.add
   (local.tee $*tmp/1342
    (i32.mul
     (local.get $base/384)
     (i32.const 2)))
   (i32.const 1)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
 (local.tee $*tmp/1341
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_SPLIT2))
 (local.set $*idx/1799
  (local.get $*p/695))
 (local.set $*arr/1798)
 (call $moonbit.check_range
  (local.get $*idx/1799)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1798))
   (i32.const 1)))
 (local.set $*tmp/1656
  (i64.load offset=8
   (i32.add
    (local.get $*arr/1798)
    (i32.shl
     (local.get $*idx/1799)
     (i32.const 3)))))
 (call $moonbit.decref
  (local.get $*tmp/1341))
 (local.set $mul1/389
  (local.get $*tmp/1656))
 (if
  (i32.eq
   (local.get $offset/387)
   (i32.const 0))
  (then
   (local.get $mul0/388)
   (local.get $mul1/389)
   (return))
  (else))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
 (local.tee $*tmp/1340
  (global.get $moonbitlang/core/double/internal/ryu.gDOUBLE_POW5_TABLE))
 (local.set $*idx/1797
  (local.get $offset/387))
 (local.set $*arr/1796)
 (call $moonbit.check_range
  (local.get $*idx/1797)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1796))
   (i32.const 1)))
 (local.set $*tmp/1655
  (i64.load offset=8
   (i32.add
    (local.get $*arr/1796)
    (i32.shl
     (local.get $*idx/1797)
     (i32.const 3)))))
 (call $moonbit.decref
  (local.get $*tmp/1340))
 (call $moonbitlang/core/double/internal/ryu.umul128
  (local.tee $m/390
   (local.get $*tmp/1655))
  (local.get $mul1/389))
 (local.set $*bind/1/391)
 (local.tee $*bind/0/391)
 (local.set $*low1/392)
 (local.set $*high1/393
  (local.get $*bind/1/391))
 (call $moonbitlang/core/double/internal/ryu.umul128
  (local.get $m/390)
  (local.get $mul0/388))
 (local.set $*bind/1/394)
 (local.tee $*bind/0/394)
 (local.set $*low0/395)
 (local.set $sum/397
  (i64.add
   (local.tee $*high0/396
    (local.get $*bind/1/394))
   (local.get $*low1/392)))
 (local.set $high1/398
  (local.get $*high1/393))
 (if
  (i64.lt_u
   (local.get $sum/397)
   (local.get $*high0/396))
  (then
   (local.set $high1/398
    (i64.add
     (local.tee $*tmp/1316
      (local.get $high1/398))
     (i64.const 1))))
  (else))
 (local.set $*tmp/1330
  (i32.add
   (local.tee $*tmp/1336
    (local.tee $*tmp/1337
     (i32.shr_u
      (local.tee $*tmp/1338
       (local.tee $*tmp/1339
        (i32.mul
         (local.get $i/385)
         (i32.const 1217359))))
      (i32.const 19))))
   (i32.const 1)))
 (local.set $*tmp/1331
  (i32.add
   (local.tee $*tmp/1332
    (local.tee $*tmp/1333
     (i32.shr_u
      (local.tee $*tmp/1334
       (local.tee $*tmp/1335
        (i32.mul
         (local.get $base2/386)
         (i32.const 1217359))))
      (i32.const 19))))
   (i32.const 1)))
 (local.set $delta/399
  (i32.sub
   (local.get $*tmp/1330)
   (local.get $*tmp/1331)))
 (local.set $*tmp/1329
  (i32.sub
   (i32.const 64)
   (local.get $delta/399)))
 (local.set $*tmp/1327
  (i64.shl
   (local.get $sum/397)
   (i64.extend_i32_s
    (local.get $*tmp/1329))))
 (local.set $*tmp/1328
  (i64.shr_u
   (local.get $*low0/395)
   (i64.extend_i32_s
    (local.get $delta/399))))
 (local.set $*tmp/1320
  (i64.or
   (local.get $*tmp/1327)
   (local.get $*tmp/1328)))
 (local.set $*p/706
  (i32.div_s
   (local.get $i/385)
   (i32.const 16)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/double/internal/ryu.gPOW5_OFFSETS))
 (local.tee $*tmp/1326
  (global.get $moonbitlang/core/double/internal/ryu.gPOW5_OFFSETS))
 (local.set $*idx/1795
  (local.get $*p/706))
 (local.set $*arr/1794)
 (call $moonbit.check_range
  (local.get $*idx/1795)
  (i32.const 0)
  (i32.sub
   (call $moonbit.array_length
    (local.get $*arr/1794))
   (i32.const 1)))
 (local.set $*tmp/1654
  (i32.load offset=8
   (i32.add
    (local.get $*arr/1794)
    (i32.shl
     (local.get $*idx/1795)
     (i32.const 2)))))
 (call $moonbit.decref
  (local.get $*tmp/1326))
 (local.set $*tmp/1323
  (local.get $*tmp/1654))
 (local.set $*tmp/1324
  (i32.shl
   (local.tee $*tmp/1325
    (i32.rem_s
     (local.get $i/385)
     (i32.const 16)))
   (i32.const 1)))
 (local.set $*tmp/1321
  (i64.extend_i32_u
   (local.tee $*p/709
    (i32.and
     (local.tee $*tmp/1322
      (i32.shr_u
       (local.get $*tmp/1323)
       (local.get $*tmp/1324)))
     (i32.const 3)))))
 (local.set $a/400
  (i64.add
   (local.get $*tmp/1320)
   (local.get $*tmp/1321)))
 (local.set $*p/712
  (local.get $high1/398))
 (local.set $*tmp/1319
  (i32.sub
   (i32.const 64)
   (local.get $delta/399)))
 (local.set $*tmp/1317
  (i64.shl
   (local.get $*p/712)
   (i64.extend_i32_s
    (local.get $*tmp/1319))))
 (local.set $*tmp/1318
  (i64.shr_u
   (local.get $sum/397)
   (i64.extend_i32_s
    (local.get $delta/399))))
 (local.set $b/401
  (i64.or
   (local.get $*tmp/1317)
   (local.get $*tmp/1318)))
 (local.get $a/400)
 (local.get $b/401))
(func $moonbitlang/core/double/internal/ryu.mulShiftAll64 (param $m/358 i64) (param $mul/0/355 i64) (param $mul/1/355 i64) (param $j/371 i32) (param $mmShift/373 i32) (result i64) (result i64) (result i64)
 (local $*mul0/354 i64)
 (local $*mul1/356 i64)
 (local $m/357 i64)
 (local $*bind/0/359 i64)
 (local $*bind/1/359 i64)
 (local $*lo/360 i64)
 (local $*tmp/361 i64)
 (local $*bind/0/362 i64)
 (local $*bind/1/362 i64)
 (local $*lo2/363 i64)
 (local $*hi2/364 i64)
 (local $mid/365 i64)
 (local $hi/366 i64)
 (local $lo2/367 i64)
 (local $mid2/368 i64)
 (local $hi2/369 i64)
 (local $vp/370 i64)
 (local $lo3/374 i64)
 (local $mid3/375 i64)
 (local $hi3/376 i64)
 (local $lo3/377 i64)
 (local $mid3/378 i64)
 (local $hi3/379 i64)
 (local $lo4/380 i64)
 (local $mid4/381 i64)
 (local $hi4/382 i64)
 (local $vr/383 i64)
 (local $*p/680 i32)
 (local $*p/683 i32)
 (local $*p/686 i32)
 (local $*p/689 i32)
 (local $*tmp/1286 i64)
 (local $*tmp/1287 i64)
 (local $*tmp/1288 i32)
 (local $*tmp/1289 i32)
 (local $*tmp/1290 i64)
 (local $*tmp/1291 i64)
 (local $*tmp/1292 i64)
 (local $*tmp/1293 i64)
 (local $*tmp/1294 i64)
 (local $*tmp/1295 i32)
 (local $*tmp/1296 i64)
 (local $*tmp/1297 i64)
 (local $*tmp/1298 i64)
 (local $*tmp/1299 i64)
 (local $*tmp/1300 i64)
 (local $*tmp/1301 i64)
 (local $*tmp/1302 i64)
 (local $*tmp/1303 i64)
 (local $*tmp/1304 i64)
 (local $*tmp/1305 i64)
 (local $*tmp/1306 i32)
 (local $*tmp/1307 i32)
 (local $*tmp/1308 i64)
 (local $*tmp/1309 i64)
 (local $*tmp/1310 i32)
 (local $*tmp/1311 i32)
 (local $*tmp/1312 i64)
 (local $*tmp/1313 i64)
 (local $*tmp/1314 i64)
 (local $*tmp/1315 i64)
 (local $vm/372 i64)
 (local.set $*mul0/354
  (local.get $mul/0/355))
 (local.set $*mul1/356
  (local.get $mul/1/355))
 (call $moonbitlang/core/double/internal/ryu.umul128
  (local.tee $m/357
   (i64.shl
    (local.get $m/358)
    (i64.extend_i32_s
     (i32.const 1))))
  (local.get $*mul0/354))
 (local.set $*bind/1/359)
 (local.tee $*bind/0/359)
 (local.set $*lo/360)
 (local.set $*tmp/361
  (local.get $*bind/1/359))
 (call $moonbitlang/core/double/internal/ryu.umul128
  (local.get $m/357)
  (local.get $*mul1/356))
 (local.set $*bind/1/362)
 (local.tee $*bind/0/362)
 (local.set $*lo2/363)
 (local.set $*hi2/364
  (local.get $*bind/1/362))
 (local.set $*tmp/1315
  (if (result i64)
   (i64.lt_u
    (local.tee $mid/365
     (i64.add
      (local.get $*tmp/361)
      (local.get $*lo2/363)))
    (local.get $*tmp/361))
   (then
    (i64.const 1))
   (else
    (i64.const 0))))
 (local.set $hi/366
  (i64.add
   (local.get $*hi2/364)
   (local.get $*tmp/1315)))
 (local.set $lo2/367
  (i64.add
   (local.get $*lo/360)
   (local.get $*mul0/354)))
 (local.set $*tmp/1313
  (i64.add
   (local.get $mid/365)
   (local.get $*mul1/356)))
 (local.set $*tmp/1314
  (if (result i64)
   (i64.lt_u
    (local.get $lo2/367)
    (local.get $*lo/360))
   (then
    (i64.const 1))
   (else
    (i64.const 0))))
 (local.set $*tmp/1312
  (if (result i64)
   (i64.lt_u
    (local.tee $mid2/368
     (i64.add
      (local.get $*tmp/1313)
      (local.get $*tmp/1314)))
    (local.get $mid/365))
   (then
    (i64.const 1))
   (else
    (i64.const 0))))
 (local.set $hi2/369
  (i64.add
   (local.get $hi/366)
   (local.get $*tmp/1312)))
 (local.set $*p/680
  (i32.sub
   (local.tee $*tmp/1311
    (i32.sub
     (local.get $j/371)
     (i32.const 64)))
   (i32.const 1)))
 (local.set $*tmp/1310
  (i32.sub
   (i32.const 64)
   (local.get $*p/680)))
 (local.set $*tmp/1308
  (i64.shl
   (local.get $hi2/369)
   (i64.extend_i32_s
    (local.get $*tmp/1310))))
 (local.set $*tmp/1309
  (i64.shr_u
   (local.get $mid2/368)
   (i64.extend_i32_s
    (local.get $*p/680))))
 (local.set $vp/370
  (i64.or
   (local.get $*tmp/1308)
   (local.get $*tmp/1309)))
 (local.set $vm/372
  (i64.const 0))
 (if
  (local.get $mmShift/373)
  (then
   (local.set $lo3/374
    (i64.sub
     (local.get $*lo/360)
     (local.get $*mul0/354)))
   (local.set $*tmp/1291
    (i64.sub
     (local.get $mid/365)
     (local.get $*mul1/356)))
   (local.set $*tmp/1292
    (if (result i64)
     (i64.lt_u
      (local.get $*lo/360)
      (local.get $lo3/374))
     (then
      (i64.const 1))
     (else
      (i64.const 0))))
   (local.set $mid3/375
    (i64.sub
     (local.get $*tmp/1291)
     (local.get $*tmp/1292)))
   (local.set $*tmp/1290
    (if (result i64)
     (i64.lt_u
      (local.get $mid/365)
      (local.get $mid3/375))
     (then
      (i64.const 1))
     (else
      (i64.const 0))))
   (local.set $hi3/376
    (i64.sub
     (local.get $hi/366)
     (local.get $*tmp/1290)))
   (local.set $*p/683
    (i32.sub
     (local.tee $*tmp/1289
      (i32.sub
       (local.get $j/371)
       (i32.const 64)))
     (i32.const 1)))
   (local.set $*tmp/1288
    (i32.sub
     (i32.const 64)
     (local.get $*p/683)))
   (local.set $*tmp/1286
    (i64.shl
     (local.get $hi3/376)
     (i64.extend_i32_s
      (local.get $*tmp/1288))))
   (local.set $*tmp/1287
    (i64.shr_u
     (local.get $mid3/375)
     (i64.extend_i32_s
      (local.get $*p/683))))
   (local.set $vm/372
    (i64.or
     (local.get $*tmp/1286)
     (local.get $*tmp/1287))))
  (else
   (local.set $lo3/377
    (i64.add
     (local.get $*lo/360)
     (local.get $*lo/360)))
   (local.set $*tmp/1301
    (i64.add
     (local.get $mid/365)
     (local.get $mid/365)))
   (local.set $*tmp/1302
    (if (result i64)
     (i64.lt_u
      (local.get $lo3/377)
      (local.get $*lo/360))
     (then
      (i64.const 1))
     (else
      (i64.const 0))))
   (local.set $mid3/378
    (i64.add
     (local.get $*tmp/1301)
     (local.get $*tmp/1302)))
   (local.set $*tmp/1299
    (i64.add
     (local.get $hi/366)
     (local.get $hi/366)))
   (local.set $*tmp/1300
    (if (result i64)
     (i64.lt_u
      (local.get $mid3/378)
      (local.get $mid/365))
     (then
      (i64.const 1))
     (else
      (i64.const 0))))
   (local.set $hi3/379
    (i64.add
     (local.get $*tmp/1299)
     (local.get $*tmp/1300)))
   (local.set $lo4/380
    (i64.sub
     (local.get $lo3/377)
     (local.get $*mul0/354)))
   (local.set $*tmp/1297
    (i64.sub
     (local.get $mid3/378)
     (local.get $*mul1/356)))
   (local.set $*tmp/1298
    (if (result i64)
     (i64.lt_u
      (local.get $lo3/377)
      (local.get $lo4/380))
     (then
      (i64.const 1))
     (else
      (i64.const 0))))
   (local.set $mid4/381
    (i64.sub
     (local.get $*tmp/1297)
     (local.get $*tmp/1298)))
   (local.set $*tmp/1296
    (if (result i64)
     (i64.lt_u
      (local.get $mid3/378)
      (local.get $mid4/381))
     (then
      (i64.const 1))
     (else
      (i64.const 0))))
   (local.set $hi4/382
    (i64.sub
     (local.get $hi3/379)
     (local.get $*tmp/1296)))
   (local.set $*p/686
    (i32.sub
     (local.get $j/371)
     (i32.const 64)))
   (local.set $*tmp/1295
    (i32.sub
     (i32.const 64)
     (local.get $*p/686)))
   (local.set $*tmp/1293
    (i64.shl
     (local.get $hi4/382)
     (i64.extend_i32_s
      (local.get $*tmp/1295))))
   (local.set $*tmp/1294
    (i64.shr_u
     (local.get $mid4/381)
     (i64.extend_i32_s
      (local.get $*p/686))))
   (local.set $vm/372
    (i64.or
     (local.get $*tmp/1293)
     (local.get $*tmp/1294)))))
 (local.set $*p/689
  (i32.sub
   (local.tee $*tmp/1307
    (i32.sub
     (local.get $j/371)
     (i32.const 64)))
   (i32.const 1)))
 (local.set $*tmp/1306
  (i32.sub
   (i32.const 64)
   (local.get $*p/689)))
 (local.set $*tmp/1304
  (i64.shl
   (local.get $hi/366)
   (i64.extend_i32_s
    (local.get $*tmp/1306))))
 (local.set $*tmp/1305
  (i64.shr_u
   (local.get $mid/365)
   (i64.extend_i32_s
    (local.get $*p/689))))
 (local.set $vr/383
  (i64.or
   (local.get $*tmp/1304)
   (local.get $*tmp/1305)))
 (local.set $*tmp/1303
  (local.get $vm/372))
 (local.get $vr/383)
 (local.get $vp/370)
 (local.get $*tmp/1303))
(func $moonbitlang/core/double/internal/ryu.multipleOfPowerOf5 (param $value/350 i64) (param $p/351 i32) (result i32)
 (local $*tmp/1282 i32)
 (i32.ge_s
  (local.tee $*tmp/1282
   (call $moonbitlang/core/double/internal/ryu.pow5Factor
    (local.get $value/350)))
  (local.get $p/351)))
(func $moonbitlang/core/double/internal/ryu.pow5Factor (param $value/346 i64) (result i32)
 (local $*tmp/1270 i64)
 (local $*tmp/1271 i64)
 (local $*tmp/1272 i64)
 (local $*tmp/1273 i64)
 (local $*tmp/1274 i64)
 (local $*tmp/1275 i64)
 (local $*tmp/1276 i64)
 (local $*tmp/1277 i64)
 (local $*tmp/1278 i32)
 (local $*tmp/1279 i32)
 (local $*tmp/1280 i32)
 (local $*tmp/1281 i64)
 (local $count/347 i32)
 (local $value/348 i64)
 (local.tee $*tmp/1270
  (i64.rem_u
   (local.get $value/346)
   (i64.const 5)))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 0)
   (return))
  (else))
 (local.tee $*tmp/1271
  (i64.rem_u
   (local.get $value/346)
   (i64.const 25)))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.tee $*tmp/1272
  (i64.rem_u
   (local.get $value/346)
   (i64.const 125)))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 2)
   (return))
  (else))
 (local.tee $*tmp/1273
  (i64.rem_u
   (local.get $value/346)
   (i64.const 625)))
 (if
  (i64.ne
   (i64.const 0))
  (then
   (i32.const 3)
   (return))
  (else))
 (local.set $count/347
  (i32.const 4))
 (local.set $value/348
  (i64.div_u
   (local.get $value/346)
   (i64.const 625)))
 (loop $loop:349
  (if
   (i64.gt_u
    (local.tee $*tmp/1274
     (local.get $value/348))
    (i64.const 0))
   (then
    (local.tee $*tmp/1275
     (i64.rem_u
      (local.tee $*tmp/1276
       (local.get $value/348))
      (i64.const 5)))
    (if
     (i64.ne
      (i64.const 0))
     (then
      (local.get $count/347)
      (return))
     (else))
    (local.set $value/348
     (i64.div_u
      (local.tee $*tmp/1277
       (local.get $value/348))
      (i64.const 5)))
    (local.set $count/347
     (i32.add
      (local.tee $*tmp/1278
       (local.get $count/347))
      (i32.const 1)))
    (br $loop:349))
   (else)))
 (local.set $*tmp/1280
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|UInt64|
   (local.tee $*tmp/1281
    (local.get $value/348))))
 (call $moonbitlang/core/builtin.abort|Int|
  (local.tee $*tmp/1279
   (call $moonbit.add_string
    (i32.const 10144)
    (local.get $*tmp/1280)))
  (i32.const 10016)))
(func $moonbitlang/core/double/internal/ryu.umul128 (param $a/333 i64) (param $b/336 i64) (result i64) (result i64)
 (local $aLo/332 i64)
 (local $aHi/334 i64)
 (local $bLo/335 i64)
 (local $bHi/337 i64)
 (local $x/338 i64)
 (local $y/339 i64)
 (local $z/340 i64)
 (local $w/341 i64)
 (local $lo/342 i64)
 (local $*tmp/1259 i64)
 (local $*tmp/1260 i64)
 (local $*tmp/1261 i64)
 (local $*tmp/1262 i64)
 (local $*tmp/1263 i64)
 (local $*tmp/1264 i64)
 (local $*tmp/1265 i64)
 (local $*tmp/1266 i64)
 (local.set $aLo/332
  (i64.and
   (local.get $a/333)
   (i64.const 4294967295)))
 (local.set $aHi/334
  (i64.shr_u
   (local.get $a/333)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $bLo/335
  (i64.and
   (local.get $b/336)
   (i64.const 4294967295)))
 (local.set $bHi/337
  (i64.shr_u
   (local.get $b/336)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $x/338
  (i64.mul
   (local.get $aLo/332)
   (local.get $bLo/335)))
 (local.set $*tmp/1265
  (i64.mul
   (local.get $aHi/334)
   (local.get $bLo/335)))
 (local.set $*tmp/1266
  (i64.shr_u
   (local.get $x/338)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $y/339
  (i64.add
   (local.get $*tmp/1265)
   (local.get $*tmp/1266)))
 (local.set $*tmp/1263
  (i64.mul
   (local.get $aLo/332)
   (local.get $bHi/337)))
 (local.set $*tmp/1264
  (i64.and
   (local.get $y/339)
   (i64.const 4294967295)))
 (local.set $z/340
  (i64.add
   (local.get $*tmp/1263)
   (local.get $*tmp/1264)))
 (local.set $*tmp/1261
  (i64.mul
   (local.get $aHi/334)
   (local.get $bHi/337)))
 (local.set $*tmp/1262
  (i64.shr_u
   (local.get $y/339)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $*tmp/1259
  (i64.add
   (local.get $*tmp/1261)
   (local.get $*tmp/1262)))
 (local.set $*tmp/1260
  (i64.shr_u
   (local.get $z/340)
   (i64.extend_i32_s
    (i32.const 32))))
 (local.set $w/341
  (i64.add
   (local.get $*tmp/1259)
   (local.get $*tmp/1260)))
 (local.tee $lo/342
  (i64.mul
   (local.get $a/333)
   (local.get $b/336)))
 (local.get $w/341))
(func $moonbitlang/core/double/internal/ryu.string_from_bytes (param $bytes/327 i32) (param $from/331 i32) (param $to/329 i32) (result i32)
 (local $buf/326 i32)
 (local $i/328 i32)
 (local $*p/677 i32)
 (local $*tmp/1255 i32)
 (local $*tmp/1256 i32)
 (local $*tmp/1257 i32)
 (local $*tmp/1258 i32)
 (local $*arr/1802 i32)
 (local $*idx/1803 i32)
 (local.set $buf/326
  (call $@moonbitlang/core/builtin.StringBuilder::new.inner
   (local.tee $*tmp/1258
    (call $moonbit.array_length
     (local.get $bytes/327)))))
 (local.get $from/331)
 (loop $loop:330 (param i32)
  (local.tee $i/328)
  (local.get $to/329)
  (i32.lt_s)
  (if
   (then
    (local.get $bytes/327)
    (local.set $*idx/1803
     (local.get $i/328))
    (local.set $*arr/1802)
    (call $moonbit.check_range
     (local.get $*idx/1803)
     (i32.const 0)
     (i32.sub
      (call $moonbit.array_length
       (local.get $*arr/1802))
      (i32.const 1)))
    (local.set $*tmp/1255
     (local.tee $*tmp/1256
      (local.tee $*p/677
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1802)
         (local.get $*idx/1803))))))
    (call $moonbit.incref
     (local.get $buf/326))
    (drop
     (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
      (local.get $buf/326)
      (local.get $*tmp/1255)))
    (local.tee $*tmp/1257
     (i32.add
      (local.get $i/328)
      (i32.const 1)))
    (br $loop:330))
   (else
    (call $moonbit.decref
     (local.get $bytes/327)))))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $buf/326)))
(func $moonbitlang/core/double/internal/ryu.copy_special_str (param $sign/322 i32) (param $exponent/323 i32) (param $mantissa/320 i32) (result i32)
 (local $s/321 i32)
 (if
  (local.get $mantissa/320)
  (then
   (i32.const 10288)
   (return))
  (else))
 (local.set $s/321
  (if (result i32)
   (local.get $sign/322)
   (then
    (i32.const 10256))
   (else
    (i32.const 10272))))
 (if
  (local.get $exponent/323)
  (then
   (call $moonbit.add_string
    (local.get $s/321)
    (i32.const 10224))
   (return))
  (else))
 (call $moonbit.add_string
  (local.get $s/321)
  (i32.const 10208)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output (param $self/317 i32) (param $logger/0/318 i32) (param $logger/1/318 i32) (result i32)
 (local $*tmp/1243 i32)
 (local $*tmp/1244 i32)
 (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output
  (local.tee $*tmp/1243
   (call $@moonbitlang/core/builtin.SourceLocRepr::parse
    (local.tee $*tmp/1244
     (local.get $self/317))))
  (local.get $logger/0/318)
  (local.get $logger/1/318)))
(func $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLocRepr::output (param $self/303 i32) (param $logger/0/316 i32) (param $logger/1/316 i32) (result i32)
 (local $pkg/0/302 i32)
 (local $pkg/1/302 i32)
 (local $pkg/2/302 i32)
 (local $*bind/304 i64)
 (local $*bind/305 i32)
 (local $*Some/306 i64)
 (local $*first_slash/307 i32)
 (local $*bind/308 i64)
 (local $*Some/309 i64)
 (local $*second_slash/310 i32)
 (local $module_name_end/311 i32)
 (local $*module_name/0/312 i32)
 (local $*module_name/1/312 i32)
 (local $*module_name/2/312 i32)
 (local $*package_name/313 i32)
 (local $*Some/314 i32)
 (local $*pkg_name/0/315 i32)
 (local $*pkg_name/1/315 i32)
 (local $*pkg_name/2/315 i32)
 (local $*bind/0/1222 i32)
 (local $*bind/1/1222 i32)
 (local $*bind/0/1223 i32)
 (local $*bind/1/1223 i32)
 (local $filename/0/1224 i32)
 (local $filename/1/1224 i32)
 (local $filename/2/1224 i32)
 (local $start_line/0/1225 i32)
 (local $start_line/1/1225 i32)
 (local $start_line/2/1225 i32)
 (local $start_column/0/1226 i32)
 (local $start_column/1/1226 i32)
 (local $start_column/2/1226 i32)
 (local $end_line/0/1227 i32)
 (local $end_line/1/1227 i32)
 (local $end_line/2/1227 i32)
 (local $end_column/0/1228 i32)
 (local $end_column/1/1228 i32)
 (local $end_column/2/1228 i32)
 (local $None/1229 i32)
 (local $None/1230 i32)
 (local $*tmp/0/1231 i32)
 (local $*tmp/1/1231 i32)
 (local $*tmp/2/1231 i32)
 (local $Some/1232 i32)
 (local $*tmp/0/1233 i32)
 (local $*tmp/1/1233 i32)
 (local $*tmp/2/1233 i32)
 (local $*tmp/1234 i32)
 (local $*tmp/1235 i64)
 (local $*tmp/1236 i32)
 (local $*tmp/0/1237 i32)
 (local $*tmp/1/1237 i32)
 (local $*tmp/2/1237 i32)
 (local $*tmp/0/1238 i32)
 (local $*tmp/1/1238 i32)
 (local $*tmp/2/1238 i32)
 (local $*tmp/1239 i32)
 (local $*tmp/1240 i32)
 (local $*tmp/0/1241 i32)
 (local $*tmp/1/1241 i32)
 (local $*tmp/2/1241 i32)
 (local $*tmp/1242 i32)
 (local $*field/0/1658 i32)
 (local $*field/1/1658 i32)
 (local $*field/2/1658 i32)
 (local $*field/0/1659 i32)
 (local $*field/1/1659 i32)
 (local $*field/2/1659 i32)
 (local $*field/0/1660 i32)
 (local $*field/1/1660 i32)
 (local $*field/2/1660 i32)
 (local $*field/0/1661 i32)
 (local $*field/1/1661 i32)
 (local $*field/2/1661 i32)
 (local $*field/0/1662 i32)
 (local $*field/1/1662 i32)
 (local $*field/2/1662 i32)
 (local $*field/0/1663 i32)
 (local $*field/1/1663 i32)
 (local $*field/2/1663 i32)
 (local $*field/1664 i32)
 (local $*field/0/1665 i32)
 (local $*field/1/1665 i32)
 (local $*field/2/1665 i32)
 (local $*field/0/1666 i32)
 (local $*field/1/1666 i32)
 (local $*field/2/1666 i32)
 (local $*cnt/1725 i32)
 (local $*new_cnt/1726 i32)
 (local $*cnt/1727 i32)
 (local $*new_cnt/1728 i32)
 (local $*cnt/1729 i32)
 (local $*field/0/1730 i32)
 (local $*field/1/1730 i32)
 (local $*field/2/1730 i32)
 (local $*field/0/1731 i32)
 (local $*field/1/1731 i32)
 (local $*field/2/1731 i32)
 (local $*field/0/1732 i32)
 (local $*field/1/1732 i32)
 (local $*field/2/1732 i32)
 (local $*field/0/1733 i32)
 (local $*field/1/1733 i32)
 (local $*field/2/1733 i32)
 (local $*field/0/1734 i32)
 (local $*field/1/1734 i32)
 (local $*field/2/1734 i32)
 (local $*new_cnt/1735 i32)
 (local $*tag/1804 i32)
 (local $ptr/1805 i32)
 (local $ptr/1806 i32)
 (local $ptr/1807 i32)
 (local $ptr/1808 i32)
 (i32.load offset=56
  (local.get $self/303))
 (i32.load offset=8
  (local.get $self/303))
 (local.set $*field/2/1666
  (i32.load offset=12
   (local.get $self/303)))
 (local.set $*field/1/1666)
 (local.tee $*field/0/1666)
 (local.get $*field/1/1666)
 (local.set $pkg/2/302
  (local.get $*field/2/1666))
 (local.set $pkg/1/302)
 (local.set $pkg/0/302)
 (local.set $*tmp/1242
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.output.*bind|8190)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.output.*bind|8190))
 (global.get $moonbitlang/core/builtin.output.*bind|8190)
 (i32.const 0)
 (local.set $*tmp/2/1241
  (local.get $*tmp/1242))
 (local.set $*tmp/1/1241)
 (local.set $*tmp/0/1241)
 (call $moonbit.incref
  (local.get $pkg/0/302))
 (call $moonbit.incref
  (local.get $pkg/0/302))
 (i32.load offset=16
  (local.tee $*bind/305
   (if (result i32)
    (i64.eq
     (local.tee $*bind/304
      (call $StringView::find
       (local.get $pkg/0/302)
       (local.get $pkg/1/302)
       (local.get $pkg/2/302)
       (local.get $*tmp/0/1241)
       (local.get $*tmp/1/1241)
       (local.get $*tmp/2/1241)))
     (i64.const 4294967296))
    (then
     (local.set $None/1229
      (i32.const 10304))
     (i32.store offset=4
      (local.tee $ptr/1805
       (call $moonbit.gc.malloc
        (i32.const 16)))
      (i32.const 2097664))
     (i32.store offset=20
      (local.get $ptr/1805)
      (local.get $None/1229))
     (i32.store offset=16
      (local.get $ptr/1805)
      (local.get $pkg/0/302))
     (i32.store offset=8
      (local.get $ptr/1805)
      (local.get $pkg/1/302))
     (i32.store offset=12
      (local.get $ptr/1805)
      (local.get $pkg/2/302))
     (local.get $ptr/1805))
    (else
     (local.set $*tmp/1240
      (i32.add
       (local.tee $*first_slash/307
        (i32.wrap_i64
         (local.tee $*Some/306
          (local.get $*bind/304))))
       (i32.const 1)))
     (call $moonbit.incref
      (local.get $pkg/0/302))
     (call $StringView::view.inner
      (local.get $pkg/0/302)
      (local.get $pkg/1/302)
      (local.get $pkg/2/302)
      (local.get $*tmp/1240)
      (i64.const 4294967296))
     (local.set $*tmp/2/1237)
     (local.set $*tmp/1/1237)
     (local.set $*tmp/0/1237)
     (local.set $*tmp/1239
      (call $moonbit.array_length
       (global.get $moonbitlang/core/builtin.output.*bind|8184)))
     (call $moonbit.incref
      (global.get $moonbitlang/core/builtin.output.*bind|8184))
     (global.get $moonbitlang/core/builtin.output.*bind|8184)
     (i32.const 0)
     (local.set $*tmp/2/1238
      (local.get $*tmp/1239))
     (local.set $*tmp/1/1238)
     (local.set $*tmp/0/1238)
     (if (result i32)
      (i64.eq
       (local.tee $*bind/308
        (call $StringView::find
         (local.get $*tmp/0/1237)
         (local.get $*tmp/1/1237)
         (local.get $*tmp/2/1237)
         (local.get $*tmp/0/1238)
         (local.get $*tmp/1/1238)
         (local.get $*tmp/2/1238)))
       (i64.const 4294967296))
      (then
       (local.set $None/1230
        (i32.const 10304))
       (i32.store offset=4
        (local.tee $ptr/1806
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1806)
        (local.get $None/1230))
       (i32.store offset=16
        (local.get $ptr/1806)
        (local.get $pkg/0/302))
       (i32.store offset=8
        (local.get $ptr/1806)
        (local.get $pkg/1/302))
       (i32.store offset=12
        (local.get $ptr/1806)
        (local.get $pkg/2/302))
       (local.get $ptr/1806))
      (else
       (local.set $*second_slash/310
        (i32.wrap_i64
         (local.tee $*Some/309
          (local.get $*bind/308))))
       (local.set $*tmp/1235
        (i64.extend_i32_s
         (local.tee $module_name_end/311
          (i32.add
           (local.tee $*tmp/1236
            (i32.add
             (local.get $*first_slash/307)
             (i32.const 1)))
           (local.get $*second_slash/310)))))
       (call $moonbit.incref
        (local.get $pkg/0/302))
       (call $StringView::view.inner
        (local.get $pkg/0/302)
        (local.get $pkg/1/302)
        (local.get $pkg/2/302)
        (i32.const 0)
        (local.get $*tmp/1235))
       (local.set $*tmp/2/1231)
       (local.set $*tmp/1/1231)
       (local.set $*tmp/0/1231)
       (local.set $*tmp/1234
        (i32.add
         (local.get $module_name_end/311)
         (i32.const 1)))
       (call $StringView::view.inner
        (local.get $pkg/0/302)
        (local.get $pkg/1/302)
        (local.get $pkg/2/302)
        (local.get $*tmp/1234)
        (i64.const 4294967296))
       (local.set $*tmp/2/1233)
       (local.set $*tmp/1/1233)
       (local.set $*tmp/0/1233)
       (i32.store offset=4
        (local.tee $ptr/1808
         (call $moonbit.gc.malloc
          (i32.const 12)))
        (i32.const 2097409))
       (i32.store offset=16
        (local.get $ptr/1808)
        (local.get $*tmp/0/1233))
       (i32.store offset=8
        (local.get $ptr/1808)
        (local.get $*tmp/1/1233))
       (i32.store offset=12
        (local.get $ptr/1808)
        (local.get $*tmp/2/1233))
       (local.set $Some/1232
        (local.get $ptr/1808))
       (i32.store offset=4
        (local.tee $ptr/1807
         (call $moonbit.gc.malloc
          (i32.const 16)))
        (i32.const 2097664))
       (i32.store offset=20
        (local.get $ptr/1807)
        (local.get $Some/1232))
       (i32.store offset=16
        (local.get $ptr/1807)
        (local.get $*tmp/0/1231))
       (i32.store offset=8
        (local.get $ptr/1807)
        (local.get $*tmp/1/1231))
       (i32.store offset=12
        (local.get $ptr/1807)
        (local.get $*tmp/2/1231))
       (local.get $ptr/1807)))))))
 (i32.load offset=8
  (local.get $*bind/305))
 (local.set $*field/2/1665
  (i32.load offset=12
   (local.get $*bind/305)))
 (local.set $*field/1/1665)
 (local.tee $*field/0/1665)
 (local.get $*field/1/1665)
 (local.set $*module_name/2/312
  (local.get $*field/2/1665))
 (local.set $*module_name/1/312)
 (local.set $*module_name/0/312)
 (local.set $*field/1664
  (i32.load offset=20
   (local.get $*bind/305)))
 (if
  (i32.gt_s
   (local.tee $*cnt/1725
    (i32.load
     (local.get $*bind/305)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/1664))
   (call $moonbit.incref
    (local.get $*module_name/0/312))
   (local.set $*new_cnt/1726
    (i32.sub
     (local.get $*cnt/1725)
     (i32.const 1)))
   (i32.store
    (local.get $*bind/305)
    (local.get $*new_cnt/1726)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1725)
     (i32.const 1))
    (then
     (call $moonbit.free
      (local.get $*bind/305)))
    (else))))
 (if
  (i32.eq
   (local.tee $*tag/1804
    (call $moonbit.get_tag
     (local.tee $*package_name/313
      (local.get $*field/1664))))
   (i32.const 1))
  (then
   (i32.load offset=16
    (local.tee $*Some/314
     (local.get $*package_name/313)))
   (i32.load offset=8
    (local.get $*Some/314))
   (local.set $*field/2/1663
    (i32.load offset=12
     (local.get $*Some/314)))
   (local.set $*field/1/1663)
   (local.set $*field/0/1663)
   (if
    (i32.gt_s
     (local.tee $*cnt/1727
      (i32.load
       (local.get $*Some/314)))
     (i32.const 1))
    (then
     (call $moonbit.incref
      (local.get $*field/0/1663))
     (local.set $*new_cnt/1728
      (i32.sub
       (local.get $*cnt/1727)
       (i32.const 1)))
     (i32.store
      (local.get $*Some/314)
      (local.get $*new_cnt/1728)))
    (else
     (if
      (i32.eq
       (local.get $*cnt/1727)
       (i32.const 1))
      (then
       (call $moonbit.free
        (local.get $*Some/314)))
      (else))))
   (local.get $*field/0/1663)
   (local.get $*field/1/1663)
   (local.set $*pkg_name/2/315
    (local.get $*field/2/1663))
   (local.set $*pkg_name/1/315)
   (local.set $*pkg_name/0/315)
   (if
    (local.get $logger/1/316)
    (then
     (call $moonbit.incref
      (local.get $logger/1/316)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
     (local.get $logger/1/316)
     (local.get $*pkg_name/0/315)
     (local.get $*pkg_name/1/315)
     (local.get $*pkg_name/2/315)
     (i32.load offset=16
      (local.get $logger/0/316))))
   (local.get $logger/0/316)
   (local.set $*bind/1/1222
    (local.get $logger/1/316))
   (local.set $*bind/0/1222)
   (if
    (local.get $*bind/1/1222)
    (then
     (call $moonbit.incref
      (local.get $*bind/1/1222)))
    (else))
   (drop
    (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
     (local.get $*bind/1/1222)
     (i32.const 47)
     (i32.load offset=20
      (local.get $*bind/0/1222)))))
  (else
   (call $moonbit.decref
    (local.get $*package_name/313))))
 (i32.load offset=60
  (local.get $self/303))
 (i32.load offset=16
  (local.get $self/303))
 (local.set $*field/2/1662
  (i32.load offset=20
   (local.get $self/303)))
 (local.set $*field/1/1662)
 (local.tee $*field/0/1662)
 (local.get $*field/1/1662)
 (local.set $filename/2/1224
  (local.get $*field/2/1662))
 (local.set $filename/1/1224)
 (local.tee $filename/0/1224)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/316)
   (local.get $filename/0/1224)
   (local.get $filename/1/1224)
   (local.get $filename/2/1224)
   (i32.load offset=16
    (local.get $logger/0/316))))
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/316)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/316))))
 (i32.load offset=64
  (local.get $self/303))
 (i32.load offset=24
  (local.get $self/303))
 (local.set $*field/2/1661
  (i32.load offset=28
   (local.get $self/303)))
 (local.set $*field/1/1661)
 (local.tee $*field/0/1661)
 (local.get $*field/1/1661)
 (local.set $start_line/2/1225
  (local.get $*field/2/1661))
 (local.set $start_line/1/1225)
 (local.tee $start_line/0/1225)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/316)
   (local.get $start_line/0/1225)
   (local.get $start_line/1/1225)
   (local.get $start_line/2/1225)
   (i32.load offset=16
    (local.get $logger/0/316))))
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/316)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/316))))
 (i32.load offset=68
  (local.get $self/303))
 (i32.load offset=32
  (local.get $self/303))
 (local.set $*field/2/1660
  (i32.load offset=36
   (local.get $self/303)))
 (local.set $*field/1/1660)
 (local.tee $*field/0/1660)
 (local.get $*field/1/1660)
 (local.set $start_column/2/1226
  (local.get $*field/2/1660))
 (local.set $start_column/1/1226)
 (local.tee $start_column/0/1226)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/316)
   (local.get $start_column/0/1226)
   (local.get $start_column/1/1226)
   (local.get $start_column/2/1226)
   (i32.load offset=16
    (local.get $logger/0/316))))
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/316)
   (i32.const 45)
   (i32.load offset=20
    (local.get $logger/0/316))))
 (i32.load offset=72
  (local.get $self/303))
 (i32.load offset=40
  (local.get $self/303))
 (local.set $*field/2/1659
  (i32.load offset=44
   (local.get $self/303)))
 (local.set $*field/1/1659)
 (local.tee $*field/0/1659)
 (local.get $*field/1/1659)
 (local.set $end_line/2/1227
  (local.get $*field/2/1659))
 (local.set $end_line/1/1227)
 (local.tee $end_line/0/1227)
 (call $moonbit.incref)
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/316)
   (local.get $end_line/0/1227)
   (local.get $end_line/1/1227)
   (local.get $end_line/2/1227)
   (i32.load offset=16
    (local.get $logger/0/316))))
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/316)
   (i32.const 58)
   (i32.load offset=20
    (local.get $logger/0/316))))
 (i32.load offset=76
  (local.get $self/303))
 (i32.load offset=48
  (local.get $self/303))
 (local.set $*field/2/1658
  (i32.load offset=52
   (local.get $self/303)))
 (local.set $*field/1/1658)
 (local.set $*field/0/1658)
 (if
  (i32.gt_s
   (local.tee $*cnt/1729
    (i32.load
     (local.get $self/303)))
   (i32.const 1))
  (then
   (call $moonbit.incref
    (local.get $*field/0/1658))
   (local.set $*new_cnt/1735
    (i32.sub
     (local.get $*cnt/1729)
     (i32.const 1)))
   (i32.store
    (local.get $self/303)
    (local.get $*new_cnt/1735)))
  (else
   (if
    (i32.eq
     (local.get $*cnt/1729)
     (i32.const 1))
    (then
     (i32.load offset=72
      (local.get $self/303))
     (i32.load offset=40
      (local.get $self/303))
     (local.set $*field/2/1734
      (i32.load offset=44
       (local.get $self/303)))
     (local.set $*field/1/1734)
     (local.tee $*field/0/1734)
     (call $moonbit.decref)
     (i32.load offset=68
      (local.get $self/303))
     (i32.load offset=32
      (local.get $self/303))
     (local.set $*field/2/1733
      (i32.load offset=36
       (local.get $self/303)))
     (local.set $*field/1/1733)
     (local.tee $*field/0/1733)
     (call $moonbit.decref)
     (i32.load offset=64
      (local.get $self/303))
     (i32.load offset=24
      (local.get $self/303))
     (local.set $*field/2/1732
      (i32.load offset=28
       (local.get $self/303)))
     (local.set $*field/1/1732)
     (local.tee $*field/0/1732)
     (call $moonbit.decref)
     (i32.load offset=60
      (local.get $self/303))
     (i32.load offset=16
      (local.get $self/303))
     (local.set $*field/2/1731
      (i32.load offset=20
       (local.get $self/303)))
     (local.set $*field/1/1731)
     (local.tee $*field/0/1731)
     (call $moonbit.decref)
     (i32.load offset=56
      (local.get $self/303))
     (i32.load offset=8
      (local.get $self/303))
     (local.set $*field/2/1730
      (i32.load offset=12
       (local.get $self/303)))
     (local.set $*field/1/1730)
     (local.tee $*field/0/1730)
     (call $moonbit.decref)
     (call $moonbit.free
      (local.get $self/303)))
    (else))))
 (local.get $*field/0/1658)
 (local.get $*field/1/1658)
 (local.set $end_column/2/1228
  (local.get $*field/2/1658))
 (local.set $end_column/1/1228)
 (local.set $end_column/0/1228)
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
   (local.get $logger/1/316)
   (local.get $end_column/0/1228)
   (local.get $end_column/1/1228)
   (local.get $end_column/2/1228)
   (i32.load offset=16
    (local.get $logger/0/316))))
 (if
  (local.get $logger/1/316)
  (then
   (call $moonbit.incref
    (local.get $logger/1/316)))
  (else))
 (drop
  (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_3)
   (local.get $logger/1/316)
   (i32.const 64)
   (i32.load offset=20
    (local.get $logger/0/316))))
 (local.get $logger/0/316)
 (local.set $*bind/1/1223
  (local.get $logger/1/316))
 (local.set $*bind/0/1223)
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_2)
  (local.get $*bind/1/1223)
  (local.get $*module_name/0/312)
  (local.get $*module_name/1/312)
  (local.get $*module_name/2/312)
  (i32.load offset=16
   (local.get $*bind/0/1223))))
(func $moonbitlang/core/builtin.println|String| (param $input/298 i32) (result i32)
 (call $moonbit.println
  (local.get $input/298))
 (call $moonbit.decref
  (local.get $input/298))
 (i32.const 0))
(func $@moonbitlang/core/builtin.Show::UInt64::output (param $self/291 i64) (param $logger/0/290 i32) (param $logger/1/290 i32) (result i32)
 (local $*tmp/1219 i32)
 (local.set $*tmp/1219
  (call $UInt64::to_string.inner
   (local.get $self/291)
   (i32.const 10)))
 (call_indirect $moonbit.global (type $@moonbitlang/core/builtin.Logger.method_0)
  (local.get $logger/1/290)
  (local.get $*tmp/1219)
  (i32.load offset=8
   (local.get $logger/0/290))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view (param $self/288 i32) (param $str/0/289 i32) (param $str/1/289 i32) (param $str/2/289 i32) (result i32)
 (local $*tmp/1200 i32)
 (local $len/1201 i32)
 (local $*tmp/1202 i32)
 (local $*tmp/1203 i32)
 (local $end/1204 i32)
 (local $start/1205 i32)
 (local $data/1206 i32)
 (local $len/1207 i32)
 (local $str/1208 i32)
 (local $start/1209 i32)
 (local $*tmp/1210 i32)
 (local $end/1211 i32)
 (local $start/1212 i32)
 (local $*tmp/1213 i32)
 (local $len/1214 i32)
 (local $*tmp/1215 i32)
 (local $*tmp/1216 i32)
 (local $end/1217 i32)
 (local $start/1218 i32)
 (local $*field/1669 i32)
 (local $*field/1670 i32)
 (local $*field/1671 i32)
 (local.set $len/1201
  (i32.load offset=8
   (local.get $self/288)))
 (local.set $end/1204
  (local.get $str/2/289))
 (local.set $start/1205
  (local.get $str/1/289))
 (local.set $*tmp/1202
  (i32.mul
   (local.tee $*tmp/1203
    (i32.sub
     (local.get $end/1204)
     (local.get $start/1205)))
   (i32.const 2)))
 (local.set $*tmp/1200
  (i32.add
   (local.get $len/1201)
   (local.get $*tmp/1202)))
 (call $moonbit.incref
  (local.get $self/288))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/288)
   (local.get $*tmp/1200)))
 (local.set $data/1206
  (local.tee $*field/1671
   (i32.load offset=12
    (local.get $self/288))))
 (local.set $len/1207
  (i32.load offset=8
   (local.get $self/288)))
 (local.set $str/1208
  (local.tee $*field/1670
   (local.get $str/0/289)))
 (local.set $start/1209
  (local.get $str/1/289))
 (local.set $end/1211
  (local.get $str/2/289))
 (local.set $start/1212
  (local.get $str/1/289))
 (local.set $*tmp/1210
  (i32.sub
   (local.get $end/1211)
   (local.get $start/1212)))
 (call $moonbit.incref
  (local.get $str/1208))
 (call $moonbit.incref
  (local.get $data/1206))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/1206)
   (local.get $len/1207)
   (local.get $str/1208)
   (local.get $start/1209)
   (local.get $*tmp/1210)))
 (local.set $len/1214
  (i32.load offset=8
   (local.get $self/288)))
 (local.set $end/1217
  (local.get $str/2/289))
 (local.set $*field/1669
  (local.get $str/1/289))
 (call $moonbit.decref
  (local.get $str/0/289))
 (local.set $start/1218
  (local.get $*field/1669))
 (local.set $*tmp/1215
  (i32.mul
   (local.tee $*tmp/1216
    (i32.sub
     (local.get $end/1217)
     (local.get $start/1218)))
   (i32.const 2)))
 (local.set $*tmp/1213
  (i32.add
   (local.get $len/1214)
   (local.get $*tmp/1215)))
 (i32.store offset=8
  (local.get $self/288)
  (local.get $*tmp/1213))
 (call $moonbit.decref
  (local.get $self/288))
 (i32.const 0))
(func $String::offset_of_nth_char.inner (param $self/285 i32) (param $i/286 i32) (param $start_offset/287 i32) (param $end_offset/283 i64) (result i64)
 (local $end_offset/282 i32)
 (local $*Some/284 i64)
 (local $*tmp/1199 i32)
 (local.set $end_offset/282
  (if (result i32)
   (i64.eq
    (local.get $end_offset/283)
    (i64.const 4294967296))
   (then
    (call $moonbit.array_length
     (local.get $self/285)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/284
      (local.get $end_offset/283))))))
 (if (result i64)
  (i32.ge_s
   (local.get $i/286)
   (i32.const 0))
  (then
   (call $String::offset_of_nth_char_forward
    (local.get $self/285)
    (local.get $i/286)
    (local.get $start_offset/287)
    (local.get $end_offset/282)))
  (else
   (local.set $*tmp/1199
    (i32.sub
     (i32.const 0)
     (local.get $i/286)))
   (call $String::offset_of_nth_char_backward
    (local.get $self/285)
    (local.get $*tmp/1199)
    (local.get $start_offset/287)
    (local.get $end_offset/282)))))
(func $String::offset_of_nth_char_forward (param $self/280 i32) (param $n/278 i32) (param $start_offset/274 i32) (param $end_offset/275 i32) (result i64)
 (local $c/279 i32)
 (local $*tmp/1190 i32)
 (local $*tmp/1191 i32)
 (local $*tmp/1192 i32)
 (local $*tmp/1193 i32)
 (local $*tmp/1194 i32)
 (local $*tmp/1195 i32)
 (local $*tmp/1196 i32)
 (local $*tmp/1197 i32)
 (local $*tmp/1198 i32)
 (local $utf16_offset/276 i32)
 (local $char_count/277 i32)
 (if (result i64)
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/274)
    (i32.const 0))
   (then
    (i32.le_s
     (local.get $start_offset/274)
     (local.get $end_offset/275)))
   (else
    (i32.const 0)))
  (then
   (local.set $utf16_offset/276
    (local.get $start_offset/274))
   (local.set $char_count/277
    (i32.const 0))
   (loop $loop:281
    (if
     (if (result i32)
      (i32.lt_s
       (local.tee $*tmp/1191
        (local.get $utf16_offset/276))
       (local.get $end_offset/275))
      (then
       (i32.lt_s
        (local.tee $*tmp/1190
         (local.get $char_count/277))
        (local.get $n/278)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/1195
       (local.get $utf16_offset/276))
      (local.set $c/279
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/280)
         (i32.shl
          (local.get $*tmp/1195)
          (i32.const 1)))))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 55296)
         (local.get $c/279))
        (then
         (i32.le_s
          (local.get $c/279)
          (i32.const 56319)))
        (else
         (i32.const 0)))
       (then
        (local.set $utf16_offset/276
         (i32.add
          (local.tee $*tmp/1192
           (local.get $utf16_offset/276))
          (i32.const 2))))
       (else
        (local.set $utf16_offset/276
         (i32.add
          (local.tee $*tmp/1193
           (local.get $utf16_offset/276))
          (i32.const 1)))))
      (local.set $char_count/277
       (i32.add
        (local.tee $*tmp/1194
         (local.get $char_count/277))
        (i32.const 1)))
      (br $loop:281))
     (else
      (call $moonbit.decref
       (local.get $self/280)))))
   (if (result i64)
    (if (result i32)
     (i32.lt_s
      (local.tee $*tmp/1197
       (local.get $char_count/277))
      (local.get $n/278))
     (then
      (i32.const 1))
     (else
      (i32.ge_s
       (local.tee $*tmp/1196
        (local.get $utf16_offset/276))
       (local.get $end_offset/275))))
    (then
     (i64.const 4294967296))
    (else
     (i64.extend_i32_s
      (local.tee $*tmp/1198
       (local.get $utf16_offset/276))))))
  (else
   (call $moonbit.decref
    (local.get $self/280))
   (call $moonbitlang/core/builtin.abort|Option<Int>|
    (i32.const 10432)
    (i32.const 10320)))))
(func $String::offset_of_nth_char_backward (param $self/272 i32) (param $n/270 i32) (param $start_offset/269 i32) (param $end_offset/268 i32) (result i64)
 (local $c/271 i32)
 (local $*tmp/1179 i32)
 (local $*tmp/1180 i32)
 (local $*tmp/1181 i32)
 (local $*tmp/1182 i32)
 (local $*tmp/1183 i32)
 (local $*tmp/1184 i32)
 (local $*tmp/1185 i32)
 (local $*tmp/1186 i32)
 (local $*tmp/1187 i32)
 (local $*tmp/1188 i32)
 (local $*tmp/1189 i32)
 (local $char_count/266 i32)
 (local $utf16_offset/267 i32)
 (local.set $char_count/266
  (i32.const 0))
 (local.set $utf16_offset/267
  (local.get $end_offset/268))
 (loop $loop:273
  (if
   (if (result i32)
    (i32.ge_s
     (local.tee $*tmp/1180
      (i32.sub
       (local.tee $*tmp/1181
        (local.get $utf16_offset/267))
       (i32.const 1)))
     (local.get $start_offset/269))
    (then
     (i32.lt_s
      (local.tee $*tmp/1179
       (local.get $char_count/266))
      (local.get $n/270)))
    (else
     (i32.const 0)))
   (then
    (local.set $*tmp/1185
     (i32.sub
      (local.tee $*tmp/1186
       (local.get $utf16_offset/267))
      (i32.const 1)))
    (local.set $c/271
     (i32.load16_u offset=8
      (i32.add
       (local.get $self/272)
       (i32.shl
        (local.get $*tmp/1185)
        (i32.const 1)))))
    (if
     (if (result i32)
      (i32.le_s
       (i32.const 56320)
       (local.get $c/271))
      (then
       (i32.le_s
        (local.get $c/271)
        (i32.const 57343)))
      (else
       (i32.const 0)))
     (then
      (local.set $utf16_offset/267
       (i32.sub
        (local.tee $*tmp/1182
         (local.get $utf16_offset/267))
        (i32.const 2))))
     (else
      (local.set $utf16_offset/267
       (i32.sub
        (local.tee $*tmp/1183
         (local.get $utf16_offset/267))
        (i32.const 1)))))
    (local.set $char_count/266
     (i32.add
      (local.tee $*tmp/1184
       (local.get $char_count/266))
      (i32.const 1)))
    (br $loop:273))
   (else
    (call $moonbit.decref
     (local.get $self/272)))))
 (if (result i64)
  (if (result i32)
   (i32.lt_s
    (local.tee $*tmp/1188
     (local.get $char_count/266))
    (local.get $n/270))
   (then
    (i32.const 1))
   (else
    (i32.lt_s
     (local.tee $*tmp/1187
      (local.get $utf16_offset/267))
     (local.get $start_offset/269))))
  (then
   (i64.const 4294967296))
  (else
   (i64.extend_i32_s
    (local.tee $*tmp/1189
     (local.get $utf16_offset/267))))))
(func $String::char_length_ge.inner (param $self/258 i32) (param $len/261 i32) (param $start_offset/265 i32) (param $end_offset/256 i64) (result i32)
 (local $end_offset/255 i32)
 (local $*Some/257 i64)
 (local $index/259 i32)
 (local $count/260 i32)
 (local $c1/262 i32)
 (local $c2/263 i32)
 (local $*tmp/1173 i32)
 (local $*tmp/1174 i32)
 (local $*tmp/1175 i32)
 (local $*tmp/1176 i32)
 (local $*tmp/1177 i32)
 (local $*tmp/1178 i32)
 (local.set $end_offset/255
  (if (result i32)
   (i64.eq
    (local.get $end_offset/256)
    (i64.const 4294967296))
   (then
    (call $moonbit.array_length
     (local.get $self/258)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/257
      (local.get $end_offset/256))))))
 (local.get $start_offset/265)
 (i32.const 0)
 (loop $loop:264 (param i32) (param i32) (result i32)
  (local.set $count/260)
  (local.tee $index/259)
  (local.get $end_offset/255)
  (i32.lt_s)
  (if (result i32)
   (then
    (i32.lt_s
     (local.get $count/260)
     (local.get $len/261)))
   (else
    (i32.const 0)))
  (if (result i32)
   (then
    (local.set $c1/262
     (i32.load16_u offset=8
      (i32.add
       (local.get $self/258)
       (i32.shl
        (local.get $index/259)
        (i32.const 1)))))
    (if
     (if (result i32)
      (if (result i32)
       (i32.le_s
        (i32.const 55296)
        (local.get $c1/262))
       (then
        (i32.le_s
         (local.get $c1/262)
         (i32.const 56319)))
       (else
        (i32.const 0)))
      (then
       (i32.lt_s
        (local.tee $*tmp/1173
         (i32.add
          (local.get $index/259)
          (i32.const 1)))
        (local.get $end_offset/255)))
      (else
       (i32.const 0)))
     (then
      (local.set $*tmp/1176
       (i32.add
        (local.get $index/259)
        (i32.const 1)))
      (local.set $c2/263
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/258)
         (i32.shl
          (local.get $*tmp/1176)
          (i32.const 1)))))
      (if
       (if (result i32)
        (i32.le_s
         (i32.const 56320)
         (local.get $c2/263))
        (then
         (i32.le_s
          (local.get $c2/263)
          (i32.const 57343)))
        (else
         (i32.const 0)))
       (then
        (local.set $*tmp/1174
         (i32.add
          (local.get $index/259)
          (i32.const 2)))
        (local.set $*tmp/1175
         (i32.add
          (local.get $count/260)
          (i32.const 1)))
        (local.get $*tmp/1174)
        (local.get $*tmp/1175)
        (br $loop:264))
       (else
        (drop
         (call $moonbitlang/core/builtin.abort|Unit|
          (i32.const 10592)
          (i32.const 10480))))))
     (else))
    (local.set $*tmp/1177
     (i32.add
      (local.get $index/259)
      (i32.const 1)))
    (local.set $*tmp/1178
     (i32.add
      (local.get $count/260)
      (i32.const 1)))
    (local.get $*tmp/1177)
    (local.get $*tmp/1178)
    (br $loop:264))
   (else
    (call $moonbit.decref
     (local.get $self/258))
    (i32.ge_s
     (local.get $count/260)
     (local.get $len/261))))))
(func $UInt64::to_string.inner (param $self/247 i64) (param $radix/246 i32) (result i32)
 (local $buffer/248 i32)
 (local $len/249 i32)
 (local $buffer/250 i32)
 (local $len/251 i32)
 (local $buffer/252 i32)
 (local $len/253 i32)
 (local $buffer/254 i32)
 (if
  (if (result i32)
   (i32.lt_s
    (local.get $radix/246)
    (i32.const 2))
   (then
    (i32.const 1))
   (else
    (i32.gt_s
     (local.get $radix/246)
     (i32.const 36))))
  (then
   (drop
    (call $moonbitlang/core/builtin.abort|Unit|
     (i32.const 10768)
     (i32.const 10648))))
  (else))
 (if
  (i64.eq
   (local.get $self/247)
   (i64.const 0))
  (then
   (i32.const 10000)
   (return))
  (else))
 (local.tee $buffer/248
  (if (result i32)
   (i32.eq
    (local.get $radix/246)
    (i32.const 10))
   (then
    (call $moonbit.incref
     (local.tee $buffer/250
      (call $moonbit.int16_array_make
       (local.tee $len/249
        (call $moonbitlang/core/builtin.dec_count64
         (local.get $self/247)))
       (i32.const 0))))
    (drop
     (call $moonbitlang/core/builtin.int64_to_string_dec
      (local.get $buffer/250)
      (local.get $self/247)
      (i32.const 0)
      (local.get $len/249)))
    (local.get $buffer/250))
   (else
    (if (result i32)
     (i32.eq
      (local.get $radix/246)
      (i32.const 16))
     (then
      (call $moonbit.incref
       (local.tee $buffer/252
        (call $moonbit.int16_array_make
         (local.tee $len/251
          (call $moonbitlang/core/builtin.hex_count64
           (local.get $self/247)))
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int64_to_string_hex
        (local.get $buffer/252)
        (local.get $self/247)
        (i32.const 0)
        (local.get $len/251)))
      (local.get $buffer/252))
     (else
      (call $moonbit.incref
       (local.tee $buffer/254
        (call $moonbit.int16_array_make
         (local.tee $len/253
          (call $moonbitlang/core/builtin.radix_count64
           (local.get $self/247)
           (local.get $radix/246)))
         (i32.const 0))))
      (drop
       (call $moonbitlang/core/builtin.int64_to_string_generic
        (local.get $buffer/254)
        (local.get $self/247)
        (i32.const 0)
        (local.get $len/253)
        (local.get $radix/246)))
      (local.get $buffer/254)))))))
(func $moonbitlang/core/builtin.int64_to_string_dec (param $buffer/236 i32) (param $num/224 i64) (param $digit_start/227 i32) (param $total_len/226 i32) (result i32)
 (local $t/228 i64)
 (local $r/229 i32)
 (local $d1/230 i32)
 (local $d2/231 i32)
 (local $d1_hi/232 i32)
 (local $d1_lo/233 i32)
 (local $d2_hi/234 i32)
 (local $d2_lo/235 i32)
 (local $t/239 i32)
 (local $d/240 i32)
 (local $d_hi/241 i32)
 (local $d_lo/242 i32)
 (local $d_hi/244 i32)
 (local $d_lo/245 i32)
 (local $*tmp/1116 i64)
 (local $*tmp/1117 i32)
 (local $*tmp/1118 i32)
 (local $*tmp/1119 i32)
 (local $*tmp/1120 i32)
 (local $*tmp/1121 i32)
 (local $*tmp/1122 i32)
 (local $*tmp/1123 i32)
 (local $*tmp/1124 i32)
 (local $*tmp/1125 i32)
 (local $*tmp/1126 i32)
 (local $*tmp/1127 i32)
 (local $*tmp/1128 i32)
 (local $*tmp/1129 i32)
 (local $*tmp/1130 i32)
 (local $*tmp/1131 i32)
 (local $*tmp/1132 i32)
 (local $*tmp/1133 i32)
 (local $*tmp/1134 i32)
 (local $*tmp/1135 i32)
 (local $*tmp/1136 i32)
 (local $*tmp/1137 i64)
 (local $*tmp/1138 i64)
 (local $*tmp/1139 i64)
 (local $*tmp/1140 i32)
 (local $*tmp/1141 i32)
 (local $*tmp/1142 i32)
 (local $*tmp/1143 i32)
 (local $*tmp/1144 i32)
 (local $*tmp/1145 i32)
 (local $*tmp/1146 i32)
 (local $*tmp/1147 i32)
 (local $*tmp/1148 i32)
 (local $*tmp/1149 i32)
 (local $*tmp/1150 i32)
 (local $*tmp/1151 i32)
 (local $*tmp/1152 i32)
 (local $*tmp/1153 i32)
 (local $*tmp/1154 i32)
 (local $*tmp/1155 i32)
 (local $*tmp/1156 i32)
 (local $*tmp/1157 i32)
 (local $*tmp/1158 i32)
 (local $*tmp/1159 i32)
 (local $*tmp/1160 i32)
 (local $*tmp/1161 i32)
 (local $*tmp/1162 i32)
 (local $*tmp/1163 i32)
 (local $*tmp/1164 i32)
 (local $*tmp/1165 i32)
 (local $*tmp/1166 i32)
 (local $*tmp/1167 i32)
 (local $*tmp/1168 i32)
 (local $*tmp/1169 i32)
 (local $*tmp/1170 i32)
 (local $*tmp/1171 i32)
 (local $*tmp/1172 i64)
 (local $num/223 i64)
 (local $offset/225 i32)
 (local $remaining/238 i32)
 (local.set $num/223
  (local.get $num/224))
 (local.set $offset/225
  (i32.sub
   (local.get $total_len/226)
   (local.get $digit_start/227)))
 (loop $loop:237
  (if
   (i64.ge_u
    (local.tee $*tmp/1116
     (local.get $num/223))
    (i64.const 10000))
   (then
    (local.set $t/228
     (i64.div_u
      (local.tee $*tmp/1139
       (local.get $num/223))
      (i64.const 10000)))
    (local.set $r/229
     (i32.wrap_i64
      (local.tee $*tmp/1137
       (i64.rem_u
        (local.tee $*tmp/1138
         (local.get $num/223))
        (i64.const 10000)))))
    (local.set $num/223
     (local.get $t/228))
    (local.set $d1/230
     (i32.div_s
      (local.get $r/229)
      (i32.const 100)))
    (local.set $d2/231
     (i32.rem_s
      (local.get $r/229)
      (i32.const 100)))
    (local.set $offset/225
     (i32.sub
      (local.tee $*tmp/1117
       (local.get $offset/225))
      (i32.const 4)))
    (local.set $*tmp/1136
     (i32.div_s
      (local.get $d1/230)
      (i32.const 10)))
    (local.set $d1_hi/232
     (i32.and
      (local.tee $*tmp/1135
       (i32.add
        (i32.const 48)
        (local.get $*tmp/1136)))
      (i32.const 65535)))
    (local.set $*tmp/1134
     (i32.rem_s
      (local.get $d1/230)
      (i32.const 10)))
    (local.set $d1_lo/233
     (i32.and
      (local.tee $*tmp/1133
       (i32.add
        (i32.const 48)
        (local.get $*tmp/1134)))
      (i32.const 65535)))
    (local.set $*tmp/1132
     (i32.div_s
      (local.get $d2/231)
      (i32.const 10)))
    (local.set $d2_hi/234
     (i32.and
      (local.tee $*tmp/1131
       (i32.add
        (i32.const 48)
        (local.get $*tmp/1132)))
      (i32.const 65535)))
    (local.set $*tmp/1130
     (i32.rem_s
      (local.get $d2/231)
      (i32.const 10)))
    (local.set $d2_lo/235
     (i32.and
      (local.tee $*tmp/1129
       (i32.add
        (i32.const 48)
        (local.get $*tmp/1130)))
      (i32.const 65535)))
    (local.set $*tmp/1119
     (local.get $offset/225))
    (local.set $*tmp/1118
     (i32.add
      (local.get $digit_start/227)
      (local.get $*tmp/1119)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/236)
      (i32.shl
       (local.get $*tmp/1118)
       (i32.const 1)))
     (local.get $d1_hi/232))
    (local.set $*tmp/1122
     (local.get $offset/225))
    (local.set $*tmp/1120
     (i32.add
      (local.tee $*tmp/1121
       (i32.add
        (local.get $digit_start/227)
        (local.get $*tmp/1122)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/236)
      (i32.shl
       (local.get $*tmp/1120)
       (i32.const 1)))
     (local.get $d1_lo/233))
    (local.set $*tmp/1125
     (local.get $offset/225))
    (local.set $*tmp/1123
     (i32.add
      (local.tee $*tmp/1124
       (i32.add
        (local.get $digit_start/227)
        (local.get $*tmp/1125)))
      (i32.const 2)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/236)
      (i32.shl
       (local.get $*tmp/1123)
       (i32.const 1)))
     (local.get $d2_hi/234))
    (local.set $*tmp/1128
     (local.get $offset/225))
    (local.set $*tmp/1126
     (i32.add
      (local.tee $*tmp/1127
       (i32.add
        (local.get $digit_start/227)
        (local.get $*tmp/1128)))
      (i32.const 3)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/236)
      (i32.shl
       (local.get $*tmp/1126)
       (i32.const 1)))
     (local.get $d2_lo/235))
    (br $loop:237))
   (else)))
 (local.set $remaining/238
  (i32.wrap_i64
   (local.tee $*tmp/1172
    (local.get $num/223))))
 (loop $loop:243
  (if
   (i32.ge_s
    (local.tee $*tmp/1140
     (local.get $remaining/238))
    (i32.const 100))
   (then
    (local.set $t/239
     (i32.div_s
      (local.tee $*tmp/1152
       (local.get $remaining/238))
      (i32.const 100)))
    (local.set $d/240
     (i32.rem_s
      (local.tee $*tmp/1151
       (local.get $remaining/238))
      (i32.const 100)))
    (local.set $remaining/238
     (local.get $t/239))
    (local.set $offset/225
     (i32.sub
      (local.tee $*tmp/1141
       (local.get $offset/225))
      (i32.const 2)))
    (local.set $*tmp/1150
     (i32.div_s
      (local.get $d/240)
      (i32.const 10)))
    (local.set $d_hi/241
     (i32.and
      (local.tee $*tmp/1149
       (i32.add
        (i32.const 48)
        (local.get $*tmp/1150)))
      (i32.const 65535)))
    (local.set $*tmp/1148
     (i32.rem_s
      (local.get $d/240)
      (i32.const 10)))
    (local.set $d_lo/242
     (i32.and
      (local.tee $*tmp/1147
       (i32.add
        (i32.const 48)
        (local.get $*tmp/1148)))
      (i32.const 65535)))
    (local.set $*tmp/1143
     (local.get $offset/225))
    (local.set $*tmp/1142
     (i32.add
      (local.get $digit_start/227)
      (local.get $*tmp/1143)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/236)
      (i32.shl
       (local.get $*tmp/1142)
       (i32.const 1)))
     (local.get $d_hi/241))
    (local.set $*tmp/1146
     (local.get $offset/225))
    (local.set $*tmp/1144
     (i32.add
      (local.tee $*tmp/1145
       (i32.add
        (local.get $digit_start/227)
        (local.get $*tmp/1146)))
      (i32.const 1)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/236)
      (i32.shl
       (local.get $*tmp/1144)
       (i32.const 1)))
     (local.get $d_lo/242))
    (br $loop:243))
   (else)))
 (if (result i32)
  (i32.ge_s
   (local.tee $*tmp/1153
    (local.get $remaining/238))
   (i32.const 10))
  (then
   (local.set $offset/225
    (i32.sub
     (local.tee $*tmp/1154
      (local.get $offset/225))
     (i32.const 2)))
   (local.set $*tmp/1164
    (i32.div_s
     (local.tee $*tmp/1165
      (local.get $remaining/238))
     (i32.const 10)))
   (local.set $d_hi/244
    (i32.and
     (local.tee $*tmp/1163
      (i32.add
       (i32.const 48)
       (local.get $*tmp/1164)))
     (i32.const 65535)))
   (local.set $*tmp/1161
    (i32.rem_s
     (local.tee $*tmp/1162
      (local.get $remaining/238))
     (i32.const 10)))
   (local.set $d_lo/245
    (i32.and
     (local.tee $*tmp/1160
      (i32.add
       (i32.const 48)
       (local.get $*tmp/1161)))
     (i32.const 65535)))
   (local.set $*tmp/1156
    (local.get $offset/225))
   (local.set $*tmp/1155
    (i32.add
     (local.get $digit_start/227)
     (local.get $*tmp/1156)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/236)
     (i32.shl
      (local.get $*tmp/1155)
      (i32.const 1)))
    (local.get $d_hi/244))
   (local.set $*tmp/1159
    (local.get $offset/225))
   (local.set $*tmp/1157
    (i32.add
     (local.tee $*tmp/1158
      (i32.add
       (local.get $digit_start/227)
       (local.get $*tmp/1159)))
     (i32.const 1)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/236)
     (i32.shl
      (local.get $*tmp/1157)
      (i32.const 1)))
    (local.get $d_lo/245))
   (call $moonbit.decref
    (local.get $buffer/236))
   (i32.const 0))
  (else
   (local.set $*tmp/1171
    (local.tee $offset/225
     (i32.sub
      (local.tee $*tmp/1166
       (local.get $offset/225))
      (i32.const 1))))
   (local.set $*tmp/1167
    (i32.add
     (local.get $digit_start/227)
     (local.get $*tmp/1171)))
   (local.set $*tmp/1170
    (local.get $remaining/238))
   (local.set $*tmp/1168
    (i32.and
     (local.tee $*tmp/1169
      (i32.add
       (i32.const 48)
       (local.get $*tmp/1170)))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/236)
     (i32.shl
      (local.get $*tmp/1167)
      (i32.const 1)))
    (local.get $*tmp/1168))
   (call $moonbit.decref
    (local.get $buffer/236))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int64_to_string_generic (param $buffer/218 i32) (param $num/212 i64) (param $digit_start/210 i32) (param $total_len/209 i32) (param $radix/214 i32) (result i32)
 (local $base/213 i64)
 (local $shift/215 i32)
 (local $mask/216 i64)
 (local $digit/217 i32)
 (local $q/220 i64)
 (local $digit/221 i32)
 (local $*tmp/1094 i32)
 (local $*tmp/1095 i32)
 (local $*tmp/1096 i64)
 (local $*tmp/1097 i32)
 (local $*tmp/1098 i32)
 (local $*tmp/1099 i32)
 (local $*tmp/1100 i32)
 (local $*tmp/1101 i32)
 (local $*tmp/1102 i64)
 (local $*tmp/1103 i64)
 (local $*tmp/1104 i64)
 (local $*tmp/1105 i64)
 (local $*tmp/1106 i32)
 (local $*tmp/1107 i32)
 (local $*tmp/1108 i32)
 (local $*tmp/1109 i32)
 (local $*tmp/1110 i32)
 (local $*tmp/1111 i64)
 (local $*tmp/1112 i64)
 (local $*tmp/1113 i64)
 (local $*tmp/1114 i64)
 (local $*tmp/1115 i64)
 (local $offset/208 i32)
 (local $n/211 i64)
 (local.set $offset/208
  (i32.sub
   (local.get $total_len/209)
   (local.get $digit_start/210)))
 (local.set $n/211
  (local.get $num/212))
 (local.set $base/213
  (local.tee $*tmp/1115
   (i64.extend_i32_s
    (local.get $radix/214))))
 (local.set $*tmp/1095
  (i32.sub
   (local.get $radix/214)
   (i32.const 1)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/1094
    (i32.and
     (local.get $radix/214)
     (local.get $*tmp/1095)))
   (i32.const 0))
  (then
   (local.set $shift/215
    (i32.ctz
     (local.get $radix/214)))
   (local.set $mask/216
    (i64.sub
     (local.get $base/213)
     (i64.const 1)))
   (loop $loop:219
    (if
     (i64.gt_u
      (local.tee $*tmp/1096
       (local.get $n/211))
      (i64.const 0))
     (then
      (local.set $offset/208
       (i32.sub
        (local.tee $*tmp/1097
         (local.get $offset/208))
        (i32.const 1)))
      (local.set $digit/217
       (i32.wrap_i64
        (local.tee $*tmp/1103
         (i64.and
          (local.tee $*tmp/1104
           (local.get $n/211))
          (local.get $mask/216)))))
      (local.set $*tmp/1101
       (local.get $offset/208))
      (local.set $*tmp/1098
       (i32.add
        (local.get $digit_start/210)
        (local.get $*tmp/1101)))
      (local.set $*tmp/1099
       (i32.and
        (local.tee $*tmp/1100
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10840)
           (i32.shl
            (local.get $digit/217)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/218)
        (i32.shl
         (local.get $*tmp/1098)
         (i32.const 1)))
       (local.get $*tmp/1099))
      (local.set $n/211
       (i64.shr_u
        (local.tee $*tmp/1102
         (local.get $n/211))
        (i64.extend_i32_s
         (local.get $shift/215))))
      (br $loop:219))
     (else
      (call $moonbit.decref
       (local.get $buffer/218)))))
   (i32.const 0))
  (else
   (loop $loop:222
    (if
     (i64.gt_u
      (local.tee $*tmp/1105
       (local.get $n/211))
      (i64.const 0))
     (then
      (local.set $offset/208
       (i32.sub
        (local.tee $*tmp/1106
         (local.get $offset/208))
        (i32.const 1)))
      (local.set $q/220
       (i64.div_u
        (local.tee $*tmp/1114
         (local.get $n/211))
        (local.get $base/213)))
      (local.set $*tmp/1112
       (local.get $n/211))
      (local.set $*tmp/1113
       (i64.mul
        (local.get $q/220)
        (local.get $base/213)))
      (local.set $digit/221
       (i32.wrap_i64
        (local.tee $*tmp/1111
         (i64.sub
          (local.get $*tmp/1112)
          (local.get $*tmp/1113)))))
      (local.set $*tmp/1110
       (local.get $offset/208))
      (local.set $*tmp/1107
       (i32.add
        (local.get $digit_start/210)
        (local.get $*tmp/1110)))
      (local.set $*tmp/1108
       (i32.and
        (local.tee $*tmp/1109
         (i32.load16_u offset=8
          (i32.add
           (i32.const 10840)
           (i32.shl
            (local.get $digit/221)
            (i32.const 1)))))
        (i32.const 65535)))
      (i32.store16 offset=8
       (i32.add
        (local.get $buffer/218)
        (i32.shl
         (local.get $*tmp/1107)
         (i32.const 1)))
       (local.get $*tmp/1108))
      (local.set $n/211
       (local.get $q/220))
      (br $loop:222))
     (else
      (call $moonbit.decref
       (local.get $buffer/218)))))
   (i32.const 0))))
(func $moonbitlang/core/builtin.int64_to_string_hex (param $buffer/205 i32) (param $num/201 i64) (param $digit_start/199 i32) (param $total_len/198 i32) (result i32)
 (local $byte_val/202 i32)
 (local $hi/203 i32)
 (local $lo/204 i32)
 (local $nibble/207 i32)
 (local $*tmp/1075 i32)
 (local $*tmp/1076 i32)
 (local $*tmp/1077 i32)
 (local $*tmp/1078 i32)
 (local $*tmp/1079 i32)
 (local $*tmp/1080 i32)
 (local $*tmp/1081 i32)
 (local $*tmp/1082 i32)
 (local $*tmp/1083 i32)
 (local $*tmp/1084 i32)
 (local $*tmp/1085 i32)
 (local $*tmp/1086 i64)
 (local $*tmp/1087 i64)
 (local $*tmp/1088 i64)
 (local $*tmp/1089 i32)
 (local $*tmp/1090 i32)
 (local $*tmp/1091 i32)
 (local $*tmp/1092 i64)
 (local $*tmp/1093 i64)
 (local $offset/197 i32)
 (local $n/200 i64)
 (local.set $offset/197
  (i32.sub
   (local.get $total_len/198)
   (local.get $digit_start/199)))
 (local.set $n/200
  (local.get $num/201))
 (loop $loop:206
  (if
   (i32.ge_s
    (local.tee $*tmp/1075
     (local.get $offset/197))
    (i32.const 2))
   (then
    (local.set $offset/197
     (i32.sub
      (local.tee $*tmp/1076
       (local.get $offset/197))
      (i32.const 2)))
    (local.set $hi/203
     (i32.div_s
      (local.tee $byte_val/202
       (i32.wrap_i64
        (local.tee $*tmp/1087
         (i64.and
          (local.tee $*tmp/1088
           (local.get $n/200))
          (i64.const 255)))))
      (i32.const 16)))
    (local.set $lo/204
     (i32.rem_s
      (local.get $byte_val/202)
      (i32.const 16)))
    (local.set $*tmp/1080
     (local.get $offset/197))
    (local.set $*tmp/1077
     (i32.add
      (local.get $digit_start/199)
      (local.get $*tmp/1080)))
    (local.set $*tmp/1078
     (i32.and
      (local.tee $*tmp/1079
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10840)
         (i32.shl
          (local.get $hi/203)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/205)
      (i32.shl
       (local.get $*tmp/1077)
       (i32.const 1)))
     (local.get $*tmp/1078))
    (local.set $*tmp/1085
     (local.get $offset/197))
    (local.set $*tmp/1081
     (i32.add
      (local.tee $*tmp/1084
       (i32.add
        (local.get $digit_start/199)
        (local.get $*tmp/1085)))
      (i32.const 1)))
    (local.set $*tmp/1082
     (i32.and
      (local.tee $*tmp/1083
       (i32.load16_u offset=8
        (i32.add
         (i32.const 10840)
         (i32.shl
          (local.get $lo/204)
          (i32.const 1)))))
      (i32.const 65535)))
    (i32.store16 offset=8
     (i32.add
      (local.get $buffer/205)
      (i32.shl
       (local.get $*tmp/1081)
       (i32.const 1)))
     (local.get $*tmp/1082))
    (local.set $n/200
     (i64.shr_u
      (local.tee $*tmp/1086
       (local.get $n/200))
      (i64.extend_i32_s
       (i32.const 8))))
    (br $loop:206))
   (else)))
 (if (result i32)
  (i32.eq
   (local.tee $*tmp/1089
    (local.get $offset/197))
   (i32.const 1))
  (then
   (local.set $nibble/207
    (i32.wrap_i64
     (local.tee $*tmp/1092
      (i64.and
       (local.tee $*tmp/1093
        (local.get $n/200))
       (i64.const 15)))))
   (local.set $*tmp/1090
    (i32.and
     (local.tee $*tmp/1091
      (i32.load16_u offset=8
       (i32.add
        (i32.const 10840)
        (i32.shl
         (local.get $nibble/207)
         (i32.const 1)))))
     (i32.const 65535)))
   (i32.store16 offset=8
    (i32.add
     (local.get $buffer/205)
     (i32.shl
      (local.get $digit_start/199)
      (i32.const 1)))
    (local.get $*tmp/1090))
   (call $moonbit.decref
    (local.get $buffer/205))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $buffer/205))
   (i32.const 0))))
(func $moonbitlang/core/builtin.radix_count64 (param $value/191 i64) (param $radix/194 i32) (result i32)
 (local $base/193 i64)
 (local $*tmp/1071 i64)
 (local $*tmp/1072 i32)
 (local $*tmp/1073 i64)
 (local $*tmp/1074 i64)
 (local $num/192 i64)
 (local $count/195 i32)
 (if
  (i64.eq
   (local.get $value/191)
   (i64.const 0))
  (then
   (i32.const 1)
   (return))
  (else))
 (local.set $num/192
  (local.get $value/191))
 (local.set $base/193
  (local.tee $*tmp/1074
   (i64.extend_i32_s
    (local.get $radix/194))))
 (local.set $count/195
  (i32.const 0))
 (loop $loop:196
  (if
   (i64.gt_u
    (local.tee $*tmp/1071
     (local.get $num/192))
    (i64.const 0))
   (then
    (local.set $count/195
     (i32.add
      (local.tee $*tmp/1072
       (local.get $count/195))
      (i32.const 1)))
    (local.set $num/192
     (i64.div_u
      (local.tee $*tmp/1073
       (local.get $num/192))
      (local.get $base/193)))
    (br $loop:196))
   (else)))
 (local.get $count/195))
(func $moonbitlang/core/builtin.hex_count64 (param $value/189 i64) (result i32)
 (local $leading_zeros/190 i32)
 (local $*tmp/1069 i32)
 (local $*tmp/1070 i32)
 (if (result i32)
  (i64.eq
   (local.get $value/189)
   (i64.const 0))
  (then
   (i32.const 1))
  (else
   (local.set $leading_zeros/190
    (i32.wrap_i64
     (i64.clz
      (local.get $value/189))))
   (i32.add
    (local.tee $*tmp/1069
     (i32.div_s
      (local.tee $*tmp/1070
       (i32.sub
        (i32.const 63)
        (local.get $leading_zeros/190)))
      (i32.const 4)))
    (i32.const 1)))))
(func $moonbitlang/core/builtin.dec_count64 (param $value/188 i64) (result i32)
 (if (result i32)
  (i64.ge_u
   (local.get $value/188)
   (i64.const 10000000000))
  (then
   (if (result i32)
    (i64.ge_u
     (local.get $value/188)
     (i64.const 100000000000000))
    (then
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 10000000000000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000000000000000))
        (then
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const -8446744073709551616))
          (then
           (i32.const 20))
          (else
           (i32.const 19))))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const 100000000000000000))
          (then
           (i32.const 18))
          (else
           (i32.const 17))))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000000000000))
        (then
         (i32.const 16))
        (else
         (i32.const 15))))))
    (else
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 1000000000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 10000000000000))
        (then
         (i32.const 14))
        (else
         (i32.const 13))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 100000000000))
        (then
         (i32.const 12))
        (else
         (i32.const 11))))))))
  (else
   (if (result i32)
    (i64.ge_u
     (local.get $value/188)
     (i64.const 100000))
    (then
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 10000000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000000))
        (then
         (i32.const 10))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const 100000000))
          (then
           (i32.const 9))
          (else
           (i32.const 8))))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 1000000))
        (then
         (i32.const 7))
        (else
         (i32.const 6))))))
    (else
     (if (result i32)
      (i64.ge_u
       (local.get $value/188)
       (i64.const 1000))
      (then
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 10000))
        (then
         (i32.const 5))
        (else
         (i32.const 4))))
      (else
       (if (result i32)
        (i64.ge_u
         (local.get $value/188)
         (i64.const 100))
        (then
         (i32.const 3))
        (else
         (if (result i32)
          (i64.ge_u
           (local.get $value/188)
           (i64.const 10))
          (then
           (i32.const 2))
          (else
           (i32.const 1))))))))))))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|UInt64| (param $self/187 i64) (result i32)
 (local $logger/186 i32)
 (local $*tmp/0/1068 i32)
 (local $*tmp/1/1068 i32)
 (call $moonbit.incref
  (local.tee $logger/186
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/1068
  (local.get $logger/186))
 (local.set $*tmp/0/1068)
 (drop
  (call $@moonbitlang/core/builtin.Show::UInt64::output
   (local.get $self/187)
   (local.get $*tmp/0/1068)
   (local.get $*tmp/1/1068)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/186)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc| (param $self/185 i32) (result i32)
 (local $logger/184 i32)
 (local $*tmp/0/1067 i32)
 (local $*tmp/1/1067 i32)
 (call $moonbit.incref
  (local.tee $logger/184
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/1067
  (local.get $logger/184))
 (local.set $*tmp/0/1067)
 (drop
  (call $@moonbitlang/core/builtin.Show::@moonbitlang/core/builtin.SourceLoc::output
   (local.get $self/185)
   (local.get $*tmp/0/1067)
   (local.get $*tmp/1/1067)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/184)))
(func $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double| (param $self/183 f64) (result i32)
 (local $logger/182 i32)
 (local $*tmp/0/1066 i32)
 (local $*tmp/1/1066 i32)
 (call $moonbit.incref
  (local.tee $logger/182
   (call $@moonbitlang/core/builtin.StringBuilder::new.inner
    (i32.const 0))))
 (global.get $@moonbitlang/core/builtin.StringBuilder.as_@moonbitlang/core/builtin.Logger.static_method_table_id)
 (local.set $*tmp/1/1066
  (local.get $logger/182))
 (local.set $*tmp/0/1066)
 (drop
  (call $@moonbitlang/core/builtin.Show::Double::output
   (local.get $self/183)
   (local.get $*tmp/0/1066)
   (local.get $*tmp/1/1066)))
 (call $@moonbitlang/core/builtin.StringBuilder::to_string
  (local.get $logger/182)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder| (param $self/174 i32) (param $value/177 i32) (param $start/178 i32) (param $len/179 i32) (result i32)
 (local $*try_err/176 i32)
 (local $*tmp/0/1061 i32)
 (local $*tmp/1/1061 i32)
 (local $*tmp/2/1061 i32)
 (local $*tmp/1062 i64)
 (local $*tmp/1063 i32)
 (local $*ok/0/1064 i32)
 (local $*ok/1/1064 i32)
 (local $*ok/2/1064 i32)
 (local $*err/1065 i32)
 (local $*obj/0/1814 i32)
 (local $*obj/1/1814 i32)
 (local $*obj/2/1814 i32)
 (block $outer/1813 (result i32) (result i32) (result i32)
  (block $join:175
   (local.set $*tmp/1062
    (i64.extend_i32_s
     (local.tee $*tmp/1063
      (i32.add
       (local.get $start/178)
       (local.get $len/179)))))
   (call $String::sub.inner
    (local.get $value/177)
    (local.get $start/178)
    (local.get $*tmp/1062))
   (local.set $*obj/2/1814)
   (local.set $*obj/1/1814)
   (local.set $*obj/0/1814)
   (if (result i32) (result i32) (result i32)
    (then
     (local.get $*obj/0/1814)
     (local.get $*obj/1/1814)
     (local.set $*ok/2/1064
      (local.get $*obj/2/1814))
     (local.set $*ok/1/1064)
     (local.tee $*ok/0/1064)
     (local.get $*ok/1/1064)
     (local.get $*ok/2/1064))
    (else
     (local.set $*try_err/176
      (local.tee $*err/1065
       (local.get $*obj/0/1814)))
     (br $join:175)))
   (br $outer/1813))
  (call $moonbit.decref
   (local.get $*try_err/176))
  (unreachable))
 (local.set $*tmp/2/1061)
 (local.set $*tmp/1/1061)
 (local.set $*tmp/0/1061)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.get $self/174)
  (local.get $*tmp/0/1061)
  (local.get $*tmp/1/1061)
  (local.get $*tmp/2/1061)))
(func $String::sub.inner (param $self/167 i32) (param $start/173 i32) (param $end/169 i64) (result i32) (result i32) (result i32) (result i32)
 (local $len/166 i32)
 (local $end/168 i32)
 (local $*Some/170 i64)
 (local $*end/171 i32)
 (local $start/172 i32)
 (local $*p/647 i32)
 (local $*p/650 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/1057 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/1058 i32)
 (local $*tmp/0/1059 i32)
 (local $*tmp/1/1059 i32)
 (local $*tmp/2/1059 i32)
 (local $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/1060 i32)
 (local.set $len/166
  (call $moonbit.array_length
   (local.get $self/167)))
 (local.set $end/168
  (if (result i32)
   (i64.eq
    (local.get $end/169)
    (i64.const 4294967296))
   (then
    (local.get $len/166))
   (else
    (if (result i32)
     (i32.lt_s
      (local.tee $*end/171
       (i32.wrap_i64
        (local.tee $*Some/170
         (local.get $end/169))))
      (i32.const 0))
     (then
      (i32.add
       (local.get $len/166)
       (local.get $*end/171)))
     (else
      (local.get $*end/171))))))
 (if (result i32) (result i32) (result i32) (result i32)
  (if (result i32)
   (i32.ge_s
    (local.tee $start/172
     (if (result i32)
      (i32.lt_s
       (local.get $start/173)
       (i32.const 0))
      (then
       (i32.add
        (local.get $len/166)
        (local.get $start/173)))
      (else
       (local.get $start/173))))
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start/172)
      (local.get $end/168))
     (then
      (i32.le_s
       (local.get $end/168)
       (local.get $len/166)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $start/172)
      (local.get $len/166))
     (then
      (local.set $*p/647
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/167)
         (i32.shl
          (local.get $start/172)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/647))
       (then
        (i32.le_s
         (local.get $*p/647)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/167))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/1057
      (i32.const 10304))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/1057)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (if
    (if (result i32)
     (i32.lt_s
      (local.get $end/168)
      (local.get $len/166))
     (then
      (local.set $*p/650
       (i32.load16_u offset=8
        (i32.add
         (local.get $self/167)
         (i32.shl
          (local.get $end/168)
          (i32.const 1)))))
      (if (result i32)
       (i32.le_s
        (i32.const 56320)
        (local.get $*p/650))
       (then
        (i32.le_s
         (local.get $*p/650)
         (i32.const 57343)))
       (else
        (i32.const 0))))
     (else
      (i32.const 0)))
    (then
     (call $moonbit.decref
      (local.get $self/167))
     (local.set $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/1058
      (i32.const 10304))
     (i32.const 0)
     (local.get $moonbitlang/core/builtin.CreatingViewError.InvalidIndex/1058)
     (i32.const 0)
     (i32.const 0)
     (return))
    (else))
   (local.get $self/167)
   (local.get $start/172)
   (local.set $*tmp/2/1059
    (local.get $end/168))
   (local.set $*tmp/1/1059)
   (local.set $*tmp/0/1059)
   (i32.const 1)
   (local.get $*tmp/0/1059)
   (local.get $*tmp/1/1059)
   (local.get $*tmp/2/1059))
  (else
   (call $moonbit.decref
    (local.get $self/167))
   (local.set $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/1060
    (i32.const 10928))
   (i32.const 0)
   (local.get $moonbitlang/core/builtin.CreatingViewError.IndexOutOfBounds/1060)
   (i32.const 0)
   (i32.const 0))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string (param $self/163 i32) (param $str/164 i32) (result i32)
 (local $*tmp/1045 i32)
 (local $len/1046 i32)
 (local $*tmp/1047 i32)
 (local $*tmp/1048 i32)
 (local $data/1049 i32)
 (local $len/1050 i32)
 (local $*tmp/1051 i32)
 (local $*tmp/1052 i32)
 (local $len/1053 i32)
 (local $*tmp/1054 i32)
 (local $*tmp/1055 i32)
 (local $*tmp/1674 i32)
 (local $*field/1675 i32)
 (local.set $len/1046
  (i32.load offset=8
   (local.get $self/163)))
 (local.set $*tmp/1047
  (i32.mul
   (local.tee $*tmp/1048
    (call $moonbit.array_length
     (local.get $str/164)))
   (i32.const 2)))
 (local.set $*tmp/1045
  (i32.add
   (local.get $len/1046)
   (local.get $*tmp/1047)))
 (call $moonbit.incref
  (local.get $self/163))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/163)
   (local.get $*tmp/1045)))
 (local.set $data/1049
  (local.tee $*field/1675
   (i32.load offset=12
    (local.get $self/163))))
 (local.set $len/1050
  (i32.load offset=8
   (local.get $self/163)))
 (local.set $*tmp/1051
  (call $moonbit.array_length
   (local.get $str/164)))
 (call $moonbit.incref
  (local.get $data/1049))
 (call $moonbit.incref
  (local.get $str/164))
 (drop
  (call $FixedArray::blit_from_string
   (local.get $data/1049)
   (local.get $len/1050)
   (local.get $str/164)
   (i32.const 0)
   (local.get $*tmp/1051)))
 (local.set $len/1053
  (i32.load offset=8
   (local.get $self/163)))
 (local.set $*tmp/1674
  (call $moonbit.array_length
   (local.get $str/164)))
 (call $moonbit.decref
  (local.get $str/164))
 (local.set $*tmp/1054
  (i32.mul
   (local.tee $*tmp/1055
    (local.get $*tmp/1674))
   (i32.const 2)))
 (local.set $*tmp/1052
  (i32.add
   (local.get $len/1053)
   (local.get $*tmp/1054)))
 (i32.store offset=8
  (local.get $self/163)
  (local.get $*tmp/1052))
 (call $moonbit.decref
  (local.get $self/163))
 (i32.const 0))
(func $FixedArray::blit_from_string (param $self/155 i32) (param $bytes_offset/150 i32) (param $str/157 i32) (param $str_offset/153 i32) (param $length/151 i32) (result i32)
 (local $e1/149 i32)
 (local $e2/152 i32)
 (local $len1/154 i32)
 (local $len2/156 i32)
 (local $end_str_offset/158 i32)
 (local $i/159 i32)
 (local $j/160 i32)
 (local $c/161 i32)
 (local $*p/641 i32)
 (local $*p/644 i32)
 (local $*tmp/1034 i32)
 (local $*tmp/1035 i32)
 (local $*tmp/1036 i32)
 (local $*tmp/1037 i32)
 (local $*tmp/1038 i32)
 (local $*tmp/1039 i32)
 (local $*tmp/1040 i32)
 (local $*tmp/1041 i32)
 (local $*tmp/1042 i32)
 (local $*tmp/1043 i32)
 (local $*tmp/1044 i32)
 (local $*arr/1815 i32)
 (local $*idx/1816 i32)
 (local $*arr/1817 i32)
 (local $*idx/1818 i32)
 (local.set $*tmp/1044
  (i32.mul
   (local.get $length/151)
   (i32.const 2)))
 (local.set $e1/149
  (i32.sub
   (local.tee $*tmp/1043
    (i32.add
     (local.get $bytes_offset/150)
     (local.get $*tmp/1044)))
   (i32.const 1)))
 (local.set $e2/152
  (i32.sub
   (local.tee $*tmp/1042
    (i32.add
     (local.get $str_offset/153)
     (local.get $length/151)))
   (i32.const 1)))
 (local.set $len1/154
  (call $moonbit.array_length
   (local.get $self/155)))
 (local.set $len2/156
  (call $moonbit.array_length
   (local.get $str/157)))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $length/151)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $bytes_offset/150)
      (i32.const 0))
     (then
      (if (result i32)
       (i32.lt_s
        (local.get $e1/149)
        (local.get $len1/154))
       (then
        (if (result i32)
         (i32.ge_s
          (local.get $str_offset/153)
          (i32.const 0))
         (then
          (i32.lt_s
           (local.get $e2/152)
           (local.get $len2/156)))
         (else
          (i32.const 0))))
       (else
        (i32.const 0))))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $end_str_offset/158
    (i32.add
     (local.get $str_offset/153)
     (local.get $length/151)))
   (local.get $str_offset/153)
   (local.get $bytes_offset/150)
   (loop $loop:162 (param i32) (param i32)
    (local.set $j/160)
    (local.tee $i/159)
    (local.get $end_str_offset/158)
    (i32.lt_s)
    (if
     (then
      (local.set $*tmp/1034
       (i32.and
        (local.tee $*tmp/1035
         (local.tee $*p/641
          (i32.and
           (local.tee $c/161
            (local.tee $*tmp/1039
             (i32.load16_u offset=8
              (i32.add
               (local.get $str/157)
               (i32.shl
                (local.get $i/159)
                (i32.const 1))))))
           (i32.const 255))))
        (i32.const 255)))
      (local.get $self/155)
      (local.set $*idx/1818
       (local.get $j/160))
      (local.set $*arr/1817)
      (call $moonbit.check_range
       (local.get $*idx/1818)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1817))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1817)
        (local.get $*idx/1818))
       (local.get $*tmp/1034))
      (local.set $*tmp/1036
       (i32.add
        (local.get $j/160)
        (i32.const 1)))
      (local.set $*tmp/1037
       (i32.and
        (local.tee $*tmp/1038
         (local.tee $*p/644
          (i32.shr_u
           (local.get $c/161)
           (i32.const 8))))
        (i32.const 255)))
      (local.get $self/155)
      (local.set $*idx/1816
       (local.get $*tmp/1036))
      (local.set $*arr/1815)
      (call $moonbit.check_range
       (local.get $*idx/1816)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1815))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1815)
        (local.get $*idx/1816))
       (local.get $*tmp/1037))
      (local.set $*tmp/1040
       (i32.add
        (local.get $i/159)
        (i32.const 1)))
      (local.set $*tmp/1041
       (i32.add
        (local.get $j/160)
        (i32.const 2)))
      (local.get $*tmp/1040)
      (local.get $*tmp/1041)
      (br $loop:162))
     (else
      (call $moonbit.decref
       (local.get $str/157))
      (call $moonbit.decref
       (local.get $self/155)))))
   (i32.const 0))
  (else
   (call $moonbit.decref
    (local.get $str/157))
   (call $moonbit.decref
    (local.get $self/155))
   (unreachable))))
(func $@moonbitlang/core/builtin.SourceLocRepr::parse (param $repr/117 i32) (result i32)
 (local $*x/118 i32)
 (local $*x/0/119 i32)
 (local $*x/1/119 i32)
 (local $*x/2/119 i32)
 (local $*Some/120 i64)
 (local $*bind/121 i64)
 (local $*Some/122 i64)
 (local $*pkg_end/123 i32)
 (local $pkg/0/124 i32)
 (local $pkg/1/124 i32)
 (local $pkg/2/124 i32)
 (local $*bind/125 i64)
 (local $*Some/126 i64)
 (local $*start_loc_end/127 i32)
 (local $end_loc/0/128 i32)
 (local $end_loc/1/128 i32)
 (local $end_loc/2/128 i32)
 (local $*bind/129 i32)
 (local $*Some/130 i32)
 (local $*x/131 i32)
 (local $*end_line/0/132 i32)
 (local $*end_line/1/132 i32)
 (local $*end_line/2/132 i32)
 (local $*end_column/0/133 i32)
 (local $*end_column/1/133 i32)
 (local $*end_column/2/133 i32)
 (local $rest/0/134 i32)
 (local $rest/1/134 i32)
 (local $rest/2/134 i32)
 (local $*bind/136 i64)
 (local $*Some/137 i64)
 (local $*start_line_end/138 i32)
 (local $*bind/139 i64)
 (local $*Some/140 i64)
 (local $*filename_end/141 i32)
 (local $start_loc/0/142 i32)
 (local $start_loc/1/142 i32)
 (local $start_loc/2/142 i32)
 (local $*bind/143 i32)
 (local $*Some/144 i32)
 (local $*x/145 i32)
 (local $*start_line/0/146 i32)
 (local $*start_line/1/146 i32)
 (local $*start_line/2/146 i32)
 (local $*start_column/0/147 i32)
 (local $*start_column/1/147 i32)
 (local $*start_column/2/147 i32)
 (local $filename/0/148 i32)
 (local $filename/1/148 i32)
 (local $filename/2/148 i32)
 (local $*bind/539 i64)
 (local $*tmp/1002 i64)
 (local $*tmp/1003 i32)
 (local $*tmp/1004 i32)
 (local $*tmp/1005 i32)
 (local $end/1006 i32)
 (local $start/1007 i32)
 (local $*tmp/1008 i32)
 (local $*tmp/1009 i32)
 (local $end/1010 i32)
 (local $start/1011 i32)
 (local $*tmp/1012 i32)
 (local $*tmp/1013 i32)
 (local $*tmp/1014 i64)
 (local $*tmp/1015 i32)
 (local $*tmp/0/1016 i32)
 (local $*tmp/1/1016 i32)
 (local $*tmp/2/1016 i32)
 (local $*tmp/0/1017 i32)
 (local $*tmp/1/1017 i32)
 (local $*tmp/2/1017 i32)
 (local $*tmp/1018 i32)
 (local $*tmp/1019 i64)
 (local $*tmp/0/1020 i32)
 (local $*tmp/1/1020 i32)
 (local $*tmp/2/1020 i32)
 (local $*tmp/1021 i32)
 (local $*tmp/1022 i64)
 (local $*tmp/1023 i32)
 (local $*tmp/0/1024 i32)
 (local $*tmp/1/1024 i32)
 (local $*tmp/2/1024 i32)
 (local $*tmp/1025 i32)
 (local $*tmp/1026 i64)
 (local $*tmp/0/1027 i32)
 (local $*tmp/1/1027 i32)
 (local $*tmp/2/1027 i32)
 (local $*tmp/1028 i32)
 (local $*tmp/1029 i32)
 (local $*tmp/1030 i32)
 (local $*tmp/1031 i64)
 (local $*tmp/1032 i32)
 (local $*tmp/1033 i32)
 (local $*field/0/1676 i32)
 (local $*field/1/1676 i32)
 (local $*field/2/1676 i32)
 (local $*field/0/1677 i32)
 (local $*field/1/1677 i32)
 (local $*field/2/1677 i32)
 (local $*field/0/1678 i32)
 (local $*field/1/1678 i32)
 (local $*field/2/1678 i32)
 (local $*field/0/1679 i32)
 (local $*field/1/1679 i32)
 (local $*field/2/1679 i32)
 (local $*cnt/1736 i32)
 (local $*new_cnt/1737 i32)
 (local $*cnt/1738 i32)
 (local $*new_cnt/1739 i32)
 (local $ptr/1819 i32)
 (block $join:116
  (local.set $*tmp/1002
   (i64.extend_i32_s
    (local.tee $*tmp/1003
     (call $moonbit.array_length
      (local.get $repr/117)))))
  (call $moonbit.incref
   (local.get $repr/117))
  (if (result i32)
   (call $String::char_length_ge.inner
    (local.get $repr/117)
    (i32.const 1)
    (i32.const 0)
    (local.get $*tmp/1002))
   (then
    (if (result i32)
     (i32.eq
      (local.tee $*x/118
       (local.tee $*tmp/1033
        (i32.load16_u offset=8
         (i32.add
          (local.get $repr/117)
          (i32.shl
           (i32.const 0)
           (i32.const 1))))))
      (i32.const 64))
     (then
      (local.set $*tmp/1031
       (i64.extend_i32_s
        (local.tee $*tmp/1032
         (call $moonbit.array_length
          (local.get $repr/117)))))
      (call $moonbit.incref
       (local.get $repr/117))
      (local.set $*tmp/1029
       (if (result i32)
        (i64.eq
         (local.tee $*bind/539
          (call $String::offset_of_nth_char.inner
           (local.get $repr/117)
           (i32.const 1)
           (i32.const 0)
           (local.get $*tmp/1031)))
         (i64.const 4294967296))
        (then
         (call $moonbit.array_length
          (local.get $repr/117)))
        (else
         (i32.wrap_i64
          (local.tee $*Some/120
           (local.get $*bind/539))))))
      (local.set $*tmp/1030
       (call $moonbit.array_length
        (local.get $repr/117)))
      (local.get $repr/117)
      (local.get $*tmp/1029)
      (local.set $*x/2/119
       (local.get $*tmp/1030))
      (local.set $*x/1/119)
      (local.set $*x/0/119)
      (local.set $*tmp/1028
       (call $moonbit.array_length
        (global.get $moonbitlang/core/builtin.parse.*bind|5440)))
      (call $moonbit.incref
       (global.get $moonbitlang/core/builtin.parse.*bind|5440))
      (global.get $moonbitlang/core/builtin.parse.*bind|5440)
      (i32.const 0)
      (local.set $*tmp/2/1027
       (local.get $*tmp/1028))
      (local.set $*tmp/1/1027)
      (local.set $*tmp/0/1027)
      (call $moonbit.incref
       (local.get $*x/0/119))
      (if (result i32)
       (i64.eq
        (local.tee $*bind/121
         (call $StringView::find
          (local.get $*x/0/119)
          (local.get $*x/1/119)
          (local.get $*x/2/119)
          (local.get $*tmp/0/1027)
          (local.get $*tmp/1/1027)
          (local.get $*tmp/2/1027)))
        (i64.const 4294967296))
       (then
        (call $moonbit.decref
         (local.get $*x/0/119))
        (unreachable))
       (else
        (local.set $*tmp/1026
         (i64.extend_i32_s
          (local.tee $*pkg_end/123
           (i32.wrap_i64
            (local.tee $*Some/122
             (local.get $*bind/121))))))
        (call $moonbit.incref
         (local.get $*x/0/119))
        (call $StringView::view.inner
         (local.get $*x/0/119)
         (local.get $*x/1/119)
         (local.get $*x/2/119)
         (i32.const 0)
         (local.get $*tmp/1026))
        (local.set $pkg/2/124)
        (local.set $pkg/1/124)
        (local.set $pkg/0/124)
        (local.set $*tmp/1025
         (call $moonbit.array_length
          (global.get $moonbitlang/core/builtin.parse.*bind|5434)))
        (call $moonbit.incref
         (global.get $moonbitlang/core/builtin.parse.*bind|5434))
        (global.get $moonbitlang/core/builtin.parse.*bind|5434)
        (i32.const 0)
        (local.set $*tmp/2/1024
         (local.get $*tmp/1025))
        (local.set $*tmp/1/1024)
        (local.set $*tmp/0/1024)
        (call $moonbit.incref
         (local.get $*x/0/119))
        (if (result i32)
         (i64.eq
          (local.tee $*bind/125
           (call $StringView::rev_find
            (local.get $*x/0/119)
            (local.get $*x/1/119)
            (local.get $*x/2/119)
            (local.get $*tmp/0/1024)
            (local.get $*tmp/1/1024)
            (local.get $*tmp/2/1024)))
          (i64.const 4294967296))
         (then
          (call $moonbit.decref
           (local.get $pkg/0/124))
          (call $moonbit.decref
           (local.get $*x/0/119))
          (unreachable))
         (else
          (local.set $*tmp/1004
           (i32.add
            (local.tee $*start_loc_end/127
             (i32.wrap_i64
              (local.tee $*Some/126
               (local.get $*bind/125))))
            (i32.const 1)))
          (local.set $end/1006
           (local.get $*x/2/119))
          (local.set $start/1007
           (local.get $*x/1/119))
          (local.set $*tmp/1005
           (i32.sub
            (local.get $end/1006)
            (local.get $start/1007)))
          (if (result i32)
           (i32.lt_s
            (local.get $*tmp/1004)
            (local.get $*tmp/1005))
           (then
            (local.set $*tmp/1023
             (i32.add
              (local.get $*start_loc_end/127)
              (i32.const 1)))
            (call $moonbit.incref
             (local.get $*x/0/119))
            (call $StringView::view.inner
             (local.get $*x/0/119)
             (local.get $*x/1/119)
             (local.get $*x/2/119)
             (local.get $*tmp/1023)
             (i64.const 4294967296))
            (local.set $end_loc/2/128)
            (local.set $end_loc/1/128)
            (local.tee $end_loc/0/128)
            (local.get $end_loc/1/128)
            (local.get $end_loc/2/128)
            (call $moonbitlang/core/builtin.parse.parse_loc|1101)
            (local.tee $*bind/129)
            (i32.const 0)
            (i32.eq)
            (if (result i32)
             (then
              (if
               (local.get $*bind/129)
               (then
                (call $moonbit.decref
                 (local.get $*bind/129)))
               (else))
              (call $moonbit.decref
               (local.get $pkg/0/124))
              (call $moonbit.decref
               (local.get $*x/0/119))
              (unreachable))
             (else
              (i32.load offset=24
               (local.tee $*x/131
                (local.tee $*Some/130
                 (local.get $*bind/129))))
              (i32.load offset=8
               (local.get $*x/131))
              (local.set $*field/2/1679
               (i32.load offset=12
                (local.get $*x/131)))
              (local.set $*field/1/1679)
              (local.tee $*field/0/1679)
              (local.get $*field/1/1679)
              (local.set $*end_line/2/132
               (local.get $*field/2/1679))
              (local.set $*end_line/1/132)
              (local.set $*end_line/0/132)
              (i32.load offset=28
               (local.get $*x/131))
              (i32.load offset=16
               (local.get $*x/131))
              (local.set $*field/2/1678
               (i32.load offset=20
                (local.get $*x/131)))
              (local.set $*field/1/1678)
              (local.set $*field/0/1678)
              (if
               (i32.gt_s
                (local.tee $*cnt/1736
                 (i32.load
                  (local.get $*x/131)))
                (i32.const 1))
               (then
                (call $moonbit.incref
                 (local.get $*field/0/1678))
                (call $moonbit.incref
                 (local.get $*end_line/0/132))
                (local.set $*new_cnt/1737
                 (i32.sub
                  (local.get $*cnt/1736)
                  (i32.const 1)))
                (i32.store
                 (local.get $*x/131)
                 (local.get $*new_cnt/1737)))
               (else
                (if
                 (i32.eq
                  (local.get $*cnt/1736)
                  (i32.const 1))
                 (then
                  (call $moonbit.free
                   (local.get $*x/131)))
                 (else))))
              (local.get $*field/0/1678)
              (local.get $*field/1/1678)
              (local.set $*end_column/2/133
               (local.get $*field/2/1678))
              (local.set $*end_column/1/133)
              (local.set $*end_column/0/133)
              (local.set $*tmp/1022
               (i64.extend_i32_s
                (local.get $*start_loc_end/127)))
              (call $StringView::view.inner
               (local.get $*x/0/119)
               (local.get $*x/1/119)
               (local.get $*x/2/119)
               (i32.const 0)
               (local.get $*tmp/1022))
              (local.set $rest/2/134)
              (local.set $rest/1/134)
              (local.set $rest/0/134)
              (block $join:135
               (local.set $*tmp/1021
                (call $moonbit.array_length
                 (global.get $moonbitlang/core/builtin.parse.*bind|5421)))
               (call $moonbit.incref
                (global.get $moonbitlang/core/builtin.parse.*bind|5421))
               (global.get $moonbitlang/core/builtin.parse.*bind|5421)
               (i32.const 0)
               (local.set $*tmp/2/1020
                (local.get $*tmp/1021))
               (local.set $*tmp/1/1020)
               (local.set $*tmp/0/1020)
               (call $moonbit.incref
                (local.get $rest/0/134))
               (if (result i32)
                (i64.eq
                 (local.tee $*bind/136
                  (call $StringView::rev_find
                   (local.get $rest/0/134)
                   (local.get $rest/1/134)
                   (local.get $rest/2/134)
                   (local.get $*tmp/0/1020)
                   (local.get $*tmp/1/1020)
                   (local.get $*tmp/2/1020)))
                 (i64.const 4294967296))
                (then
                 (call $moonbit.decref
                  (local.get $rest/0/134))
                 (call $moonbit.decref
                  (local.get $*end_column/0/133))
                 (call $moonbit.decref
                  (local.get $*end_line/0/132))
                 (call $moonbit.decref
                  (local.get $pkg/0/124))
                 (br $join:135))
                (else
                 (local.set $*tmp/1019
                  (i64.extend_i32_s
                   (local.tee $*start_line_end/138
                    (i32.wrap_i64
                     (local.tee $*Some/137
                      (local.get $*bind/136))))))
                 (call $moonbit.incref
                  (local.get $rest/0/134))
                 (call $StringView::view.inner
                  (local.get $rest/0/134)
                  (local.get $rest/1/134)
                  (local.get $rest/2/134)
                  (i32.const 0)
                  (local.get $*tmp/1019))
                 (local.set $*tmp/2/1016)
                 (local.set $*tmp/1/1016)
                 (local.set $*tmp/0/1016)
                 (local.set $*tmp/1018
                  (call $moonbit.array_length
                   (global.get $moonbitlang/core/builtin.parse.*bind|5415)))
                 (call $moonbit.incref
                  (global.get $moonbitlang/core/builtin.parse.*bind|5415))
                 (global.get $moonbitlang/core/builtin.parse.*bind|5415)
                 (i32.const 0)
                 (local.set $*tmp/2/1017
                  (local.get $*tmp/1018))
                 (local.set $*tmp/1/1017)
                 (local.set $*tmp/0/1017)
                 (if (result i32)
                  (i64.eq
                   (local.tee $*bind/139
                    (call $StringView::rev_find
                     (local.get $*tmp/0/1016)
                     (local.get $*tmp/1/1016)
                     (local.get $*tmp/2/1016)
                     (local.get $*tmp/0/1017)
                     (local.get $*tmp/1/1017)
                     (local.get $*tmp/2/1017)))
                   (i64.const 4294967296))
                  (then
                   (call $moonbit.decref
                    (local.get $rest/0/134))
                   (call $moonbit.decref
                    (local.get $*end_column/0/133))
                   (call $moonbit.decref
                    (local.get $*end_line/0/132))
                   (call $moonbit.decref
                    (local.get $pkg/0/124))
                   (br $join:135))
                  (else
                   (local.set $*tmp/1008
                    (i32.add
                     (local.tee $*filename_end/141
                      (i32.wrap_i64
                       (local.tee $*Some/140
                        (local.get $*bind/139))))
                     (i32.const 1)))
                   (local.set $end/1010
                    (local.get $rest/2/134))
                   (local.set $start/1011
                    (local.get $rest/1/134))
                   (local.set $*tmp/1009
                    (i32.sub
                     (local.get $end/1010)
                     (local.get $start/1011)))
                   (if (result i32)
                    (i32.lt_s
                     (local.get $*tmp/1008)
                     (local.get $*tmp/1009))
                    (then
                     (local.set $*tmp/1015
                      (i32.add
                       (local.get $*filename_end/141)
                       (i32.const 1)))
                     (call $moonbit.incref
                      (local.get $rest/0/134))
                     (call $StringView::view.inner
                      (local.get $rest/0/134)
                      (local.get $rest/1/134)
                      (local.get $rest/2/134)
                      (local.get $*tmp/1015)
                      (i64.const 4294967296))
                     (local.set $start_loc/2/142)
                     (local.set $start_loc/1/142)
                     (local.tee $start_loc/0/142)
                     (local.get $start_loc/1/142)
                     (local.get $start_loc/2/142)
                     (call $moonbitlang/core/builtin.parse.parse_loc|1101)
                     (local.tee $*bind/143)
                     (i32.const 0)
                     (i32.eq)
                     (if (result i32)
                      (then
                       (if
                        (local.get $*bind/143)
                        (then
                         (call $moonbit.decref
                          (local.get $*bind/143)))
                        (else))
                       (call $moonbit.decref
                        (local.get $rest/0/134))
                       (call $moonbit.decref
                        (local.get $*end_column/0/133))
                       (call $moonbit.decref
                        (local.get $*end_line/0/132))
                       (call $moonbit.decref
                        (local.get $pkg/0/124))
                       (unreachable))
                      (else
                       (i32.load offset=24
                        (local.tee $*x/145
                         (local.tee $*Some/144
                          (local.get $*bind/143))))
                       (i32.load offset=8
                        (local.get $*x/145))
                       (local.set $*field/2/1677
                        (i32.load offset=12
                         (local.get $*x/145)))
                       (local.set $*field/1/1677)
                       (local.tee $*field/0/1677)
                       (local.get $*field/1/1677)
                       (local.set $*start_line/2/146
                        (local.get $*field/2/1677))
                       (local.set $*start_line/1/146)
                       (local.set $*start_line/0/146)
                       (i32.load offset=28
                        (local.get $*x/145))
                       (i32.load offset=16
                        (local.get $*x/145))
                       (local.set $*field/2/1676
                        (i32.load offset=20
                         (local.get $*x/145)))
                       (local.set $*field/1/1676)
                       (local.set $*field/0/1676)
                       (if
                        (i32.gt_s
                         (local.tee $*cnt/1738
                          (i32.load
                           (local.get $*x/145)))
                         (i32.const 1))
                        (then
                         (call $moonbit.incref
                          (local.get $*field/0/1676))
                         (call $moonbit.incref
                          (local.get $*start_line/0/146))
                         (local.set $*new_cnt/1739
                          (i32.sub
                           (local.get $*cnt/1738)
                           (i32.const 1)))
                         (i32.store
                          (local.get $*x/145)
                          (local.get $*new_cnt/1739)))
                        (else
                         (if
                          (i32.eq
                           (local.get $*cnt/1738)
                           (i32.const 1))
                          (then
                           (call $moonbit.free
                            (local.get $*x/145)))
                          (else))))
                       (local.get $*field/0/1676)
                       (local.get $*field/1/1676)
                       (local.set $*start_column/2/147
                        (local.get $*field/2/1676))
                       (local.set $*start_column/1/147)
                       (local.set $*start_column/0/147)
                       (local.set $*tmp/1012
                        (i32.add
                         (local.get $*pkg_end/123)
                         (i32.const 1)))
                       (if (result i32)
                        (i32.gt_s
                         (local.get $*filename_end/141)
                         (local.get $*tmp/1012))
                        (then
                         (local.set $*tmp/1013
                          (i32.add
                           (local.get $*pkg_end/123)
                           (i32.const 1)))
                         (local.set $*tmp/1014
                          (i64.extend_i32_s
                           (local.get $*filename_end/141)))
                         (call $StringView::view.inner
                          (local.get $rest/0/134)
                          (local.get $rest/1/134)
                          (local.get $rest/2/134)
                          (local.get $*tmp/1013)
                          (local.get $*tmp/1014))
                         (local.set $filename/2/148)
                         (local.set $filename/1/148)
                         (local.set $filename/0/148)
                         (i32.store offset=4
                          (local.tee $ptr/1819
                           (call $moonbit.gc.malloc
                            (i32.const 72)))
                          (i32.const 7341568))
                         (i32.store offset=76
                          (local.get $ptr/1819)
                          (local.get $*end_column/0/133))
                         (i32.store offset=48
                          (local.get $ptr/1819)
                          (local.get $*end_column/1/133))
                         (i32.store offset=52
                          (local.get $ptr/1819)
                          (local.get $*end_column/2/133))
                         (i32.store offset=72
                          (local.get $ptr/1819)
                          (local.get $*end_line/0/132))
                         (i32.store offset=40
                          (local.get $ptr/1819)
                          (local.get $*end_line/1/132))
                         (i32.store offset=44
                          (local.get $ptr/1819)
                          (local.get $*end_line/2/132))
                         (i32.store offset=68
                          (local.get $ptr/1819)
                          (local.get $*start_column/0/147))
                         (i32.store offset=32
                          (local.get $ptr/1819)
                          (local.get $*start_column/1/147))
                         (i32.store offset=36
                          (local.get $ptr/1819)
                          (local.get $*start_column/2/147))
                         (i32.store offset=64
                          (local.get $ptr/1819)
                          (local.get $*start_line/0/146))
                         (i32.store offset=24
                          (local.get $ptr/1819)
                          (local.get $*start_line/1/146))
                         (i32.store offset=28
                          (local.get $ptr/1819)
                          (local.get $*start_line/2/146))
                         (i32.store offset=60
                          (local.get $ptr/1819)
                          (local.get $filename/0/148))
                         (i32.store offset=16
                          (local.get $ptr/1819)
                          (local.get $filename/1/148))
                         (i32.store offset=20
                          (local.get $ptr/1819)
                          (local.get $filename/2/148))
                         (i32.store offset=56
                          (local.get $ptr/1819)
                          (local.get $pkg/0/124))
                         (i32.store offset=8
                          (local.get $ptr/1819)
                          (local.get $pkg/1/124))
                         (i32.store offset=12
                          (local.get $ptr/1819)
                          (local.get $pkg/2/124))
                         (local.get $ptr/1819))
                        (else
                         (call $moonbit.decref
                          (local.get $*start_column/0/147))
                         (call $moonbit.decref
                          (local.get $*start_line/0/146))
                         (call $moonbit.decref
                          (local.get $rest/0/134))
                         (call $moonbit.decref
                          (local.get $*end_column/0/133))
                         (call $moonbit.decref
                          (local.get $*end_line/0/132))
                         (call $moonbit.decref
                          (local.get $pkg/0/124))
                         (unreachable))))))
                    (else
                     (call $moonbit.decref
                      (local.get $rest/0/134))
                     (call $moonbit.decref
                      (local.get $*end_column/0/133))
                     (call $moonbit.decref
                      (local.get $*end_line/0/132))
                     (call $moonbit.decref
                      (local.get $pkg/0/124))
                     (unreachable)))))))
               (return))
              (unreachable))))
           (else
            (call $moonbit.decref
             (local.get $pkg/0/124))
            (call $moonbit.decref
             (local.get $*x/0/119))
            (unreachable))))))))
     (else
      (call $moonbit.decref
       (local.get $repr/117))
      (br $join:116))))
   (else
    (call $moonbit.decref
     (local.get $repr/117))
    (br $join:116)))
  (return))
 (unreachable))
(func $moonbitlang/core/builtin.parse.parse_loc|1101 (param $view/0/113 i32) (param $view/1/113 i32) (param $view/2/113 i32) (result i32)
 (local $*bind/112 i64)
 (local $*Some/114 i64)
 (local $*i/115 i32)
 (local $*tmp/991 i32)
 (local $*tmp/992 i32)
 (local $end/993 i32)
 (local $start/994 i32)
 (local $*tuple/995 i32)
 (local $*tmp/0/996 i32)
 (local $*tmp/1/996 i32)
 (local $*tmp/2/996 i32)
 (local $*tmp/0/997 i32)
 (local $*tmp/1/997 i32)
 (local $*tmp/2/997 i32)
 (local $*tmp/998 i32)
 (local $*tmp/999 i64)
 (local $*tmp/0/1000 i32)
 (local $*tmp/1/1000 i32)
 (local $*tmp/2/1000 i32)
 (local $*tmp/1001 i32)
 (local $ptr/1820 i32)
 (local.set $*tmp/1001
  (call $moonbit.array_length
   (global.get $moonbitlang/core/builtin.parse.*bind|5401)))
 (call $moonbit.incref
  (global.get $moonbitlang/core/builtin.parse.*bind|5401))
 (global.get $moonbitlang/core/builtin.parse.*bind|5401)
 (i32.const 0)
 (local.set $*tmp/2/1000
  (local.get $*tmp/1001))
 (local.set $*tmp/1/1000)
 (local.set $*tmp/0/1000)
 (call $moonbit.incref
  (local.get $view/0/113))
 (if (result i32)
  (i64.eq
   (local.tee $*bind/112
    (call $StringView::find
     (local.get $view/0/113)
     (local.get $view/1/113)
     (local.get $view/2/113)
     (local.get $*tmp/0/1000)
     (local.get $*tmp/1/1000)
     (local.get $*tmp/2/1000)))
   (i64.const 4294967296))
  (then
   (call $moonbit.decref
    (local.get $view/0/113))
   (i32.const 0))
  (else
   (if (result i32)
    (if (result i32)
     (i32.gt_s
      (local.tee $*i/115
       (i32.wrap_i64
        (local.tee $*Some/114
         (local.get $*bind/112))))
      (i32.const 0))
     (then
      (local.set $*tmp/991
       (i32.add
        (local.get $*i/115)
        (i32.const 1)))
      (local.set $end/993
       (local.get $view/2/113))
      (local.set $start/994
       (local.get $view/1/113))
      (local.set $*tmp/992
       (i32.sub
        (local.get $end/993)
        (local.get $start/994)))
      (i32.lt_s
       (local.get $*tmp/991)
       (local.get $*tmp/992)))
     (else
      (i32.const 0)))
    (then
     (local.set $*tmp/999
      (i64.extend_i32_s
       (local.get $*i/115)))
     (call $moonbit.incref
      (local.get $view/0/113))
     (call $StringView::view.inner
      (local.get $view/0/113)
      (local.get $view/1/113)
      (local.get $view/2/113)
      (i32.const 0)
      (local.get $*tmp/999))
     (local.set $*tmp/2/996)
     (local.set $*tmp/1/996)
     (local.set $*tmp/0/996)
     (local.set $*tmp/998
      (i32.add
       (local.get $*i/115)
       (i32.const 1)))
     (call $StringView::view.inner
      (local.get $view/0/113)
      (local.get $view/1/113)
      (local.get $view/2/113)
      (local.get $*tmp/998)
      (i64.const 4294967296))
     (local.set $*tmp/2/997)
     (local.set $*tmp/1/997)
     (local.set $*tmp/0/997)
     (i32.store offset=4
      (local.tee $ptr/1820
       (call $moonbit.gc.malloc
        (i32.const 24)))
      (i32.const 3146240))
     (i32.store offset=28
      (local.get $ptr/1820)
      (local.get $*tmp/0/997))
     (i32.store offset=16
      (local.get $ptr/1820)
      (local.get $*tmp/1/997))
     (i32.store offset=20
      (local.get $ptr/1820)
      (local.get $*tmp/2/997))
     (i32.store offset=24
      (local.get $ptr/1820)
      (local.get $*tmp/0/996))
     (i32.store offset=8
      (local.get $ptr/1820)
      (local.get $*tmp/1/996))
     (i32.store offset=12
      (local.get $ptr/1820)
      (local.get $*tmp/2/996))
     (local.tee $*tuple/995
      (local.get $ptr/1820)))
    (else
     (call $moonbit.decref
      (local.get $view/0/113))
     (i32.const 0))))))
(func $StringView::view.inner (param $self/0/110 i32) (param $self/1/110 i32) (param $self/2/110 i32) (param $start_offset/111 i32) (param $end_offset/108 i64) (result i32) (result i32) (result i32)
 (local $end_offset/107 i32)
 (local $*Some/109 i64)
 (local $*tmp/981 i32)
 (local $end/982 i32)
 (local $start/983 i32)
 (local $str/984 i32)
 (local $*tmp/985 i32)
 (local $*tmp/986 i32)
 (local $start/987 i32)
 (local $start/988 i32)
 (local $end/989 i32)
 (local $start/990 i32)
 (local $*field/1680 i32)
 (local $*field/1681 i32)
 (local.set $end_offset/107
  (if (result i32)
   (i64.eq
    (local.get $end_offset/108)
    (i64.const 4294967296))
   (then
    (local.set $end/989
     (local.get $self/2/110))
    (local.set $start/990
     (local.get $self/1/110))
    (i32.sub
     (local.get $end/989)
     (local.get $start/990)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/109
      (local.get $end_offset/108))))))
 (if (result i32) (result i32) (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $start_offset/111)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.le_s
      (local.get $start_offset/111)
      (local.get $end_offset/107))
     (then
      (local.set $end/982
       (local.get $self/2/110))
      (local.set $start/983
       (local.get $self/1/110))
      (local.set $*tmp/981
       (i32.sub
        (local.get $end/982)
        (local.get $start/983)))
      (i32.le_s
       (local.get $end_offset/107)
       (local.get $*tmp/981)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (local.set $str/984
    (local.tee $*field/1681
     (local.get $self/0/110)))
   (local.set $*tmp/985
    (i32.add
     (local.tee $start/988
      (local.get $self/1/110))
     (local.get $start_offset/111)))
   (local.set $*tmp/986
    (i32.add
     (local.tee $start/987
      (local.tee $*field/1680
       (local.get $self/1/110)))
     (local.get $end_offset/107)))
   (local.get $str/984)
   (local.get $*tmp/985)
   (local.get $*tmp/986))
  (else
   (call $moonbit.decref
    (local.get $self/0/110))
   (call $moonbitlang/core/builtin.abort|StringView|
    (i32.const 11064)
    (i32.const 10944)))))
(func $StringView::rev_find (param $self/0/106 i32) (param $self/1/106 i32) (param $self/2/106 i32) (param $str/0/105 i32) (param $str/1/105 i32) (param $str/2/105 i32) (result i64)
 (local $*tmp/978 i32)
 (local $end/979 i32)
 (local $start/980 i32)
 (local.set $end/979
  (local.get $str/2/105))
 (local.set $start/980
  (local.get $str/1/105))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/978
    (i32.sub
     (local.get $end/979)
     (local.get $start/980)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_rev_find
    (local.get $self/0/106)
    (local.get $self/1/106)
    (local.get $self/2/106)
    (local.get $str/0/105)
    (local.get $str/1/105)
    (local.get $str/2/105)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_rev_find
    (local.get $self/0/106)
    (local.get $self/1/106)
    (local.get $self/2/106)
    (local.get $str/0/105)
    (local.get $str/1/105)
    (local.get $str/2/105)))))
(func $moonbitlang/core/builtin.brute_force_rev_find (param $haystack/0/96 i32) (param $haystack/1/96 i32) (param $haystack/2/96 i32) (param $needle/0/98 i32) (param $needle/1/98 i32) (param $needle/2/98 i32) (result i64)
 (local $haystack_len/95 i32)
 (local $needle_len/97 i32)
 (local $needle_first/99 i32)
 (local $j/102 i32)
 (local $*p/618 i32)
 (local $*p/621 i32)
 (local $*p/624 i32)
 (local $*tmp/951 i32)
 (local $*tmp/952 i32)
 (local $str/953 i32)
 (local $*tmp/954 i32)
 (local $start/955 i32)
 (local $*tmp/956 i32)
 (local $*tmp/957 i32)
 (local $*tmp/958 i32)
 (local $*tmp/959 i32)
 (local $*tmp/960 i32)
 (local $str/961 i32)
 (local $*tmp/962 i32)
 (local $start/963 i32)
 (local $str/964 i32)
 (local $*tmp/965 i32)
 (local $start/966 i32)
 (local $*tmp/967 i32)
 (local $*tmp/968 i32)
 (local $*tmp/969 i32)
 (local $*tmp/970 i32)
 (local $str/971 i32)
 (local $*tmp/972 i32)
 (local $start/973 i32)
 (local $end/974 i32)
 (local $start/975 i32)
 (local $end/976 i32)
 (local $start/977 i32)
 (local $*tmp/1682 i32)
 (local $*field/1683 i32)
 (local $*tmp/1684 i32)
 (local $*field/1685 i32)
 (local $*tmp/1686 i32)
 (local $*field/1687 i32)
 (local $*tmp/1688 i32)
 (local $*field/1689 i32)
 (local $i/100 i32)
 (local.set $end/976
  (local.get $haystack/2/96))
 (local.set $start/977
  (local.get $haystack/1/96))
 (local.set $haystack_len/95
  (i32.sub
   (local.get $end/976)
   (local.get $start/977)))
 (local.set $end/974
  (local.get $needle/2/98))
 (local.set $start/975
  (local.get $needle/1/98))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/97
    (i32.sub
     (local.get $end/974)
     (local.get $start/975)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/95)
     (local.get $needle_len/97))
    (then
     (local.set $*p/618
      (i32.const 0))
     (local.set $str/971
      (local.tee $*field/1689
       (local.get $needle/0/98)))
     (local.set $*tmp/972
      (i32.add
       (local.tee $start/973
        (local.get $needle/1/98))
       (local.get $*p/618)))
     (local.set $needle_first/99
      (local.tee $*tmp/1688
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/971)
         (i32.shl
          (local.get $*tmp/972)
          (i32.const 1))))))
     (local.set $i/100
      (i32.sub
       (local.get $haystack_len/95)
       (local.get $needle_len/97)))
     (loop $loop:104
      (if
       (i32.ge_s
        (local.tee $*tmp/951
         (local.get $i/100))
        (i32.const 0))
       (then
        (loop $loop:101
         (if
          (if (result i32)
           (i32.ge_s
            (local.tee $*tmp/956
             (local.get $i/100))
            (i32.const 0))
           (then
            (local.set $*p/621
             (local.get $i/100))
            (local.set $str/953
             (local.tee $*field/1687
              (local.get $haystack/0/96)))
            (local.set $*tmp/954
             (i32.add
              (local.tee $start/955
               (local.get $haystack/1/96))
              (local.get $*p/621)))
            (local.tee $*tmp/952
             (local.tee $*tmp/1686
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/953)
                (i32.shl
                 (local.get $*tmp/954)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/99)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/100
            (i32.sub
             (local.tee $*tmp/957
              (local.get $i/100))
             (i32.const 1)))
           (br $loop:101))
          (else)))
        (if
         (i32.ge_s
          (local.tee $*tmp/958
           (local.get $i/100))
          (i32.const 0))
         (then
          (block $break:103
           (i32.const 1)
           (loop $loop:103 (param i32)
            (local.tee $j/102)
            (local.get $needle_len/97)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/624
               (i32.add
                (local.tee $*tmp/967
                 (local.get $i/100))
                (local.get $j/102)))
              (local.set $str/964
               (local.tee $*field/1685
                (local.get $haystack/0/96)))
              (local.set $*tmp/965
               (i32.add
                (local.tee $start/966
                 (local.get $haystack/1/96))
                (local.get $*p/624)))
              (local.set $*tmp/959
               (local.tee $*tmp/1684
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/964)
                  (i32.shl
                   (local.get $*tmp/965)
                   (i32.const 1))))))
              (local.set $str/961
               (local.tee $*field/1683
                (local.get $needle/0/98)))
              (local.set $*tmp/962
               (i32.add
                (local.tee $start/963
                 (local.get $needle/1/98))
                (local.get $j/102)))
              (local.set $*tmp/960
               (local.tee $*tmp/1682
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/961)
                  (i32.shl
                   (local.get $*tmp/962)
                   (i32.const 1))))))
              (local.get $*tmp/959)
              (if
               (i32.ne
                (local.get $*tmp/960))
               (then
                (br $break:103))
               (else))
              (local.tee $*tmp/968
               (i32.add
                (local.get $j/102)
                (i32.const 1)))
              (br $loop:103))
             (else
              (call $moonbit.decref
               (local.get $needle/0/98))
              (call $moonbit.decref
               (local.get $haystack/0/96))
              (i64.extend_i32_s
               (local.tee $*tmp/969
                (local.get $i/100)))
              (return)))))
          (local.set $i/100
           (i32.sub
            (local.tee $*tmp/970
             (local.get $i/100))
            (i32.const 1))))
         (else))
        (br $loop:104))
       (else
        (call $moonbit.decref
         (local.get $needle/0/98))
        (call $moonbit.decref
         (local.get $haystack/0/96)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/98))
     (call $moonbit.decref
      (local.get $haystack/0/96))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/98))
   (call $moonbit.decref
    (local.get $haystack/0/96))
   (i64.extend_i32_s
    (local.get $haystack_len/95)))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_rev_find (param $haystack/0/85 i32) (param $haystack/1/85 i32) (param $haystack/2/85 i32) (param $needle/0/87 i32) (param $needle/1/87 i32) (param $needle/2/87 i32) (result i64)
 (local $haystack_len/84 i32)
 (local $needle_len/86 i32)
 (local $skip_table/88 i32)
 (local $i/89 i32)
 (local $i/91 i32)
 (local $j/92 i32)
 (local $*p/607 i32)
 (local $*tmp/923 i32)
 (local $*tmp/924 i32)
 (local $str/925 i32)
 (local $*tmp/926 i32)
 (local $start/927 i32)
 (local $*tmp/928 i32)
 (local $*tmp/929 i32)
 (local $*tmp/930 i32)
 (local $*tmp/931 i32)
 (local $str/932 i32)
 (local $*tmp/933 i32)
 (local $start/934 i32)
 (local $str/935 i32)
 (local $*tmp/936 i32)
 (local $start/937 i32)
 (local $*tmp/938 i32)
 (local $*tmp/939 i32)
 (local $*tmp/940 i32)
 (local $*tmp/941 i32)
 (local $*tmp/942 i32)
 (local $str/943 i32)
 (local $*tmp/944 i32)
 (local $start/945 i32)
 (local $*tmp/946 i32)
 (local $end/947 i32)
 (local $start/948 i32)
 (local $end/949 i32)
 (local $start/950 i32)
 (local $*tmp/1690 i32)
 (local $*field/1691 i32)
 (local $*tmp/1692 i32)
 (local $*field/1693 i32)
 (local $*tmp/1694 i32)
 (local $*field/1695 i32)
 (local $*tmp/1696 i32)
 (local $*field/1697 i32)
 (local $*arr/1821 i32)
 (local $*idx/1822 i32)
 (local $*arr/1823 i32)
 (local $*idx/1824 i32)
 (local.set $end/949
  (local.get $haystack/2/85))
 (local.set $start/950
  (local.get $haystack/1/85))
 (local.set $haystack_len/84
  (i32.sub
   (local.get $end/949)
   (local.get $start/950)))
 (local.set $end/947
  (local.get $needle/2/87))
 (local.set $start/948
  (local.get $needle/1/87))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/86
    (i32.sub
     (local.get $end/947)
     (local.get $start/948)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/84)
     (local.get $needle_len/86))
    (then
     (local.set $skip_table/88
      (call $moonbit.i32_array_make
       (i32.const 256)
       (local.get $needle_len/86)))
     (local.tee $*tmp/929
      (i32.sub
       (local.get $needle_len/86)
       (i32.const 1)))
     (loop $loop:90 (param i32)
      (local.tee $i/89)
      (i32.const 0)
      (i32.gt_s)
      (if
       (then
        (local.set $str/925
         (local.tee $*field/1697
          (local.get $needle/0/87)))
        (local.set $*tmp/926
         (i32.add
          (local.tee $start/927
           (local.get $needle/1/87))
          (local.get $i/89)))
        (local.set $*tmp/923
         (i32.and
          (local.tee $*tmp/924
           (local.tee $*tmp/1696
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/925)
              (i32.shl
               (local.get $*tmp/926)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/88)
        (local.set $*idx/1824
         (local.get $*tmp/923))
        (local.set $*arr/1823)
        (call $moonbit.check_range
         (local.get $*idx/1824)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1823))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1823)
          (i32.shl
           (local.get $*idx/1824)
           (i32.const 2)))
         (local.get $i/89))
        (local.tee $*tmp/928
         (i32.sub
          (local.get $i/89)
          (i32.const 1)))
        (br $loop:90))
       (else)))
     (local.tee $*tmp/946
      (i32.sub
       (local.get $haystack_len/84)
       (local.get $needle_len/86)))
     (loop $loop:94 (param i32)
      (local.tee $i/91)
      (i32.const 0)
      (i32.ge_s)
      (if
       (then
        (block $break:93
         (i32.const 0)
         (loop $loop:93 (param i32)
          (local.tee $j/92)
          (local.get $needle_len/86)
          (i32.lt_s)
          (if
           (then
            (local.set $*p/607
             (i32.add
              (local.get $i/91)
              (local.get $j/92)))
            (local.set $str/935
             (local.tee $*field/1695
              (local.get $haystack/0/85)))
            (local.set $*tmp/936
             (i32.add
              (local.tee $start/937
               (local.get $haystack/1/85))
              (local.get $*p/607)))
            (local.set $*tmp/930
             (local.tee $*tmp/1694
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/935)
                (i32.shl
                 (local.get $*tmp/936)
                 (i32.const 1))))))
            (local.set $str/932
             (local.tee $*field/1693
              (local.get $needle/0/87)))
            (local.set $*tmp/933
             (i32.add
              (local.tee $start/934
               (local.get $needle/1/87))
              (local.get $j/92)))
            (local.set $*tmp/931
             (local.tee $*tmp/1692
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/932)
                (i32.shl
                 (local.get $*tmp/933)
                 (i32.const 1))))))
            (local.get $*tmp/930)
            (if
             (i32.ne
              (local.get $*tmp/931))
             (then
              (br $break:93))
             (else))
            (local.tee $*tmp/938
             (i32.add
              (local.get $j/92)
              (i32.const 1)))
            (br $loop:93))
           (else
            (call $moonbit.decref
             (local.get $skip_table/88))
            (call $moonbit.decref
             (local.get $needle/0/87))
            (call $moonbit.decref
             (local.get $haystack/0/85))
            (i64.extend_i32_s
             (local.get $i/91))
            (return)))))
        (local.set $str/943
         (local.tee $*field/1691
          (local.get $haystack/0/85)))
        (local.set $*tmp/944
         (i32.add
          (local.tee $start/945
           (local.get $haystack/1/85))
          (local.get $i/91)))
        (local.set $*tmp/941
         (i32.and
          (local.tee $*tmp/942
           (local.tee $*tmp/1690
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/943)
              (i32.shl
               (local.get $*tmp/944)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/88)
        (local.set $*idx/1822
         (local.get $*tmp/941))
        (local.set $*arr/1821)
        (call $moonbit.check_range
         (local.get $*idx/1822)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1821))
          (i32.const 1)))
        (local.set $*tmp/940
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1821)
           (i32.shl
            (local.get $*idx/1822)
            (i32.const 2)))))
        (local.tee $*tmp/939
         (i32.sub
          (local.get $i/91)
          (local.get $*tmp/940)))
        (br $loop:94))
       (else
        (call $moonbit.decref
         (local.get $skip_table/88))
        (call $moonbit.decref
         (local.get $needle/0/87))
        (call $moonbit.decref
         (local.get $haystack/0/85)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/87))
     (call $moonbit.decref
      (local.get $haystack/0/85))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/87))
   (call $moonbit.decref
    (local.get $haystack/0/85))
   (i64.extend_i32_s
    (local.get $haystack_len/84)))))
(func $StringView::find (param $self/0/83 i32) (param $self/1/83 i32) (param $self/2/83 i32) (param $str/0/82 i32) (param $str/1/82 i32) (param $str/2/82 i32) (result i64)
 (local $*tmp/920 i32)
 (local $end/921 i32)
 (local $start/922 i32)
 (local.set $end/921
  (local.get $str/2/82))
 (local.set $start/922
  (local.get $str/1/82))
 (if (result i64)
  (i32.le_s
   (local.tee $*tmp/920
    (i32.sub
     (local.get $end/921)
     (local.get $start/922)))
   (i32.const 4))
  (then
   (call $moonbitlang/core/builtin.brute_force_find
    (local.get $self/0/83)
    (local.get $self/1/83)
    (local.get $self/2/83)
    (local.get $str/0/82)
    (local.get $str/1/82)
    (local.get $str/2/82)))
  (else
   (call $moonbitlang/core/builtin.boyer_moore_horspool_find
    (local.get $self/0/83)
    (local.get $self/1/83)
    (local.get $self/2/83)
    (local.get $str/0/82)
    (local.get $str/1/82)
    (local.get $str/2/82)))))
(func $moonbitlang/core/builtin.brute_force_find (param $haystack/0/72 i32) (param $haystack/1/72 i32) (param $haystack/2/72 i32) (param $needle/0/74 i32) (param $needle/1/74 i32) (param $needle/2/74 i32) (result i64)
 (local $haystack_len/71 i32)
 (local $needle_len/73 i32)
 (local $needle_first/75 i32)
 (local $forward_len/76 i32)
 (local $j/79 i32)
 (local $*p/588 i32)
 (local $*p/591 i32)
 (local $*p/594 i32)
 (local $*tmp/893 i32)
 (local $*tmp/894 i32)
 (local $str/895 i32)
 (local $*tmp/896 i32)
 (local $start/897 i32)
 (local $*tmp/898 i32)
 (local $*tmp/899 i32)
 (local $*tmp/900 i32)
 (local $*tmp/901 i32)
 (local $*tmp/902 i32)
 (local $str/903 i32)
 (local $*tmp/904 i32)
 (local $start/905 i32)
 (local $str/906 i32)
 (local $*tmp/907 i32)
 (local $start/908 i32)
 (local $*tmp/909 i32)
 (local $*tmp/910 i32)
 (local $*tmp/911 i32)
 (local $*tmp/912 i32)
 (local $str/913 i32)
 (local $*tmp/914 i32)
 (local $start/915 i32)
 (local $end/916 i32)
 (local $start/917 i32)
 (local $end/918 i32)
 (local $start/919 i32)
 (local $*tmp/1698 i32)
 (local $*field/1699 i32)
 (local $*tmp/1700 i32)
 (local $*field/1701 i32)
 (local $*tmp/1702 i32)
 (local $*field/1703 i32)
 (local $*tmp/1704 i32)
 (local $*field/1705 i32)
 (local $i/77 i32)
 (local.set $end/918
  (local.get $haystack/2/72))
 (local.set $start/919
  (local.get $haystack/1/72))
 (local.set $haystack_len/71
  (i32.sub
   (local.get $end/918)
   (local.get $start/919)))
 (local.set $end/916
  (local.get $needle/2/74))
 (local.set $start/917
  (local.get $needle/1/74))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/73
    (i32.sub
     (local.get $end/916)
     (local.get $start/917)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/71)
     (local.get $needle_len/73))
    (then
     (local.set $*p/588
      (i32.const 0))
     (local.set $str/913
      (local.tee $*field/1705
       (local.get $needle/0/74)))
     (local.set $*tmp/914
      (i32.add
       (local.tee $start/915
        (local.get $needle/1/74))
       (local.get $*p/588)))
     (local.set $needle_first/75
      (local.tee $*tmp/1704
       (i32.load16_u offset=8
        (i32.add
         (local.get $str/913)
         (i32.shl
          (local.get $*tmp/914)
          (i32.const 1))))))
     (local.set $forward_len/76
      (i32.sub
       (local.get $haystack_len/71)
       (local.get $needle_len/73)))
     (local.set $i/77
      (i32.const 0))
     (loop $loop:81
      (if
       (i32.le_s
        (local.tee $*tmp/893
         (local.get $i/77))
        (local.get $forward_len/76))
       (then
        (loop $loop:78
         (if
          (if (result i32)
           (i32.le_s
            (local.tee $*tmp/898
             (local.get $i/77))
            (local.get $forward_len/76))
           (then
            (local.set $*p/591
             (local.get $i/77))
            (local.set $str/895
             (local.tee $*field/1703
              (local.get $haystack/0/72)))
            (local.set $*tmp/896
             (i32.add
              (local.tee $start/897
               (local.get $haystack/1/72))
              (local.get $*p/591)))
            (local.tee $*tmp/894
             (local.tee $*tmp/1702
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/895)
                (i32.shl
                 (local.get $*tmp/896)
                 (i32.const 1))))))
            (i32.ne
             (local.get $needle_first/75)))
           (else
            (i32.const 0)))
          (then
           (local.set $i/77
            (i32.add
             (local.tee $*tmp/899
              (local.get $i/77))
             (i32.const 1)))
           (br $loop:78))
          (else)))
        (if
         (i32.le_s
          (local.tee $*tmp/900
           (local.get $i/77))
          (local.get $forward_len/76))
         (then
          (block $break:80
           (i32.const 1)
           (loop $loop:80 (param i32)
            (local.tee $j/79)
            (local.get $needle_len/73)
            (i32.lt_s)
            (if
             (then
              (local.set $*p/594
               (i32.add
                (local.tee $*tmp/909
                 (local.get $i/77))
                (local.get $j/79)))
              (local.set $str/906
               (local.tee $*field/1701
                (local.get $haystack/0/72)))
              (local.set $*tmp/907
               (i32.add
                (local.tee $start/908
                 (local.get $haystack/1/72))
                (local.get $*p/594)))
              (local.set $*tmp/901
               (local.tee $*tmp/1700
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/906)
                  (i32.shl
                   (local.get $*tmp/907)
                   (i32.const 1))))))
              (local.set $str/903
               (local.tee $*field/1699
                (local.get $needle/0/74)))
              (local.set $*tmp/904
               (i32.add
                (local.tee $start/905
                 (local.get $needle/1/74))
                (local.get $j/79)))
              (local.set $*tmp/902
               (local.tee $*tmp/1698
                (i32.load16_u offset=8
                 (i32.add
                  (local.get $str/903)
                  (i32.shl
                   (local.get $*tmp/904)
                   (i32.const 1))))))
              (local.get $*tmp/901)
              (if
               (i32.ne
                (local.get $*tmp/902))
               (then
                (br $break:80))
               (else))
              (local.tee $*tmp/910
               (i32.add
                (local.get $j/79)
                (i32.const 1)))
              (br $loop:80))
             (else
              (call $moonbit.decref
               (local.get $needle/0/74))
              (call $moonbit.decref
               (local.get $haystack/0/72))
              (i64.extend_i32_s
               (local.tee $*tmp/911
                (local.get $i/77)))
              (return)))))
          (local.set $i/77
           (i32.add
            (local.tee $*tmp/912
             (local.get $i/77))
            (i32.const 1))))
         (else))
        (br $loop:81))
       (else
        (call $moonbit.decref
         (local.get $needle/0/74))
        (call $moonbit.decref
         (local.get $haystack/0/72)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/74))
     (call $moonbit.decref
      (local.get $haystack/0/72))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/74))
   (call $moonbit.decref
    (local.get $haystack/0/72))
   (global.get $moonbitlang/core/builtin.brute_force_find.constr/70))))
(func $moonbitlang/core/builtin.boyer_moore_horspool_find (param $haystack/0/58 i32) (param $haystack/1/58 i32) (param $haystack/2/58 i32) (param $needle/0/60 i32) (param $needle/1/60 i32) (param $needle/2/60 i32) (result i64)
 (local $haystack_len/57 i32)
 (local $needle_len/59 i32)
 (local $skip_table/61 i32)
 (local $*end4298/62 i32)
 (local $i/63 i32)
 (local $i/65 i32)
 (local $*end4304/66 i32)
 (local $j/67 i32)
 (local $*p/576 i32)
 (local $*p/581 i32)
 (local $*tmp/863 i32)
 (local $*tmp/864 i32)
 (local $*tmp/865 i32)
 (local $*tmp/866 i32)
 (local $str/867 i32)
 (local $*tmp/868 i32)
 (local $start/869 i32)
 (local $*tmp/870 i32)
 (local $*tmp/871 i32)
 (local $*tmp/872 i32)
 (local $*tmp/873 i32)
 (local $str/874 i32)
 (local $*tmp/875 i32)
 (local $start/876 i32)
 (local $str/877 i32)
 (local $*tmp/878 i32)
 (local $start/879 i32)
 (local $*tmp/880 i32)
 (local $*tmp/881 i32)
 (local $*tmp/882 i32)
 (local $*tmp/883 i32)
 (local $*tmp/884 i32)
 (local $str/885 i32)
 (local $*tmp/886 i32)
 (local $start/887 i32)
 (local $*tmp/888 i32)
 (local $end/889 i32)
 (local $start/890 i32)
 (local $end/891 i32)
 (local $start/892 i32)
 (local $*tmp/1706 i32)
 (local $*field/1707 i32)
 (local $*tmp/1708 i32)
 (local $*field/1709 i32)
 (local $*tmp/1710 i32)
 (local $*field/1711 i32)
 (local $*tmp/1712 i32)
 (local $*field/1713 i32)
 (local $*arr/1825 i32)
 (local $*idx/1826 i32)
 (local $*arr/1827 i32)
 (local $*idx/1828 i32)
 (local.set $end/891
  (local.get $haystack/2/58))
 (local.set $start/892
  (local.get $haystack/1/58))
 (local.set $haystack_len/57
  (i32.sub
   (local.get $end/891)
   (local.get $start/892)))
 (local.set $end/889
  (local.get $needle/2/60))
 (local.set $start/890
  (local.get $needle/1/60))
 (if (result i64)
  (i32.gt_s
   (local.tee $needle_len/59
    (i32.sub
     (local.get $end/889)
     (local.get $start/890)))
   (i32.const 0))
  (then
   (if (result i64)
    (i32.ge_s
     (local.get $haystack_len/57)
     (local.get $needle_len/59))
    (then
     (local.set $skip_table/61
      (call $moonbit.i32_array_make
       (i32.const 256)
       (local.get $needle_len/59)))
     (local.set $*end4298/62
      (i32.sub
       (local.get $needle_len/59)
       (i32.const 1)))
     (i32.const 0)
     (loop $loop:64 (param i32)
      (local.tee $i/63)
      (local.get $*end4298/62)
      (i32.lt_s)
      (if
       (then
        (local.set $str/867
         (local.tee $*field/1713
          (local.get $needle/0/60)))
        (local.set $*tmp/868
         (i32.add
          (local.tee $start/869
           (local.get $needle/1/60))
          (local.get $i/63)))
        (local.set $*tmp/863
         (i32.and
          (local.tee $*tmp/866
           (local.tee $*tmp/1712
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/867)
              (i32.shl
               (local.get $*tmp/868)
               (i32.const 1))))))
          (i32.const 255)))
        (local.set $*tmp/864
         (i32.sub
          (local.tee $*tmp/865
           (i32.sub
            (local.get $needle_len/59)
            (i32.const 1)))
          (local.get $i/63)))
        (local.get $skip_table/61)
        (local.set $*idx/1828
         (local.get $*tmp/863))
        (local.set $*arr/1827)
        (call $moonbit.check_range
         (local.get $*idx/1828)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1827))
          (i32.const 1)))
        (i32.store offset=8
         (i32.add
          (local.get $*arr/1827)
          (i32.shl
           (local.get $*idx/1828)
           (i32.const 2)))
         (local.get $*tmp/864))
        (local.tee $*tmp/870
         (i32.add
          (local.get $i/63)
          (i32.const 1)))
        (br $loop:64))
       (else)))
     (i32.const 0)
     (loop $loop:69 (param i32)
      (local.set $i/65)
      (local.set $*tmp/871
       (i32.sub
        (local.get $haystack_len/57)
        (local.get $needle_len/59)))
      (if
       (i32.le_s
        (local.get $i/65)
        (local.get $*tmp/871))
       (then
        (local.set $*end4304/66
         (i32.sub
          (local.get $needle_len/59)
          (i32.const 1)))
        (block $break:68
         (i32.const 0)
         (loop $loop:68 (param i32)
          (local.tee $j/67)
          (local.get $*end4304/66)
          (i32.le_s)
          (if
           (then
            (local.set $*p/576
             (i32.add
              (local.get $i/65)
              (local.get $j/67)))
            (local.set $str/877
             (local.tee $*field/1711
              (local.get $haystack/0/58)))
            (local.set $*tmp/878
             (i32.add
              (local.tee $start/879
               (local.get $haystack/1/58))
              (local.get $*p/576)))
            (local.set $*tmp/872
             (local.tee $*tmp/1710
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/877)
                (i32.shl
                 (local.get $*tmp/878)
                 (i32.const 1))))))
            (local.set $str/874
             (local.tee $*field/1709
              (local.get $needle/0/60)))
            (local.set $*tmp/875
             (i32.add
              (local.tee $start/876
               (local.get $needle/1/60))
              (local.get $j/67)))
            (local.set $*tmp/873
             (local.tee $*tmp/1708
              (i32.load16_u offset=8
               (i32.add
                (local.get $str/874)
                (i32.shl
                 (local.get $*tmp/875)
                 (i32.const 1))))))
            (local.get $*tmp/872)
            (if
             (i32.ne
              (local.get $*tmp/873))
             (then
              (br $break:68))
             (else))
            (local.tee $*tmp/880
             (i32.add
              (local.get $j/67)
              (i32.const 1)))
            (br $loop:68))
           (else
            (call $moonbit.decref
             (local.get $skip_table/61))
            (call $moonbit.decref
             (local.get $needle/0/60))
            (call $moonbit.decref
             (local.get $haystack/0/58))
            (i64.extend_i32_s
             (local.get $i/65))
            (return)))))
        (local.set $*p/581
         (i32.sub
          (local.tee $*tmp/888
           (i32.add
            (local.get $i/65)
            (local.get $needle_len/59)))
          (i32.const 1)))
        (local.set $str/885
         (local.tee $*field/1707
          (local.get $haystack/0/58)))
        (local.set $*tmp/886
         (i32.add
          (local.tee $start/887
           (local.get $haystack/1/58))
          (local.get $*p/581)))
        (local.set $*tmp/883
         (i32.and
          (local.tee $*tmp/884
           (local.tee $*tmp/1706
            (i32.load16_u offset=8
             (i32.add
              (local.get $str/885)
              (i32.shl
               (local.get $*tmp/886)
               (i32.const 1))))))
          (i32.const 255)))
        (local.get $skip_table/61)
        (local.set $*idx/1826
         (local.get $*tmp/883))
        (local.set $*arr/1825)
        (call $moonbit.check_range
         (local.get $*idx/1826)
         (i32.const 0)
         (i32.sub
          (call $moonbit.array_length
           (local.get $*arr/1825))
          (i32.const 1)))
        (local.set $*tmp/882
         (i32.load offset=8
          (i32.add
           (local.get $*arr/1825)
           (i32.shl
            (local.get $*idx/1826)
            (i32.const 2)))))
        (local.tee $*tmp/881
         (i32.add
          (local.get $i/65)
          (local.get $*tmp/882)))
        (br $loop:69))
       (else
        (call $moonbit.decref
         (local.get $skip_table/61))
        (call $moonbit.decref
         (local.get $needle/0/60))
        (call $moonbit.decref
         (local.get $haystack/0/58)))))
     (i64.const 4294967296))
    (else
     (call $moonbit.decref
      (local.get $needle/0/60))
     (call $moonbit.decref
      (local.get $haystack/0/58))
     (i64.const 4294967296))))
  (else
   (call $moonbit.decref
    (local.get $needle/0/60))
   (call $moonbit.decref
    (local.get $haystack/0/58))
   (global.get $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/56))))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char (param $self/48 i32) (param $ch/50 i32) (result i32)
 (local $inc/49 i32)
 (local $*tmp/852 i32)
 (local $len/853 i32)
 (local $*tmp/854 i32)
 (local $len/855 i32)
 (local $data/856 i32)
 (local $len/857 i32)
 (local $*field/1718 i32)
 (local.set $*tmp/852
  (i32.add
   (local.tee $len/853
    (i32.load offset=8
     (local.get $self/48)))
   (i32.const 4)))
 (call $moonbit.incref
  (local.get $self/48))
 (drop
  (call $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary
   (local.get $self/48)
   (local.get $*tmp/852)))
 (local.set $data/856
  (local.tee $*field/1718
   (i32.load offset=12
    (local.get $self/48))))
 (local.set $len/857
  (i32.load offset=8
   (local.get $self/48)))
 (call $moonbit.incref
  (local.get $data/856))
 (local.set $inc/49
  (call $FixedArray::set_utf16le_char
   (local.get $data/856)
   (local.get $len/857)
   (local.get $ch/50)))
 (local.set $*tmp/854
  (i32.add
   (local.tee $len/855
    (i32.load offset=8
     (local.get $self/48)))
   (local.get $inc/49)))
 (i32.store offset=8
  (local.get $self/48)
  (local.get $*tmp/854))
 (call $moonbit.decref
  (local.get $self/48))
 (i32.const 0))
(func $@moonbitlang/core/builtin.StringBuilder::grow_if_necessary (param $self/43 i32) (param $required/44 i32) (result i32)
 (local $current_len/42 i32)
 (local $new_data/47 i32)
 (local $*tmp/846 i32)
 (local $*tmp/847 i32)
 (local $data/848 i32)
 (local $len/849 i32)
 (local $*tmp/850 i32)
 (local $data/851 i32)
 (local $*old/1719 i32)
 (local $*field/1720 i32)
 (local $*tmp/1721 i32)
 (local $*field/1722 i32)
 (local $enough_space/45 i32)
 (local.set $current_len/42
  (local.tee $*tmp/1721
   (call $moonbit.array_length
    (local.tee $data/851
     (local.tee $*field/1722
      (i32.load offset=12
       (local.get $self/43)))))))
 (if
  (i32.le_s
   (local.get $required/44)
   (local.get $current_len/42))
  (then
   (call $moonbit.decref
    (local.get $self/43))
   (i32.const 0)
   (return))
  (else))
 (local.set $enough_space/45
  (local.get $current_len/42))
 (loop $loop:46
  (if
   (i32.lt_s
    (local.tee $*tmp/846
     (local.get $enough_space/45))
    (local.get $required/44))
   (then
    (local.set $enough_space/45
     (i32.mul
      (local.tee $*tmp/847
       (local.get $enough_space/45))
      (i32.const 2)))
    (br $loop:46))
   (else)))
 (local.set $new_data/47
  (call $moonbit.bytes_make
   (local.tee $*tmp/850
    (local.get $enough_space/45))
   (i32.const 0)))
 (local.set $data/848
  (local.tee $*field/1720
   (i32.load offset=12
    (local.get $self/43))))
 (local.set $len/849
  (i32.load offset=8
   (local.get $self/43)))
 (call $moonbit.incref
  (local.get $data/848))
 (call $moonbit.incref
  (local.get $new_data/47))
 (drop
  (call $FixedArray::unsafe_blit|Byte|
   (local.get $new_data/47)
   (i32.const 0)
   (local.get $data/848)
   (i32.const 0)
   (local.get $len/849)))
 (call $moonbit.decref
  (local.tee $*old/1719
   (i32.load offset=12
    (local.get $self/43))))
 (i32.store offset=12
  (local.get $self/43)
  (local.get $new_data/47))
 (call $moonbit.decref
  (local.get $self/43))
 (i32.const 0))
(func $FixedArray::set_utf16le_char (param $self/37 i32) (param $offset/38 i32) (param $value/36 i32) (result i32)
 (local $code/35 i32)
 (local $hi/39 i32)
 (local $lo/40 i32)
 (local $hi/41 i32)
 (local $*p/550 i32)
 (local $*p/553 i32)
 (local $*p/556 i32)
 (local $*p/559 i32)
 (local $*p/562 i32)
 (local $*p/565 i32)
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
 (local $*arr/1829 i32)
 (local $*idx/1830 i32)
 (local $*arr/1831 i32)
 (local $*idx/1832 i32)
 (local $*arr/1833 i32)
 (local $*idx/1834 i32)
 (local $*arr/1835 i32)
 (local $*idx/1836 i32)
 (local $*arr/1837 i32)
 (local $*idx/1838 i32)
 (local $*arr/1839 i32)
 (local $*idx/1840 i32)
 (if (result i32)
  (i32.lt_u
   (local.tee $code/35
    (local.tee $*tmp/845
     (local.get $value/36)))
   (i32.const 65536))
  (then
   (local.set $*tmp/827
    (i32.and
     (local.tee $*tmp/828
      (local.tee $*p/550
       (i32.and
        (local.get $code/35)
        (i32.const 255))))
     (i32.const 255)))
   (local.get $self/37)
   (local.set $*idx/1832
    (local.get $offset/38))
   (local.set $*arr/1831)
   (call $moonbit.check_range
    (local.get $*idx/1832)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1831))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1831)
     (local.get $*idx/1832))
    (local.get $*tmp/827))
   (local.set $*tmp/829
    (i32.add
     (local.get $offset/38)
     (i32.const 1)))
   (local.set $*tmp/830
    (i32.and
     (local.tee $*tmp/831
      (local.tee $*p/553
       (i32.shr_u
        (local.get $code/35)
        (i32.const 8))))
     (i32.const 255)))
   (local.get $self/37)
   (local.set $*idx/1830
    (local.get $*tmp/829))
   (local.set $*arr/1829)
   (call $moonbit.check_range
    (local.get $*idx/1830)
    (i32.const 0)
    (i32.sub
     (call $moonbit.array_length
      (local.get $*arr/1829))
     (i32.const 1)))
   (i32.store8 offset=8
    (i32.add
     (local.get $*arr/1829)
     (local.get $*idx/1830))
    (local.get $*tmp/830))
   (call $moonbit.decref
    (local.get $self/37))
   (i32.const 2))
  (else
   (if (result i32)
    (i32.lt_u
     (local.get $code/35)
     (i32.const 1114112))
    (then
     (local.set $lo/40
      (i32.or
       (local.tee $*tmp/844
        (i32.shr_u
         (local.tee $hi/39
          (i32.sub
           (local.get $code/35)
           (i32.const 65536)))
         (i32.const 10)))
       (i32.const 55296)))
     (local.set $hi/41
      (i32.or
       (local.tee $*tmp/843
        (i32.and
         (local.get $hi/39)
         (i32.const 1023)))
       (i32.const 56320)))
     (local.set $*tmp/832
      (i32.and
       (local.tee $*tmp/833
        (local.tee $*p/556
         (i32.and
          (local.get $lo/40)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/37)
     (local.set $*idx/1840
      (local.get $offset/38))
     (local.set $*arr/1839)
     (call $moonbit.check_range
      (local.get $*idx/1840)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1839))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1839)
       (local.get $*idx/1840))
      (local.get $*tmp/832))
     (local.set $*tmp/834
      (i32.add
       (local.get $offset/38)
       (i32.const 1)))
     (local.set $*tmp/835
      (i32.and
       (local.tee $*tmp/836
        (local.tee $*p/559
         (i32.shr_u
          (local.get $lo/40)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/37)
     (local.set $*idx/1838
      (local.get $*tmp/834))
     (local.set $*arr/1837)
     (call $moonbit.check_range
      (local.get $*idx/1838)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1837))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1837)
       (local.get $*idx/1838))
      (local.get $*tmp/835))
     (local.set $*tmp/837
      (i32.add
       (local.get $offset/38)
       (i32.const 2)))
     (local.set $*tmp/838
      (i32.and
       (local.tee $*tmp/839
        (local.tee $*p/562
         (i32.and
          (local.get $hi/41)
          (i32.const 255))))
       (i32.const 255)))
     (local.get $self/37)
     (local.set $*idx/1836
      (local.get $*tmp/837))
     (local.set $*arr/1835)
     (call $moonbit.check_range
      (local.get $*idx/1836)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1835))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1835)
       (local.get $*idx/1836))
      (local.get $*tmp/838))
     (local.set $*tmp/840
      (i32.add
       (local.get $offset/38)
       (i32.const 3)))
     (local.set $*tmp/841
      (i32.and
       (local.tee $*tmp/842
        (local.tee $*p/565
         (i32.shr_u
          (local.get $hi/41)
          (i32.const 8))))
       (i32.const 255)))
     (local.get $self/37)
     (local.set $*idx/1834
      (local.get $*tmp/840))
     (local.set $*arr/1833)
     (call $moonbit.check_range
      (local.get $*idx/1834)
      (i32.const 0)
      (i32.sub
       (call $moonbit.array_length
        (local.get $*arr/1833))
       (i32.const 1)))
     (i32.store8 offset=8
      (i32.add
       (local.get $*arr/1833)
       (local.get $*idx/1834))
      (local.get $*tmp/841))
     (call $moonbit.decref
      (local.get $self/37))
     (i32.const 4))
    (else
     (call $moonbit.decref
      (local.get $self/37))
     (call $moonbitlang/core/builtin.abort|Int|
      (i32.const 11232)
      (i32.const 11120)))))))
(func $@moonbitlang/core/builtin.StringBuilder::to_string (param $self/32 i32) (result i32)
 (local $*tmp/821 i32)
 (local $*tmp/822 i64)
 (local $len/823 i32)
 (local $data/824 i32)
 (local $*field/1723 i32)
 (local $*field/1724 i32)
 (call $moonbit.incref
  (local.tee $data/824
   (local.tee $*field/1724
    (i32.load offset=12
     (local.get $self/32)))))
 (local.set $*tmp/821
  (local.get $data/824))
 (local.set $*field/1723
  (i32.load offset=8
   (local.get $self/32)))
 (call $moonbit.decref
  (local.get $self/32))
 (local.set $*tmp/822
  (i64.extend_i32_s
   (local.tee $len/823
    (local.get $*field/1723))))
 (call $Bytes::to_unchecked_string.inner
  (local.get $*tmp/821)
  (i32.const 0)
  (local.get $*tmp/822)))
(func $Bytes::to_unchecked_string.inner (param $self/27 i32) (param $offset/31 i32) (param $length/29 i64) (result i32)
 (local $len/26 i32)
 (local $length/28 i32)
 (local $*Some/30 i64)
 (local $*tmp/820 i32)
 (local.set $len/26
  (call $moonbit.array_length
   (local.get $self/27)))
 (local.set $length/28
  (if (result i32)
   (i64.eq
    (local.get $length/29)
    (i64.const 4294967296))
   (then
    (i32.sub
     (local.get $len/26)
     (local.get $offset/31)))
   (else
    (i32.wrap_i64
     (local.tee $*Some/30
      (local.get $length/29))))))
 (if (result i32)
  (if (result i32)
   (i32.ge_s
    (local.get $offset/31)
    (i32.const 0))
   (then
    (if (result i32)
     (i32.ge_s
      (local.get $length/28)
      (i32.const 0))
     (then
      (i32.le_s
       (local.tee $*tmp/820
        (i32.add
         (local.get $offset/31)
         (local.get $length/28)))
       (local.get $len/26)))
     (else
      (i32.const 0))))
   (else
    (i32.const 0)))
  (then
   (call $moonbitlang/core/builtin.unsafe_sub_string
    (local.get $self/27)
    (local.get $offset/31)
    (local.get $length/28)))
  (else
   (call $moonbit.decref
    (local.get $self/27))
   (unreachable))))
(func $moonbitlang/core/builtin.unsafe_sub_string (param $*param/771 i32) (param $*param/772 i32) (param $*param/773 i32) (result i32)
 (call $moonbit.unsafe_bytes_sub_string
  (local.get $*param/771)
  (local.get $*param/772)
  (local.get $*param/773)))
(func $@moonbitlang/core/builtin.StringBuilder::new.inner (param $size_hint/24 i32) (result i32)
 (local $initial/23 i32)
 (local $data/25 i32)
 (local $ptr/1841 i32)
 (local.set $data/25
  (call $moonbit.bytes_make
   (local.tee $initial/23
    (if (result i32)
     (i32.lt_s
      (local.get $size_hint/24)
      (i32.const 1))
     (then
      (i32.const 1))
     (else
      (local.get $size_hint/24))))
   (i32.const 0)))
 (i32.store offset=4
  (local.tee $ptr/1841
   (call $moonbit.gc.malloc
    (i32.const 8)))
  (i32.const 1573120))
 (i32.store offset=8
  (local.get $ptr/1841)
  (i32.const 0))
 (i32.store offset=12
  (local.get $ptr/1841)
  (local.get $data/25))
 (local.get $ptr/1841))
(func $FixedArray::unsafe_blit|Byte| (param $dst/13 i32) (param $dst_offset/15 i32) (param $src/14 i32) (param $src_offset/16 i32) (param $len/18 i32) (result i32)
 (local $i/17 i32)
 (local $i/20 i32)
 (local $*tmp/810 i32)
 (local $*tmp/811 i32)
 (local $*tmp/812 i32)
 (local $*tmp/813 i32)
 (local $*tmp/814 i32)
 (local $*tmp/815 i32)
 (local $*tmp/816 i32)
 (local $*tmp/817 i32)
 (local $*tmp/818 i32)
 (local $*arr/1842 i32)
 (local $*idx/1843 i32)
 (local $*arr/1844 i32)
 (local $*idx/1845 i32)
 (local $*arr/1846 i32)
 (local $*idx/1847 i32)
 (local $*arr/1848 i32)
 (local $*idx/1849 i32)
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
      (local.set $*tmp/810
       (i32.add
        (local.get $dst_offset/15)
        (local.get $i/17)))
      (local.set $*tmp/812
       (i32.add
        (local.get $src_offset/16)
        (local.get $i/17)))
      (local.get $src/14)
      (local.set $*idx/1845
       (local.get $*tmp/812))
      (local.set $*arr/1844)
      (call $moonbit.check_range
       (local.get $*idx/1845)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1844))
        (i32.const 1)))
      (local.set $*tmp/811
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1844)
         (local.get $*idx/1845))))
      (local.get $dst/13)
      (local.set $*idx/1843
       (local.get $*tmp/810))
      (local.set $*arr/1842)
      (call $moonbit.check_range
       (local.get $*idx/1843)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1842))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1842)
        (local.get $*idx/1843))
       (local.get $*tmp/811))
      (local.tee $*tmp/813
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
   (local.tee $*tmp/818
    (i32.sub
     (local.get $len/18)
     (i32.const 1)))
   (loop $loop:21 (param i32)
    (local.tee $i/20)
    (i32.const 0)
    (i32.ge_s)
    (if
     (then
      (local.set $*tmp/814
       (i32.add
        (local.get $dst_offset/15)
        (local.get $i/20)))
      (local.set $*tmp/816
       (i32.add
        (local.get $src_offset/16)
        (local.get $i/20)))
      (local.get $src/14)
      (local.set $*idx/1849
       (local.get $*tmp/816))
      (local.set $*arr/1848)
      (call $moonbit.check_range
       (local.get $*idx/1849)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1848))
        (i32.const 1)))
      (local.set $*tmp/815
       (i32.load8_u offset=8
        (i32.add
         (local.get $*arr/1848)
         (local.get $*idx/1849))))
      (local.get $dst/13)
      (local.set $*idx/1847
       (local.get $*tmp/814))
      (local.set $*arr/1846)
      (call $moonbit.check_range
       (local.get $*idx/1847)
       (i32.const 0)
       (i32.sub
        (call $moonbit.array_length
         (local.get $*arr/1846))
        (i32.const 1)))
      (i32.store8 offset=8
       (i32.add
        (local.get $*arr/1846)
        (local.get $*idx/1847))
       (local.get $*tmp/815))
      (local.tee $*tmp/817
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
 (local $*tmp/806 i32)
 (local $*tmp/807 i32)
 (local $*tmp/808 i32)
 (local $*tmp/809 i32)
 (local.set $*tmp/808
  (call $moonbit.add_string
   (local.get $string/11)
   (i32.const 11296)))
 (local.set $*tmp/809
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/12)))
 (call $moonbitlang/core/abort.abort|Option<Int>|
  (local.tee $*tmp/806
   (call $moonbit.add_string
    (local.tee $*tmp/807
     (call $moonbit.add_string
      (local.get $*tmp/808)
      (local.get $*tmp/809)))
    (i32.const 11280)))))
(func $moonbitlang/core/builtin.abort|Unit| (param $string/9 i32) (param $loc/10 i32) (result i32)
 (local $*tmp/802 i32)
 (local $*tmp/803 i32)
 (local $*tmp/804 i32)
 (local $*tmp/805 i32)
 (local.set $*tmp/804
  (call $moonbit.add_string
   (local.get $string/9)
   (i32.const 11296)))
 (local.set $*tmp/805
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/10)))
 (call $moonbitlang/core/abort.abort|Unit|
  (local.tee $*tmp/802
   (call $moonbit.add_string
    (local.tee $*tmp/803
     (call $moonbit.add_string
      (local.get $*tmp/804)
      (local.get $*tmp/805)))
    (i32.const 11280)))))
(func $moonbitlang/core/builtin.abort|StringView| (param $string/7 i32) (param $loc/8 i32) (result i32) (result i32) (result i32)
 (local $*tmp/798 i32)
 (local $*tmp/799 i32)
 (local $*tmp/800 i32)
 (local $*tmp/801 i32)
 (local.set $*tmp/800
  (call $moonbit.add_string
   (local.get $string/7)
   (i32.const 11296)))
 (local.set $*tmp/801
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/8)))
 (call $moonbitlang/core/abort.abort|StringView|
  (local.tee $*tmp/798
   (call $moonbit.add_string
    (local.tee $*tmp/799
     (call $moonbit.add_string
      (local.get $*tmp/800)
      (local.get $*tmp/801)))
    (i32.const 11280)))))
(func $moonbitlang/core/builtin.abort|Int| (param $string/5 i32) (param $loc/6 i32) (result i32)
 (local $*tmp/794 i32)
 (local $*tmp/795 i32)
 (local $*tmp/796 i32)
 (local $*tmp/797 i32)
 (local.set $*tmp/796
  (call $moonbit.add_string
   (local.get $string/5)
   (i32.const 11296)))
 (local.set $*tmp/797
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|@moonbitlang/core/builtin.SourceLoc|
   (local.get $loc/6)))
 (call $moonbitlang/core/abort.abort|Int|
  (local.tee $*tmp/794
   (call $moonbit.add_string
    (local.tee $*tmp/795
     (call $moonbit.add_string
      (local.get $*tmp/796)
      (local.get $*tmp/797)))
    (i32.const 11280)))))
(func $moonbitlang/core/abort.abort|Option<Int>| (param $msg/4 i32) (result i64)
 (call $moonbit.decref
  (local.get $msg/4))
 (unreachable))
(func $moonbitlang/core/abort.abort|Unit| (param $msg/3 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/3))
 (unreachable))
(func $moonbitlang/core/abort.abort|StringView| (param $msg/2 i32) (result i32) (result i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/2))
 (unreachable))
(func $moonbitlang/core/abort.abort|Int| (param $msg/1 i32) (result i32)
 (call $moonbit.decref
  (local.get $msg/1))
 (unreachable))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/787 i32) (param $*param/786 i32) (result i32)
 (local $*self/785 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_char
  (local.tee $*self/785
   (local.get $*obj_ptr/787))
  (local.get $*param/786)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/784 i32) (param $*param/0/783 i32) (param $*param/1/783 i32) (param $*param/2/783 i32) (result i32)
 (local $*self/782 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_view
  (local.tee $*self/782
   (local.get $*obj_ptr/784))
  (local.get $*param/0/783)
  (local.get $*param/1/783)
  (local.get $*param/2/783)))
(func $@moonbitlang/core/builtin.Logger::$default_impl::write_substring.dyncall_as_@moonbitlang/core/builtin.Logger|@moonbitlang/core/builtin.StringBuilder| (param $*obj_ptr/781 i32) (param $*param/778 i32) (param $*param/779 i32) (param $*param/780 i32) (result i32)
 (local $*self/777 i32)
 (call $@moonbitlang/core/builtin.Logger::$default_impl::write_substring|@moonbitlang/core/builtin.StringBuilder|
  (local.tee $*self/777
   (local.get $*obj_ptr/781))
  (local.get $*param/778)
  (local.get $*param/779)
  (local.get $*param/780)))
(func $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string.dyncall_as_@moonbitlang/core/builtin.Logger (param $*obj_ptr/776 i32) (param $*param/775 i32) (result i32)
 (local $*self/774 i32)
 (call $@moonbitlang/core/builtin.Logger::@moonbitlang/core/builtin.StringBuilder::write_string
  (local.tee $*self/774
   (local.get $*obj_ptr/776))
  (local.get $*param/775)))
(start $*init*/2)
(func $*init*/2
 (global.set $moonbitlang/core/builtin.boyer_moore_horspool_find.constr/56
  (i64.extend_i32_s
   (i32.const 0)))
 (global.set $moonbitlang/core/builtin.brute_force_find.constr/70
  (i64.extend_i32_s
   (i32.const 0))))
(func $*main*/1
 (local $*tmp/788 i32)
 (local $*tmp/789 i32)
 (local $*tmp/790 f64)
 (local $*tmp/791 i32)
 (local $*tmp/792 i32)
 (local $*tmp/793 f64)
 (call $moonbit.incref
  (global.get $username/moonbit_examples/cmd/enum.*main.c/537))
 (local.set $*tmp/789
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double|
   (local.tee $*tmp/790
    (call $username/moonbit_examples/cmd/enum.area
     (global.get $username/moonbit_examples/cmd/enum.*main.c/537)))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/788
    (call $moonbit.add_string
     (i32.const 11368)
     (local.get $*tmp/789)))))
 (call $moonbit.incref
  (global.get $username/moonbit_examples/cmd/enum.*main.r/538))
 (local.set $*tmp/792
  (call $@moonbitlang/core/builtin.Show::$default_impl::to_string|Double|
   (local.tee $*tmp/793
    (call $username/moonbit_examples/cmd/enum.area
     (global.get $username/moonbit_examples/cmd/enum.*main.r/538)))))
 (drop
  (call $moonbitlang/core/builtin.println|String|
   (local.tee $*tmp/791
    (call $moonbit.add_string
     (i32.const 11320)
     (local.get $*tmp/792))))))
(export "_start" (func $*main*/1))