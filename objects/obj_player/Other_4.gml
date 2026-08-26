face = global.saved_player.face;
sprite_index = get_sprite(face);
var count = 0
if (array_length(party_input) < array_length(global.party)*10) {
	array_resize(party_input,array_length(global.party)*10);
}