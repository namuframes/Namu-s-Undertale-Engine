///@description Outro
if (oneshot) {
	instance_destroy(obj_target_mark)
	tween(id, "outroX","image_xscale",0,EASE_LINEAR,2);
	tween(id, "outroY","image_yscale",1,EASE_LINEAR,2);

	oneshot=false;
}
image_alpha -= 0.1;
if ((!tween_exists("outroX") && !tween_exists("outroY")) || image_alpha <= 0) {
	instance_destroy();	
}