var box = obj_battle_box
if (state == STATE.free) {

	if (place_meeting(x,y,obj_collision)) {
		var off = 0;
		if (box.angle_previous != box.angle) {
			var _d = box.angle-box.angle_previous;
			if (_d != 0) {
				var _px = box.x,	_py = box.y;
				var _dist = point_distance(_px, _py, x, y);
				var _dir  = point_direction(_px, _py, x, y) + _d;
				x = _px + lengthdir_x(_dist, _dir);
				y = _py + lengthdir_y(_dist, _dir);
			}
		}
		while(off < max(sprite_width,sprite_height)) {
			if (!place_meeting(x+off,y,obj_collision))			{x += off; break}
			else if (!place_meeting(x,y+off,obj_collision))		{y += off; break}
			else if (!place_meeting(x-off,y,obj_collision))		{x -= off; break}
			else if (!place_meeting(x,y-off,obj_collision))		{y -= off; break}
			else if (!place_meeting(x-off,y-off,obj_collision)) {x -= off; y -= off; break}
			else if (!place_meeting(x+off,y+off,obj_collision)) {x += off; y += off; break};
			off++
		}
	}
};
if (follow_border) {
	x += box.x - box.xprevious;
	y += box.y - box.yprevious;

}