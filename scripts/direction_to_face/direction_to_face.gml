function direction_to_face(_direction){
	var dir = round(_direction);
	var r = DIR.RIGHT
	if (dir >= 45 && dir < 135) {r = DIR.UP}
	
	if (dir >= 135 && dir < 225) {r = DIR.LEFT}
	
	if (dir >= 225 && dir < 315) {r = DIR.DOWN}
	
	return r;
}