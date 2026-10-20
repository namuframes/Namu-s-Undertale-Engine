function doodle_execute_typer_command(_arguments){
	var arg = _arguments
	if (is_string(arg)) {arg = string_split(arg,",")};
	var arg_count = array_length(arg)-1;
	if (doodle_typer_command_exist(arg[0])) {
		//If you want to make your own command, go to doodle_typer_commands
		script_execute_ext(global.DOODLE_TYPEWRITER_EVENT[$ arg[0]],arg,1)
	}
}