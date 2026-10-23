var prev_page = page.current
READY = instance_exists(obj_pre_battle) ? obj_pre_battle.state >= 3 : true
switch(TURN) {
	case BATTLE_TURNS.PLAYER:
		switch(page.current) {
			case BATTLE_PAGES.MAIN:
				if (READY) {
					set_controls(input_horizontal(),array_length(buttons)-1);
					var _action = buttons[index.current];
					if (!_action.selectable) {index.current += index.input}
					if (input_pressed(INPUT_CONFIRM)) {
						if (buttons[index.current].selectable) {
							with(buttons[index.current]) {event_user(3)};
						} else {audio_play_sound(snd_deny,0,false)};
					};
				}
			break;
			
			case BATTLE_PAGES.ACT:
				set_controls(input_vertical(),array_length(enemy)-1);
				enemy_list(BATTLE_PAGES.ACT_CHOOSE);
			break;
			
			case BATTLE_PAGES.ACT_CHOOSE:
				set_controls(input_vertical(),array_length(target_enemy.instance.action)-1);
				if (input_horizontal() != 0) {
					var line  = index.current mod row_length, collum = index.current div row_length;
					var _in = (collum+input_horizontal()) * row_length + line;
					_in = wrap(_in,0,row_length+line)
				    index.current = _in;
				}
				
				if (input_pressed(INPUT_CONFIRM)) {
					var inst = target_enemy.instance;
					if (is_method(inst.action[index.current].script)) {
						with (inst) {
							my_scene = create_cutscene(action[other.index.current].script); 
						}
					} else {
						enemy_event(other.index.current,inst);
					}
					battle_next_turn();
				}
			break;
			
			case BATTLE_PAGES.MERCY:
				set_controls(input_vertical(),array_length(mercy_actions)-1);
				if (input_pressed(INPUT_CONFIRM)) {
					if (index.current == 0) { // Spare
						with(parEnemy) {
							if (spareable) {spared = true};
						}
						battle_next_turn();
					}
					
					if (index.current == 1) {battle_next_turn()}; //Flee
					audio_play_sound(snd_confirm,0,0);
				}	
			break;

			case BATTLE_PAGES.FIGHT: 
				set_controls(input_vertical(),array_length(enemy)-1);
				enemy_list(BATTLE_PAGES.FIGHT_ACTION);
			break;

			case BATTLE_PAGES.FIGHT_ACTION:
				var atk_g = obj_attack_grid;
				battle_soul_visible(false)
				if (!instance_exists(atk_g)) {
					instance_create_depth(0,0,obj_battle_box.depth-1,atk_g)
				}
			break;

			case BATTLE_PAGES.ITEM:
				var page_array = paged_inventory[inventory_page]
				set_controls(input_vertical(),array_length(page_array)-1);
				if (input_horizontal() != 0) {
					var line  = index.current mod row_length,	collum = index.current div row_length
					var _in = (collum+input_horizontal()) * row_length + line;
					var length = row_length+line
					if (_in > length || _in < 0) {
						if (_in > length) {inventory_page+=(inventory_page < array_length(paged_inventory)-1)} 
						else if (_in < 0) {inventory_page-=(inventory_page > 0)};
					}
					_in = wrap(_in,0,length)
				    index.current = _in;
				}
				
				var w = obj_battle_box.width
				if (input_pressed(INPUT_CONFIRM)) {
					var in = index.current;
					var selected_item = page_array[in];
					my_cutscene = item_use(selected_item);
					battle_next_turn();
				}
			break;

			default: set_controls(0,0) break;
		}
		if (input_pressed(INPUT_CANCEL) && page.current != BATTLE_PAGES.FIGHT_ACTION) {previous_page()};
	break;

	case BATTLE_TURNS.TURN:
		if (oneshot) {//TURN START
			if (!instance_exists(obj_soul)) {
				instance_create_depth(obj_battle_box.x,obj_battle_box.y,obj_battle_box.depth-1,obj_soul);
			};
			battle_soul_state(STATE.free);
			battle_soul_visible(true);

			enemy_event(ENEMY_EVENTS.TURN_START);
			turn_event(TURN_EVENTS.TURN_START);

			oneshot=false;
		};
		
		enemy_event(ENEMY_EVENTS.TURN);
		global.BATTLE_TIME++;

		if (!instance_exists(parTurn)) { //TURN END
			global.turn++;
			global.BATTLE_TIME = 0;
			
			battle_soul_visible(false);
			
			instance_destroy(obj_soul_bullet);
			
			enemy_event(ENEMY_EVENTS.TURN_END);
			turn_event(TURN_EVENTS.TURN_END);
			battle_next_turn();
		};
	break;
	
	case BATTLE_TURNS.END:
		if (oneshot) {
			if (instance_exists(obj_soul)) {instance_destroy(obj_soul)}
			bgm_set(noone,0,0);
			global.stat.gold += lootbox.gold;
			global.stat.xp += lootbox.xp;	
			oneshot=false;
		};

		if (box_is_normal()) {
			if (win_writer.done && (input_pressed(INPUT_CONFIRM) || input_pressed(INPUT_SPECIAL))) {
				switch_room(global.saved_player.room);
			}
		} else {box_reset()};
	break;
};


if (page.current != prev_page) {
	if (page.current == BATTLE_PAGES.ITEM) {
		inventory_page = 0;
		prepare_paged_inventory()
	};
	enemy_event(ENEMY_EVENTS.MENU_SWITCH);	
}

if (page.current == BATTLE_PAGES.MAIN) {
	var bt = buttons[index.current]
	with(par_bt_button) {
		hovering = (bt == id);
		if (hovering || !other.READY) {
			with(other) {set_heart(other.x+18,other.y+20)};
		}
	}
} else {
	par_bt_button.hovering = false;
}


if (play_song && READY) {
	bgm_set(song,2,2);
	play_song=false;
}
