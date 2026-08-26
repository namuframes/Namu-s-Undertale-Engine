width =  image_xscale*sprite_get_width(sprite_index);
height = image_yscale*sprite_get_width(sprite_index);
angle = image_angle

normal = {
	x: x,
	y: y,
	width: width,
	height: height,
	spd: 20,
	angle: angle
}

thickness = 4;

create_collisions = function(_x,_y) {
	var a = instance_create_depth(_x,_y,depth-1,obj_collision)
	a.image_xscale = scale_to_width(thickness)
	a.image_yscale = scale_to_height(thickness)
	return a
}

left = 0;
up = 1;
right = 2;
down = 3;

collisions = []
collisions[left] = create_collisions(bbox_left,bbox_top)
collisions[up] = create_collisions(bbox_right-thickness,bbox_top)
collisions[right] = create_collisions(bbox_right-thickness,bbox_bottom-thickness)
collisions[down] = create_collisions(bbox_left,bbox_bottom-thickness)