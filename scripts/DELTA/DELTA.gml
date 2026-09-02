function DELTA(otherway=false) {
	if (otherway) {
		return 	(max(1,fps)/NATIVE_FPS);
	}
	return 	(NATIVE_FPS/max(1,fps));
}