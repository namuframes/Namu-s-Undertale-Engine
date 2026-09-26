function switch_room(room,x=undefined,y=undefined,object=noone,	_fadein_speed=undefined,	_fadeout_speed=undefined) {
	if (!instance_exists(obj_room_transitioner)) {
		var t = instance_create_depth(0,0,0,obj_room_transitioner);
		if (asset_get_type(object) == asset_object) {t.destiny.object = object};
		if (asset_get_type(room) == asset_room) {t.destiny.rm = room};
		if (is_numeric(x)) {t.destiny.x = x;}
		if (is_numeric(y)) {t.destiny.y = y;}
		if (is_numeric(_fadein_speed))	{fadein_speed = _fadein_speed};
		if (is_numeric(_fadeout_speed)) {fadeout_speed = _fadeout_speed};
	}
}