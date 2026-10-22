function draw_box(_x,_y,_width,_height){
	var outline = 0;
	if (outline > 0) {
		draw_sprite_stretched_ext(spr_box,0,_x-outline,_y-outline,_width+outline*2,_height+outline*2,c_black,draw_get_alpha())
	}
	draw_sprite_stretched_ext(spr_box,0,_x,_y,_width,_height,c_white,draw_get_alpha())
}