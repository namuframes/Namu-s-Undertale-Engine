
//if (!is_struct(writer)) {exit}
switch(type) {
	case BOX_TYPE.overworld:
		var text_pos = {
			x: 14,
			y: 10
		}

		draw_sprite(spr_textbox,0,x,y);
	
		if (instance_exists(portrait)) {
			var s = 50
			text_pos.x += s;
			var off_x = portrait.sprite_xoffset;
			var off_y = portrait.sprite_yoffset;
			var spr_width = portrait.sprite_width/2;
			var spr_height = portrait.sprite_height/2;
			portrait.draw((x+30+off_x)-spr_width,(y+30+off_y)-spr_height);
		}

		var final_length = (sprite_get_width(spr_textbox)-text_pos.x-4)
		text_draw(x+text_pos.x,y+text_pos.y,final_length)
		//writer.draw(x+text_pos.x,y+text_pos.y,text[curtxt],character.spacing,,,character.font,1,1,0,final_length,character.sound);
	break;
	
	case BOX_TYPE.shop:
		depth = obj_shopManager.depth-1
		var _x = obj_shopManager.txt.x
		var _y = obj_shopManager.txt.y
		text_draw(_x,_y,200)
	break;
}
