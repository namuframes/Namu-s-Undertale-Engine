draw_self();

draw_set_mask(1)
var t = thickness*1.5
draw_rectangle_colour(bbox_left+t,bbox_top+t,bbox_right-t,bbox_bottom-t,c_red,c_red,c_red,c_red,false);

draw_reset_mask()

draw_on_mask()
	with (parBullet) {event_perform(ev_draw,0)}
draw_not_on_mask()

with(obj_battle_control) {
	event_user(1);
}