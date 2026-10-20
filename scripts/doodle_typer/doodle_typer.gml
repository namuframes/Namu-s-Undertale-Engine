function doodle_typer() constructor{
	static prepare = function() {
		index = 0;
		wait= {
			time: 1,
			input: false
		};
		if (instance_exists(manager)) {manager.wipe_surfaces()};
	}
	manager = noone;
	creator = other;
	
	done=false
	
	skipable = true
	can_proceed = true;
	is_writing = false;
	voice = noone;
	input = [];
	autopause = false;
	prepare();
	
	speed=1
	
	static sound = function(_soundasset) {
		voice = _soundasset;	
	}
	
	static length = function() {return array_length(input)}
	
	static get_input = function(_val=pos()) {
		if (length() > 0) {
			return input[clamp(_val,0,length()-1)];
		} else {return {char: ""}};
	}
	static get_command = function() {
		if (has_command()) {
			return get_input().cmd 
		}
	}
	static reset = function() {prepare()};
	
	static has_command = function() {return struct_exists(get_input(),"cmd")}

	static char = function(offset=0) {
		return get_input(pos()-1+offset).char;
	}
	
	static add_index = function(amount) {
		index += amount
		if (pos() > length()) {index = length()};
	}
		
	static set_wait = function(amount) {wait.time += amount*10};
	
	static pos = function() {return floor(clamp(index,0,length()))};
	static position = function() {return pos()};
	
	static skip = function() {
		if (skipable) {
			while(pos() < length()-1) { //Executing certain commands
				if (wait.input) {break};
				if (has_command()) {
					doodle_execute_typer_command(get_command());
				}
				add_index(1);
			}
			wait.time=0;
		}
	}
	
	static step = function() {
		if (!instance_exists(creator)) {creator = manager.creator};
		if (pos() < length() && length() > 0) {
			done = false;
			while (has_command() && index < length()-1 && !wait.input && wait.time <= 0) {
				doodle_execute_typer_command(get_command());
				add_index(1);
			}
			var prev_index = pos();
			if (wait.time <= 0 && !wait.input) {
				add_index(speed)
				if (autopause) {
					if (string_count(char(),D_AUTOPAUSE_CHAR) >= 1 && char() != "") {set_wait(.5)};
				}
			} else {
				wait.time -= (wait.time>0)
				if (wait.time <= 0 && wait.input) {
					if (input_pressed(INPUT_CONFIRM)) {
						wait.input = false;	
					}
				}
			};
			
			
			index = clamp(index,0,length());
			is_writing = (pos() != floor(prev_index))
			if (instance_exists(manager)) {manager.show = pos()};
		} else {
			is_writing=false;	done=true;
		};
		
		if (is_writing) {
			var is_valid = string_pos(char(),D_NO_BLIP_STRING) <= 0
			if (is_valid) {doodle_play_blip(voice)};
		};
	};
};