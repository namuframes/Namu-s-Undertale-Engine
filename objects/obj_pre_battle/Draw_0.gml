if (warning_time > 0) {
	draw_sprite(spr_encounter_bubble,0,obj_player.x,((obj_player.y+obj_player.sprite_yoffset)-obj_player.sprite_height)-2)	
} else if (dark) {
	draw_set_alpha(image_alpha)
	draw_set_colour(c_black); 
	draw_rectangle(0,0,room_width,room_height,false)
	draw_set_colour(c_white); 
	draw_sprite_ext(spr_soul,0,soul_x,soul_y,.5,.5,0,SOUL_MODE.RED,1);
}
draw_set_alpha(1)