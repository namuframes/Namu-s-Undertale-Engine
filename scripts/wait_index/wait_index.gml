function wait_index(frames=[]){
	if (array_length(frames) > 0) {
		return array_contains(frames,floor(image_index))
	};
	return false;
}