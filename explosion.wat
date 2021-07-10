(;
EXP FRAME 1
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 1 1  0x03
;)
(global $exp_frame1 i64 (i64.const 0x00_00_00_00_00_00_01_03))

(;
EXP FRAME 2
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 1 0 1  0x05
0 0 0 0  0 0 1 1  0x03
0 0 0 0  0 1 1 1  0x07
;)
(global $exp_frame2 i64 (i64.const 0x00_00_00_00_00_05_03_07))

(;
EXP FRAME 3
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  1 0 0 0  0x08
0 0 0 1  0 1 0 1  0x15
0 0 0 0  1 0 1 0  0x0a
0 0 0 0  0 1 0 0  0x04
0 0 0 0  1 0 0 0  0x08
;)
(global $exp_frame3 i64 (i64.const 0x00_00_00_08_15_0a_04_08))
(;
EXP FRAME 4
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 1 1  0x03
0 0 0 0  0 1 1 1  0x07
0 0 0 0  1 1 1 1  0x0f
0 0 0 1  1 1 1 1  0x1f
1 1 1 1  1 1 1 1  0xff
;)
(global $exp_frame4 i64 (i64.const 0x01_01_01_03_07_0f_1f_ff))

(;
EXP FRAME 5
0 0 0 0  0 0 0 0  0x00
0 0 1 0  0 0 0 0  0x20
0 1 1 1  0 1 1 1  0x77
0 0 1 1  1 1 1 1  0x3f
0 0 0 1  1 1 1 1  0x1f
0 0 1 1  1 1 1 0  0x3e
0 0 1 1  1 1 0 0  0x3c
0 0 1 1  1 0 0 0  0x38
;)
(global $exp_frame5 i64 (i64.const 0x00_00_00_00_00_00_00_00))

(;
EXP FRAME 6
0 0 0 0  0 1 1 1  0x07
0 0 0 0  1 1 0 0  0x0c
0 0 0 1  1 0 1 1  0x1b
0 0 1 1  0 1 0 0  0x34
0 1 1 0  1 0 0 0  0x68
1 1 0 1  0 0 0 0  0xd0
1 0 1 0  0 0 0 0  0xa0
1 0 1 0  0 0 0 0  0xa0
;)
(global $exp_frame6 i64 (i64.const 0x07_0c_1b_34_68_d0_a0_a0))


