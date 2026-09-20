next_page = function() {
	if (curtxt < array_length(text)-1) {
		writer.reset()
		curtxt++;
	} else if (array_length(questions) <= 0) {
		instance_destroy()
	};
}

text_draw = function(_x,_y,_length=infinity) {
	var _font = font,	can_draw = array_length(questions) > 2 ? question_wait : true
	if (instance_exists(portrait)) {
		if (asset_get_type(portrait.font) == asset_font) {_font = portrait.font};
	}
	if (can_draw) {
		draw_each_letter(_x,_y,text[curtxt],,,,lang_font(_font),1,1,0,_length,true,writer)
	}
	
	if (array_length(questions) > 2 ? !can_draw : true) {
		if (writer.done) {
			var ut_style = (array_length(questions) <= 2)
			draw_set_font(font)
			var heart_width = sprite_get_width(spr_small_heart)
			var heart_height = sprite_get_height(spr_small_heart)
			var box_width = sprite_get_width(spr_textbox)
			var box_height = sprite_get_height(spr_textbox)
			var __x, __y, ptx,
			centerX = box_width*.5,	_dir = [180,0, 90, 270],	_heartSpace = heart_width*1.5,	c = c_white,	tw = 0,
			centerY = box_height*.5
			if (ut_style) {
				for (var i = 0; i < array_length(questions); i++) {
				    tw += string_width(questions[i][0]);
				}
				__x = centerX-tw/2+_heartSpace/2;
			}

			for (var i = 0; i < array_length(questions); i++) {
			    var txt = questions[i][0], sh = string_height(txt),	sw = string_width(txt);
				if (ut_style) {
					__y = (_y+box_height*.75);
				} else {
					__y = _y+centerY+sh*0.4
					__x = centerX-sw*0.3;
					var gapx = max(_heartSpace,sw);
					if (i == 0) {__x = _x+_heartSpace};
					else if (i == 1) {__x = (_x+(box_width-_x))-gapx}
					else if (i == 2) {__y = _y+sh}
					else if (i == 3) {__y = _y+(box_height)-sh}
				}
			    draw_text_colour(__x, __y-sh, txt, c, c, c, c, 1);
				if (question_index == i) {
					draw_sprite(spr_small_heart,0,__x-_heartSpace,__y-sh/1.4);	
				}
				if (ut_style) {__x += string_width(txt)+_heartSpace*2};
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
	var p = portrait;
	switch(string_lower(input)) {
		case "gaster":
			portrait = obj_portrait_gaster;
		break;
	
		case "": portrait = noone break;
	};
	if (portrait != p) { //Destroying the old portrait
		if (instance_exists(p)) {instance_destroy(p)};	
	};

	if (asset_get_type(portrait) == asset_object || instance_exists(portrait)) {
		if (!instance_exists(portrait)) {
			portrait = instance_create_depth(0,0,0,portrait)
		} else {
			portrait.face = input	
		};
	};

	if (instance_exists(portrait)) {
		writer.sound(portrait.voice)
		if (is_string(face)) {portrait.face = face};
	} else {
		writer.sound("")	
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