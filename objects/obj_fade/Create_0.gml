color			= c_white;
fadein_speed	= 10;
fadeout_speed	= 1;
fade_wait		= 0;
state			= 0;
sp				= 0;
oneshot			= true;

fadein_ease		= EASE_LINEAR;
fadeout_ease	= EASE_LINEAR;

alpha			= 0;

creator = id;

fadein_end = undefined

fadeout_start = undefined

step = undefined

freeze_player = false

draw_fade = function(_alpha_multiplier=1) {
	draw_set_alpha(alpha*_alpha_multiplier)
	draw_rectangle_colour(0,0,99999,99999,color,color,color,color,false)
	draw_set_alpha(1)
}