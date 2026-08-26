function tween_destroy(tag){
	with(obj_tweenHandler) {
		if (variable_instance_exists(id,tag)) {instance_destroy()}	
	}
}