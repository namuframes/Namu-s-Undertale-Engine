var g = ideal_speed*0.05
if (x+(hspeed+g)-sprite_get_width(sprite_index)*3 > obj_battle_box.bbox_left) {
	if (image_alpha < 1) {
		image_alpha += 0.1;
		image_alpha = clamp(image_alpha,0,1);
	}
	image_xscale = lerp(image_xscale,1,0.2);
	hspeed += g;
} else {
	hspeed -= g*(hspeed < g)
	if (image_xscale > 0) {
		image_xscale -= abs(g*2)/sprite_get_width(sprite_index)
	}
	image_alpha -= 0.05
	if (image_alpha <= 0) {instance_destroy()}
}