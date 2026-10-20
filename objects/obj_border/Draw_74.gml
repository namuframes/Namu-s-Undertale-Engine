LIVE;
var width  = window_get_width();
var height = window_get_height();
if (!global.border) {
	var factor = min(width/BASE_WIDTH, height/BASE_HEIGHT);
	var fW = BASE_WIDTH*factor;
	var fH = BASE_HEIGHT*factor;
	var _x = (width-fW)/2, _y = (height-fH)/2
	display_set_gui_size(BASE_WIDTH,BASE_HEIGHT)
	gpu_set_scissor(_x,_y,fW,fH)
} else {
	var fx = width/BORDER_WIDTH;
	var fy = height/BORDER_HEIGHT;
	var factor = min(fx,fy);
	var fW = BORDER_WIDTH*factor;
	var fH = BORDER_HEIGHT*factor;
	var bx = (width-fW)/2+border_offset.x*factor, by = (height-fH)/2+border_offset.y*factor
	display_set_gui_maximise(factor,factor,bx,by)
	draw_surface_stretched(application_surface,0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
	prepare_gui(BORDER_WIDTH,BORDER_HEIGHT,bx,by)	
}