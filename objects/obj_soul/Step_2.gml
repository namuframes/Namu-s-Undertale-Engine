
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
	x += obj_bulletBorder.x - obj_bulletBorder.xprevious
	y += obj_bulletBorder.y - obj_bulletBorder.yprevious	
}

