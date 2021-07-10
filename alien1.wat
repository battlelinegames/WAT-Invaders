(;
ZERO
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
;)

(;
LAYER TOP A
0 1 1 1  0 0 0 0  0x70
1 1 1 1  1 0 0 0  0xf8
0 1 1 1  1 1 0 0  0x7c
0 0 0 0  1 1 1 1  0x0f
0 0 0 0  1 1 1 1  0x0f
0 0 0 1  1 1 1 1  0x1f
0 0 1 1  1 1 1 1  0x3f
0 1 1 1  1 1 1 1  0x7f
;)
(global $alien1_frame1_top i64 (i64.const 0x70_f8_7c_0f_0f_1f_3f_7f))

(;
LAYER BOTTOM A
1 1 1 1  0 0 1 1  0xf3
0 1 1 1  1 1 1 1  0x7f
0 0 0 1  1 1 1 1  0x1f
0 0 1 1  1 1 1 1  0x3f
0 1 1 1  0 0 1 1  0x73
1 1 1 0  0 0 1 1  0xe3
1 1 1 0  0 0 0 1  0xe1
0 1 0 0  0 0 0 0  0x40
;)
(global $alien1_frame1_bottom i64 (i64.const 0xf3_7f_1f_3f_73_e3_e1_40))

(;
LAYER TOP B
0 0 0 0  0 0 0 0  0x00
0 0 1 1  1 1 0 0  0x3c
0 1 1 1  1 1 1 0  0x7e
1 1 0 1  1 1 1 1  0xdf
1 0 0 0  1 1 1 1  0x8f
0 0 0 1  1 1 1 1  0x1f
0 0 1 1  1 1 1 1  0x3f
0 1 1 1  1 1 1 1  0x7f
;)
(global $alien1_frame2_top i64 (i64.const 0x00_3c_7e_df_8f_1f_3f_7f))

(;
LAYER BOTTOM B
0 1 1 1  1 1 1 1  0x7f
0 1 1 1  1 1 1 1  0x7f
0 0 0 1  1 1 1 1  0x1f
0 0 1 1  1 1 1 1  0x3f
0 0 1 1  1 0 1 1  0x3b
0 0 1 1  1 0 0 1  0x39
0 0 0 1  1 0 0 0  0x18
0 0 0 0  1 0 0 0  0x08
;)
(global $alien1_frame2_bottom i64 (i64.const 0x7f_7f_1f_3f_3b_39_18_08))

(func $render_alien_1
  (param $x i32)
  (param $y i32)
  (param $c i32)
  (param $frame i32)

  (local $top_frame i64)
  (local $bottom_frame i64)

  local.get $frame
  i32.const 1
  i32.and
  if
    (global.get $alien1_frame1_top)
    (local.set $top_frame)
    (global.get $alien1_frame1_bottom)
    (local.set $bottom_frame)
  else
    (global.get $alien1_frame2_top)
    (local.set $top_frame)
    (global.get $alien1_frame2_bottom)
    (local.set $bottom_frame)
  end
  ;; $player_outer_layer_top rendered on left
  (call $render_sprite
    (local.get $top_frame)
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

  (call $render_sprite
    (local.get $top_frame)
    (local.get $c) ;; color
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

  ;; $player_outer_layer_bottom
  (call $render_sprite
    (local.get $bottom_frame)
    (local.get $c) ;; color
    (i32.sub 
      (local.get $x)
      (i32.const 4)
    )
    (i32.add 
      (local.get $y)
      (i32.const 4)
    )
    (i32.const 0) ;; flip_x
    (i32.const 0) ;; flip_y
  )

  (call $render_sprite
    (local.get $bottom_frame)
    (local.get $c) ;; color
    (i32.add 
      (local.get $x)
      (i32.const 4)
    )
    (i32.add 
      (local.get $y)
      (i32.const 4)
    )
    (i32.const 1) ;; flip_x
    (i32.const 0) ;; flip_y
  )
)
