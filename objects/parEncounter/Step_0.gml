if (instance_exists(obj_player)) {
	if (!player_cantmove()) {
		if (obj_player.hsp != 0 || obj_player.vsp != 0 ) {
			steps++;
		}
	}
}

if (steps >= step_required) {
	if (array_length(encounters) > 0) {
		battle_start(encounters[irandom(array_length(encounters)-1)])
	}
	steps=0;
}