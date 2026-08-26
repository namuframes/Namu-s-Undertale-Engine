var box = obj_bulletBorder
if (time >= 120) {
	var _f = obj_soul.sprite_height
	if (time == 120) box_size(,_f,,,,,.5)
	if (box.height == _f) {instance_destroy()}
}