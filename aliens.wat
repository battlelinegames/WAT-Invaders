;;                                       ACTIVE BIT
;;                                       |    
;; 1111 0000 1111 0000 1111 0000 1111 0000
;;          |         |    |    |    |
;; X        |Y        |R G  B A |    |TYPE 
(global $clear_x i32 (i32.const 0x00_ff_ff_ff))
(global $clear_y i32 (i32.const 0xff_00_ff_ff))
(global $frame (mut i32) (i32.const 0))
(global $alien_dir (mut i32) (i32.const 0))
(;
(func $iabs
  (param $val i32)
  (result i32)

  local.get $val
  i32.const 0
  i32.lt_s
  if
    i32.const 0
    local.get $val
    i32.sub
    return
  end
  local.get $val
)
;)

(func $bullet_hit
  (param $ax i32)
  (param $ay i32)
  (param $bx i32)
  (param $by i32)
  (result i32)
  (local $ax_sub_bx i32)
  (local $ay_sub_by i32)
  (local $hit_x i32)
  (local $hit_y i32)
  ;; this will do box collision detection
  local.get $ax
  local.get $bx
  i32.sub
  local.tee $ax_sub_bx
  i32.const 0
  i32.ge_s 
  if
    local.get $ax_sub_bx
    i32.const 16
    i32.le_s
    local.set $hit_x
  else
    local.get $ax_sub_bx
    i32.const -8
    i32.ge_s
    local.set $hit_x
  end

  ;; test y
  local.get $ay
  local.get $by
  i32.sub
  local.tee $ay_sub_by
  i32.const 0
  i32.ge_s 
  if
    local.get $ay_sub_by
    i32.const 16
    i32.le_s
    local.set $hit_y
  else
    local.get $ay_sub_by
    i32.const -8
    i32.ge_s
    local.set $hit_y
  end

  ;; if it hist on x and y it is a collision
  local.get $hit_x
  local.get $hit_y
  i32.and
)

