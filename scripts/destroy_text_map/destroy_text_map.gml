function destroy_text_map() { //Use this when you're finished using draw_each_letter to not have memory leak!
	if (variable_instance_exists(id,TEXT_MAP_STRING)) {
		var mp = variable_instance_get(id,TEXT_MAP_STRING)	
		ds_map_destroy(mp)
	}
}