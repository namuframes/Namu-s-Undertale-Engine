
if (!instance_exists(shop)) {exit}

var box = {
	main: {x: 0, y: 120, width: BASE_WIDTH, height: 120},
	options: {x: 210, y: 120, width: 110, height: 120},
}
box.buy = {x: box.options.x,	y: box.options.y-81,	width: box.options.width}

txt = {x: box.main.x+15,	y: box.main.y+10}

var soul = {
	width: sprite_get_width(spr_small_heart)	
}

{//Main box
	draw_sprite_stretched(spr_box,0,box.main.x,box.main.y,box.main.width, box.main.height)
	if (page.current == -1) { 
		draw_each_letter(txt.x,txt.y,speech.main,,,,,,,,(box.main.width-box.options.width)-15,true,main_text)
	} else {main_text.reset()}
	
	switch(page.current) {
		case SHOP_OPTIONS.BUY:
			draw_sprite_stretched(spr_box,0,box.buy.x,box.buy.y+offy,box.buy.width,1000)
			for (var i = 0; i < array_length(storage); i++) {
				var _item = storage[i].item;
				var _x = txt.x;
				var _y = txt.y+20*i;
				draw_each_letter(_x+soul.width+6,_y,$"{storage[i].cost}G - {item_name(_item)}");

				var desc = storage[buy_state <= 0 ? index.current : array_last(index.previous)].item

				draw_each_letter(box.buy.x+15,box.buy.y+10+offy,item_description(desc,"shop"),,,,,,,,box.buy.width-15);
	
				if (index.current == i && buy_state <= 0) {
					set_heart(_x,_y+4);
					show_soul(spr_small_heart);
				}
			}
		break;
		
		case SHOP_OPTIONS.TALK:
			if (!in_cutscene) {
				for (var i = 0; i < array_length(talk); i++) {
					var _talk = talk[i];
					var _x = txt.x;
					var _y = txt.y+20*i;
					draw_each_letter(_x+soul.width+6,_y,_talk.name,);

					if (index.current == i) {
						set_heart(_x,_y+4);
						show_soul(spr_small_heart);
					}
				}
			}
		break;
	}
}

if (page.current != "cutscene" && page.current != SHOP_OPTIONS.EXIT) {//Options box
	draw_sprite_stretched(spr_box,0,box.options.x,box.options.y,box.options.width, box.options.height)
	if (page.current == -1) {
		for(var i = 0; i < array_length(options); i++) {
			var _x = box.options.x+15
			var _y = box.options.y+10+20*i
			draw_lang_font(fnt_main)
			draw_text(_x+soul.width+6,_y,options[i].name)
			draw_set_font(-1)
			if (index.current == i) {
				set_heart(_x,_y+4)
				show_soul(spr_small_heart)
			}
		}
	}
	
	switch(page.current) {
		case SHOP_OPTIONS.BUY:
			if (buy_state == 0) {
				draw_each_letter(box.options.x+15,box.options.y+10,buy_speak,,,,,,,,box.buy.width-15,false,right_text)
			} else {
				var _x = box.options.x+15, _y = (box.options.y+10)
				draw_each_letter(_x,_y,"Buy it for\n"+string(storage[array_last(index.previous)].cost)+"G?")
				right_text.reset()
				
				for(var i = 0; i < array_length(buy_options); i++) {
					var my_y = (_y+40+20*i)
					draw_each_letter(_x+soul.width+6,my_y,buy_options[i])
					if (index.current == i) {
						set_heart(_x,my_y+4)
						show_soul(spr_small_heart)
					}
				}
			}
		break;
		
		case SHOP_OPTIONS.TALK:
			draw_each_letter(box.options.x+15,box.options.y+10,speech.talk,,,,,,,,box.buy.width-15,false,right_text)
		break;
	}

	draw_lang_font(fnt_main);
	draw_set_halign(fa_middle)
	draw_text(box.options.x+33,((box.options.y+box.options.height)-string_height("I"))-14,$"{global.stat.gold}G")
	draw_set_halign(fa_left)
	draw_text(box.options.x+70,((box.options.y+box.options.height)-string_height("I"))-14,$"{array_length(global.inventory)}/8")
	draw_set_font(-1);

} else {right_text.index = 0}