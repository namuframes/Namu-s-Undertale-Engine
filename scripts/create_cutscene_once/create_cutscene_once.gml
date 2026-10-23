function create_cutscene_once(_target=id){
	if (has_cutscene_command()) {// If we already commands, execute my code
		var c = create_cutscene(get_cutscene_variable(),_target); //Cutscene Instance
		set_cutscene_variable([],_target); //Preparing _target for next commands and all yeah
		return c;
	}
	return noone
}