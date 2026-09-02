if (!attacked && !dead) {
	if (blink_time <= sprite_get_speed(sprite_index)/2) {
		image_speed = 1;
		if (blink_time <= 0) {
			if (wait_index([0])) {
				image_speed=0
				blink_time = irandom_range(min_time,max_time)
			}
		}
	}

	blink_time -= (blink_time>0)*DELTA();
	if (sprite_index == spr_loox_hurt) {
		sprite_index = spr_loox_rest
	}
} else {
	sprite_index = spr_loox_hurt	
}

if (!on_battle()) {image_speed=0}