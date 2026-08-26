if (proceed) {
	var p = instance_create_depth(obj_bulletBorder.bbox_right+40,random_range(obj_bulletBorder.bbox_top,obj_bulletBorder.bbox_bottom),obj_bulletBorder.depth-1,obj_bullet_loox)
	p.hspeed = -4
}
alarm[0] = room_speed/2