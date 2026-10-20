event_inherited();

function is_solid(object=obj_collision, h=hsp, v=vsp) {
	var i = instance_place(x+h,y+v,object)
	if (i && variable_instance_exists(i,"collideable")) {
		if (i.collideable) {
			return true
		}
	}
	return false
}
	
function frisk_dance(object=obj_collision){
	if (!is_solid(,0,-spd)) {exit};
	if (instance_place(x,y-spd,object)) {
		if (input_check(INPUT_DOWN) && input_check(INPUT_UP)) {
			if (face != DIR.UP) {face = DIR.UP};
			vsp += spd;
			face = DIR.DOWN
		};
	};
}

function collision(object=obj_collision) {
	if (!is_solid()) {exit};
	
	var slide_range = spd;

	var p = 0.1;
	if (place_meeting(x+hsp,y,object)) {
		var _slid = false;
		if (place_meeting(x+hsp,y,obj_slope)) {
	        for (var i = p; i <= slide_range; i+=p) {
				if (!place_meeting(x+hsp, y-i, obj_slope) && !place_meeting(x+hsp, y-i, object)) {y -= i; _slid = true; break; }
				if (!place_meeting(x+hsp, y+i, obj_slope) && !place_meeting(x+hsp, y+i, object)) {y += i; _slid = true; break; }
			}
		}
		
		if (!_slid) {
			while(!place_meeting(x+sign(hsp)*p,y,object)) {
				x += sign(hsp)*p	
			}
			hsp = 0;
		};
	};

	if (place_meeting(x,y+vsp,object)) {
		var _slid = false;
		if (place_meeting(x,y+vsp,obj_slope)) {
		    for (var i = p; i <= slide_range; i+=p) {
				if (!place_meeting(x-i, y+vsp, obj_slope) && !place_meeting(x-i, y+vsp, object)) {x -= i; _slid = true; break; }
				if (!place_meeting(x+i, y+vsp, obj_slope) && !place_meeting(x+i, y+vsp, object)) {x += i; _slid = true; break; }
			}
		}
		
		if (!_slid) {
			while(!place_meeting(x,y+sign(vsp)*p,object)) {
				y += sign(vsp)*p	
			}		
			vsp = 0;
		}
	};
	face_forward(hsp,vsp);
	
}

hsp = 0;
vsp = 0;
spd = PLAYER.overworld_speed;

collsions = [];

set_sprite(DIR.DOWN, spr_main_d);
set_sprite(DIR.LEFT, spr_main_l);
set_sprite(DIR.UP, spr_main_u);
set_sprite(DIR.RIGHT, spr_main_r);

ready_to_cutscene = false