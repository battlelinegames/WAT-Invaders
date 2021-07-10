(;
OUTER LAYER TOP
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 1 0  0x02
0 0 0 0  0 0 1 0  0x02
0 0 0 0  0 0 1 0  0x02
0 0 0 0  0 0 1 0  0x02
0 0 0 0  0 0 1 0  0x02
0 0 0 0  0 1 0 0  0x04
0 1 0 0  0 1 0 0  0x44
;)
(global $player_outer_layer_top i64 (i64.const 0x01_02_02_02_02_02_04_44))

(;
OUTER LAYER BOTTOM
1 0 1 0  0 1 0 0  0xa4
1 0 1 0  0 1 0 1  0xa5
1 0 1 0  0 1 0 0  0xa4
1 0 1 1  1 1 1 0  0xbe
1 0 1 1  1 1 0 0  0xbc
1 0 1 1  1 1 0 1  0xbb
1 0 1 0  0 1 1 0  0xa6
0 1 0 0  0 0 1 1  0x43
;)
(global $player_outer_layer_bottom i64 (i64.const 0xa4_a5_a4_be_bc_bb_a6_43))

(;
INNER LAYER TOP
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 1 1  0x03
0 0 0 0  0 0 1 1  0x03
;)
(global $player_inner_layer_top i64 (i64.const 0x00_01_01_01_01_01_03_03))

(;
INNER LAYER BOTTOM
0 1 0 0  0 0 1 1  0x43
0 1 0 0  0 0 1 0  0x42
0 1 0 0  0 0 1 0  0x42
0 1 0 0  0 0 0 0  0x40
0 1 0 0  0 0 0 0  0x40
0 1 0 0  0 1 0 0  0x44
0 1 0 0  0 0 0 1  0x41
0 0 0 0  0 0 0 0  0x00
;)
(global $player_inner_layer_bottom i64 (i64.const 0x43_42_42_40_40_44_41_00))

(;
COCKPIT
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 0 1  0x01
0 0 0 0  0 0 1 1  0x03
0 0 0 0  0 0 1 0  0x02
0 0 0 0  0 0 0 0  0x00
0 0 0 0  0 0 0 0  0x00
;)
(global $player_cockpit i64 (i64.const 0x00_00_01_01_03_02_00_00))


(func $render_player
  (param $x i32)
  (param $y i32)

  ;; $player_outer_layer_top rendered on left
  (call $render_sprite
    (global.get $player_outer_layer_top)
    (i32.const 0xff_fc_db_cb) ;; color
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
    (global.get $player_outer_layer_top)
    (i32.const 0xff_fc_db_cb) ;; color 
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
    (global.get $player_outer_layer_bottom)
    (i32.const 0xff_fc_db_cb) ;; color 
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
    (global.get $player_outer_layer_bottom)
    (i32.const 0xff_fc_db_cb) ;; color 
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

  ;; $player_inner_layer_top
  (call $render_sprite
    (global.get $player_inner_layer_top)
    (i32.const 0xff_ff_ff_ff) ;; color 
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
    (global.get $player_inner_layer_top)
    (i32.const 0xff_ff_ff_ff) ;; color 
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


  ;; $player_inner_layer_bottom
  (call $render_sprite
    (global.get $player_inner_layer_bottom)
    (i32.const 0xff_ff_ff_ff) ;; color 
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
    (global.get $player_inner_layer_bottom)
    (i32.const 0xff_ff_ff_ff) ;; color 
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

  ;; $player_cockpit
  (call $render_sprite
    (global.get $player_cockpit)
    (i32.const 0xff_ff_24_00) ;; color 
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
    (global.get $player_cockpit)
    (i32.const 0xff_ff_24_00) ;; color 
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