;; EXPLOSION                             ACTIVE BIT
;;                                       |    
;; 1111 0000 1111 0000 1111 0000 1111 0000
;;               |              |    
;; X             |Y             |FRAME   |
(;
(global $explosion_data_location i32 (i32.const 265250))
(global $explosion_count i32 (i32.const 10))
(global $explosion_index (mut i32) (i32.const 0))
;)
(func $render_exp_sprite
  (param $x i32)
  (param $y i32)
  (param $frame i64)
  (call $render_sprite
    (local.get $frame)
    (i32.const 0xff_00_66_ff) ;; color
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

  (call $render_sprite
    (local.get $frame)
    (i32.const 0xff_00_66_ff) ;; color
    (i32.add
      (local.get $x)
      (i32.const 4)
    )
    (i32.sub 
      (local.get $y)
      (i32.const 4)
    )
    (i32.const 1) ;; flip_x
    (i32.const 0) ;; flip_y
  )

  (call $render_sprite
    (local.get $frame)
    (i32.const 0xff_00_66_ff) ;; color
    (i32.sub 
      (local.get $x)
      (i32.const 4)
    )
    (i32.add
      (local.get $y)
      (i32.const 3)
    )
    (i32.const 0) ;; flip_x
    (i32.const 1) ;; flip_y
  )

  (call $render_sprite
    (local.get $frame)
    (i32.const 0xff_00_66_ff) ;; color
    (i32.add
      (local.get $x)
      (i32.const 4)
    )
    (i32.add 
      (local.get $y)
      (i32.const 3)
    )
    (i32.const 1) ;; flip_x
    (i32.const 1) ;; flip_y
  )

)

(func $render_explosion
  (param $x i32)
  (param $y i32)
  (param $frame i32)

  (block $frame_1
  (block $frame_2
  (block $frame_3
  (block $frame_4
  (block $frame_5
  (block $frame_6
    (br_table $frame_1 $frame_2 $frame_3 $frame_4 $frame_5 $frame_6
      (local.get $frame)
    )
  ) ;; frame 6
    (call $render_exp_sprite
      (local.get $x)
      (local.get $y)
      (global.get $exp_frame6)
    )
    return
  ) ;; frame 5  
    (call $render_exp_sprite
      (local.get $x)
      (local.get $y)
      (global.get $exp_frame5)
    )
    return
  ) ;; frame 4
    (call $render_exp_sprite
      (local.get $x)
      (local.get $y)
      (global.get $exp_frame4)
    )
    return
  ) ;; frame 3  
    (call $render_exp_sprite
      (local.get $x)
      (local.get $y)
      (global.get $exp_frame3)
    )
    return
  ) ;; frame 2
    (call $render_exp_sprite
      (local.get $x)
      (local.get $y)
      (global.get $exp_frame2)
    )
    return
  ) ;; frame 1
  (call $render_exp_sprite
    (local.get $x)
    (local.get $y)
    (global.get $exp_frame1)
  )
  return
)

(func $move_explosions
  (local $i i32)
  (local $data i32)
  (local $data_location i32)
  (local $active_flag i32)
  (local $frame i32)
  (local $shifted_frame i32)
  (local $x i32)
  (local $y i32)

  (loop $move_loop
  
    global.get $explosion_data_location
    local.get $i
    i32.const 2
    i32.shl
    i32.add
    local.set $data_location

    (i32.load
      (local.get $data_location) 
    )

    local.tee $data
    i32.const 1
    i32.and
    local.tee $active_flag
    i32.eqz
    if
      local.get $i
      i32.const 1
      i32.add
      local.tee $i
      global.get $explosion_count
      i32.lt_u
      br_if $move_loop
    end

    local.get $data
    i32.const 1
    i32.shr_u
    i32.const 4 ;; should be 1?
    i32.add
    i32.const 0x7f
    i32.and
    local.tee $frame
    i32.const 4
    i32.shr_u
    local.tee $shifted_frame
    i32.const 6
    i32.ge_u

    if
      (i32.store
        (local.get $data_location) 
        (i32.const 0)
      )
      local.get $i
      i32.const 1
      i32.add
      local.set $i

    else
      local.get $active_flag
      if
        local.get $data
        i32.const 0xff_ff_ff_01
        i32.and ;; frame data is clear
        local.get $frame 
        i32.const 1
        i32.shl
        i32.or
        local.set $data

        (i32.store
          (local.get $data_location) 
          (local.get $data)
        )

        local.get $data
        i32.const 20
        i32.shr_u
        i32.const 0xfff
        i32.and ;; now we have $x
        local.set $x

        local.get $data
        i32.const 8
        i32.shr_u
        i32.const 0xfff
        i32.and ;; now we have $y
        local.set $y

        (call $render_explosion
          (local.get $x)
          (local.get $y)
          (local.get $shifted_frame)
        )
      end

      local.get $i
      i32.const 1
      i32.add
      local.tee $i
      global.get $explosion_count
      i32.lt_u
      br_if $move_loop
    end
  )
)

(func $trigger_explosion
  (param $x i32)
  (param $y i32)

  (local $data i32)
  (local $data_location i32)

  local.get $x
  i32.const 20
  i32.shl ;; XXXX XXXX XXXX | 0000 0000 0000 | 0000 0000

  local.get $y
  i32.const 8
  i32.shl ;; 0000 0000 0000 | YYYY YYYY YYYY | 0000 0000
  i32.or  ;; XXXX XXXX XXXX | YYYY YYYY YYYY | 0000 0000
  i32.const 1
  i32.or  ;; XXXX XXXX XXXX | YYYY YYYY YYYY | 0000 0001
  local.set $data

  global.get $explosion_data_location
  global.get $explosion_index
  i32.const 2
  i32.shl
  i32.add
  local.set $data_location

  (i32.store
    (local.get $data_location) 
    (local.get $data)
  )

  global.get $explosion_index
  i32.const 1
  i32.add
  global.set $explosion_index

  global.get $explosion_index
  global.get $explosion_count
  i32.ge_u
  if
    i32.const 0
    global.set $explosion_index
  end
)