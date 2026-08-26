function enemy_remove(index) {
	with(obj_battle_control) {
		if (is_numeric(index)) {
			if (string_length(index) <= 2) {
				array_delete(enemy,index,1)
			} else { //The argument is an instance/id
				for(var i = 0; i < array_length(enemy); i++) {
					if (enemy[i] == index) {enemy_remove(i); break}	
				}
			}
		}
	}
}