/// @description BORDER
var width  = window_get_width(), height = window_get_height();
var fx = width/BORDER_WIDTH;
var fy = height/BORDER_HEIGHT;
var factor = min(fx,fy);
var fW = BORDER_WIDTH*factor;
var fH = BORDER_HEIGHT*factor;
var bx = (width-fW)/2+border_offset.x*factor, by = (height-fH)/2+border_offset.y*factor
display_set_gui_maximise(factor,factor,bx,by)
draw_surface_stretched(application_surface,0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
prepare_gui(BORDER_WIDTH,BORDER_HEIGHT,bx,by)