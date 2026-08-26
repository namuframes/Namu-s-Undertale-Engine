var prev_index = index;
index += input_pressed(INPUT_RIGHT)-input_pressed(INPUT_LEFT);
index = wrap(index,0,array_length(options)-1);
if (index != prev_index) {
	audio_play_sound(snd_select,0,0)	
}

if (input_pressed(INPUT_CONFIRM)) {
	if (is_method(options[index].script)) {
		script_execute(options[index].script);
	}
	instance_destroy();
}