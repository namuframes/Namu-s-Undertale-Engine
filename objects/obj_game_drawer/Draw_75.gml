if (global.border) {
	var width = window_get_width(), height = window_get_height()
	var f = min(width/BORDER_WIDTH,height/BORDER_HEIGHT);
	var _x = (width-(BORDER_WIDTH*f))/2, _y = (height-(BORDER_HEIGHT*f))/2
	display_set_gui_maximise(f,f,_x,_y);
	var m = _border.current;
	draw_sprite_stretched_ext(m.sprite,m.index,0,0,BORDER_WIDTH,BORDER_HEIGHT,c_white,m.alpha);
	if (asset_get_type(_border.target.sprite) == asset_sprite) {
		m = _border.target;
		draw_sprite_stretched_ext(m.sprite,m.index,0,0,BORDER_WIDTH,BORDER_HEIGHT,c_white,m.alpha);
	}

	prepare_gui(BORDER_WIDTH,BORDER_HEIGHT,_x,_y)
}
