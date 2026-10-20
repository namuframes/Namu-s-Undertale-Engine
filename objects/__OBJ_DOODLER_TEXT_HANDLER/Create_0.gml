setup = function() {
	input = [];
	moving = [];
	width =	 1;	height = 1;
	
	show = 0;	draw_show = 0;
	
	wipe_surfaces();
	setup_effects();
}

setup_effects = function(formating=undefined) {
	if (is_undefined(formating) || string_lower(formating) == "wave") {
		wave_range = 2;
		wave_frequency = .5;
		wave_speed = 1;
	};
	if (is_undefined(formating) || string_lower(formating) == "shake") {
		shake_range = 1;
		shake_speed = 1;
	};
}

create_glyph = function(_c, _x, _y, _line, _pos, _color, _font, _effects) constructor {
	char = _c;
	x = _x;
	y = _y;
	line = _line;
	pos = _pos ;
	color = _color;
	effects = _effects;
	font = _font;
};

add_char_space = function(char) {
	var s = string_width(char)+(separation*string_length(char))
	space += s*xscale;
};

line_gain = function(_line,_offset=0) {return (((string_height("I")+line_spacing)*yscale)*_line)+_offset}

load = function() {
	setup();
	space = 0;

	var line = 0, pos=0;
	var line_previous = line;

	var old_font = draw_get_font(), old_color = draw_get_colour();
	var _wave = false,	_shake = false, has_spacing_char=false;
	var final_x = 0,	final_y = 0

	var line_width = [];
	var last_line_char = "";
	var line_extra = []; //Extra height (above/below) a line needs because of tall sprites
	draw_set_font(font);	draw_set_colour(color);
	for(var i = 1; i <= string_length(text); i++) { //Executing this ONCE for optimization
		var c = string_char_at(text,i);
		var _effects = [];
		//Adding the effects to the list
		if (_wave && !array_contains(_effects,"wave"))	{array_push(_effects,"wave")}; 
		if (_shake && !array_contains(_effects,"shake"))	{array_push(_effects,"shake")};
		
		//Automatic Break line
		if (string_char_at(text,i-1) == " " && check_line_break(text,i,line_length,true,xscale,separation,space)) {line++};
		if (c = D_LINE_BREAK_CHAR || c = "\n") { //Manual Line Break
			line++;	
			continue;
		}
		
		if (line != line_previous) { //Runs before commands so a sprite can start a line
			space = 0;
			if (has_spacing_char && c != spacing_char && halign == fa_left) {add_char_space(spacing_char+" ")};
			pos = 0;
			line_previous = line;
		};
		
		if (is_command(text,i) == 1) {
			var _end = string_pos_ext(D_CMD_END,text,i);
			var arg = string_split(string_copy(text,i+1,_end-i-1),",")
			var arg_length = array_length(arg)-1;
			var char = ""
			var spr = undefined;
			#region Command Executing
			
			if (!array_contains([asset_font, asset_sprite],asset_get_type(arg[0]))) {
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
							_wave = !_wave;
							if (_wave) {
								if (arg_length >= 1 && arg[1] != "") {wave_range = real(arg[1])};	
								if (arg_length >= 2 && arg[2] != "") {wave_speed = real(arg[2])};
							} else  {setup_effects("wave")};
						break;
						

						case "/wave": case "/wv":
							_wave = false
							setup_effects("wave")
						break;
							
						case "/shake": case "/sh":
							_shake = false
							setup_effects("shake")
						break;
							
						case "shake": case "sh":
							_shake = !_shake;
							if (_shake) {
								if (arg_length >= 1 && arg[1] != "") {shake_range = real(arg[1])};
								if (arg_length >= 2 && arg[2] != "") {shake_speed = real(arg[2])};
							} else {setup_effects("shake")};
						break;
		
						case "":
							draw_set_colour(color);	_wave=false;	_shake = false;
							setup_effects();
						break;
					}
				} else {
					var _c = string_copy(arg[0],2,string_length(arg[0]))
					draw_set_color(hex_to_rgb(arg[0]))
				}
			} else {
				var asset = asset_get_index(arg[0]);
				if (asset_get_type(arg[0]) == asset_font) {
					draw_set_font(asset);
				} else if (asset_get_type(arg[0]) == asset_sprite) {
					spr = asset;
					var g = max(0, ((sprite_get_height(asset)-string_height("I"))/2)*yscale);
					if (array_length(line_extra) <= line) {array_resize(line_extra, line+1)};
					line_extra[line] = max(line_extra[line], g);
					if (arg_length >= 1) {char = arg[1]};
				}
			}
			
			#endregion
			c = new create_glyph(char, space, line_gain(line), line, pos, draw_get_colour(), draw_get_font(), _effects);
			if (!is_undefined(spr)) {
				c.spr = spr;
				c.frame = 0;
				space += (sprite_get_width(spr)+separation+2)*xscale;
				line_width[line] = space;	//A line ending in a sprite still has a width
				width = max(width, space);
				height = max(height, max((string_height("I")*yscale)*line+1,line_gain(line+1))); //Sprites count for the text height too
				pos++;
			} else {c.cmd = arg};
			i = _end;
			array_push(input,c);
			
			continue;
			
		} else if (is_command(text,i) == 2) {
			continue;
		}

		if (is_string(spacing_char) && c == spacing_char && space <= 0) {has_spacing_char=true}; //If has the spacing char

		//Pushing the letter info into the input
		var s = new create_glyph(c, space, line_gain(line), line, pos, draw_get_colour(), draw_get_font(), _effects)
		array_push(input, s);
		
		add_char_space(c);	//Adding the glyph Width
		if (c != " ") {
			line_width[line] = space; //Getting the line width
			width = max(width, line_width[line]); //Getting the hole text width
		};
		height = max(height, max((string_height("I")*yscale)*line+1,line_gain(line+1))); //Getting the hole text height
		pos++;
	};
	
	//Making room for sprites taller than the text line
	var shift = [], total_extra = 0;
	for (var _ln = 0; _ln <= line; _ln++) {
		var _e = (_ln < array_length(line_extra)) ? line_extra[_ln] : 0;
		shift[_ln] = total_extra + _e;	//Room above this line's sprites + everything above it
		total_extra += _e*2;
	}
	for (var gi = 0; gi < array_length(input); gi++) {
		var _gl = input[gi], _l = _gl.line;
		if (shift[_l] > 0) {
			_gl.y += shift[_l];
			var _e2 = (_l < array_length(line_extra)) ? line_extra[_l] : 0;
			height = max(height, line_gain(_l+1) + shift[_l] + _e2);
		}
	}
	half_w = floor(width/2);
	half_h = floor(height/2);
	
	if (halign != fa_left) { //If the test alignment isn't fa_left
		for (var g = 0; g < array_length(input); g++) {
			var _gl = input[g];
			var _lw = (_gl.line < array_length(line_width)) ? line_width[_gl.line] : 0;
			
			if (halign == fa_center) {
				_gl.x += half_w-floor(_lw/2);
			} else if (halign == fa_right) {
				_gl.x += (width-_lw);
			}
		}
	};
	
	//Adding outline width & height so the size shit can be accurate yeaahahhhh
	width  += (outline*2)*xscale;
	height += (outline*2)*yscale;

	
	


	if (is_undefined(_typer)) { //If there isn't a typer, show the hole text
		show=array_length(input)
	} else { //Else set it's input to be my input (array)
		_typer.input = input;
		_typer.manager = id;
	};
	loaded = true
	draw_render_surface(); //Drawing the surface in the first frame, important!
	draw_set_font(old_font);	draw_set_colour(old_color);	
}

