function get_cutscene_variable(target=id) {
	if (variable_instance_exists(target,CUTSCENE_VARIABLE)) {//If the variable exists, return it
		return variable_instance_get(target,CUTSCENE_VARIABLE);
	} else {return []}; //Else return an empty shit
}