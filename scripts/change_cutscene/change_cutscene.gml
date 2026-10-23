function change_cutscene(scene,cutscene_holder_string="my_scene"){
	var p = variable_clone(get_cutscene_variable(id))
	set_cutscene_variable([]); //Reseting the cutscene variables for fresh new shit

	if (is_method(scene)) {script_execute(scene)}
	else if (is_array(scene)) {set_cutscene_variable(scene)}

	if (variable_instance_exists(id,cutscene_holder_string)) {
		var cutscene_instance = variable_instance_get(id,cutscene_holder_string) //Grabbing Cutscene Instance
		if (instance_exists(cutscene_instance)) {
			with(cutscene_instance) {
				var cr=creator
				event_perform(ev_create,0)
				creator = cr;
			}
			variable_instance_set(cutscene_instance,CUTSCENE_VARIABLE, get_cutscene_variable(id))
		}
	} else { //If doesn't exist a cutscene instance, so we create one and yeaahhh...
		create_cutscene(get_cutscene_variable())	
	}
	variable_instance_set(id,CUTSCENE_VARIABLE, p)
}