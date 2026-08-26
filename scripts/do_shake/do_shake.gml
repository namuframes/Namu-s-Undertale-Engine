// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function do_shake(_object,_var,_range,_time){
	var s = instance_create_depth(20,20,0,obj_shaker)
	s.target = _object;
	s.target_variable = _var;
	s.range = _range;
	s.time = _time
	return s
}