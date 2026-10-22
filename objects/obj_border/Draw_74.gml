LIVE;
var width  = window_get_width();
var height = window_get_height();

var draw_border = function(m=_border.current) {
	if (asset_get_type(m.sprite) == asset_sprite) {
		draw_sprite_stretched_ext(m.sprite,m.index,0,0,BORDER_WIDTH,BORDER_HEIGHT,c_white,m.alpha);
	} else if (m.sprite == BORDER_SPECIAL) {
		draw_set_alpha(m.alpha)
		var _x = border_offset.x,	_y = border_offset.y
		var a = draw_get_alpha()
		
		draw_surface_ext(application_surface,0,(WINDOW_HEIGHT-BORDER_HEIGHT)*1.5,1.5,1.5,0,c_white,a);
		with(obj_fade) {draw_fade(a)};
		
		draw_set_colour(c_black);	draw_set_alpha(a*.4);
		draw_rectangle(0,0,GUI_WIDTH,GUI_HEIGHT,false);
		draw_set_colour(c_white);	draw_set_alpha(1)

		draw_sprite_ext(spr_border_special,0,0,0,.5,.5,0,c_white,a);
	}
}


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
	
	
	var f = min(width/BORDER_WIDTH,height/BORDER_HEIGHT);
	var _x = (width-(BORDER_WIDTH*f))/2, _y = (height-(BORDER_HEIGHT*f))/2
	display_set_gui_maximise(f,f,_x,_y);
	draw_border(_border.current)
	draw_border(_border.target);
	
	display_set_gui_maximise(factor,factor,bx,by)
	draw_set_colour(c_black)
	draw_rectangle(0,0,WINDOW_WIDTH-1,WINDOW_HEIGHT-1,false)
	draw_set_colour(c_white)
	draw_surface_stretched(application_surface,0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
	gpu_set_scissor(0,0,width-bx,height-by)
	prepare_gui(BORDER_WIDTH,BORDER_HEIGHT,bx,by)
}