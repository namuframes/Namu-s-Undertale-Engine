draw();
if (global.debug) {
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true)
	draw_rectangle_color(bbox_left-interaction_left,bbox_top-interaction_top,bbox_right+interaction_right,bbox_bottom+interaction_bottom,c_blue,c_blue,c_blue,c_blue,true)
}