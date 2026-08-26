function preload_map_exist(tag,instance=id) {
	if (variable_instance_exists(instance,TEXT_MAP_STRING)) {
		if (ds_map_exists(variable_instance_get(instance,TEXT_MAP_STRING), tag)) {return true}
	}
	
	return false
}

function preload_get_map(tag,instance=id) {
	if (preload_map_exist(tag,instance)) {
		var map = variable_instance_get(instance,TEXT_MAP_STRING)
		return map[? tag]
	}
	return false
}