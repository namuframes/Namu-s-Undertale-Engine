global.DOODLE_TYPER_BLIPRULE = {};

function doodle_set_bliprule(_sound, pitch_min=1, pitch_max=1, interrupt=true){
	if (asset_get_type(_sound) == asset_sound || is_undefined(_sound)) {
		struct_set(global.DOODLE_TYPER_BLIPRULE,_sound,{
			pitch_min,
			pitch_max,
			interrupt
		});
	};
};

function doodle_get_bliprule(_sound){
	if (struct_exists(global.DOODLE_TYPER_BLIPRULE, _sound)) {
		return global.DOODLE_TYPER_BLIPRULE[$ _sound];
	}
	return global.DOODLE_TYPER_BLIPRULE[$ undefined];
};

function doodle_play_blip(_sound, _pitch=0){
	if (asset_get_type(_sound) == asset_sound) {
		var r = doodle_get_bliprule(_sound);
		if (r.interrupt) {
			audio_stop_sound(_sound);
		};
		return audio_play_sound(_sound,0,0,1,0,random_range(r.pitch_min, r.pitch_max)+_pitch)
	}
};

doodle_set_bliprule(undefined)
