function shake(_object,x_range,y_range,_time){
	var s = instance_create_depth(0,0,0,obj_shaker)
	s.target = _object;
	s.range_x = x_range;
	s.range_y = y_range;
	s.time = _time
	return s;
};