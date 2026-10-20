function doodle(_text,_separation=0,_line_spacing=0,
_color=draw_get_colour(),_font=draw_get_font(),
_xscale=1,_yscale=1,_angle=0, _line_length=infinity, _spacing_char="",
_outline=0, _outline_colour=c_white, __typer=undefined,_creator=id) {
	var _tag = $"{D_TEXT_TAG}:{_text}:{_separation}:{_line_spacing}:{_color}:{_font}:{_xscale}:{_yscale}:{_line_length}:{_spacing_char}";
	var i = global.__doodle_cache[$ _tag];

	if (is_undefined(i) || !instance_exists(i)) {
		i = instance_create_depth(0,0,0,__OBJ_DOODLER_TEXT_HANDLER);
		global.__doodle_cache[$ _tag] = i;
		with(i) {
			tag = _tag;
			text = _text;
			creator = _creator;
			separation = _separation;
			line_spacing = _line_spacing;
			color = _color;
			font = _font;
			xscale = _xscale;
			yscale = _yscale;
			if (room == rm_battle) {
				xscale *= 2;
				yscale *= 2;
			}
			angle = _angle;
			line_length = _line_length;
			spacing_char = _spacing_char;
			_typer = __typer;
			outline = _outline;
			outline_colour = _outline_colour;
			load();
		}
	}
	return i;
}