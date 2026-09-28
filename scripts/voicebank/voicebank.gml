function voicebank(voice_string) {
	var voice = function(_sound,_pitchmin=1,_pitchmax=1,_stop_previous=false) constructor {
		sound = _sound;
		pitchMin = _pitchmin;
		pitchMax = _pitchmax;
		stop_previous = _stop_previous;
	}
	switch(voice_string) {
		case "gaster":
			return new voice(snd_txtgaster,0.95,0.9);
		
		case "battle":
			return new voice(snd_txt2);
	}
	return new voice(snd_txt1)
}

function voice_play(voice_string) {
	var vc = voicebank(voice_string);
	var asst = is_array(vc.sound) ? vc.sound : [vc.sound];
	var snd = asst[irandom(array_length(asst)-1)];
	if (vc.stop_previous) {audio_stop_sound(snd)};
	audio_play_sound(snd,0,0,1,0,random_range(vc.pitchMin,vc.pitchMax));
}