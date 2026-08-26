function preload_each_letter(text,separation=0,line_spacing=0,font,_xscale=1,_yscale=1,line_length=infinity, asterisk_rule=false,_creator=id,tag=text) {
	if (!instance_exists(_creator)) {exit}
	if (!variable_instance_exists(_creator,TEXT_MAP_STRING)) {variable_instance_set(_creator,TEXT_MAP_STRING,ds_map_create())}

	var textIndex = variable_instance_get(_creator,TEXT_MAP_STRING);
	if (!ds_map_exists(variable_instance_get(_creator,TEXT_MAP_STRING), tag)) { //Create event basically
		draw_set_font(font)
		
		var space = 0, line = 0, array=[]
		
		var res = {
			space: 0, line: 0, waveIndex:0, font: font,
			char: "", wave: {enabled: false, speed: WAVE_DEFAULT_SPEED, range: WAVE_DEFAULT_RANGE}, shake: {enabled: false, intensity: SHAKE_DEFAULT_INTENSITY, x: 0, y:0}
		}
		
		var ww=0,hh=0
		var len = string_length(text);
		
		var final_separation = separation;
		var final_line_space = string_height("I")+line_spacing;
		
		var waveIndex = 1

		for (var i = 1; i <= len; i++) {
			draw_set_font(res.font)
	
			var c = string_char_at(text,i), pc = string_char_at(text,i-1);
			var w = string_width(c)

			if (pc == " ") {
				if (check_line_break(text,i,line_length,true,_xscale,final_separation,space)) {
					space = 0; line++; waveIndex = 1;
				}
			}

			if (c == CMD_START) {
				var next_ch = string_char_at(text, i + 1), endLetter = string_pos_ext(CMD_END, text, i);
				if (next_ch != CMD_START) {
					if (string_pos_ext(CMD_END,text,i) > 0) {
						var arg = string_split(string_copy(text, i+1, (endLetter - i)-1),",")
						var arg_count = array_length(arg)-1
						var cmd_char = variable_clone(res);
						if (asset_get_type(arg[0]) == -1) {
							cmd_char.char = "";
							cmd_char.command = arg;
							arg[0] = string_lower(arg[0])
							switch(arg[0]) {
								case "wave":
									res.wave.enabled = !res.wave.enabled;
									if (arg_count >= 1) {res.wave.range = WAVE_DEFAULT_RANGE*real(arg[1])}
									if (arg_count >= 2) {res.wave.speed = WAVE_DEFAULT_SPEED*real(arg[2])}
								break;
							
								case "shake":
									res.shake.enabled = !res.shake.enabled;
									if (arg_count >= 1) {res.shake.intensity = SHAKE_DEFAULT_INTENSITY*real(arg[1])}
								break;
								
								case "/shake": res.shake.enabled = false break;
								case "/wave": res.wave.enabled = false break;
							
								case "/": case "/r": 
									res.shake = {enabled: false, intensity: SHAKE_DEFAULT_INTENSITY, x: 0, y:0}; 
									res.wave = {enabled: false, speed: WAVE_DEFAULT_SPEED, range: WAVE_DEFAULT_RANGE};
									
									res.font = font;
									final_separation = separation;
									final_line_space = string_height("I")+line_spacing;
		
								break;
								
								case "font": case "/f": case "/font":
									res.font = font;
									final_separation = separation;
									final_line_space = string_height("I")+line_spacing;
								break;
							
							}
						} else {
							var asset = asset_get_index(arg[0]);
							if (asset_get_type(asset) == asset_sprite) {
								cmd_char.char = arg_count > 0 ? arg[1] : " ";
								cmd_char.space = space;	cmd_char.line = line*line_spacing*_yscale;

								cmd_char.sprite = asset; cmd_char.index = 0;

								if (cmd_char.char != "*") {
									space += (sprite_get_width(asset)*_xscale)+1*_xscale
								} else {
									space += (separation+w)*_xscale; 
								};
								
							} else if (asset_get_type(asset) == asset_font) {
								cmd_char.char = "";
								cmd_char.command = [arg[0]]
								final_separation = separation;
								final_line_space = string_height("I")+line_spacing;
								res.font = asset
							};
						}

						array_push(array,cmd_char)
						i = string_pos_ext(CMD_END,text,i);
						continue;
					}
				} else {
					i++	
				}
			}

			if (c == "\n" || c == LINE_BREAK_CHAR) {line++; space=0; waveIndex = 1; continue}

			if (asterisk_rule) {
				if (string_count("*",text) > 0 && c != "*" && space == 0) {
					space += (string_width("* ")+final_separation)*_xscale
				}
			}
			
			if (res.font == fnt_pap) {c = string_upper(c)}

			res.space = space;
			res.line = line*final_line_space*_yscale;

			res.char = c;
			res.waveIndex = waveIndex;
			
			array_push(array,variable_clone(res));

			if (res.char != "") {space += (final_separation+w)*_xscale}  
			waveIndex++;
			ww = max(ww,space);
		}

		textIndex[? tag] = {letters: array, length: array_length(array), width: ww, height: res.line+line_spacing*_yscale, text: text, font: font, line_length: line_length, tag: tag};
	}
	var map = textIndex[? tag]
	if (map.text != text || map.font != font || map.line_length != line_length) {ds_map_clear(textIndex);}
	draw_set_font(-1);
	return map
};