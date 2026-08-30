function set_heart(_x,_y,smooth=1,_rounded=false) { //Helpfull for ui things
	if (!variable_global_exists("ui_heart")) {
		variable_global_set("ui_heart",{
			x: _x,
			y: _y,
		});
	};

	if (!is_numeric(global.ui_heart.x)) {global.ui_heart.x = _x};
	if (!is_numeric(global.ui_heart.y)) {global.ui_heart.x = _y};

	var dif = ((_x+_y)-(global.ui_heart.x+global.ui_heart.y))

	global.ui_heart.x = lerp(global.ui_heart.x,_x,smooth)
	global.ui_heart.y = lerp(global.ui_heart.y,_y,smooth)

	if (_rounded) {
		global.ui_heart.x = round(global.ui_heart.x);
		global.ui_heart.y = round(global.ui_heart.y);
	}
	with(obj_soul) {
		if (state == STATE.follow) {
			x = global.ui_heart.x;
			y = global.ui_heart.y;
		}	
	}
}