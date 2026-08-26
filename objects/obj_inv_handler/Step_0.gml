
var _l = 0
switch(page) {
	case "item":
		input = input_pressed(INPUT_DOWN)-input_pressed(INPUT_UP)
		
		if (input_pressed(INPUT_CONFIRM)) {
			selected_item = global.inventory[index.current];
			array_push(index.previous,index.current)
			index.current = 0;
			page = "action"	
			audio_play_sound(snd_confirm,0,0)
		}
		
		if (input_pressed(INPUT_CANCEL)) {
			instance_destroy();	
		}
		
		_l = array_length(global.inventory)-1
	break;
	
	case "action":
		input = input_pressed(INPUT_RIGHT)-input_pressed(INPUT_LEFT)
		_l = array_length(actions)-1
		if (input_pressed(INPUT_CONFIRM)) {
			var in = array_get_index(global.inventory,selected_item);
			audio_play_sound(snd_confirm,0,0)
			switch(index.current) {
				case 0: //USE
					item_use(selected_item)
				break;
				
				case 1: //INFO
					create_dialogue(item_description(selected_item))
				break;
				
				case 2: //DROP
					create_dialogue($"* The {item_name(selected_item)} was thrown away.")
					array_delete(global.inventory,in, 1)
				break;
			}
			//instance_destroy(obj_menu)
			instance_destroy()
		}

		if (input_pressed(INPUT_CANCEL)) {page = "item"}
	break;
}

if (input_pressed(INPUT_CANCEL)) {
	if (array_length(index.previous) > 0) index.current = array_pop(index.previous)
}

var prev_index = index.current
index.current += input
index.current = wrap(index.current,0,_l);

if (index.current != prev_index) {audio_play_sound(snd_select,0,0)};