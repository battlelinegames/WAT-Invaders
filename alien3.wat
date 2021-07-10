(;
LAYER TOP
0 0 1 0  0 0 0 0  0x20
0 1 1 1  0 0 0 0  0x70
0 0 1 1  1 0 0 0  0x38
0 0 0 1  1 1 1 1  0x1f
0 0 1 1  1 1 1 1  0x3f
0 1 1 1  1 1 1 1  0x7f
1 1 1 1  1 1 1 1  0xff
1 1 1 1  0 0 0 0  0xf0
;)
(global $alien3_frame1_top i64 (i64.const 0x20_70_38_1f_3f_7f_ff_f0))

(;
FRAME1 BOTTOM
0 1 1 0  0 0 1 1  0x63
0 0 1 1  0 1 1 1  0x37
0 0 0 1  1 1 1 1  0x1f
0 0 1 1  1 0 0 0  0x38
0 1 1 1  0 0 0 0  0x70
1 1 1 0  0 0 0 0  0xe0
1 1 1 1  0 0 0 0  0xf0
0 1 1 0  0 0 0 0  0x60
;)
(global $alien3_frame1_bottom i64 (i64.const 0x63_37_1f_38_70_e0_f0_60))

(;
FRAME2 BOTTOM
0 1 1 0  0 1 1 1  0x67
0 0 1 1  1 1 1 1  0x3f
0 0 0 1  1 1 1 1  0x1f
0 0 0 1  1 0 0 0  0x18
0 0 1 1  0 0 0 0  0x30
0 1 1 1  0 0 0 0  0x70
0 1 1 1  1 0 0 0  0x78
0 0 1 1  0 0 0 0  0x30
;)
(global $alien3_frame2_bottom i64 (i64.const 0x67_3f_1f_18_30_70_78_30))

(func $render_alien_3
  (param $x i32)
  (param $y i32)
  (param $c i32)
  (param $frame i32)

  (local $top_frame i64)
  (local $bottom_frame i64)

  (global.get $alien3_frame1_top)
  (local.set $top_frame)

  local.get $frame
  i32.const 1
  i32.and
  if
    (global.get $alien3_frame1_bottom)
    (local.set $bottom_frame)
  else
    (global.get $alien3_frame2_bottom)
    (local.set $bottom_frame)
  end
  ;; $player_outer_layer_top rendered on left
  (;
  (func $render_sprite 
    (param $sprite_data i64)
    (param $color i32)
    (param $x i32)
    (param $y i32)
    (param $flip_x i32)
    (param $flip_y i32)
  
  ;)
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

