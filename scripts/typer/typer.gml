function typer() constructor{
	creator = noone;
	index = 0;
	
	done=false
	
	skipable = false
	can_proceed = true;
	is_writing = false;
	do_end=false;
	voice = "";
	text = "";
	length = string_length(text);
	
	wait= {
		time: 1,
		input: false
	};
	
	speed=1
	
	static reset = function() {
		index = 0;
		wait.input = false; wait.time=0;
	}
	
	static commands = function(argmuents) {
		var arg = argmuents
		if (is_string(arg)) {arg = string_split(arg,",")};
		var arg_count = array_length(arg)-1;
		if (ds_map_exists(global.TYPEWRITER_EVENT,arg[0])) {
			//If you want to make your own command, go to typer_commands
			script_execute_ext(global.TYPEWRITER_EVENT[? arg[0]],arg,1)
		}
	}

	static sound = function(voice_string) {
		voice = voice_string;	
	}
	
	static __skip = function() {
		if (skipable && can_proceed) {
			while(index < length) { //Executing certain commands
				var glyph = string_char_at(text,index);
				if (is_command(text,index)) {
					var _end = string_pos_ext(CMD_END,text,index);
					commands(string_copy(text,index+1,_end-index-1))
					if (wait.input || index >= length-1) {break}
				}
				index++
			}
			index = clamp(index,0,length)
		}
	}

	static index_char = function() {
		return string_char_at(text,index)
	}
	
	static step = function() {
		length = string_length(text);
		if (index < length) {
			var prev_index = index;		done = false;
			wait.time -= (wait.time>0)*DELTA();
			if (wait.input) {if (input_pressed(INPUT_CONFIRM) || input_check(INPUT_SPECIAL)) {wait.input=false}};
			if (input_pressed(INPUT_CANCEL) || input_check(INPUT_SPECIAL)) {__skip()}
			
			if (!is_command(text,index)) {
				if (wait.time<=0 && !wait.input) {
					if (index < length) {index += speed*DELTA()}
				}
			} else {
				while (is_command(text,index) && (!wait.time && !wait.input)) {
					var _start = string_pos_ext(CMD_START,text,index),	_end = string_pos_ext(CMD_END,text,_start);
					var cmd = string_copy(text,_start+1,_end-(_start+1))
					commands(cmd)
					index = _end+1;
				}
			};
			
			
			
			
			
			
			
			is_writing = floor(index) != floor(prev_index)
			if (is_writing) {
				var is_valid = string_count(index_char()," !?.,*<>[]/´'\"():;{}$") <= 0
				if (is_valid) {
					voice_play(voice)
				};
				wait.allowed=true;
				
				if (creator.object_index == obj_txtbox) {
					if (do_end) {creator.next_page()}
				}	
			}
		} else {
			is_writing=false;	done=true;
		}
	}
}