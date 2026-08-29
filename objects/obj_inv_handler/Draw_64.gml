
var _item = page = "item" ? global.inventory[index.current] : selected_item

draw_box(x,y,173,181)

for(var i = 0; i < array_length(actions); i++) {
	var option = actions[i]
	var _x = x+22+48*i
	draw_lang_font(fnt_main)
	draw_text(_x,y+154,option)
	draw_set_font(-1)
	if (index.current == i && page = "action") set_heart(_x-13,y+154+4)
}

for(var i = 0; i < array_length(global.inventory); i++) {
	var it = global.inventory[i]
	var _y = y+14+16*i
	draw_each_letter(x+22,_y,item_name(it),,,,lang_font(fnt_main))
	if (index.current == i && page == "item") set_heart(x+9,_y+4)
}




draw_sprite_ext(spr_small_heart,0,ui_heart.x,ui_heart.y,1,1,0,c_white,1)