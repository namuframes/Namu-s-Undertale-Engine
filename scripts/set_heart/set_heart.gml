function set_heart(_x,_y,smooth=1,_rounded=false) { //Helpfull for ui things
	if (!variable_instance_exists(id,"ui_heart")) {
		variable_instance_set(id,"ui_heart",{
			x: _x,
			y: _y,
		});
	};

	if (!is_numeric(ui_heart.x)) {ui_heart.x = _x};
	if (!is_numeric(ui_heart.y)) {ui_heart.x = _y};

	var target = instance_exists(obj_soul) ? obj_soul : ui_heart 
	var dif = ((_x+_y)-(target.x+target.y))

	target.x = lerp(target.x,_x,smooth)
	target.y = lerp(target.y,_y,smooth)

	if (_rounded) {
		target.x = round(target.x);
		target.y = round(target.y);
	}
}