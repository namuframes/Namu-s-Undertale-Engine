event_inherited();

function addscene(s) {
	array_push(scenes, s);
}

interaction_behaviour = function() {
	var _x1 = bbox_left-interaction_left, _y1 = bbox_top-interaction_top, _x2 = bbox_right+interaction_right, _y2 = bbox_bottom+interaction_bottom
	if (collision_rectangle(_x1,_y1,_x2,_y2,obj_player_interactor,false,true) && !player_cantmove()) {
		interaction();
	}
}

step = function() {
	interaction_behaviour();	
}
	
draw = function() {
	event_inherited();
}

interaction = function() {
	if (!instance_exists(my_scene)) {
		look_at_player()
		if (array_length(scenes) > 0) {
			if (is_method(scenes[page])) {
				script_execute(scenes[page])	
			}
			check_custenceCommands()
			page+= (page < array_length(scenes)-1)
		} else {check_custenceCommands(,false)}
		reset_sprite = true
	}
}

scenes = [];
page = 0;
talk = false;
done_talking = false;

my_scene = noone

reset_sprite = false;

image_speed=0;

sprite_down = find_sprite(sprite_down)
sprite_left = find_sprite(sprite_left);
sprite_up = find_sprite(sprite_up);
sprite_right = find_sprite(sprite_right);

set_sprite(DIR.DOWN,[sprite_down,find_sprite(talk_down,sprite_down)])
set_sprite(DIR.UP,[sprite_up,find_sprite(talk_up,sprite_up)])
set_sprite(DIR.LEFT,[sprite_left,find_sprite(talk_left,sprite_left)])
set_sprite(DIR.RIGHT,[sprite_right,find_sprite(talk_right,sprite_right)])

prev_sprite = find_sprite(sprite_down);
prev_face = face;
prev_image_speed = image_speed;

did_scene = false
set_talk_sprite=true