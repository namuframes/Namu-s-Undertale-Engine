function check_line_break(text,number,line_length, precise_width, xscale, char_spacing=0, space, return_length=false) {
	var j = number, length = 0;
	var text_length = string_length(text);

	while (j <= text_length) {
		var cj = string_char_at(text, j);
		if (cj == " " || cj == "\n" || cj == LINE_BREAK_CHAR) break;

		if (cj == CMD_START) {
			var e = string_pos_ext(CMD_END, text, j);
			if (e > 0) {
			    j = e + 1;
			    continue;
			}
		}

		length += (precise_width ? (string_width(cj) + char_spacing) : char_spacing)*xscale;

		j++;
	}
	return !return_length ? (space + length > line_length) : length 
}
