var old_state = state;
switch(state) {
	case ATTACK_STATE.INTRO:
		if (oneshot) {
			do_tween(id,"introX","image_xscale",1,EASE_LINEAR,1);
			do_tween(id, "introY","image_yscale",1,EASE_LINEAR,1);
			oneshot=false;
		}
		image_alpha += .05*(image_alpha < 1)
		if (!tween_exists("introX") && !tween_exists("introY")) {
			state = ATTACK_STATE.ATTACKING;
			for(var i = 0; i < markers_amount; i++) {
				instance_create_depth(bbox_left-60*i,y,depth-1,obj_target_mark)
			}
			obj_target_mark.hspeed = 16*DELTA;
		}
	break;
	
	case ATTACK_STATE.ATTACKING:
		if (!instance_exists(marker) || marker.finished) {
			with(obj_target_mark) {
				if (!finished && place_meeting(x,y,other)) {other.marker = id;		}
			}
		}
		
		if (!instance_exists(marker) || marker.finished) {
			with(obj_target_mark) {
				if (!finished) {other.marker = id};
			}
		}
		
		if (instance_exists(marker) && !marker.finished) {
			if (marker.x > room_width) {instance_destroy(marker)} else {
				var dist = abs(point_distance(marker.x,marker.y,x,y));
				var presision = 1-clamp(dist/x,0,1)
				if ((input_pressed(INPUT_CONFIRM)) && place_meeting(x,y,marker)) {
					damage += ((global.stat.attack/markers_amount)*presision)+irandom(2)
					damage = round((damage-target.defense))
					damage = clamp(damage,0,infinity)
					
					marker.finished = true
					marker.hspeed = 0;
					missed=false
				}
			}
		} else {state = ATTACK_STATE.ANIMATION};
	break;

	case ATTACK_STATE.ANIMATION:
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
				damage_enemy(damage);	anim = false;
			};
			if (!instance_exists(target.my_scene)) {state = ATTACK_STATE.OUTRO};
		}
	break;
	
	case ATTACK_STATE.OUTRO:
			if (oneshot) {
				instance_destroy(obj_target_mark)
				do_tween(id, "outroX","image_xscale",0,EASE_LINEAR,2);
				do_tween(id, "outroY","image_yscale",1,EASE_LINEAR,2);

				oneshot=false;
			}
			image_alpha -= 0.1;
			if ((!tween_exists("outroX") && !tween_exists("outroY")) || image_alpha <= 0) {
				instance_destroy();	
			}
		
	break;
	
}

if (old_state != state) {
	oneshot=true;	
}