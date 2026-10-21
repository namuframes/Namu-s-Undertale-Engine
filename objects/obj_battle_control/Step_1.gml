///@description Instantaneous Processing
var break_array = [BATTLE_TURNS.PLAYER, BATTLE_TURNS.TURN], stop = false
while(!array_contains(break_array,TURN) && !stop) {
	switch(TURN) {
		case BATTLE_TURNS.PLAYER_INIT:
			if (box_is_normal()) {
				if (!instance_exists(obj_soul)) {instance_create_depth(x,y,obj_battle_box.depth-1,obj_soul)}
				battle_soul_visible(true);
				battle_soul_state(STATE.follow);
				battle_soul_variable_set("invincible",0)

				if (array_length(index.previous) > 0) {index.current = array_first(index.previous)};
				page.current = BATTLE_PAGES.MAIN;
				if (!buttons[index.current].selectable) { //If button isn't selectable, search for a selectable one
					var off = 0;
					while(true) {
						if (buttons[off].selectable) {index.current = off; break}
						if (off > array_length(buttons)) {break}
					}
				}
				target_enemy.instance = undefined;
				target_enemy.index = 0;

				did_scene = false;
				index.previous=[];
				page.previous=[];

				battle_next_turn();
			} else {
				battle_soul_visible(false)
				box_reset();
				stop=true;
			}
		break;
		
		case BATTLE_TURNS.PLAYER_END:
			if (!instance_exists(obj_soul)) {instance_create_depth(x,y,obj_battle_box.depth-1,obj_soul)};
			battle_soul_visible(false);
			battle_soul_state(STATE.follow);
			//If there isn't any cutscene from the enemies and myself, proceed.
			if (no_cutscene()) {battle_next_turn()} else {stop=true};
		break;
		
		case BATTLE_TURNS.TURN_PREPARATION:
			if (oneshot) {
				battle_soul_position(obj_battle_box.x,obj_battle_box.y);
				with(parEnemy) {
					if (on_battle()) {
						if (dead) {
						 	other.lootbox.gold += gold*2;
						 	other.lootbox.xp += xp;
							region_add_kill(1);
							enemy_event(ENEMY_EVENTS.DEATH,id);
						}
						else if (spared) { //If enemy is spared
						 	other.lootbox.gold += gold;
						 	enemy_event(ENEMY_EVENTS.SPARED,id);
						} else {enemy_event(ENEMY_EVENTS.TURN_PREPARATION,id)};
					}
				}
			
				if (instance_exists(parTurn)) {//If there is an attack, prepare the box and yeah :3
					box_reset();	box_size(160,136);	battle_soul_visible(true);
				};
				turn_event(TURN_EVENTS.TURN_PREPARATION);
				oneshot=false;
			};
		
			update_enemy_array()

			if (no_cutscene()) { //PREPARATION END
				if (array_length(enemy) > 0) {
					enemy_event(ENEMY_EVENTS.TURN_PREPARATION_END);
					turn_event(TURN_EVENTS.TURN_PREPARATION_END);
				
					battle_next_turn();
				} else {battle_end()};
			} else {stop=true};
		break;
		
		
		default: stop=true break;
	}
};