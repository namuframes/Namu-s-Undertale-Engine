function tween_exists(_tag){
	with(obj_tweenHandler) {
		if (variable_instance_exists(id,_tag)) {return true}	
	}
	return false
}