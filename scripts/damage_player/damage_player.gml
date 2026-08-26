function damage_player(amount,invincibility_frames=30){
	global.stat.hp -= amount;
	if (instance_exists(obj_soul)) {
		obj_soul.invincible = real(invincibility_frames)
	}
}