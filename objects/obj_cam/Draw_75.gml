if (global.debug) {
	draw_lang_font(fnt_main);
	var txt = $"CAM: {x}/{y}";
	var hg = string_height(txt)*.5;
	draw_text_transformed(5,(BASE_HEIGHT-5)-hg,txt,.5,.5,0);
	draw_set_font(-1);
}