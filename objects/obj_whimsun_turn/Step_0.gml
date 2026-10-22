var box = obj_battle_box
if (time >= 120) {
	var _f = obj_soul.sprite_height*1.5
	if (time == 120) box_size(,_f,,,,,.5)
	if (box.height == _f && alarm[1] == -1) {alarm[1] = 15}
}