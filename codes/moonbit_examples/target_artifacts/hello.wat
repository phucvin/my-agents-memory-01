(module
  (type (;0;) (func (param i32)))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (param i32 i32 i64)))
  (type (;3;) (func))
  (type (;4;) (func (param i32) (result i32)))
  (import "spectest" "print_char" (func (;0;) (type 0)))
  (func (;1;) (type 1) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 1
    i32.load align=1
    i32.const -4
    i32.and
    local.tee 2
    i32.const 256
    i32.lt_u
    if (result i32)  ;; label = @1
      local.get 2
      i32.const 4
      i32.shr_u
      local.set 3
      i32.const 0
    else
      i32.const 31
      i32.const 1073741820
      local.get 2
      local.get 2
      i32.const 1073741820
      i32.ge_u
      select
      local.tee 3
      i32.clz
      i32.sub
      local.set 2
      local.get 3
      local.get 2
      i32.const 4
      i32.sub
      i32.shr_u
      i32.const 16
      i32.xor
      local.set 3
      local.get 2
      i32.const 7
      i32.sub
    end
    local.set 5
    local.get 1
    i32.load offset=8 align=1
    local.set 2
    local.get 1
    i32.load offset=4 align=1
    local.tee 4
    if  ;; label = @1
      local.get 4
      local.get 2
      i32.store offset=8 align=1
    end
    local.get 2
    if  ;; label = @1
      local.get 2
      local.get 4
      i32.store offset=4 align=1
    end
    local.get 1
    local.get 0
    local.get 5
    i32.const 4
    i32.shl
    local.get 3
    i32.add
    i32.const 2
    i32.shl
    i32.add
    local.tee 4
    i32.load offset=96 align=1
    i32.eq
    if  ;; label = @1
      local.get 4
      local.get 2
      i32.store offset=96 align=1
      local.get 2
      i32.eqz
      if  ;; label = @2
        local.get 0
        local.get 5
        i32.const 2
        i32.shl
        i32.add
        local.tee 1
        local.get 1
        i32.load offset=4 align=1
        i32.const -2
        local.get 3
        i32.rotl
        i32.and
        local.tee 1
        i32.store offset=4 align=1
        local.get 1
        i32.eqz
        if  ;; label = @3
          local.get 0
          local.get 0
          i32.load align=1
          i32.const -2
          local.get 5
          i32.rotl
          i32.and
          i32.store align=1
        end
      end
    end)
  (func (;2;) (type 1) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 1
    i32.load align=1
    local.tee 4
    local.set 3
    local.get 1
    i32.const 4
    i32.add
    local.tee 5
    local.get 4
    i32.const -4
    i32.and
    i32.add
    local.tee 2
    i32.load align=1
    local.tee 4
    i32.const 1
    i32.and
    if  ;; label = @1
      local.get 0
      local.get 2
      call 1
      local.get 1
      local.get 3
      i32.const 4
      i32.add
      local.get 4
      i32.const -4
      i32.and
      i32.add
      local.tee 3
      i32.store align=1
      local.get 1
      i32.load align=1
      i32.const -4
      i32.and
      local.get 5
      i32.add
      local.tee 2
      i32.load align=1
      local.set 4
    end
    local.get 3
    i32.const 2
    i32.and
    if  ;; label = @1
      local.get 1
      i32.const 4
      i32.sub
      i32.load align=1
      local.tee 1
      i32.load align=1
      local.set 5
      local.get 0
      local.get 1
      call 1
      local.get 1
      local.get 5
      i32.const 4
      i32.add
      local.get 3
      i32.const -4
      i32.and
      i32.add
      local.tee 3
      i32.store align=1
    end
    local.get 2
    local.get 4
    i32.const 2
    i32.or
    i32.store align=1
    local.get 2
    i32.const 4
    i32.sub
    local.get 1
    i32.store align=1
    local.get 3
    i32.const -4
    i32.and
    local.tee 2
    i32.const 256
    i32.lt_u
    if (result i32)  ;; label = @1
      local.get 2
      i32.const 4
      i32.shr_u
      local.set 2
      i32.const 0
    else
      i32.const 31
      i32.const 1073741820
      local.get 2
      local.get 2
      i32.const 1073741820
      i32.ge_u
      select
      local.tee 2
      i32.clz
      i32.sub
      local.set 3
      local.get 2
      local.get 3
      i32.const 4
      i32.sub
      i32.shr_u
      i32.const 16
      i32.xor
      local.set 2
      local.get 3
      i32.const 7
      i32.sub
    end
    local.set 3
    local.get 0
    local.get 3
    i32.const 4
    i32.shl
    local.get 2
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96 align=1
    local.set 4
    local.get 1
    i32.const 0
    i32.store offset=4 align=1
    local.get 1
    local.get 4
    i32.store offset=8 align=1
    local.get 4
    if  ;; label = @1
      local.get 4
      local.get 1
      i32.store offset=4 align=1
    end
    local.get 0
    local.get 3
    i32.const 4
    i32.shl
    local.get 2
    i32.add
    i32.const 2
    i32.shl
    i32.add
    local.get 1
    i32.store offset=96 align=1
    local.get 0
    local.get 0
    i32.load align=1
    i32.const 1
    local.get 3
    i32.shl
    i32.or
    i32.store align=1
    local.get 0
    local.get 3
    i32.const 2
    i32.shl
    i32.add
    local.tee 0
    local.get 0
    i32.load offset=4 align=1
    i32.const 1
    local.get 2
    i32.shl
    i32.or
    i32.store offset=4 align=1)
  (func (;3;) (type 2) (param i32 i32 i64)
    (local i32 i32 i32)
    local.get 0
    i32.load offset=1568 align=1
    local.tee 4
    i32.const 0
    local.get 1
    i32.const 19
    i32.add
    i32.const -16
    i32.and
    i32.const 4
    i32.sub
    local.tee 1
    i32.const 16
    i32.sub
    local.tee 3
    local.get 4
    i32.eq
    select
    if  ;; label = @1
      local.get 4
      i32.load align=1
      local.set 5
      local.get 3
      local.set 1
    end
    local.get 2
    i32.wrap_i64
    i32.const -16
    i32.and
    local.get 1
    i32.sub
    local.tee 3
    i32.const 20
    i32.lt_u
    if  ;; label = @1
      return
    end
    local.get 1
    local.get 5
    i32.const 2
    i32.and
    local.get 3
    i32.const 8
    i32.sub
    local.tee 3
    i32.const 1
    i32.or
    i32.or
    i32.store align=1
    local.get 1
    i32.const 0
    i32.store offset=4 align=1
    local.get 1
    i32.const 0
    i32.store offset=8 align=1
    local.get 1
    i32.const 4
    i32.add
    local.get 3
    i32.add
    local.tee 3
    i32.const 2
    i32.store align=1
    local.get 0
    local.get 3
    i32.store offset=1568 align=1
    local.get 0
    local.get 1
    call 2)
  (func (;4;) (type 3)
    (local i32 i32 i32)
    i32.const 10040
    i32.const 15
    i32.add
    i32.const -16
    i32.and
    local.set 0
    memory.size
    local.tee 1
    local.get 0
    i32.const 67107
    i32.add
    i32.const -65536
    i32.and
    i32.const 16
    i32.shr_u
    local.tee 2
    i32.lt_s
    if (result i32)  ;; label = @1
      local.get 2
      local.get 1
      i32.sub
      memory.grow
      i32.const 0
      i32.lt_s
    else
      i32.const 0
    end
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.const 0
    i32.store align=1
    local.get 0
    i32.const 0
    i32.store offset=1568 align=1
    i32.const 0
    local.set 1
    loop  ;; label = @1
      local.get 1
      i32.const 23
      i32.lt_u
      if  ;; label = @2
        local.get 0
        local.get 1
        i32.const 2
        i32.shl
        i32.add
        i32.const 0
        i32.store offset=4 align=1
        i32.const 0
        local.set 2
        loop  ;; label = @3
          local.get 2
          i32.const 16
          i32.lt_u
          if  ;; label = @4
            local.get 0
            local.get 1
            i32.const 4
            i32.shl
            local.get 2
            i32.add
            i32.const 2
            i32.shl
            i32.add
            i32.const 0
            i32.store offset=96 align=1
            local.get 2
            i32.const 1
            i32.add
            local.set 2
            br 1 (;@3;)
          end
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        br 1 (;@1;)
      end
    end
    local.get 0
    local.get 0
    i32.const 1572
    i32.add
    memory.size
    i64.extend_i32_s
    i64.const 16
    i64.shl
    call 3
    local.get 0
    global.set 0)
  (func (;5;) (type 0) (param i32)
    (local i32 i32)
    i32.const 10040
    local.get 0
    i32.gt_u
    if  ;; label = @1
      return
    end
    global.get 0
    i32.eqz
    if  ;; label = @1
      call 4
    end
    global.get 0
    local.set 2
    local.get 0
    i32.const 4
    i32.sub
    local.set 1
    local.get 0
    i32.const 15
    i32.and
    i32.const 1
    local.get 0
    select
    if (result i32)  ;; label = @1
      i32.const 1
    else
      local.get 1
      i32.load align=1
      i32.const 1
      i32.and
    end
    if  ;; label = @1
      unreachable
    end
    local.get 1
    local.get 1
    i32.load align=1
    i32.const 1
    i32.or
    i32.store align=1
    local.get 2
    local.get 1
    call 2)
  (func (;6;) (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=4 align=1
    i32.const 268435455
    i32.and)
  (func (;7;) (type 0) (param i32)
    (local i32)
    loop  ;; label = @1
      local.get 1
      local.get 0
      call 6
      i32.lt_s
      if  ;; label = @2
        local.get 0
        local.get 1
        i32.const 1
        i32.shl
        i32.add
        i32.load16_u offset=8 align=1
        call 0
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        br 1 (;@1;)
      end
    end
    i32.const 10
    call 0)
  (func (;8;) (type 0) (param i32)
    (local i32)
    local.get 0
    i32.load align=1
    local.tee 1
    i32.const 1
    i32.gt_s
    if  ;; label = @1
      local.get 0
      local.get 1
      i32.const 1
      i32.sub
      i32.store align=1
    else
      local.get 1
      i32.const 1
      i32.eq
      if  ;; label = @2
        local.get 0
        call 9
      end
    end)
  (func (;9;) (type 0) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    loop  ;; label = @1
      local.get 0
      i32.load offset=4 align=1
      local.tee 13
      i32.const 30
      i32.shr_u
      local.set 6
      block  ;; label = @2
        i32.const 0
        local.get 6
        i32.eq
        if  ;; label = @3
          local.get 13
          i32.const 8
          i32.shr_u
          i32.const 2047
          i32.and
          local.tee 4
          i32.eqz
          if  ;; label = @4
          else
            local.get 13
            i32.const 19
            i32.shr_u
            i32.const 2047
            i32.and
            local.set 5
            local.get 5
            local.set 2
            local.get 4
            local.set 3
            br 2 (;@2;)
          end
        else
          i32.const 2
          local.get 6
          i32.eq
          if  ;; label = @4
            i32.const 3
            local.get 13
            i32.const 28
            i32.shr_u
            i32.and
            local.set 7
            i32.const 1
            local.get 7
            i32.eq
            if  ;; label = @5
              local.get 13
              i32.const 268435455
              i32.and
              local.set 16
              local.get 0
              i32.const 8
              i32.add
              local.set 8
              local.get 8
              i32.load align=1
              local.set 12
              i32.const 2047
              local.get 12
              i32.const 8
              i32.shr_u
              i32.and
              local.set 11
              i32.const 2047
              local.get 12
              i32.const 19
              i32.shr_u
              i32.and
              local.set 10
              local.get 8
              i32.const 4
              i32.add
              local.set 8
              loop  ;; label = @6
                local.get 16
                i32.const 0
                i32.gt_s
                if  ;; label = @7
                  local.get 16
                  i32.const 1
                  i32.sub
                  local.set 16
                  i32.const 0
                  local.set 9
                  local.get 8
                  local.get 10
                  i32.const 4
                  i32.mul
                  i32.add
                  local.set 8
                  loop  ;; label = @8
                    local.get 9
                    local.get 11
                    i32.lt_s
                    if  ;; label = @9
                      local.get 8
                      i32.load align=1
                      i32.const 0
                      i32.ne
                      if  ;; label = @10
                        local.get 8
                        i32.load align=1
                        call 8
                      end
                      local.get 9
                      i32.const 1
                      i32.add
                      local.set 9
                      local.get 8
                      i32.const 4
                      i32.add
                      local.set 8
                      br 1 (;@8;)
                    end
                  end
                  br 1 (;@6;)
                end
              end
            else
              local.get 13
              i32.const 268435455
              i32.and
              local.set 16
              local.get 16
              i32.const 0
              i32.gt_s
              if  ;; label = @6
                i32.const 8
                i32.const 2
                i32.shr_u
                local.set 2
                local.get 16
                local.set 3
                br 4 (;@2;)
              end
            end
          else
            i32.const 1
            local.get 6
            i32.eq
            if  ;; label = @5
            else
              unreachable
            end
          end
        end
        local.get 0
        call 5
        local.get 1
        i32.eqz
        if  ;; label = @3
          return
        end
        local.get 1
        i32.load align=1
        local.set 2
        local.get 1
        i32.load offset=4 align=1
        local.set 3
        local.get 1
        local.set 0
        local.get 0
        local.get 2
        i32.const 4
        i32.mul
        i32.add
        i32.load align=1
        local.set 1
        local.get 2
        i32.const 1
        i32.add
        local.set 2
      end
      loop  ;; label = @2
        loop  ;; label = @3
          local.get 3
          i32.const 0
          i32.gt_s
          if  ;; label = @4
            local.get 3
            i32.const 1
            i32.sub
            local.set 3
            local.get 0
            local.get 2
            i32.const 4
            i32.mul
            i32.add
            local.tee 15
            i32.load align=1
            local.tee 14
            i32.eqz
            if  ;; label = @5
              local.get 2
              i32.const 1
              i32.add
              local.set 2
              br 2 (;@3;)
            end
            local.get 14
            i32.load align=1
            local.tee 17
            i32.const 1
            i32.gt_s
            if  ;; label = @5
              local.get 14
              local.get 17
              i32.const 1
              i32.sub
              i32.store align=1
            else
              local.get 17
              i32.const 1
              i32.eq
              if  ;; label = @6
                local.get 3
                i32.const 0
                i32.eq
                if  ;; label = @7
                  local.get 0
                  call 5
                else
                  local.get 0
                  local.get 2
                  i32.store align=1
                  local.get 0
                  local.get 3
                  i32.store offset=4 align=1
                  local.get 15
                  local.get 1
                  i32.store align=1
                  local.get 0
                  local.set 1
                end
                local.get 14
                local.set 0
                br 5 (;@1;)
              end
            end
            local.get 2
            i32.const 1
            i32.add
            local.set 2
            br 1 (;@3;)
          end
        end
        local.get 0
        call 5
        local.get 1
        i32.eqz
        if  ;; label = @3
          return
        end
        local.get 1
        i32.load align=1
        local.set 2
        local.get 1
        i32.load offset=4 align=1
        local.set 3
        local.get 1
        local.set 0
        local.get 0
        local.get 2
        i32.const 4
        i32.mul
        i32.add
        i32.load align=1
        local.set 1
        local.get 2
        i32.const 1
        i32.add
        local.set 2
        br 0 (;@2;)
      end
      unreachable
    end)
  (func (;10;) (type 4) (param i32) (result i32)
    local.get 0
    call 7
    local.get 0
    call 8
    i32.const 0)
  (func (;11;) (type 3)
    i32.const 10000
    call 10
    drop)
  (table (;0;) 0 0 funcref)
  (memory (;0;) 1)
  (global (;0;) (mut i32) (i32.const 0))
  (export "_start" (func 11))
  (elem (;0;) (i32.const 0) func)
  (data (;0;) (i32.const 10000) "\ff\ff\ff\ff\0f\00\00PH\00e\00l\00l\00o\00,\00 \00M\00o\00o\00n\00B\00i\00t\00!\00\00\00"))
