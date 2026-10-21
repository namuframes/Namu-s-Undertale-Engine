var old_state = state;
switch(state) {
	case ATTACK_STATE.INTRO:
		event_user(1)
	break;
	
	case ATTACK_STATE.ATTACKING:
		event_user(2)
	break;

	case ATTACK_STATE.ANIMATION:
		damage = clamp(damage,0,infinity)
		if (oneshot) {
			if (damage > 0) {
				cutscene = create_cutscene(function() {
					c_instance_create((target.bbox_left+target.bbox_right)/2,(target.bbox_top+target.bbox_bottom)/2,target.depth-1,obj_slash);
					c_custom(function() {
						if (!instance_exists(obj_slash)) {end_action()}	
					})
					c_wait(.1)
				})
			}
			with(target) {event_user(ENEMY_EVENTS.BEFORE_HURT); check_custenceCommands()};
			
			oneshot=false;
		}
		if (!instance_exists(cutscene)) {
			if (anim) {
				damage_enemy(damage)
				anim = false;
			}
			if (!instance_exists(target.my_scene)) {
				state = ATTACK_STATE.OUTRO
				battle_next_turn();
			}
		}
	break;
	
	case ATTACK_STATE.OUTRO:
		event_user(3)
	break;
	
}

if (old_state != state) {
	oneshot=true;	
}