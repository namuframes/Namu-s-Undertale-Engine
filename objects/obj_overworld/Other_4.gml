if (!instance_exists(obj_cam)) {
	instance_create_depth(0,0,0,obj_cam);
}

for(var i = 0; i < array_length(global.party); i++) {
	var m = global.party[i]
	if (asset_get_type(m) == asset_object) {
		var inst = instance_create_depth(obj_player.x,obj_player.y,obj_player.depth,m);
		inst.follow_player = true;
		inst.follow_index = (i+1)*10
		global.party[i] = inst;
	}
}

global.region = string_get_suffix(room_get_name(room),1)
if (!ds_map_exists(global.region_kills,global.region)) {
	ds_map_add(global.region_kills,global.region,0)	
}