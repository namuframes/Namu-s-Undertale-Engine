if (curtxt < array_length(text)) {
	var txt = text[curtxt]
	if (is_struct(writer)) {
		if (writer.done) {
			if ((input_pressed(INPUT_CONFIRM) || input_check(INPUT_SPECIAL)) && writer.can_proceed) {next_page()}
		} else {
			if (input_pressed(INPUT_CANCEL) || input_check(INPUT_SPECIAL)) {writer.skip()};
				
		}
	}
}