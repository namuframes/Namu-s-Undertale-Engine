text_info = undefined;
update_side = function() {
	var __p = x+txt_offset.x+string_width("W")*4
	switch(side) {
		default: //Right
			length = room_width-(__p)
			if (instance_exists(target)) {
				x = target.speech_bubble.x_right+pointer.xoffset
				y = target.speech_bubble.y
			}
			pointer.x = x;
			pointer.y = y;
			pointer.angle = 0;
			pointer.flipx = false;
			
			bubble.x = ((pointer.x-pointer.xoffset)+pointer.width)-outline_size;
			bubble.y = pointer.y-height/2+2
		break;

		case SPEECH_SIDE.LEFT: //Left
			if (instance_exists(target)) {
				x = target.speech_bubble.x_left
				y = target.speech_bubble.y
			}
			
			pointer.x = x;
			pointer.y = y;
			pointer.angle = 0;
			pointer.flipx = true;
			length = -__p
			
			bubble.x = ((pointer.x-pointer.xoffset)-width)+outline_size*0.5;
			bubble.y = pointer.y-height*.5+2
		break;
		
		case SPEECH_SIDE.UP: //Up
			length = room_width/2-txt_offset.x
			if (instance_exists(target)) {
				x = ((target.bbox_left+target.bbox_right)/2)
				y = target.speech_bubble.y_top
			}
			pointer.x = x;
			pointer.y = y;
			pointer.angle = 90;
			pointer.flipx = false;
	
			bubble.x = pointer.x-width/2
			bubble.y = pointer.y-height-round(pointer.height/2)+1
		break;
	
		case SPEECH_SIDE.DOWN: //Down
			length = room_width/2-txt_offset.x
			if (instance_exists(target)) {
				x = ((target.bbox_left+target.bbox_right)/2)
				y = target.bbox_bottom
			}
	
			pointer.x = x;
			pointer.y = y;
			pointer.angle = 270;
			pointer.flipx = false;
			length = txt_offset.x-string_width("W")*.8
	
			bubble.x = pointer.x-width/2
			bubble.y = pointer.y+pointer.height-pointer.yoffset-1
		break;
	
	}

}

update_bubble = function() {
	draw_lang_font(font)
	var map = text_info;
	pointer.x = x;
	pointer.y = y;
	
	var extra_w = string_width("W")*1.6
	var extra_h = string_height("I")*1.6
	width = max(map.width,sprite_get_width(spr_speech_bubble))+txt_offset.x+extra_w
	height = max(map.height,sprite_get_height(spr_speech_bubble))+txt_offset.y+extra_h

	update_side();
	
	txt = {
		x: bubble.x+txt_offset.x,
		y: bubble.y+txt_offset.y
	}
}

next_page = function() {
	var can_procced = true
	if (instance_number(object_index) > 1) {
		for(var i = 0; i < instance_number(object_index); i++) {
			var bubble = instance_find(object_index,i)
			with(bubble) {
				if (!writer.done) {can_procced=false}
			}
		}
	}
	if (can_procced) {
		curtxt++;
		writer.reset()
		
		if (curtxt > array_length(text)-1) {instance_destroy(object_index)}
	}
}

check_mute = function() {
	if (instance_number(object_index) > 1) {
		for(var i = 0; i < instance_number(object_index); i++) {
			var bubble = instance_find(object_index,i)
			if (string_length(bubble.text) >= string_length(text)) {
				mute=true
			}
		}
	}
}

can_draw = false
text = []
outline_size = 2
curtxt = 0
target = undefined
font = fnt_dotum

writer = new typer()
writer.skipable=true
writer.sound(snd_txt1)

length = 0

side = 0
mute = false
blip = snd_txt1

pointer = {
	x: 0,
	y: 0,
	width: sprite_get_width(spr_speech_pointer),
	height: sprite_get_height(spr_speech_pointer),
	flipx: false,
	xoffset: sprite_get_xoffset(spr_speech_pointer),
	yoffset: sprite_get_yoffset(spr_speech_pointer)
}

txt_offset = {x: 12, y: 12}

height = 0
width = 0

bubble = {
	x: 0,
	y: 0,
	width:0,
	height: 0,
	angle: 0
}

txt = {
	x: 0,
	y: 0
}

alarm[0] = 1;