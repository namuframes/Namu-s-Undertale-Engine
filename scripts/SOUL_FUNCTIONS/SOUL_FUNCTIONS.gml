function battle_soul_variable_set(_variable,_value) {
	with(obj_soul) {
		variable_instance_set(id,_variable,_value)	
	}	
}


function battle_soul_visible(boolean) {
	battle_soul_variable_set("visible",boolean)
}

function battle_soul_state(_state) {
	battle_soul_variable_set("state",_state)
}

function battle_soul_depth(_value) {
	battle_soul_variable_set("depth",_value)
}

function battle_set_soul_mode(mode=SOUL_MODE.RED){
	battle_soul_variable_set("mode",mode)
}