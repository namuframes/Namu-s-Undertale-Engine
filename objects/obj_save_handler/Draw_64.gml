
var _x = x+54;
var _y = y+59;
draw_sprite_stretched(spr_box,0,_x,_y,212,87)

var txt_x = _x+16;
var txt_y = _y+11;

draw_lang_font(fnt_main)
draw_text(txt_x,txt_y,global.name)
draw_text(txt_x+84,txt_y,$"LV {global.stat.level}")
draw_text(txt_x+156,txt_y,$"0:00")
draw_text(txt_x,txt_y+20,string_upper_first(global.region))
for(var i = 0; i < array_length(options); i++) {
	var txt = options[i].text;
	var offx = sprite_get_width(hrt)+6
	var __y = txt_y+50
	var __x = txt_x+90*i
	draw_text(__x+offx,__y,txt)
	if (index == i) {
		set_heart(__x,__y+3)
	}
}
draw_sprite(spr_small_heart,0,ui_heart.x,ui_heart.y);
draw_set_font(-1)