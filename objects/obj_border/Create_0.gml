/// @description 
LIVE;
//depth = 99999

border_offset = {
	x: 160,
	y: 30
}
border_template = {
	sprite:		BORDER_DEFAULT,
	alpha:		0,
	index:		0,
	ease_time:	20
}

_border = {
	current:	variable_clone(border_template),
	target:		variable_clone(border_template)
}

prepare_gui = function(width,height,_x=0,_y=0,multiplier=2) {
	var f = min(window_get_width()/width,window_get_height()/height);
	display_set_gui_maximise(f*multiplier,f*multiplier,_x,_y);
}

border_valid = function(_border) {
	return asset_get_type(_border) == asset_sprite || _border == BORDER_SPECIAL
}