function change_cutscene(scene,cutscene_holder_string="my_scene"){
	var p = variable_clone(variable_instance_get(id,CUTSCENE_VARIABLE))
	variable_instance_set(id,CUTSCENE_VARIABLE, []) //Reseting the cutscene variables for fresh new shit

	if (is_method(scene)) {script_execute(scene)}
	else if (is_array(scene)) {variable_instance_set(id,CUTSCENE_VARIABLE, scene)}

	if (variable_instance_exists(id,cutscene_holder_string)) {
		var i = variable_instance_get(id,cutscene_holder_string)
		if (instance_exists(i)) {
			with(i) {
				var cr=creator
				event_perform(ev_create,0)
				creator = cr;
			}
			variable_instance_set(variable_instance_get(id,cutscene_holder_string),CUTSCENE_VARIABLE, variable_instance_get(id,CUTSCENE_VARIABLE))
		}
	}
	check_custenceCommands(cutscene_holder_string) //fallback
	variable_instance_set(id,CUTSCENE_VARIABLE, p)
}