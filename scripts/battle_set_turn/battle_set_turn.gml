function battle_set_turn(_turn){
	with(obj_battle_control) {
		oneshot = true
		delay=1
		TURN = _turn
	}
}