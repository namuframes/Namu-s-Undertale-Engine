if (curtxt < array_length(text)) {
	var txt = text[curtxt]
	if (is_struct(writer)) {
		if (input_pressed(INPUT_CONFIRM) && writer.done && writer.can_proceed) {next_page()}
	}
}