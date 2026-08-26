// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function draw_infront_shadow(_x,_y,colour=c_black,sprite=sprite_index,index=image_index,alpha=draw_get_alpha(),xscale=image_xscale,yscale=image_yscale,angle=image_angle){
	draw_set_mask(1,127)
	draw_self();
	draw_reset_mask();

	draw_on_mask();
	draw_solid_colour(colour,alpha);
	draw_sprite_ext(sprite,index,x+_x,y+_y,xscale,yscale,angle,c_white,alpha)
	shader_reset()
	draw_not_on_mask();
}