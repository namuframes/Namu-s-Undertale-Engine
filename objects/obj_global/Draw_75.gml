if (global.debug) {
	var _x = 2, _y = 2
	draw_lang_font(fnt_main)
	var txt = "";
	txt += $"fps: {fps}/{fps_real}\n";
	txt += $"Delta: {DELTA()}\n{global.saved_player}\n"
	txt += $"Region: {global.region}\n"
	txt += $"Region_kills: {global.region_kills[? global.region]}\n"
	txt += $"Language Font: {global.LANG_FONT}"
	draw_set_colour(c_black);	draw_set_alpha(0.25)
	draw_rectangle(_x,_y,_x+string_width(txt)*.5,_y+string_height(txt)*.5,false)
	draw_set_colour(c_white);	draw_set_alpha(1)
	draw_text_transformed(_x,_y,txt,.5,.5,0)
	
	draw_set_alpha(0.25)
	draw_text(0,0,"corner_1")
	draw_set_valign(fa_bottom);	draw_set_halign(fa_right)
	draw_text(GUI_WIDTH,GUI_HEIGHT,"corner_2")
	draw_set_valign(fa_top);	draw_set_halign(fa_left)
	draw_set_alpha(1)
	
	draw_set_font(-1)
}