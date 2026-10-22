/// @func evaporate(source, [x], [y], [params], [depth], [free_src])
/// source: surface (x,y = its top-left) | sprite index (x,y = its origin) | instance (uses its sprite, index, scale and position)
function evaporate(_src, _x = undefined, _y = undefined, _params = {}, _depth = -9999, _free_src = false) {
	var _surf = _src;
	var _own  = false;
	var _inst = noone;
	
	if (!surface_exists(_src)) {
		var _spr, _img = 0, _xs = 1, _ys = 1;
		
		if (sprite_exists(_src)) {_spr = _src} else if (instance_exists(_src)) {
			_inst = _src;
			_spr = _inst.sprite_index;
			_img = _inst.image_index;
			_xs  = _inst.image_xscale;
			_ys  = _inst.image_yscale;
			if (is_undefined(_x)) _x = _inst.x;
			if (is_undefined(_y)) _y = _inst.y;
		} else {return noone}
		if (is_undefined(_x)) _x = 0;
		if (is_undefined(_y)) _y = 0;
		
		var _w  = sprite_get_width(_spr)*abs(_xs);
		var _h  = sprite_get_height(_spr)*abs(_ys);
		var _ox = sprite_get_xoffset(_spr)*_xs
		var _oy = sprite_get_yoffset(_spr)*_ys
		
		_surf = surface_create(ceil(_w), ceil(_h));
		surface_set_target(_surf);
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(_spr, _img, _ox, _oy, _xs, _ys, 0, c_white, 1);
		surface_reset_target();
		_own = true;
		
		_x -= _ox;
		_y -= _oy;
	} else {
		if (is_undefined(_x)) _x = 0;
		if (is_undefined(_y)) _y = 0;
	}
	
	var _p = {src_surf: _surf};
	var _names = variable_struct_get_names(_params);
	for (var i = 0; i < array_length(_names); i++) {
		variable_struct_set(_p, _names[i], variable_struct_get(_params, _names[i]));
	}
	
	var e = instance_create_depth(_x, _y, _depth, obj_evaporator, _p);
	
	// Create already copied the surface, so freeing here is safe
	if ((_own || _free_src) && surface_exists(_surf)) surface_free(_surf);
	return e;
}