(func $render_pixel
  (param $x i32)
  (param $y i32)
  (param $c i32)
)

  (func $clear_canvas
    (local $i i32)

    (loop $pixel_loop
      (i64.store (local.get $i) (i64.const 0xff_00_00_00_ff_00_00_00))
      (i32.add (local.get $i) (i32.const 8))
      local.set $i

      (i32.lt_u (local.get $i) (global.get $img_buf_size))
      br_if $pixel_loop
    )
  )

  (func $set_pixel
    (param $x i32)
    (param $y i32)
    (param $c i32)
    
    (i32.ge_u (local.get $x) (global.get $cnvs_size))
    if
      return
    end

    (i32.ge_u (local.get $y) (global.get $cnvs_size))
    if
      return
    end

    local.get $y
    global.get $cnvs_size
    i32.mul

    local.get $x
    i32.add

    i32.const 4
    i32.mul

    local.get $c

    i32.store
  )

  (func $render_sprite 
    (param $sprite_data i64)
    (param $color i32)
    (param $x i32)
    (param $y i32)
    (param $flip_x i32)
    (param $flip_y i32)

    (local $i i32)
    (local $yval i32)
    (local $xval i32)

    (loop $pixel_loop
      local.get $sprite_data 
      i32.const 63 
      local.get $i ;; [$sprite_data, 63, i]
      i32.sub ;; 63 - $i [$sprite_data, 63 - i]
      i64.extend_i32_u 
      i64.shr_u ;; $sprite_data >> (63 - $i)
      i64.const 1 
      i64.and ;; ($sprite_data >> (64 - $i)) & 1
      i32.wrap_i64 ;; [i32]
      if ;; if pixel data is 1
        local.get $flip_x 
        if
          local.get $x 
          local.get $i 
          i32.const 0x07 
          i32.and ;; last 8 bits of $i
          i32.sub ;; $x - ($i & 0000 1111)
          i32.const 3
          i32.add
          local.set $xval
        else 
          local.get $x 
          local.get $i 
          i32.const 0x07 
          i32.and ;; last 8 bits of $i
          i32.add ;; $x + ($i & 0000 1111)
          i32.const 4
          i32.sub
          local.set $xval
        end 
        ;; now you have the x value for the pixel

        local.get $flip_y 
        if 
          local.get $y 
          local.get $i 
          i32.const 3 
          i32.shr_u ;; $i / 8
          i32.sub ;; $y - ($i / 8)
          i32.const 4
          i32.add
          local.set $yval
        else
          local.get $y 
          local.get $i 
          i32.const 3 
          i32.shr_u ;; $i / 8
          i32.add ;; $y + ($i / 8)
          i32.const 4
          i32.sub
          local.set $yval
        end 

        ;; now you have the y value for the pixel

        local.get $xval
        local.get $yval
        local.get $color ;; [i32, i32, i32]

        call $set_pixel
      
      end 
      ;; should not return

      local.get $i  
      i32.const 1   
      i32.add       ;; $i++
      local.tee $i

      i32.const 64
      i32.lt_u
      br_if $pixel_loop
      
    )
  )
