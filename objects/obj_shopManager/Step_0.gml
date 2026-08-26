
if (!instance_exists(shop)) {exit}

if (input_pressed(INPUT_CANCEL) && buy_state == 0 && page.current != "cutscene" && page.current != SHOP_OPTIONS.EXIT) {
	if (array_length(page.previous) <= 0 && room != rm_shop) {instance_destroy()}
	previous_page()
}

switch(page.current) {
		default:
			previous_page()
		break;
		
		case -1:
			set_controls((input_pressed(INPUT_DOWN)-input_pressed(INPUT_UP)),array_length(options)-1)
			if (input_pressed(INPUT_CONFIRM)) {
				script_execute(options[index.current].script)
			}
			right_text.index = 0;
			buy_speak = speech.buying;
			offy = 75;
			oneshot=true
		break;
		
		case SHOP_OPTIONS.SELL:
			
		break;
	
		case SHOP_OPTIONS.BUY:
			offy = linearVar(offy,0,16)
			if (buy_state == 0) {
				set_controls((input_pressed(INPUT_DOWN)-input_pressed(INPUT_UP)),array_length(storage)-1)
				if (input_pressed(INPUT_CONFIRM)) {
					buy_state=1; 
					array_push(index.previous,index.current)
					index.current = 0;
					audio_play_sound(snd_confirm,1,0)
				}
			} else {
				set_controls((input_pressed(INPUT_DOWN)-input_pressed(INPUT_UP)),array_length(buy_options)-1)
				if (input_pressed(INPUT_CONFIRM)) {
					if (index.current == 0) { //Yes
						var itm = storage[array_last(index.previous)]
						var cost = itm.cost
						if (cost > global.stat.gold) {// Can buy?
							//Can't buy! Fuck you!!!!
							buy_speak = speech.no_cash
						} else { //Can buy :)
							buy_speak = speech.buyed
							global.stat.gold -= cost
							array_push(global.inventory,itm.item)
						};
					} else { //No
						buy_speak = speech.denied;
					}
					index.current = array_pop(index.previous);
					buy_state = 0;
				}
			
				if (input_pressed(INPUT_CANCEL)) {
					buy_state=0
					index.current = array_pop(index.previous)
				}
			}
		break;
	
		case SHOP_OPTIONS.TALK:
			set_controls((input_pressed(INPUT_DOWN)-input_pressed(INPUT_UP)),array_length(talk)-1);
			if (input_pressed(INPUT_CONFIRM)) {
				with(shop) {script_execute(talk[other.index.current].script)};
			}
		break;
		
		case SHOP_OPTIONS.EXIT:
			if (oneshot) {with(shop) {event_user(0); check_custenceCommands("cutscene")}; oneshot=false}

			if (!instance_exists(parCutscene)) {
				if (room != rm_shop) {instance_destroy()} else {
					switch_room(global.saved_player.room)	
				}
			}
		break;
		
		case "cutscene":
			if (!instance_exists(cutscene) && !instance_exists(shop.cutscene)) {
				previous_page()
			}
		break;
}