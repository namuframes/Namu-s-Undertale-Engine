function add_typer_command(tag,_method){
	ds_map_add(global.TYPEWRITER_EVENT,tag,_method);
};

function string_to_asset(_string) {
	if (!is_string(_string)) {_string = string(_string)} //If for some FUCKING reason it isn't a string
	var asset = asset_get_index(_string);
	if (asset != -1) {
		return asset;
	} else {return real(asset)};
};

//These functions is generally called in the typewriter struct
var wait = function(time=10) {
	var wait_time = real(time);
	wait.time += wait_time*max(1,speed);
};

var portrait = function(character="",face=undefined) {
	if (creator.object_index != obj_txtbox) {exit}
	creator.set_portrait(character,face);
};

var blip = function(snd=undefined) {
	mod_blip = asset_get_index(snd);
};

var sound = function(snd) {
	audio_play_sound(asset_get_index(snd),0,0);
};

var talker = function(target) {
	var obj = string_to_asset(target);
	if (instance_exists(obj) && creator.object_index == obj_txtbox) {creator.change_target(obj);}
}

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

add_typer_command("wait",wait);
add_typer_command("w",wait);
add_typer_command("sleep",wait);
add_typer_command("delay",wait);
add_typer_command("talker",talker);

add_typer_command("face",portrait);
add_typer_command("f",portrait);
add_typer_command("portrait",portrait);

add_typer_command("noskip",function() {skipable=!skipable});
add_typer_command("/noskip",function() {skipable=false});
add_typer_command("noproceed",function() {can_proceed=!can_proceed});
add_typer_command("/noproceed",function() {can_proceed=false});

add_typer_command("voice",blip);
add_typer_command("blip",blip);

add_typer_command("sound",sound);
add_typer_command("snd",sound);

add_typer_command("sprite",set_sprite);
add_typer_command("spr",set_sprite);

add_typer_command("script",call_script);

add_typer_command("end",function() {
	do_end=true
	if (creator.object_index == obj_txtbox) {
		creator.next_page()
	}
})

add_typer_command("spd",function(value=1) {
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

add_typer_command("z",function() {
	wait.input=true;
});