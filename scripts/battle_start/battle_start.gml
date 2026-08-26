function battle_start(encounter_id,warn=undefined,blinks=undefined,speed=undefined,speed_gain=undefined,fake=undefined){
	if (!instance_exists(obj_pre_battle)) {
		instance_create_depth(0,0,0,obj_pre_battle)
		if (is_numeric(speed)) obj_pre_battle.speed = speed 
		if (is_numeric(speed_gain)) obj_pre_battle.speed_gain = speed_gain
		if (is_numeric(blinks)) obj_pre_battle.blinks = blinks
		if (warn != undefined) obj_pre_battle.warning = bool(warn)
		if (fake != undefined) obj_pre_battle.fake = bool(fake)
		global.ENCOUNTER_ID = encounter_id;
	}
}