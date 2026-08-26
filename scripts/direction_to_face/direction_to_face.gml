function direction_to_face(x1,y1,x2,y2){
	var dir = round(point_direction(x1,y1,x2,y2));
	var r = DIR.RIGHT
	if (dir >= 45 && dir < 135) {r = DIR.UP}
	
	if (dir >= 135 && dir < 225) {r = DIR.LEFT}
	
	if (dir >= 225 && dir < 315) {r = DIR.DOWN}
	
	return r;
}