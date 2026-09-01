var collider = obj_collision
switch(state) {
	case STATE.free:
		if (place_meeting(x,y,collider) && is_solid(collider,0,0)) {
			var off = 0;
			while(true) {
				if (!place_meeting(x+off,y,collider)) {x+=off; break}
				if (!place_meeting(x-off,y,collider)) {x-=off; break}
			
				if (!place_meeting(x,y+off,collider)) {y+=off; break}
				if (!place_meeting(x,y-off,collider)) {y-=off; break}
			
				off++;
			}
		}
		
		if (global.debug) {
			if (mouse_check_button(mb_right)) {
				x=mouse_x
				y=mouse_y
			}
		}

	break;
}