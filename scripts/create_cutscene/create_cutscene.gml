function create_cutscene(_script,_target=id){
	var i = instance_create_depth(0,0,0,parCutscene)
	i.creator = _target;
	if (is_method(_script)) {
		with(i.creator) {
			script_execute(_script);
			variable_instance_set(i,CUTSCENE_VARIABLE,variable_instance_get(id,CUTSCENE_VARIABLE))
		}
	} else if (is_array(_script)) {
		variable_instance_set(i,CUTSCENE_VARIABLE,_script)
	}
	
	return i;
}