///@description Encounters
song = bgm_battle
if (!is_array(global.ENCOUNTER_ID)) {
	switch(global.ENCOUNTER_ID) {
		case ENCOUNTER_ID.SPECIAL_WHIMSUN:
			enemy = [obj_ba_whimsun,obj_ba_whimsun];
			set_flavor("* Whimsun approached meekly!")
		break;
	
		case ENCOUNTER_ID.LOOX_EXAMPLE:
			enemy = [obj_ba_loox];
			set_flavor("* Loox is mad or smth#idk")
		break;
	}
} else {
	enemy = global.ENCOUNTER_ID;	
}
create_enemy_array();