/// @description NO BORDER
 
var width  = window_get_width();
var height = window_get_height();
var factor = min(width/BASE_WIDTH, height/BASE_HEIGHT);
var fW = BASE_WIDTH*factor;
var fH = BASE_HEIGHT*factor;
var _x = (width-fW)/2, _y = (height-fH)/2
display_set_gui_maximise(factor,factor,_x,_y)
draw_surface_stretched(application_surface,0,0,BASE_WIDTH,BASE_HEIGHT)
prepare_gui(BASE_WIDTH,BASE_HEIGHT,_x,_y,1)