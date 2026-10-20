global.border = false
randomise()
game_set_speed(FPS,gamespeed_fps);
window_set_size(WINDOW_WIDTH,WINDOW_HEIGHT)
window_center()
display_set_gui_size(BASE_WIDTH,BASE_HEIGHT);
display_reset(0,true);

surface_resize(application_surface,BASE_WIDTH*RESOLUTION,BASE_HEIGHT*RESOLUTION)

font_add_enable_aa(false)
gpu_set_texfilter(false);



//--------------- PRELOAD -------------------
//You can use sprite_prefetch(sprite)
BLIP_RULE();

var portrait = function(character="",face=undefined) {
	if (creator.object_index != obj_txtbox) {exit}
	creator.set_portrait(character,face);
};

var talker = function(target) {
	var obj = string_to_asset(target);
	if (instance_exists(obj) && creator.object_index == obj_txtbox) {creator.change_target(obj);}
}

doodle_add_typer_command("talker",talker);

doodle_add_typer_command("face",portrait);
doodle_add_typer_command("f",portrait);
doodle_add_typer_command("portrait",portrait);