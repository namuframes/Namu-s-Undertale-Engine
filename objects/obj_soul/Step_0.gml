


if (invincible > 0) {
	image_speed = 1;
	invincible -= 1*DELTA();
} else {image_speed = 0; image_index = 0}


if (mode == SOUL_MODE.YELLOW) {image_angle = 180}
image_blend = mode;

var angle_correct = image_angle-90
if (state == STATE.free) {
	if (input_check(INPUT_CANCEL)) {
		spd = PLAYER.soul_speed/2	
	} else {spd = PLAYER.soul_speed}
	var default_movement = function(use_hsp=true,use_vsp=true) {
		if (use_hsp) {
			hsp = ((input_check(INPUT_RIGHT)-input_check(INPUT_LEFT))*spd)*DELTA()
			if (input_check(INPUT_LEFT) && input_check(INPUT_RIGHT)) {hsp = (-1*spd)*DELTA()}
		}
		
		if (use_vsp) {
			vsp = ((input_check(INPUT_DOWN)-input_check(INPUT_UP))*spd)*DELTA()
			if (input_check(INPUT_UP)  && input_check(INPUT_DOWN))  {vsp = (-1*spd)*DELTA()}
		}
	}

	switch(mode) {
		case SOUL_MODE.RED:
			default_movement();			
			collision();
		
			x += hsp;
			y += vsp;
		break;
		
		case SOUL_MODE.YELLOW:
			default_movement()
			collision();
		
			x += hsp;
			y += vsp;
			shoot_timer -= (shoot_timer>0)*DELTA()
			if (input_check(INPUT_CONFIRM) && shoot_timer<=0) {
				audio_stop_sound(snd_yellow_shoot)
				audio_play_sound(snd_yellow_shoot,0,0,1,0,random_range(1,.95))
				
				var b = instance_create_depth(x,y,depth+1,obj_soul_bullet)
				b.direction = angle_correct;
				b.image_angle = angle_correct-90
				b.image_blend = image_blend;
				b.speed = 4*DELTA();
				
				shoot_timer=shoot_delay
			}
		break;
		
		case SOUL_MODE.BLUE:
			default_movement(,false)
			var on_floor = place_meeting(x,y+1,obj_collision);
			if (!on_floor) {
				if (input_released(INPUT_UP)) {
					vsp=vsp*0.5
					jump_hold=0
				}
				vsp+=gravity_force*DELTA()
			} else {
				jump_hold=4*(jump_force*DELTA())
			}
			
			if (jump_hold > 0) {
				if input_check(INPUT_UP) {
					if (vsp >= 0) {vsp=-jump_force*2} else {
						vsp-=jump_force*DELTA()
					}
					jump_hold-=DELTA();
				}
			}
			
			collision();
			//show_debug_message(on_floor)
		
			x += hsp;
			y += vsp;
		break;
	}
	
	

	can_reset=true

} else {
	shoot_timer=shoot_delay
	if (can_reset) {
		jump_hold=0;
		hsp = 0; vsp = 0;
		can_reset=false;
	}
};

