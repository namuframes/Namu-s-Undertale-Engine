function create_actor(sprite_down,sprite_right,sprite_up,sprite_left,_x,_y,_depth=depth) {
	var inst = instance_create_depth(_x,_y,_depth,parActor)
	inst.sprite_left = sprite_left
	inst.sprite_down = sprite_down
	inst.sprite_right = sprite_right
	inst.sprite_up = sprite_up;
	with(inst) {
		sprite[DIR.DOWN] = find_sprite(sprite_down);
		sprite[DIR.LEFT] = find_sprite(sprite_left);
		sprite[DIR.UP] = find_sprite(sprite_up);
		sprite[DIR.RIGHT] = find_sprite(sprite_right);
		sprite_index = sprite[DIR.DOWN]
	}

	return inst
}