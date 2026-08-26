var h = room_height
var bottom_ui = {
	x: 34,
	y: h-80
}

var hp= {x: bottom_ui.x+246, y: bottom_ui.y, width: (global.stat.hp_max/2)*2, height: 20}
var p = string_length(string(global.stat.hp)) > 1 ? global.stat.hp : $"0{global.stat.hp}"

draw_hp(hp.x,hp.y,hp.width,hp.height,global.stat.hp,global.stat.hp_max,c_yellow,c_red)

draw_lang_font(fnt_mars);
draw_text_transformed(bottom_ui.x,bottom_ui.y,$"{global.name}   lv {global.stat.level}",3,3,0)
draw_text_transformed((hp.x+hp.width)+16,hp.y,$"{p} / { global.stat.hp_max}",3,3,0)
draw_set_font(-1);

//The texts are in obj_bulletBorder draw event