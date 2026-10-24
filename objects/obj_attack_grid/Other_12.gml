///@description Attacking	
if (array_length(marker) > 0) {
	var i = array_first(marker);
	if (i.x > room_width) {instance_destroy(i); array_delete(marker,0,1)} else {
		if ((input_pressed(INPUT_CONFIRM)) && place_meeting(x,y,i)) {
			damage += calculate_damage(i,markers_amount)
			i.finished = true
			i.hspeed = 0;
			i=false;
			array_delete(marker,0,1)
		}
	}
} else {state = ATTACK_STATE.ANIMATION};