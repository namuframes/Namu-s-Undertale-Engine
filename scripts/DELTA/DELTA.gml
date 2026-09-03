function DELTA(otherway=false) {
	var _fps = max(FPS,fps)
	if (otherway) {
		return 	(max(1,_fps)/NATIVE_FPS);
	}
	return 	(NATIVE_FPS/max(1,_fps));
}