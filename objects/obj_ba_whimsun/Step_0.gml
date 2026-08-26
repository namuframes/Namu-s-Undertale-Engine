if (attacked || dead || spared) {
	sprite_index = spr_ba_whimsun_hurt	
	time = 0
} else {
	if (!instance_exists(parCutscene)) {sprite_index = spr_ba_whimsun}
	time++
}

if (dead || terrified) {gold = 2};