function switch_room(room,x=undefined,y=undefined,object=noone){
	if (!instance_exists(obj_room_transitioner)) {
		var t = instance_create_depth(0,0,0,obj_room_transitioner);
		if (asset_get_type(object) == asset_object) {t.destiny.object = object};
		if (asset_get_type(room) == asset_room) {t.destiny.rm = room};
		if (is_numeric(x)) {t.destiny.x = x;}
		if (is_numeric(y)) {t.destiny.y = y;}
	}
}