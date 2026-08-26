if (!player_cantmove()) {
	if (input_pressed(INPUT_SPECIAL) && menu_delay<=0) {
		instance_create_depth(0,0,0,obj_menu);	
		menu_delay=1
	}
	if (!instance_exists(obj_menu)) {menu_delay-=(menu_delay>0)}
}