if (global.stat.hp < global.stat.hp_max) {
	global.stat.hp = global.stat.hp_max;
}
audio_play_sound(snd_heal_c,0,0);
if (array_length(texts) > 0) {
	c_dialogue(texts);
	c_wait_dialogue();
}
c_instance_create(0,0,0,obj_save_handler);
check_custenceCommands();	