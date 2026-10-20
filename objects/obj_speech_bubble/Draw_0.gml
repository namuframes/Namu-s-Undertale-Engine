draw_lang_font(font)
txthandler = doodle(text[curtxt],,,c_black,,.5,.5,0,length,,,,writer)
update_bubble()

if (!ready) {exit};
draw_sprite_stretched_ext(spr_speech_bubble,0,bubble.x,bubble.y,width,height,image_blend,image_alpha)
draw_sprite_ext(spr_speech_pointer,0,pointer.x,pointer.y,image_xscale*(pointer.flipx ? -1 : 1),image_yscale,image_angle+pointer.angle,image_blend,image_alpha)

txthandler.draw(txt.x,txt.y);

if (global.debug) {
	draw_set_colour(c_blue);
	var off = {x: sprite_get_xoffset(spr_speech_pointer), y: sprite_get_yoffset(spr_speech_pointer)};
	draw_rectangle(bubble.x,bubble.y+height,bubble.x+width,bubble.y,true);
	draw_set_colour(c_white);
};