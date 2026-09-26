fade(c_black,2*fadein_speed,2*fadeout_speed,EASE_LINEAR,EASE_LINEAR,,
function() {	//Fade in end
	destiny = creator.destiny
	room_goto(destiny.rm)
},
function() { //FadeOut Start
	if (instance_exists(destiny.object)) {
		if (destiny.object.object_index == obj_warp_marker) {
			if (!ds_map_exists(global.room_player_info,room)) {
				destiny.object = instance_nearest(obj_player.x,obj_player.y,obj_warp_marker)
				with(obj_warp_marker) {
					if (spawn) {other.destiny.object = id};
				}
			} else {
				var position = global.room_player_info[? room];
				destiny.object = instance_nearest(position.x,position.y,obj_warp_marker);
			}
		}

		destiny.x += destiny.object.x;
		destiny.y += destiny.object.y;
	}

	if (instance_exists(obj_player)) {
		obj_player.x = destiny.x;
		obj_player.y = destiny.y;
	}
});

instance_destroy();