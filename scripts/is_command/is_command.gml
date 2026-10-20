function is_command(text, pos) {
	if (string_char_at(text, pos) == D_CMD_START) {
		if (string_char_at(text, pos+1) == D_CMD_START) {return 2};
		if (pos > 1 && string_char_at(text, pos-1) == D_CMD_START) {return false};

		var _end = string_pos_ext(D_CMD_END, text, pos);
		if (_end > pos+1) {return 1};
	};

	return false;
}