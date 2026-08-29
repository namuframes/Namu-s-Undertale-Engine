var c = _border.current.sprite
if (global.border) {
	if (_border.current.sprite != _border.target.sprite && asset_get_type(_border.target.sprite) == asset_sprite) {
		_border.target.alpha += (_border.target.alpha<1)*1/_border.target.ease_time;
		_border.target.index += sprite_get_speed(_border.target.sprite)/FPS;
		if (_border.target.alpha >= 1) {
			_border.current.sprite = _border.target.sprite;
			_border.current.index = _border.target.index;
		};
	}
	_border.current.alpha += (_border.current.alpha<1)*1/_border.current.ease_time;
	_border.current.index += sprite_get_speed(_border.current.sprite)/FPS;

	var no_border_rooms = [];
	if (array_get_index(no_border_rooms,room) >= 0) {border_set_sprite(spr_border)} else {
		switch(string_get_suffix(room_get_name(room),1)) {
			case "cave":	border_set_sprite(spr_border_cave)	break;
		};
	};
} else {
	_border.current.alpha = 0;
};
if (c != _border.current.sprite) {
	_border.target.sprite = undefined;
	_border.target.index = 0;
	_border.target.alpha = 0;
}
if (asset_get_type(_border.current.sprite) != asset_sprite) {_border.current.sprite = spr_border};