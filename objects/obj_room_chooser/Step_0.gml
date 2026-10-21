var input = keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)
#region research bar

if (string_length(keyboard_string) > 0) {
	room_search += keyboard_string;
	keyboard_string = "";
}
if (keyboard_check(vk_backspace)) {backspace_time++} else {backspace_time = 0};

if (backspace_time == 1 || (backspace_time%2 == 0 && backspace_time >= FPS/2)) {
	room_search = string_delete(room_search,string_length(room_search),1);		
}

if (sp != room_search) {
	room_result=[];
	for(var i = 0; i < array_length(room_list); i++) {
		if (room_list[i] == rm_init) {continue};
		var _name = room_get_name(room_list[i]);
		if (string_count(room_search,_name) > 0 || room_search == room_get_name(room)) {
			array_push(room_result, room_list[i])
		};
	}
	if (asset_get_type(room_search) == asset_room) {room_index = array_get_index(room_result,room)};
	sp = room_search
}

#endregion
room_index += input
room_index = wrap(room_index,0,array_length(room_result)-1);

if (keyboard_check_pressed(vk_enter)) {
	if (array_length(room_result) > 0) {
		if (room_result[room_index] != room) {
			room_goto(room_result[room_index]) 
			instance_destroy();
		}
	}
};