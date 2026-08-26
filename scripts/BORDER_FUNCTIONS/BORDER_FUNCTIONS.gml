function border(boolean) {
	global.border = boolean
	
	if (!global.fullscreen) {
		if (!global.border) {
			window_set_size(WINDOW_WIDTH,WINDOW_HEIGHT)
		} else {
			window_set_size(BORDER_WIDTH,BORDER_HEIGHT)	
		}
		window_center();
	}
}

function border_set_sprite(sprite, _easetime=undefined) {
	if (global.border) {
		with(obj_game_drawer) {
			if (my_border[? "target"] != sprite) {
				my_border[? "target"].sprite = sprite;
				if (is_numeric(_easetime)) {my_border[? "target"].ease_time = _easetime};
			}
		}
	}
}