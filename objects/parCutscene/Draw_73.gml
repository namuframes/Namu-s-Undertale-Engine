draw_lang_font(fnt_main)
if (global.debug) {
	if (instance_exists(creator)) {
		draw_set_colour(c_red); draw_set_halign(fa_middle)
		draw_text(creator.x,creator.bbox_top-30,index)
		draw_set_colour(c_white); draw_set_halign(fa_left)
	} else {
		draw_set_colour(c_red);
		draw_text(5,5,index)
		draw_set_colour(c_white);
	}
}
draw_set_font(-1)