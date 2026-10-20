if (proceed) {
	var p = instance_create_depth(obj_battle_box.bbox_right+40,random_range(obj_battle_box.bbox_top,obj_battle_box.bbox_bottom),obj_battle_box.depth-1,obj_bullet_loox)
	p.hspeed = -4
}
alarm[0] = room_speed/2