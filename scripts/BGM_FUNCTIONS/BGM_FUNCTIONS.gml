function bgm_set(_music, _fadeouttime = 5, _fadeintime = 5) {
	with(obj_musicManager)	{
		targetSongAsset = _music;
		endFadeOutTime = _fadeouttime;
		startFadeInTime = _fadeintime;
	}
}

function bgm_pause() {
	with(obj_musicManager)	{
		audio_pause_sound(songInstance)
	}
}

function bgm_resume() {
	with(obj_musicManager)	{
		audio_resume_sound(songInstance)
	}
}

function bgm_pitch(_pitch) {
	if (_pitch > -1) {
		with(obj_musicManager)	{pitch = _pitch}
	}
}

function bgm_volume(_volume) {
	if (_volume > -1) {with(obj_musicManager)	{volume = _volume}}
}

function bgm_get_pitch() {
	return audio_sound_get_pitch(obj_musicManager.songInstance)	
}

function bgm_get_volume() {
	return obj_musicManager.volume;
}

function bgm_is_pause() {
	return audio_is_playing(obj_musicManager.songInstance);
}