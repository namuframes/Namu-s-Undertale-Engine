function enemy_event(event,object=parEnemy) {
	with(obj_battle_control) {
		if (object.object_index == parEnemy || object_get_parent(object.object_index)) {
			with(object) {
				if (on_battle()) {
					event_user(event); 
					my_scene = create_cutscene_once();
				}
			}
		} else {show_error("invalid enemy!\nenemy_event",true)}
	}
}