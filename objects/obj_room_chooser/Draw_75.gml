draw_set_colour(c_black);	draw_set_alpha(0.8);	draw_set_font(fnt_main)
draw_rectangle(0,0,GUI_WIDTH,GUI_HEIGHT,false)

draw_set_alpha(1);	
if (array_length(room_result) <= 0) {
	draw_set_colour(c_red);	
} else {
	if (asset_get_type(room_search) == asset_room) {draw_set_colour(c_yellow)} else {
		draw_set_colour(c_white);
	}
}
var __y = 20
draw_text(GUI_WIDTH/2-string_width(room_search)/2,__y,room_search+(floor(TIME*0.25)%2 == 0 ? "_" : ""));

for(var i = 0; i < array_length(room_result); i++) {
	var _a = ""
	if (room_index == i) {draw_set_colour(c_white);	_a = "> "} else {draw_set_colour(c_gray)}
	draw_text_transformed(2,__y+(string_height("I")*.5)*i,_a+room_get_name(room_result[i]),.5,.5,0);	
}

draw_set_colour(c_white);	draw_set_font(-1)