function create_cutscene(_script,_target=id){
	var i = instance_create_depth(0,0,0,parCutscene)
	i.creator = _target;
	if (is_method(_script)) {
		with(i.creator) {
			var p = variable_clone(get_cutscene_variable()) //Saving my commands before it be overwritten
			variable_instance_set(id,CUTSCENE_VARIABLE,[]) //Seting my cutscene commands empty
			
			script_execute(_script); //Overwritting my commands
			variable_instance_set(i,CUTSCENE_VARIABLE,get_cutscene_variable()) //Giving the cutscene Instance my commands
			
			variable_instance_set(id,CUTSCENE_VARIABLE,p) //Setting my commands to the saved commands
		}
	} else if (is_array(_script)) { //If the script is an ARRAY
		if (array_length(_script) > 0) {
			variable_instance_set(i,CUTSCENE_VARIABLE,_script)
		} else { //If there isn't any command in the array, delete the cutscene and return an empty instance
			instance_destroy(i)
			return noone;
		}
	}
	
	return i;
}