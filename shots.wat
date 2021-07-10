(;
FRAME 1
0 0 0 1  1 0 0 0  0x18
0 0 1 1  1 1 0 0  0x3c
0 1 1 1  1 1 1 0  0x7e
1 1 1 0  0 1 1 1  0xe7
1 1 1 0  0 1 1 1  0xe7
0 1 1 1  1 1 1 0  0x7e
0 0 1 1  1 1 0 0  0x3c
0 0 0 1  1 0 0 0  0x18
;)
(global $shot_frame1 i64 (i64.const 0x18_3c_7e_e7_e7_7e_3c_18))

(;
FRAME 2
0 0 1 1  1 1 0 0  0x3c
0 1 1 1  1 1 1 0  0x7e
1 1 1 0  0 1 1 1  0xe7
1 1 0 0  0 0 1 1  0xc3
1 1 0 0  0 0 1 1  0xc3
1 1 1 0  0 1 1 1  0xe7
0 1 1 1  1 1 1 0  0x7e
0 0 1 1  1 1 0 0  0x3c
;)
(global $shot_frame2 i64 (i64.const 0x3c_7e_e7_c3_c3_e7_7e_3c))

;; 0000 0000 0000 | 1111 1111 1111 | 0000 0001
;;                |                |         |
;;       X        |        Y       |      ACTIVE FLAG
(global $shot_data_location i32 (i32.const 265200))
(global $clear_y_bits i32 (i32.const 0xff_f0_00_ff))

(global $shot_countdown (mut i32) (i32.const 0))
(global $shot_countdown_time i32 (i32.const 30))

(func $shoot 
  (param $x i32)
  (param $y i32)

  (local $shot_data i32)
  global.get $shot_index
  i32.const 1
  i32.add
  global.set $shot_index
  global.get $shot_index
  global.get $shot_count
  i32.ge_u
  if
    i32.const 0
    global.set $shot_index
  end

  global.get $shot_index
  i32.const 2
  i32.shl 
  global.get $shot_data_location
  i32.add ;; now we have address

  local.get $x
  i32.const 4
  i32.add
  i32.const 20
  i32.shl
  local.get $y
  i32.const 8
  i32.shl
  i32.or ;; bits = xxxx xxxx xxxx yyyy yyyy yyyy 0000 0000
  i32.const 1
  i32.or ;; bits = xxxx xxxx xxxx yyyy yyyy yyyy 0000 0001

  i32.store
)

(func $render_shot
  (param $x i32)
  (param $y i32)
  (param $c i32)
  (param $frame i32)

  local.get $frame
  i32.const 1
  i32.and
  if
    ;; render frame 1
    (call $render_sprite
      (global.get $shot_frame1)
      (local.get $c) ;; color
      (i32.sub 
        (local.get $x)
        (i32.const 4)
      )
      (i32.sub 
        (local.get $y)
        (i32.const 4)
      )
      (i32.const 0) ;; flip_x
      (i32.const 0) ;; flip_y
    )
  else
    ;; render frame 2
    (call $render_sprite
      (global.get $shot_frame2)
      (local.get $c) ;; color
      (i32.sub 
        (local.get $x)
        (i32.const 4)
      )
      (i32.sub 
        (local.get $y)
        (i32.const 4)
      )
      (i32.const 0) ;; flip_x
      (i32.const 0) ;; flip_y
    )
  end
)

(func $move_shots
  (local $i i32)
  (local $shot_active i32)
  (local $shot_x i32)
  (local $shot_y i32)
  (local $shot_data i32)
  (local $f i32)

  global.get $shot_frame
  i32.const 1
  i32.add
  global.set $shot_frame

  global.get $shot_frame
  i32.const 2
  i32.shr_u
  i32.const 1
  i32.and
  local.set $f

  (loop $shot_loop
    local.get $i
    i32.const 2
    i32.shl
    global.get $shot_data_location
    i32.add
    i32.load ;; load shot data

    local.tee $shot_data
    i32.const 1
    i32.and
    local.tee $shot_active
    if 
      local.get $shot_data
      i32.const 20
      i32.shr_u
      local.set $shot_x

      local.get $shot_data
      i32.const 8
      i32.shr_u
      i32.const 0xfff
      i32.and
      global.get $shot_speed
      i32.sub
      local.tee $shot_y
      i32.const 8
      i32.le_s
      if
        local.get $i
        i32.const 2
        i32.shl
        global.get $shot_data_location
        i32.add
            
        local.get $shot_data
        i32.const 0xff_ff_ff_fe
        i32.and
        local.tee $shot_data
        i32.store

      else
        local.get $i
        i32.const 2
        i32.shl
        global.get $shot_data_location
        i32.add
        local.get $shot_data
        global.get $clear_y_bits
        i32.and ;; all y bits in shot data are now clear
        local.get $shot_y
        i32.const 8
        i32.shl ;; shift shot_y bits 8 bits left
        i32.or
        i32.const 1
        i32.or
        i32.store

        (call $render_shot 
          (local.get $shot_x)
          (local.get $shot_y)
          (i32.const 0xff_00_00_ff)
          (local.get $f)      
        )      
      end
    end
    
    local.get $i
    i32.const 1
    i32.add
    local.tee $i
    global.get $shot_count
    i32.lt_u
    br_if $shot_loop      
  )
;; (global $clear_y_bits i32 (i32.const 0xff_ff_ff_00_00_00_ff_ff))
)
