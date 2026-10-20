function doodle_draw(_x,_y,_text,_separation=undefined,_line_spacing=undefined,
_color=undefined, _alpha=draw_get_alpha(),_font=undefined,
_xscale=undefined,_yscale=undefined,_angle=undefined,
_line_length=infinity, _spacing_char=undefined, _outline=undefined, _outline_colour=undefined, _typer=undefined,_creator=id) {
	var s = doodle(_text,_separation,_line_spacing,_color,_font,_xscale,_yscale,_angle,_line_length,_spacing_char,_outline, _outline_colour,_typer,_creator);
	s.draw(_x,_y,_alpha);
	return s;
}