function enemy_event(event,object=parEnemy) {
	with(obj_battle_control) {
		if (object.object_index == parEnemy || object_get_parent(object.object_index)) {
			with(object) {
				if (on_battle()) {
					event_user(event); 
					if (array_length(get_cutscene_variable()) > 0) {
						//Making the cutscene create with c_name be created instantly
						my_scene = create_cutscene(get_cutscene_variable());
						set_cutscene_variable([]);
					}
				}
			}
		} else {show_error("invalid enemy!\nenemy_event()",true)}
	}
}