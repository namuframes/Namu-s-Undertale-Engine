function is_command(text,pos){
	if (string_char_at(text,pos) == CMD_START) {
		var cend = string_pos_ext(CMD_END,text,pos);
		if (cend > 0) {return true}
	}
	
	return false;
}

function draw_each_letter(_x,_y,text,separation=0,line_spacing=0,color=c_white,font=get_draw_font(),_xscale=1,_yscale=1,angle=0 ,line_length=infinity, asterisk_rule=false, _typer=undefined,_creator=id){
	var length = string_length(text)+1;
	var show = length;
	var space = 0, line=0, sprite_line=0;
	var line_previous = line;
	var has_asterisk = false;
	
	var width=0, height=0
	
	if (room == rm_battle) {
		_xscale *= 2;
		_yscale *= 2;
	}
	draw_set_font(font); draw_set_colour(color)
	
	if (line_spacing <= 0) {line_spacing = string_height("I")*1.15}
	
	if (is_struct(_typer)) {
		if (_typer.creator != _creator) {_typer.creator = _creator}
		if (_typer.text != text) {_typer.text = text}

		_typer.step();
		show = _typer.index
	}
	var wave = [false,2,1], shake = [false,1], z=0
	
	for(var i = 1; i < length; i++) {
		var c = string_char_at(text,i), cw = string_width(c);
		if (c == "*") {has_asterisk=true}
		if (string_char_at(text,i-1) == " ") {
			if (check_line_break(text,i,line_length,true,_xscale,separation,space)) {
				line++;
			}
		}
		
		if (is_command(text,i)) {
			var _end = string_pos_ext(CMD_END,text,i);
			var arg = string_split(string_copy(text,i+1,_end-i-1),",")
			var arg_length = array_length(arg)-1
			if (asset_get_type(arg[0]) == -1) {
				if (string_char_at(arg[0],1) != "#") {
					switch(arg[0]) {
						case "c_red": case "red":     draw_set_color(c_red) break;
						case "c_green": case "green":   draw_set_color(c_lime) break;
						case "c_yellow": case "yellow":  draw_set_color(c_yellow) break;
						case "c_white": case "white":   draw_set_color(c_white) break;
						case "c_blue": case "blue":    draw_set_color(c_blue) break;
						case "c_purple": case "purple":  draw_set_color(#ad00ff) break;
						case "c_default": case "default": case "/": case "/r": case "/c": draw_set_color(color) break;
						case "c_gray": case "gray":    draw_set_color(c_gray) break;
						case "c_cyan": case "cyan":    draw_set_color(c_aqua) break;
						
						case "wave": case "wv": 
							wave[0] = !wave[0]
							if (arg_length >= 1) {wave[1] = real(arg[1])};
							if (arg_length >= 2) {wave[2] = real(arg[2])};
						break;
						
						case "shake": case "sh":
							shake[0] = !shake[0]
							if (arg_length >= 1) {shake[1] = real(arg[1])};
						break;
					}
				} else {
					draw_set_color(hex_to_rgb(arg[0]))	
				}
			} else {
				var asset = asset_get_index(arg[0]);
				switch(asset_get_type(asset)) {
					case asset_font:
						draw_set_font(asset);
					break;
					
					case asset_sprite:
						if (i <= show) {
							var _offx = sprite_get_xoffset(asset)*_xscale, _offy = sprite_get_yoffset(asset)*_yscale
							var _sprite_width = sprite_get_width(asset)*_xscale, _sprite_height = sprite_get_height(asset)*_yscale
							draw_sprite_ext(asset,0,_x+_offx,_y+_offy,_xscale,_yscale,angle,c_white,draw_get_alpha());
							space += _sprite_width+separation*_xscale;
							if (arg_length >= 1) {
								if (arg[1] == "*") {
									has_asterisk=true
								}
							}
							if (_sprite_height > line_spacing*_yscale) {
								sprite_line = max(sprite_line,(_sprite_height/line_spacing)*_yscale);
							}
						}
					break;
				}
			}
			
			i = _end;
			continue;
		}
		
		if (c = LINE_BREAK_CHAR || c = "\n") {
			line++;	
			continue;
		}
		
		if (line != line_previous) {
			space=0;
			if (asterisk_rule && has_asterisk && c != "*") {
				space += (string_width("* ")+separation*2)*_xscale;
			};
			line += sprite_line;
			sprite_line=0;
			z=0
		};

		if (i <= show) {
			var final_x = _x+space;
			var final_y = _y+(line_spacing*_yscale)*line;
			var offx=0, offy=0;
			if (wave[0]) {
				var mth = (get_timer()/100000*wave[2])-z/2
				offy += (wave[1]*_xscale)*cos(mth)
				offx -= (wave[1]*_yscale)*sin(mth)
			}
			if (shake[0]) {
				offx += lengthdir_x(random(shake[1]),random(360))
				offy += lengthdir_y(random(shake[1]),random(360))
			}	
			
			draw_text_transformed(final_x+offx,final_y+offy,c,_xscale,_yscale,angle);
		}
		space += (cw+separation)*_xscale;
		line_previous=line;
		width = max(width,space);
		height = max(height,line_spacing*line);
		z++
	}

	draw_set_font(-1); draw_set_colour(c_white)

	return {width, height}
};