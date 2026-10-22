if (global.border) {
	var width = window_get_width(), height = window_get_height()
	var f = min(width/BORDER_WIDTH,height/BORDER_HEIGHT);
	var _x = (width-(BORDER_WIDTH*f))/2, _y = (height-(BORDER_HEIGHT*f))/2
	gpu_set_scissor(0,0,width,height)
	prepare_gui(BORDER_WIDTH,BORDER_HEIGHT,_x,_y)
};
