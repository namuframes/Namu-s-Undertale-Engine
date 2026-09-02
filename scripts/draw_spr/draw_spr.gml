function draw_spr(_sprite=sprite_index,_index=image_index,_x=x,_y=y,
_xscale=image_xscale,_yscale=image_yscale,_image_angle=image_angle,_image_blend=image_blend,_image_alpha=image_alpha) {
	if (!variable_instance_exists(id,"shake_x")) {shake_x=0};
	if (!variable_instance_exists(id,"shake_y")) {shake_y=0};
	draw_sprite_ext(_sprite,_index,_x+shake_x,_y+shake_y,_xscale,_yscale,_image_angle,_image_blend,_image_alpha)	
}