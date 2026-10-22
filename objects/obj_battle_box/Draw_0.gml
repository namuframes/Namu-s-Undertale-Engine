draw_self();

draw_set_mask(1)
var t = thickness*0.08
var sw = sprite_get_width(sprite_index);
var sh = sprite_get_height(sprite_index);
draw_sprite_ext(sprite_index,0,x+t,y+t,(width-t*12)/sw,(height-t*12)/sh,image_angle,image_blend,image_alpha)

draw_reset_mask()

draw_on_mask()
	with (parBullet) {event_perform(ev_draw,0)}
draw_not_on_mask()

with(obj_battle_control) {
	event_user(1);
}