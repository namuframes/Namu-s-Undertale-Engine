function add_face(name,sprite,_sprite_talk=sprite,_talk_speed=1, _idle_speed=0,_index=0) {
	ds_map_set(sprite_faces,name,{
		sprite_idle: sprite,
		sprite_talk: _sprite_talk,
		talk_speed: _talk_speed,
		idle_speed: _idle_speed,
		index: _index
	})
};

draw = function(_x,_y) {
	if (ds_map_exists(sprite_faces,face)) {
		var mp = sprite_faces[? face]
		sprite_index = !talking ? mp.sprite_idle : mp.sprite_talk
		var _index = mp.index;
		if (talking) {
			image_speed = mp.talk_speed
		} else {
			if (floor(image_index) <= 0) {image_speed=mp.idle_speed}
		}
		draw_sprite_ext(sprite_index,image_index+_index,_x+offset_x,_y+offset_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	} else {
		draw_lang_font(fnt_main);
		draw_set_halign(fa_center); draw_set_valign(fa_center); 
		draw_text_transformed(_x+offset_x,_y+offset_y,$"\"{face}\" not\nfound",.5,.5,0)
		draw_set_font(-1); draw_set_halign(fa_left); draw_set_valign(fa_top); 
	}
};

face="normal";

sprite_faces = ds_map_create();
talking=false;

add_face(face,sprite_index)