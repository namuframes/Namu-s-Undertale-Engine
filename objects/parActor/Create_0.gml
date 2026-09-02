event_inherited();

function set_sprite(_name,_val) {
	struct_set(sprite,_name,is_array(_val) ? _val : [_val])	
}

function get_sprite(_name,_index=0) {
	if (struct_exists(sprite,_name)) {
		return struct_get(sprite,_name)[_index];
	}
	return sprite_index;
};

function face_at(_direction,_index=undefined) {
	face = direction_to_face(_direction);
	sprite_index = get_sprite(face,_index);
};

function look_at_player() {
	face_at(point_direction(x,y,obj_player.x,obj_player.y));
}

function find_sprite(_sprite,fallback=sprite_index) {
	if (asset_get_type(_sprite) != asset_sprite) {
		return is_string(fallback) ? asset_get_index(fallback) : fallback
	}
	return is_string(_sprite) ? asset_get_index(_sprite) : _sprite
}

function do_walk_animation() {
	if (round(x) != round(xprevious) || round(y) != round(yprevious)) {
		image_speed = 1;
	} else if (wait_index([0,2])) {image_speed = 0}	
}
	
function face_forward(hsp,vsp) {
	if (hsp != 0 || vsp != 0) {
		if (vsp == 0) {
			if (hsp < 0) {face = DIR.LEFT};
			if (hsp > 0) {face = DIR.RIGHT};
		}

		if (hsp == 0) {
			if (vsp < 0) {face = DIR.UP};
			if (vsp > 0) {face = DIR.DOWN};
		}
	
		if (face = DIR.RIGHT && hsp < 0) {face = DIR.LEFT}		if (face = DIR.LEFT && hsp > 0) {face = DIR.RIGHT}
		if (face = DIR.DOWN && vsp < 0) {face = DIR.UP}		if (face = DIR.UP && vsp > 0) {face = DIR.DOWN}
	}
}
	
state = STATE.free;

face = DIR.DOWN;
sprite = {};

offset_x = 0;
offset_y = 0;