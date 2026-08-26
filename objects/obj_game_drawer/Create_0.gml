/// @description 
depth = 9999

border_offset = {
	x: 160,
	y: 30
}
border_template = {
	sprite: spr_border,
	alpha: 0,
	index: 0,
	ease_time: 20
}

my_border = ds_map_create()
my_border[? "current"] = variable_clone(border_template)
my_border[? "target"] = variable_clone(border_template)

prepare_gui = function(width,height,_x=0,_y=0,multiplier=2) {
	var f = min(window_get_width()/width,window_get_height()/height);
	display_set_gui_maximise(f*multiplier,f*multiplier,_x,_y);
}