function damage_enemy(damage,target=obj_battle_control.target_enemy.instance,user_event=ENEMY_EVENTS.HURT) {
	with(obj_battle_control) {
		target.damage_taken = damage;
		if (is_numeric(damage)) {
			if (damage > 0) {target.attacked = true}
		}
		with(target) {event_user(user_event); check_custenceCommands()} //Execute hurt animation if i'm allowed to
	}
}