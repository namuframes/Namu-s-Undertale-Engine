/// @description DEATH
c_custom(function() {
	audio_stop_sound(snd_monster_death)
	audio_play_sound(snd_monster_death,0,0,1,0,.8)
	evaporate(creator)
	instance_destroy(creator);	
	end_action()
})