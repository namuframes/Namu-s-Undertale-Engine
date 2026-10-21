if (!DEVELOPER_MODE) {instance_destroy()}
index = 0;
backspace_time = 0;

room_list = asset_get_ids(asset_room);
room_search = room_get_name(room);
room_index = 0;
room_result = [];
sp = ""

t = 0
keyboard_string = ""