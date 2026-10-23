function has_cutscene_command(target=id){
	if (variable_instance_exists(target,CUTSCENE_VARIABLE)) {
		return array_length(get_cutscene_variable(target));
	}
	return false;
}