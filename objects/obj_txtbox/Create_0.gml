next_page = function() {
	if (curtxt < array_length(text)-1) {
		writer.reset()
		curtxt++;
	} else if (array_length(questions) <= 0) {
		instance_destroy()
	};
}

text_draw = function(_x,_y,_length=infinity) {
	var _font = font;
	if (instance_exists(portrait)) {
		if (asset_get_type(portrait.font) == asset_font) {
			_font = portrait.font;
		}
	}
	var can_draw = array_length(questions) > 2 ? question_wait : true
	if (can_draw) {
		draw_each_letter(_x,_y,text[curtxt],,,,lang_font(_font),1,1,0,_length,true,writer)
	}
	
	if (array_length(questions) > 2 ? !can_draw : true) {
		if (writer.done) {
			draw_set_font(font)
			var heart_width = sprite_get_width(spr_small_heart)
			var heart_height = sprite_get_height(spr_small_heart)
			var box_width = sprite_get_width(spr_textbox)
			var box_height = sprite_get_height(spr_textbox)
			var wid = string_width("W")
			var __x=0, __y, txt, ptx;
			for(var i = 0; i < array_length(questions); i++) {
				txt = questions[i][0]
				ptx = i > 0 ? questions[i-1][0] : ""
				if (array_length(questions) < 3) {
					__y = _y+(box_height/2+10)-string_height(txt)/2;
					__x = (_x+string_width(ptx)+wid)+heart_width+((heart_width+6)*i);
				} else {
					__y = _y+(box_height/2)-string_height(txt)/2
					if (i == 0) {__x = _x+10+heart_width;}
					else if (i == 1) {__x = box_width-10-string_width(txt)}
					else if (i == 2) {__x = _x+box_width/2-string_width(txt)/2; __y = _y}
					else if (i == 3) {__x = _x+box_width/2-string_width(txt)/2; __y = _y+box_height/2+4}
				}
				var c = TEXTconfig.color
				if (question_index == i) {
					c = TEXTconfig.color2
					draw_sprite_ext(spr_small_heart,0,__x-heart_width-6,__y+string_height(txt)/2-heart_height/2,1,1,0,c_white,1)
				}
				draw_text_colour(__x,__y,txt,c,c,c,c,1)
			}
			draw_set_font(-1)
		}
	}
}

change_target = function(_id) {
	if (instance_exists(target)) {
		if (variable_instance_exists(target,"talk")) {
			target.talk = false;
		};
		target = _id;
	} else {target = undefined};
};

set_portrait = function(input="",face=undefined) {
	switch(string_lower(input)) {
		case "gaster":
			portrait = obj_portrait_gaster;
		break;
	
		case "": portrait = noone break;
	};

	if (asset_get_type(portrait) == asset_object || instance_exists(portrait)) {
		if (!instance_exists(portrait)) {
			portrait = instance_create_depth(0,0,0,portrait)
		} else {
			portrait.face = input	
		};
	};

	if (instance_exists(portrait)) {
		if (is_string(face)) {portrait.face = face};
	};

};


top = get_if_top()

x = 16; y = top ? 160 : 4
type = BOX_TYPE.overworld;
creator = undefined;
target = undefined;
if (room == rm_battle) {type = BOX_TYPE.battle}

text = [];
curtxt = 0;

voice = "";
	
portrait = noone;

font = fnt_main_mono;

writer = new typer();
writer.skipable = true;
writer.sound(voice)

questions=[]
question_index = -1;
question_wait = false;