if (object_index != obj_collision && object_index != obj_slope) {
	event_inherited();
} else if (global.debug) {
	draw_self()	
}