if (player_cantmove()) {
	state = STATE.frozen
} else {state = STATE.free}

switch(state) {
	case STATE.free:
		var col
		ready_to_cutscene = false
		hsp = (input_check(INPUT_RIGHT)-input_check(INPUT_LEFT))*spd
		vsp = (input_check(INPUT_DOWN)-input_check(INPUT_UP))*spd
		
		if (input_check(INPUT_LEFT) && input_check(INPUT_RIGHT)) {hsp = -1*spd}
		if (input_check(INPUT_UP)  && input_check(INPUT_DOWN))  {vsp = -1*spd}
		face_forward(hsp,vsp);
		collision()
		face_forward(hsp,vsp);
		frisk_dance()
		
		x += hsp*DELTA();
		y += vsp*DELTA();
		face_at(face);

		do_walk_animation();
		if (input_pressed(INPUT_CONFIRM) && !instance_exists(obj_player_interactor)) {
			var _x = (bbox_left + bbox_right) * 0.5, _y = (bbox_top + bbox_bottom) * 0.5;
			var length = 20, radius = max(sprite_get_width(spr_main_interactor),sprite_get_height(spr_main_interactor)) * 0.25;
	
			var p = 0;
			while (p < length) {
				var xx = _x + lengthdir_x(p, face);
				var yy = _y + lengthdir_y(p, face);

				var inst = collision_rectangle(xx - radius,yy - radius,xx + radius,	yy + radius,all,false,true);
				if (instance_exists(inst)) {
					if (object_get_parent(inst.object_index) == obj_collision) {
						if (inst.collideable) {break}
					} else {
						break;	
					}
				}

				p++;
			}

			instance_create_depth(_x+lengthdir_x(p,face),_y+lengthdir_y(p,face),-9999,obj_player_interactor)
		}
	break;
	
	case STATE.frozen:
		if (!ready_to_cutscene) {
			if (wait_index([0,2])) {image_speed = 0; ready_to_cutscene = true}
		}
	break;
}