(func $move_aliens
    ;; $alien_data_location
    ;; $alien_row_bytes
    ;; $alien_row_count
    (local $alien_frame i32)
    (local $i i32)
    (local $alien_abgr i32)
    (local $alien_x i32)
    (local $alien_y i32)
    (local $alien_type i32)
    (local $alien_info i32)
    (local $bullet_info i32)
    (local $bullet_x i32)
    (local $bullet_y i32)
    (local $active_flag i32)
    (local $temp_data_location i32)
    (local $hit_edge i32)
    (local $bullet_i i32)
    (local $alien_i i32)
    (local $y_check i32)

    (i32.shr_u
      (global.get $frame)
      (i32.const 3)
    )
    local.set $alien_frame

    i32.const 1
    global.set $you_win

    (loop $alien_loop
      global.get $alien_data_location
      local.get $i
      i32.add
      i32.load
      local.tee $alien_info

      ;; ALIEN                                 ACTIVE BIT
      ;;                                       |    
      ;; 1111 0000 1111 0000 1111 0000 1111 0000
      ;;          |         |    |    |    |
      ;; X        |Y        |R G  B A |    |TYPE 
      
      i32.const 1
      i32.and
      local.tee $active_flag
      if
        i32.const 0
        global.set $you_win
      end

      local.get $alien_info
      i32.const 1
      i32.shr_u
      i32.const 7
      i32.and
      local.set $alien_type 

      local.get $alien_info
      i32.const 8
      i32.shr_u 
      i32.const 3
      i32.and
      i32.const 85
      i32.mul
      i32.const 24
      i32.shl
      local.set $alien_abgr

      local.get $alien_info
      i32.const 10
      i32.shr_u 
      i32.const 3
      i32.and
      i32.const 85
      i32.mul
      i32.const 8
      i32.shl
      local.get $alien_abgr
      i32.or
      local.set $alien_abgr

      local.get $alien_info
      i32.const 12
      i32.shr_u 
      i32.const 3
      i32.and
      i32.const 85
      i32.mul
      i32.const 8
      i32.shl
      local.get $alien_abgr
      i32.or
      local.set $alien_abgr

      local.get $alien_info
      i32.const 14
      i32.shr_u 
      i32.const 3
      i32.and
      i32.const 85
      i32.mul
      local.get $alien_abgr
      i32.or
      local.set $alien_abgr

      local.get $alien_info
      i32.const 16
      i32.shr_u 
      i32.const 0xff
      i32.and
      local.tee $alien_y
      global.get $loss_y
      i32.ge_u
      local.get $active_flag
      i32.and
      if
        i32.const 1
        global.set $game_over
        return
      end

      local.get $alien_info
      i32.const 24
      i32.shr_u 
      local.set $alien_x

      global.get $alien_dir
      if
        local.get $alien_x
        i32.const 1
        i32.add
        local.tee $alien_x

        i32.const 248
        i32.ge_u
        local.get $active_flag
        i32.and
        if
          ;;i32.const 0
          ;;global.set $alien_dir
          i32.const 1
          local.set $hit_edge
        end
      else
        local.get $alien_x
        i32.const 1
        i32.sub
        local.tee $alien_x

        i32.const 8
        i32.le_u
        local.get $active_flag
        i32.and

        if
          ;;i32.const 1
          ;;global.set $alien_dir
          i32.const 1
          local.set $hit_edge
        end
      end

      ;; (global $clear_x i32 (i32.const 0x00_ff_ff_ff))
      ;; (global $clear_y i32 (i32.const 0xff_00_ff_ff))
      global.get $alien_data_location
      local.get $i
      i32.add

      global.get $clear_x
      local.get $alien_info
      i32.and
      local.get $alien_x
      i32.const 0xff
      i32.and
      i32.const 24
      i32.shl
      i32.or
      i32.store

      local.get $alien_info
      i32.const 1
      i32.and
      if
        local.get $alien_type
        i32.const 1
        i32.eq
        if
          (call $render_alien_1
            (local.get $alien_x)
            (local.get $alien_y)
            (local.get $alien_abgr)
            (local.get $alien_frame)
          )
        else
          local.get $alien_type
          i32.const 3
          i32.eq
          if
            (call $render_alien_3
              (local.get $alien_x)
              (local.get $alien_y)
              (local.get $alien_abgr)
              (local.get $alien_frame)
            )
          else
            (call $render_alien_2
              (local.get $alien_x)
              (local.get $alien_y)
              (local.get $alien_abgr)
              (local.get $alien_frame)
            )
          end
        end
      end

      local.get $i
      i32.const 4
      i32.add
      local.tee $i
      global.get $alien_byte_count
      i32.lt_u 
      br_if $alien_loop
    )

    local.get $hit_edge
    if
      i32.const 0
      local.set $i

      global.get $y
      i32.const 8
      i32.sub
      local.set $y_check

      i32.const 1
      global.get $alien_dir
      i32.xor
      global.set $alien_dir
      (loop $advance_y
        global.get $alien_data_location
        local.get $i
        i32.add
        local.tee $temp_data_location
        i32.load
        local.tee $alien_info
        ;;global.get $clear_y
        ;;i32.and
        i32.const 16
        i32.shr_u 
        i32.const 0xff
        i32.and
        i32.const 4
        i32.add
        local.tee $alien_y
        i32.const 16
        i32.shl
        local.get $alien_info
        global.get $clear_y
        i32.and
        i32.or
        local.set $alien_info

        (i32.store (local.get $temp_data_location) (local.get $alien_info))

        ;; advance $i
        local.get $i
        i32.const 4
        i32.add
        local.tee $i
        global.get $alien_byte_count
        i32.lt_u 
        br_if $advance_y
      )
    end

    ;; (global $shot_count i32 (i32.const 10))
    ;; loop over each bullet testing against aliens
    i32.const 0
    local.set $bullet_i


    ;; BULLET DATA
    ;; 0000 0000 0000 | 1111 1111 1111 | 0000 0001
    ;;                |                |         |
    ;;       X        |        Y       |      ACTIVE FLAG
    ;; THIS IS WHERE I LEFT OFF (7/4/21)
    (loop $bullet_loop
      (block $break
      local.get $bullet_i 
      global.get $shot_count
      i32.const 2
      i32.shl
      i32.ge_s ;; if( $bullet_i < $shot_count )
      br_if $break


      global.get $shot_data_location
      local.get $bullet_i
      i32.add
      i32.load
      local.tee $bullet_info
      i32.const 1
      i32.and
      i32.eqz
      if
          local.get $bullet_i
          i32.const 4
          i32.add
          local.set $bullet_i ;; $bullet_i+=4 (4 bytes in i32)

          ;; spawn an explosion animation
          br $bullet_loop
      end

      local.get $bullet_info
      i32.const 20
      i32.shr_u 
      local.set $bullet_x

      local.get $bullet_info
      i32.const 8
      i32.shr_u 
      i32.const 0xfff
      i32.and
      local.set $bullet_y

      i32.const 0
      local.set $alien_i
      (loop $alien_hit_loop
        (block $alien_break
        
          local.get $alien_i
          global.get $alien_byte_count
          i32.ge_s 
          br_if $alien_break

          global.get $alien_data_location
          local.get $alien_i
          i32.add

          ;; remove these lines
          ;; local.tee $temp_data_location
          ;; call $pint 
          ;; local.get $temp_data_location
          ;; remove these lines

          i32.load
          local.tee $alien_info
          i32.const 1
          i32.and
          i32.eqz
          if
              local.get $alien_i
              i32.const 4
              i32.add
              local.set $alien_i ;; $bullet_i+=4 (4 bytes in i32)
              br $alien_hit_loop
          end

          local.get $alien_info
          i32.const 16
          i32.shr_u 
          i32.const 0xff
          i32.and
          local.set $alien_y

          local.get $alien_info
          i32.const 24
          i32.shr_u 
          local.set $alien_x

          (call $bullet_hit
            (local.get $alien_x)
            (local.get $alien_y)
            (local.get $bullet_x)
            (local.get $bullet_y)
          ) ;; hit true/false

          if ;; bullet hits the alien
            (call $trigger_explosion
              (local.get $bullet_x)
              (local.get $bullet_y)
            )
            (i32.store
              (i32.add
                (global.get $alien_data_location)
                (local.get $alien_i)
              )
              (i32.and
                (local.get $alien_info)
                (i32.const 0xff_ff_ff_fe)
              )
            )
            
            global.get $shot_data_location
            local.get $bullet_i
            i32.add
            
            local.get $bullet_info
            i32.const 0xff_ff_ff_fe
            i32.and
            i32.store

            local.get $bullet_i
            i32.const 4
            i32.add
            local.set $bullet_i ;; $bullet_i+=4 (4 bytes in i32)

            ;; spawn an explosion animation
            br $bullet_loop
          end

          local.get $alien_i
          i32.const 4
          i32.add
          local.tee $alien_i
          global.get $alien_byte_count
          i32.lt_u 
          br_if $alien_hit_loop
        )
      )
      
      local.get $bullet_i
      i32.const 4
      i32.add
      local.tee $bullet_i ;; $bullet_i+=4 (4 bytes in i32)

      global.get $shot_count
      i32.lt_s ;; if( $bullet_i < $shot_count )
      br_if $bullet_loop
    ))
    ;; increment frame
    global.get $frame
    i32.const 1
    i32.add
    global.set $frame
)