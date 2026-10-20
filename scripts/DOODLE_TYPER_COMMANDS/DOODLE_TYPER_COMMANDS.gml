global.DOODLE_TYPEWRITER_EVENT = {};

function doodle_add_typer_command(tag,_method){
	struct_set(global.DOODLE_TYPEWRITER_EVENT,tag,_method);
};

function doodle_typer_command_exist(_name) {
	return struct_exists(global.DOODLE_TYPEWRITER_EVENT,_name)	
}

function string_to_asset(_string) {
	if (!is_string(_string)) {_string = string(_string)} //If for some FUCKING reason it isn't a string
	var asset = asset_get_index(_string);
	if (asset != -1) {
		return asset;
	} else {return real(asset)};
};

//These functions is generally called in the typewriter struct
var wait = function(time=1) {
	set_wait(real(time))
};


var blip = function(_voice=undefined) {
	var a = asset_get_index(_voice);
	if (asset_get_type(a) == asset_sound) {
		sound(a)
	};
};

var sound = function(snd) {
	audio_play_sound(asset_get_index(snd),0,0);
};

var set_sprite = function(target,sprite) {
	var obj = string_to_asset(target);
	if (instance_exists(obj)) {obj.sprite_index = asset_get_index(sprite)};
}

var call_script = function(_method, ass=0) {
	var scr = string_to_asset(_method)
	if (asset_get_type(scr) != asset_script) {
		show_error("Argument isn't a METHOD!",true)	
	}

	if (argument_count > 1) {
		var args = []
		for(var i = 1; i < argument_count; i++) {
			array_push(args,string_to_asset(argument[i]))
		}
		script_execute_ext(scr,args)
	} else {script_execute(scr)}
}

doodle_add_typer_command("wait",wait);
doodle_add_typer_command("w",wait);
doodle_add_typer_command("sleep",wait);
doodle_add_typer_command("delay",wait);

doodle_add_typer_command("noskip",function() {skipable=!skipable});
doodle_add_typer_command("/noskip",function() {skipable=false});
doodle_add_typer_command("noproceed",function() {can_proceed=!can_proceed});
doodle_add_typer_command("/noproceed",function() {can_proceed=false});

doodle_add_typer_command("voice",blip);
doodle_add_typer_command("blip",blip);

doodle_add_typer_command("sound",sound);
doodle_add_typer_command("snd",sound);

doodle_add_typer_command("sprite",set_sprite);
doodle_add_typer_command("spr",set_sprite);

doodle_add_typer_command("script",call_script);

doodle_add_typer_command("spd",function(value=1) {
	if (is_string(value)) {
		var percentIndex = string_last_pos("%",value);
		if (!percentIndex) {
			value = 1*real(value);
		} else {
			var val = string_delete(value,percentIndex,1);
			var percentage = real(val)/100;
			value = 1*percentage;
		}
	}
	speed = value;
})

doodle_add_typer_command("z",function() {
	wait.input=true;
});