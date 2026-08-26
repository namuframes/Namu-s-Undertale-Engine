// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function get_draw_font(){
	var r = draw_get_font();
	if (r == -1) {
		r = lang_font(fnt_main_mono)
	}
	return r
}