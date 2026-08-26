switch(background) {
	default:
		var w = sprite_get_width(spr_battle_bg)
		var h = sprite_get_height(spr_battle_bg)
		draw_sprite_ext(spr_battle_bg,0,(room_width-w)/2,h*0.04,1,1,0,image_blend,image_alpha)
	break;
}