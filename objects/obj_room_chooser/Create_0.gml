if (!DEVELOPER_MODE) {instance_destroy()}
index = 0;
rooms = [room_first]
while (array_last(rooms) != -1) {
	array_push(rooms,room_next(array_last(rooms)))
}
for(var i = 0; i < array_length(rooms); i++) {
	if (room == rooms[i]) {index = i; break;}	
}