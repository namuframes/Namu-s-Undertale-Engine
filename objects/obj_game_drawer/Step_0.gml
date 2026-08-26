var c = my_border[? "current"].sprite
if (global.border) {
	if (my_border[? "current"].sprite != my_border[? "target"].sprite && asset_get_type(my_border[? "target"].sprite) == asset_sprite) {
		my_border[? "target"].alpha += (my_border[? "target"].alpha<1)*1/my_border[? "target"].ease_time;
		my_border[? "target"].index += sprite_get_speed(my_border[? "target"].sprite)/FPS;
		if (my_border[? "target"].alpha >= 1) {
			my_border[? "current"].sprite = my_border[? "target"].sprite;
			my_border[? "current"].index = my_border[? "target"].index;
		};
	}
	my_border[? "current"].alpha += (my_border[? "current"].alpha<1)*1/my_border[? "current"].ease_time;
	my_border[? "current"].index += sprite_get_speed(my_border[? "current"].sprite)/FPS;

	var no_border_rooms = [];
	if (array_get_index(no_border_rooms,room) >= 0) {border_set_sprite(spr_border)} else {
		switch(string_get_suffix(room_get_name(room),1)) {
			case "cave":	border_set_sprite(spr_border_cave)	break;
		};
	};
} else {
	my_border[? "current"].alpha = 0;
};
if (c != my_border[? "current"].sprite) {
	my_border[? "target"].sprite = undefined;
	my_border[? "target"].index = 0;
	my_border[? "target"].alpha = 0;
}
if (asset_get_type(my_border[? "current"].sprite) != asset_sprite) {my_border[? "current"].sprite = spr_border};