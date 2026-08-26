var amount = instance_number(obj_target_mark);
with(obj_target_mark) {
	if (finished) amount--;
}

if (finished) {
	if (amount == 1) {dissapear=true};
	if (dissapear) {
		image_xscale += 0.05
		image_yscale += 0.05
		image_alpha -= 0.1	
	}
	image_speed = 1;
	if (image_alpha <= 0) {instance_destroy()}
}