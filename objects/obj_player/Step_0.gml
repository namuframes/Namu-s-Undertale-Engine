if (player_cantmove()) {
	state = STATE.frozen
} else {state = STATE.free}
switch(state) {
	case STATE.free:
		var col
		ready_to_cutscene = false
		hsp = ((input_check(INPUT_RIGHT) && !input_check(INPUT_LEFT))-input_check(INPUT_LEFT))*spd
		vsp = ((input_check(INPUT_DOWN) && !input_check(INPUT_UP))-input_check(INPUT_UP))*spd

		if (place_meeting(x,y,obj_collision) && is_solid(obj_collision,0,0)) {
			var off = 0;
			while(true && is_solid(instance_place(x,y,obj_collision))) {
				if (!place_meeting(x+off,y,obj_collision)) {x+=off; break}
				if (!place_meeting(x-off,y,obj_collision)) {x-=off; break}
			
				if (!place_meeting(x,y+off,obj_collision)) {y+=off; break}
				if (!place_meeting(x,y-off,obj_collision)) {y-=off; break}
			
				off+=.1;
			}
		}
		face_forward(hsp,vsp);
		collision()
		frisk_dance()
		
		x += hsp*DELTA();
		y += vsp*DELTA();
		if (global.debug) {
			if (mouse_check_button(mb_right)) {
				x=mouse_x
				y=mouse_y
			}
		}
		
		face_at(face);
		do_walk_animation();

		if (input_pressed(INPUT_CONFIRM) && !instance_exists(obj_player_interactor) && !player_cantmove()) {
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
					} else {break};
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