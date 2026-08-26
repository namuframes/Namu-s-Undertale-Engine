menu_delay = 0;
room_save_player = function() {
	if (instance_exists(obj_player)) {
		save_player()
		var s = {x: obj_player.x,y: obj_player.y}
		ds_map_set(global.room_player_info,room,s)
	}
}