if (curtxt < array_length(text)) {
	if (is_struct(writer)) {
		var is_writing = writer.is_writing;
		
		var confirm = input_pressed(INPUT_CONFIRM) || input_check(INPUT_SPECIAL)
		if (confirm && writer.done && writer.can_proceed) {next_page()}
		
		if (instance_exists(target)) {
			if (object_get_parent(target.object_index) == parNpc || target.object_index == parNpc) {
				target.talk = is_writing
			}
		}

		if (instance_exists(portrait)) {
			writer.sound(portrait.voice)
			portrait.talking = is_writing;	
		} else {writer.sound(voice)};
		
		
		//--------- QUESTION SYSTEM ------------
		if (writer.done && array_length(questions) > 0) {
			if (!question_wait) {
				var input_horizontal = -input_pressed(INPUT_LEFT);
				var input_vertical = input_pressed(INPUT_DOWN)-input_pressed(INPUT_UP);
				var input = input_horizontal+input_vertical;
				
				if (input_pressed(INPUT_LEFT)) {question_index=0}
				else if (input_pressed(INPUT_RIGHT)) {question_index=1}
				else if (input_pressed(INPUT_UP)) {question_index=2}
				else if (input_pressed(INPUT_DOWN)) {question_index=3}
				if (question_index > -1) {question_index = clamp(question_index,0,array_length(questions)-1)}
				
				if (question_index >= 0) {
					if (input_pressed(INPUT_CONFIRM)) {
						var scr = questions[question_index][1]
						var t = instance_exists(creator) ? creator : id
						if (is_method(scr)) {
							with(t) {change_cutscene(scr)};
							instance_destroy()
						}
					}
				}
			} else {
				if (input_pressed(INPUT_CONFIRM)) {question_wait=false}	
			}
		} else {
			question_wait = (array_length(questions) > 2)
		}
	}
}