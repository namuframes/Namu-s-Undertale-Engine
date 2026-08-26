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

event_user(0)