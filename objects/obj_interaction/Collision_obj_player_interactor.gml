if (!instance_exists(my_scene)) {
	if (array_length(scenes) > 0) {
		if (is_method(scenes[page])) {
			my_scene = create_cutscene(scenes[page]);
		}
		page += (page < array_length(scenes)-1)
	} else {
		my_scene = create_cutscene(get_cutscene_variable());
	}
}