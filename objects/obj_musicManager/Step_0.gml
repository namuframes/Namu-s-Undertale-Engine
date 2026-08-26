if (songAsset != targetSongAsset)
{
	volume = 1;
	pitch = 1;
	if (audio_is_playing(songInstance))
	{
		array_push(fadeOutInstances, songInstance);
		
		array_push(fadeOutInstVol, fadeInInstVol);
		
		array_push(fadeOutInstTime, endFadeOutTime);

		songInstance = noone;
		songAsset = noone;
	}
	
	if (array_length(fadeOutInstances) == 0)
	{
		if (audio_exists(targetSongAsset))	{
			songInstance = audio_play_sound(targetSongAsset, 4, true)
			audio_sound_gain(songInstance, 0, 0);
			if (struct_exists(positions,targetSongAsset)) {
				audio_sound_set_track_position(songInstance,positions[$ targetSongAsset]);
				struct_remove(positions,targetSongAsset)
			}
			fadeInInstVol = 0;
		}
		songAsset = targetSongAsset;
	}
}

if (audio_is_playing(songInstance))
{
	if (startFadeInTime > 0)
	{
		if (fadeInInstVol < 1) {fadeInInstVol += 1/startFadeInTime};
	}
	else
	{
		fadeInInstVol = 1;	
	};
	
	audio_sound_gain(songInstance, fadeInInstVol*clamp(volume,0,infinity), 0);
	audio_sound_pitch(songInstance, clamp(pitch,0,infinity));
};

for (var i = 0; i < array_length(fadeOutInstances); i++)
{
	if (fadeOutInstTime[i] > 0) 
	{
		if (fadeOutInstVol[i] > 0) {fadeOutInstVol[i] -= 1/fadeOutInstTime[i];}	
	}
	else
	{
		fadeOutInstVol[i] = 0;
	}
	
	audio_sound_gain(fadeOutInstances[i], fadeOutInstVol[i]*volume, 0);
	
	if (fadeOutInstVol[i] <= 0)
	{
		if (audio_is_playing(fadeOutInstances[i])) {audio_stop_sound(fadeOutInstances[i])}
		array_delete(fadeOutInstances, i, 1);
		array_delete(fadeOutInstVol, i, 1);
		array_delete(fadeOutInstTime, i, 1);
		i--;
	};
}