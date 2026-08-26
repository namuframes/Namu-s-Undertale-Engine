// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function player_cantmove(){
	var _cutscene = instance_exists(parCutscene) ? parCutscene.player_nocontrol : false
	return (instance_exists(obj_menu) || 
	instance_exists(obj_txtbox) || 
	_cutscene || 
	instance_exists(obj_room_transitioner) || 
	instance_exists(obj_room_chooser) || 
	instance_exists(obj_shopManager)) ||
	instance_exists(obj_pre_battle) ||
	instance_exists(obj_save_handler)
}

