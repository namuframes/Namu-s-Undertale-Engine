if (draw_on_box) {
	visible=false	
}
if (instance_exists(obj_soul)) {
	depth = obj_soul.depth-1
} else if (instance_exists(obj_bulletBorder)) {
	depth = obj_bulletBorder.depth-1	
}

hurt = function() {
	var c = blue ? (obj_soul.hsp != 0 || obj_soul.vsp != 0) : true
	if (c && can_hurt && obj_soul.visible) {
		if (obj_soul.invincible <= 0) {
			audio_play_sound(snd_hurt,0,0,1,0,random_range(1,1.1))
			damage_player(damage,invincibility_frames)
			if (delete_self) {instance_destroy()}
		}
	}	
}
can_hurt=true