if (global.debug) {
	draw_lang_font(fnt_main)
	var txt = "";
	txt += $"fps: {fps}\n";
	txt += $"Delta: {DELTA()}\n{global.saved_player}\n"
	txt += $"fps: {fps}\n"
	txt += $"Region: {global.region}\n"
	txt += $"Region_kills: {global.region_kills[? global.region]}\n"
	txt += $"Language Font: {global.LANG_FONT}"
	draw_text_transformed(2,2,txt,.5,.5,0)
	draw_set_font(-1)
}