(module
  (global $cnvs_size (import "env" "cnvs_size") i32)
  (global $img_buf_size (import "env" "img_buf_size") i32)
  ;; 265_172
  (import "env" "mem" (memory 10))
  (import "env" "pint" (func $pint(param i32)))
  (import "env" "pfloat" (func $pfloat(param f32)))

  (global $game_over (mut i32) (i32.const 0))
  (global $you_win (mut i32) (i32.const 0))

  (#include "data.wat")      ;; 31 lines
  (#include "sprite.wat")    ;; 145 lines
  (#include "explosion.wat") ;; 338 lines
  (#include "player.wat")    ;; 226 lines
  (#include "alien1.wat")    ;; 148 lines
  (#include "alien2.wat")    ;; 122 lines
  (#include "alien3.wat")    ;; 135 lines
  (#include "shots.wat")     ;; 180 lines
  (#include "aliens.wat")    ;; 429 lines
  (#include "message.wat")   ;; 276 lines

  (global $x (mut i32) (i32.const 120))
  (global $y (mut i32) (i32.const 235))
  (global $loss_y (mut i32) (i32.const 220))

  (func (export "main")
    (param $left_arrow i32)
    (param $right_arrow i32)
    (param $space_bar i32)
    
    local.get $left_arrow
    if
      global.get $x
      i32.const 2
      i32.sub
      global.set $x
      
      global.get $x
      i32.const 8
      i32.lt_s

      if
        i32.const 8
        global.set $x
      end
      
    end

    local.get $right_arrow
    if
      global.get $x
      i32.const 2
      i32.add
      global.set $x
      global.get $x
      i32.const  248
      i32.gt_s
      if
        i32.const 248
        global.set $x
      end
    end

    global.get $shot_countdown
    i32.const 0
    i32.le_s 
    local.get $space_bar
    i32.and
    if
      global.get $shot_countdown_time
      global.set $shot_countdown

      (call $shoot 
        (global.get $x)
        (global.get $y)
      )
    end

    global.get $shot_countdown
    i32.const 1
    i32.sub
    global.set $shot_countdown

    call $clear_canvas
    (call $render_player
      (global.get $x)
      (global.get $y)
    )

    global.get $you_win
    if
      call $render_win
      return
    else
      global.get $game_over
      if
        call $render_game_over
        return
      end
    end
    call $move_shots
    call $move_aliens
    call $move_explosions
  )
)