switch(state) {
	case 0:
		if (warning) {
			audio_play_sound(snd_encounter,0,0)
			warning_time=20;
			warning=false
		}

		if (warning_time<=0) {
			if (time <= 0) {
				if (blinks <= 0) {
					state=1
				} else {
					dark = !dark
					audio_stop_sound(snd_noise)
					audio_play_sound(snd_noise,0,0)
					if (dark) {
						blinks--
					}
					speed += (speed_gain/max(1,blinks))*DELTA
					speed = clamp(speed,1,infinity)
					time = 1;
				};
			} else {time -= (1/speed)*DELTA};
		} else {warning_time-=DELTA};
		soul_x = obj_player.x;
		soul_y = obj_player.y;
	break
	
	case 1:
		if (fake) {instance_destroy()} else {
			dark=true;
			state=2;
			audio_play_sound(snd_battle_start,0,0);
			soul_x = obj_player.x*2;
			soul_y = obj_player.y*2;
			room_goto(rm_battle);
		}
	break;
	
	case 2:
		if (obj_battle_control.TURN != BATTLE_TURNS.PLAYER_INIT) {
			var ease = EASE_LINEAR
			if (tween_go) {
				do_tween(id,"posx_soulX_prepare_battle","soul_x",obj_soul.x,ease,2)
				do_tween(id,"posx_soulY_prepare_battle","soul_y",obj_soul.y,ease,2)
				tween_go=false
			}
			tween_set_value("posx_soulX_prepare_battle",obj_soul.x)
			tween_set_value("posx_soulY_prepare_battle",obj_soul.y)
		
			if (!tween_exists("posx_soulX_prepare_battle") && !tween_exists("posx_soulY_prepare_battle")) {
				state++
			}
		}
	break;
	
	case 3:
		image_alpha -= .25*DELTA;
		if (image_alpha <= 0) {instance_destroy()}
	break;
}