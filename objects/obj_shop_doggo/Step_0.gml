if (collision_rectangle(sino.x-10,sino.y,sino.x+20,sino.y-20,obj_mouse,false,true)) {
	if (mouse_check_button(mb_left) && !instance_exists(cutscene)) {
		if (!sino.turned) {
			audio_play_sound(snd_bell,0,0,1,0,random_range(1.1,1))
			sino.turned = true
		}
		if (sino.turned) {
			audio_play_sound(snd_dog,0,0,2,0,random_range(1,1.1))
			c_custom(function() {
				bgm_pause()
				end_action()
			})
			
			c_sprite(obj_shop_doggo,spr_shop_doggo_shcoked,,0)
			c_wait_anim(obj_shop_doggo)
			c_sprite(obj_shop_doggo,spr_shop_doggo_idle)
			c_custom(function() {
				bgm_resume()
				end_action()
			})
		}
	}
}


y = lerp(y,ystart,0.1)
image_xscale = lerp(image_xscale,1,0.1);
image_yscale = lerp(image_yscale,1,0.1);

if (sino.turned) {
	sino.image_index += sprite_get_speed(sino.sprite_index)/NATIVE_FPS
	if (round(sino.image_index) >= sprite_get_number(sino.sprite_index)) {
		sino.image_index = 0;
		sino.turned = false;	
	}
}