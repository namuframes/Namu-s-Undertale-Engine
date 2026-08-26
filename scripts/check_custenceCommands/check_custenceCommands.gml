function check_custenceCommands(_variable = "my_scene", reset_variable=true) {
	if (!variable_instance_exists(id,_variable)) {variable_instance_set(id,_variable,undefined)}

	if (variable_instance_exists(id,CUTSCENE_VARIABLE)) { //If a cutscene command array exists on me, proceed
		if (array_length(variable_instance_get(id,CUTSCENE_VARIABLE)) > 0) {
			var vari = variable_instance_get(id,_variable)
			if (!instance_exists(vari)) {
				variable_instance_set(id,_variable,create_cutscene(variable_instance_get(id,CUTSCENE_VARIABLE))); //Creating a cutscene with the commands
				if (reset_variable) {variable_instance_set(id,CUTSCENE_VARIABLE,[])}
			}
		}
	}	
}