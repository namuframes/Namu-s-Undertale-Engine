draw_set_alpha(.5)
draw_rectangle_color(0,0,GUI_WIDTH,GUI_HEIGHT,c_black,c_black,c_black,c_black,false)
draw_set_alpha(1)
var length = array_length(rooms)-1
index += (input_pressed(INPUT_DOWN)-input_pressed(INPUT_UP))
index = wrap(index,0,length-1)

for (var i = 0; i < length; i++)
{
	draw_lang_font(fnt_main);
	if (index == i) {
		draw_set_color(c_yellow)} else {draw_set_color(c_white);
	}
	draw_text_transformed(5,5+i*6,room_get_name(rooms[i]),.5,.5,0);
}

if (input_pressed(INPUT_CONFIRM)) {switch_room(rooms[index],0,0,obj_player)}

draw_set_font(-1)
draw_set_color(c_white)

draw_text(60,10,index)