function save_player() {
	if (instance_exists(obj_player)) {
		global.saved_player = {
			x: obj_player.x,
			y: obj_player.y,
			room: room,
			face: obj_player.face
		}
	}
}