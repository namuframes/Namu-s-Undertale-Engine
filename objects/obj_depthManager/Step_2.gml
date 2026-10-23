// Adjusting depth and all
if (instance_exists(obj_player)) {
	depth = obj_player.depth;
} else if (instance_exists(obj_overworld)) {
	depth = obj_overworld.depth;	
} else {
	depth = layer_get_depth(layer);	
}