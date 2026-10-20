
if (state == STATE.free) {
	if (place_meeting(x,y,obj_collision)) {
		var off = 0;
	
		while(true) {
			if (!place_meeting(x+off,y,obj_collision)) {x+=off; break}
			if (!place_meeting(x-off,y,obj_collision)) {x-=off; break}
			if (!place_meeting(x,y+off,obj_collision)) {y+=off; break}
			if (!place_meeting(x,y-off,obj_collision)) {y-=off; break}
			
			off+=.1;
		}
	}
}

if (follow_border) {
	x += obj_battle_box.x - obj_battle_box.xprevious
	y += obj_battle_box.y - obj_battle_box.yprevious	
}

