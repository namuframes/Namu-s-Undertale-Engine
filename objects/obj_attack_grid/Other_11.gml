///@description Intro
if (oneshot) {
	tween(id,"introX","image_xscale",1,EASE_LINEAR,1);
	tween(id, "introY","image_yscale",1,EASE_LINEAR,1);
	oneshot=false;
}
image_alpha += .05*(image_alpha < 1)
if (!tween_exists("introX") && !tween_exists("introY")) {
	for(var i = 0; i < markers_amount; i++) {
		array_push(marker,instance_create_depth(bbox_left-60*i,y,depth-1,obj_target_mark))
	}
	obj_target_mark.hspeed = 16*DELTA();
	state = ATTACK_STATE.ATTACKING;
}