wipe_surfaces = function() {
	if (surface_exists(static_surf))	{surface_free(static_surf)};
	if (surface_exists(moving_surf))	{surface_free(moving_surf)};
	if (surface_exists(render_surf))	{surface_free(render_surf)};
}

_shader_outline = function(thickness, colour, tw, th) {
	shader_set(sh_doodle_outline);
	
	var _texelSize  = shader_get_uniform(sh_doodle_outline, "texelSize");
	var _color      = shader_get_uniform(sh_doodle_outline, "color");
	var _thickness  = shader_get_uniform(sh_doodle_outline, "thickness");
	
	shader_set_uniform_f(_texelSize, 1.0 / tw, 1.0 / th);
	shader_set_uniform_f(_color, color_get_red(colour)/255, color_get_green(colour)/255, color_get_blue(colour)/255);
	shader_set_uniform_f(_thickness, thickness);
}

draw_letter = function(_array,pos,_offx=0,_offy=0) {
	var b = _array[pos],	f = draw_get_font()
	var ha = draw_get_halign(),	va = draw_get_valign();
	var _x = b.x+_offx+half_w;
	var _y = b.y+_offy+half_h;
	var _c = b.color
	draw_set_font(b.font); draw_set_halign(fa_left);	draw_set_valign(fa_top)
	if (struct_exists(b,"spr")) {
		var soffx = sprite_get_xoffset(b.spr)*xscale;
		var soffy = sprite_get_yoffset(b.spr)*yscale;
		var h     = sprite_get_height(b.spr)*yscale;
		_x += soffx;
		_y += soffy+(string_height("I")*yscale - h)/2;	//Centered on the text line
		draw_sprite_ext(b.spr, floor(b.frame), _x*res, _y*res, xscale*res, yscale*res, 0, c_white, 1);
	} else {
		draw_text_transformed_colour(_x*res,_y*res,b.char,xscale*res,yscale*res,0,_c,_c,_c,_c,1);
	}
	draw_set_font(f);	draw_set_halign(ha);	draw_set_valign(va)
}
draw_render_surface = function() {
	if (!loaded) {exit};
	var w = width*padding,	h = height*padding
	var _scissor = gpu_get_scissor();
	if (!surface_exists(render_surf)) { //Creating the surfaces
		if (surface_exists(static_surf)) {surface_free(static_surf)}; //Surface for static letters
		if (surface_exists(moving_surf)) {surface_free(moving_surf)}; //Surface for moving letters
		render_surf = surface_create(w*res,h*res);
		moving_surf = surface_create(w*res,h*res);
		static_surf = surface_create(w*res,h*res);

		if (is_struct(_typer)) {show = _typer.pos()};
		draw_show = 0;
		moving=[];
	};

	surface_set_target(static_surf) //Static-Letters Surface
	while (draw_show < show) {
		var _g = input[draw_show];
		var _anim = struct_exists(_g,"spr") && sprite_get_number(_g.spr) > 1 && sprite_get_speed(_g.spr) > 0;
		if (array_length(_g.effects) <= 0 && !_anim) { //If is not a moving character
			draw_letter(input,draw_show);
		} else if (!array_contains(moving,_g)) { //If is a moving character and array don't contain it
			array_push(moving,_g);
		}
		draw_show++;
	}
	surface_reset_target();

	if (array_length(moving) > 0) {
		surface_set_target(moving_surf) //Moving Surface
			draw_clear_alpha(c_black,0)
			for(var i = 0; i < array_length(moving); i++) {
				var _mg = moving[i];
				if (struct_exists(_mg,"spr")) { //Advancing the sprite animation
					var _spd = sprite_get_speed(_mg.spr);
					if (sprite_get_speed_type(_mg.spr) == spritespeed_framespersecond) {_spd *= delta_time/1000000}
					else {_spd *= delta_time/game_get_speed(gamespeed_microseconds)};
					_mg.frame = (_mg.frame + _spd) mod sprite_get_number(_mg.spr);
				}
				
				var pos = moving[i].pos;
				var effects = moving[i].effects
				var offx = 0, offy = 1;
				if (array_contains(effects,"wave")) { //Wave Effect
					var math = (D_TIME*wave_speed-(pos*wave_frequency))
					offx += wave_range*cos(math)
					offy += wave_range*sin(math)	
				}
				
				if (array_contains(effects,"shake")) { //Shake Effect
					var _t = D_TIME*shake_speed;
					var rndm = random_range(_t/4,_t);
					var s = choose(-shake_range,-(shake_range/2),shake_range/2,shake_range)
					offx += s*sin(rndm);
					offy += s*cos(rndm); 
				}
				draw_letter(moving,i,offx,offy);
			}
		surface_reset_target()
	}
	surface_set_target(render_surf) //Surface were everything is drawn
		draw_clear_alpha(c_black,0);
		_shader_outline(outline,outline_colour,w/xscale,h/yscale)
		draw_surface(static_surf,0,0); //Static letters surface
		draw_surface(moving_surf,0,0); //Moving letters surface
		shader_reset()
	surface_reset_target()
	//Offset for when we use other alignments
	if (halign == fa_center) {align_offx = half_w}
	else if (halign == fa_right) {align_offx = width};
	gpu_set_scissor(_scissor.x, _scissor.y, _scissor.w, _scissor.h);
};

draw = function(_x,_y,_alpha=draw_get_alpha()) { //Drawing render surface in desired place
	if (surface_exists(render_surf)) {
		var outx = outline*xscale,	 outy = outline*yscale;
		draw_surface_stretched_ext(render_surf,
		(_x-half_w)-align_offx+outx, _y-half_h+outy, width*padding,height*padding,
		c_white,_alpha);
	}
	being_drawn=true
}

half_w = 0;
half_h = 0;

static_surf = undefined;
moving_surf = undefined;
render_surf = undefined;

setup();
tag = id;
creator=id;

text = "";

separation=0;
line_spacing=0;

color=draw_get_color();
font=draw_get_font();
xscale=1;
yscale=1;
angle=0;

align_offx = 0;
halign = draw_get_halign()

outline = 0
outline_colour = c_white;

line_length=infinity;

spacing_char = undefined;
_typer=undefined;

res = D_RESOLUTION;

global_effects = [];
loaded = false;

being_drawn = true;

padding = 2;
