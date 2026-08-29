function battle_next_turn() {
	with(obj_battle_control) {
		battle_set_turn(TURN+1)
		TURN = wrap(TURN,0,BATTLE_TURNS.TURN)
	}
		
}
