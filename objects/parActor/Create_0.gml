event_inherited();

function look_at_player() {
	face = direction_to_face(x,y,obj_player.x,obj_player.y)
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
	
face_to_direction = function(hsp,vsp) {
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
	
follow_behaviour = function() {
	solid=false
	if (instance_exists(obj_player)) {
		if (array_length(obj_player.party_input) >= follow_index) {
			var input = obj_player.party_input[follow_index-1];
			if (is_struct(input)) {
				x = linearVar(x,input.x,obj_player.spd);
				y = linearVar(y,input.y,obj_player.spd);
				if (x != xprevious || y != yprevious) {
					image_speed = 1; 
					face_to_direction(x-xprevious,y-yprevious)
					sprite_index = sprite[face]
				} else {
					if (floor(image_index) % 2 == 0) {image_speed=0}	
				}
			}
		}
	}
}
	
set_sprite = function(_name,_val) {
	struct_set(sprite,_name,_val)	
}

get_sprite = function(_name) {
	return struct_get(sprite,_name);	
};

face = DIR.DOWN;
sprite = {};

shake_x = 0;
shake_y = 0;

offset_x = 0;
offset_y = 0;