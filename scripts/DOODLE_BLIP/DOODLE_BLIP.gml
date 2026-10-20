global.DOODLE_TYPER_BLIPRULE = {};
global.__doodle_delay = 1;
function doodle_set_bliprule(_sound, pitch_min=1, pitch_max=1, frequency=0, interrupt=D_BLIP_INTERRUPT){
	if (asset_get_type(_sound) == asset_sound || is_undefined(_sound)) {
		struct_set(global.DOODLE_TYPER_BLIPRULE,_sound,{
			pitch_min: D_BLIP_PITCH_MIN*pitch_min,
			pitch_max: D_BLIP_PITCH_MAX*pitch_max,
			interrupt,
			frequency: max(D_BLIP_FREQUENCY,frequency)
		});
	};
};

function doodle_get_bliprule(_sound){
	if (struct_exists(global.DOODLE_TYPER_BLIPRULE, _sound)) {return global.DOODLE_TYPER_BLIPRULE[$ _sound]};
	return global.DOODLE_TYPER_BLIPRULE[$ undefined];
};

function doodle_play_blip(_sound, _pitch=0){
	if (asset_get_type(_sound) == asset_sound) {
		var r = doodle_get_bliprule(_sound);
		if (global.__doodle_delay > 0) {global.__doodle_delay--};
		if (global.__doodle_delay  <= 0) {
			if (r.interrupt) {audio_stop_sound(_sound)};
			global.__doodle_delay  = round(r.frequency);
			return audio_play_sound(_sound,0,0,1,0,random_range(r.pitch_min, r.pitch_max)+_pitch)
		};
	}
	return noone;
};
doodle_set_bliprule(undefined);