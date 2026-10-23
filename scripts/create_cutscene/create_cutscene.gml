function create_cutscene(_info,_target=id){
	static create_cutscene_instance = function() {return instance_create_depth(0,0,0,parCutscene)}
	var i = noone
	if (is_method(_info)) {
		with(_target) {
			var p = variable_clone(get_cutscene_variable()) //Saving MY commands before it be overwritten
			set_cutscene_variable([]) //Seting MY cutscene commands empty
			
			script_execute(_info); //Overwritting my commands
			if (has_cutscene_command()) {//We have commands!
				i = create_cutscene_instance();
				set_cutscene_variable(get_cutscene_variable(),i) //Giving the Cutscene Instance MY commands
			};
			set_cutscene_variable(p) //Setting MY commands to the saved commands
		}
	} else if (is_array(_info)) { //If the _info is an ARRAY
		if (array_length(_info) > 0) {
			i = create_cutscene_instance();
			set_cutscene_variable(_info,i);
		}
	}
	if (instance_exists(i)) {i.creator = _target};
	return i;
}