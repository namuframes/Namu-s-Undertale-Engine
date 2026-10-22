create_collisions = function(_x,_y) {
	var a = instance_create_depth(_x,_y,depth-1,obj_collision)
	a.image_xscale = scale_to_width(thickness)
	a.image_yscale = scale_to_height(thickness)
	return a
}

width =  image_xscale*sprite_get_width(sprite_index);
height = image_yscale*sprite_get_width(sprite_index);
angle = image_angle

width_previous	= width;
height_previous = height;
angle_previous	= angle;

normal = {
	x: x,
	y: y,
	width: width,
	height: height,
	spd: 20,
	angle: angle
}

thickness = 4;



left = 0;
top = 1;
right = 2;
bottom = 3;

collisions = []
collisions[left] = create_collisions(bbox_left,bbox_top)
collisions[top] = create_collisions(bbox_right-thickness,bbox_top)
collisions[right] = create_collisions(bbox_right-thickness,bbox_bottom-thickness)
collisions[bottom] = create_collisions(bbox_left,bbox_bottom-thickness)


col_sw   = sprite_get_width(eng_collision);
col_sh   = sprite_get_height(eng_collision);
col_tick = thickness/col_sw;

function wall_set(_wall, _lx, _ly, _xs, _ys, _px, _py, _c, _s, _a) {
	_wall.x = _px + _lx * _c + _ly * _s;
	_wall.y = _py - _lx * _s + _ly * _c;
	_wall.image_angle  = _a;
	_wall.image_xscale = _xs;
	_wall.image_yscale = _ys;
}