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
					var centerX = ((target.x-target.sprite_xoffset)+target.sprite_width/2);
					var centerY = ((target.y-target.sprite_yoffset)+target.sprite_height/4);
					c_instance_create(centerX,centerY,target.depth-1,obj_slash);
					c_custom(function() {
						if (!instance_exists(obj_slash)) {end_action()}	
					})
					c_wait(.1)
				})
			}
			enemy_event(ENEMY_EVENTS.BEFORE_HURT,target)
			oneshot=false;
		}
		if (!doing_before_hurt) {
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
		} else if (!instance_exists(target.my_scene)) {doing_before_hurt = false};
	break;
	
	case ATTACK_STATE.OUTRO:
		event_user(3)
	break;
	
}

if (old_state != state) {
	oneshot=true;	
}