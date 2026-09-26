function fade(_color, _fadein_speed, _fadeout_speed, 
_fadein_ease=undefined, _fadeout_ease=undefined, _fade_wait=undefined,	
_fadein_end=undefined,	_fadeout_start=undefined,	_step=undefined){
	var f = instance_create_depth(0,0,LAYER.UI-99,obj_fade);
	with(f) {
		color			= _color;
		fadein_speed	= _fadein_speed;
		fadeout_speed	= _fadeout_speed;
		creator			= other;
		if (!is_undefined(_fadein_ease))	{fadein_ease = _fadein_ease};	
		if (!is_undefined(_fadeout_ease))	{fadeout_ease	= _fadeout_ease};
		if (is_numeric(_fade_wait))			{fade_wait = _fade_wait};
		if (is_method(_fadein_end))			{fadein_end	= _fadein_end};
		if (is_method(_fadeout_start))		{fadeout_start	= _fadeout_start};
		if (is_method(_step))				{step	= _step};
	}
}