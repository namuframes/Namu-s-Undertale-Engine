draw_self();

draw_set_mask(1)
var t = thickness*1.5
draw_rectangle_colour(bbox_left+t,bbox_top+t,bbox_right-t,bbox_bottom-t,c_red,c_red,c_red,c_red,false);

draw_reset_mask()

draw_on_mask()
	with (parBullet) {event_perform(ev_draw,0)}
draw_not_on_mask()

with(obj_battle_control) {
	var lr = (input_pressed(INPUT_RIGHT)-input_pressed(INPUT_LEFT));
	var row_length = 2
	var box = obj_battle_box
	draw_set_font(main_font)
	txt = {
		x: box.bbox_left+20,
		y: box.bbox_top+16
	}

	if (TURN == BATTLE_TURNS.PLAYER && page.current == BATTLE_PAGES.MAIN && READY) {	
		doodle_draw(txt.x,txt.y,flavor_text,,,,,,,,,box.bbox_right-txt.x,"*",1,c_black,flavor_writer)
	} else {flavor_writer.reset()};

	switch(TURN) {
		case BATTLE_TURNS.PLAYER:
			switch(page.current) {
				case BATTLE_PAGES.ACT:
					enemy_list(BATTLE_PAGES.ACT_CHOOSE);
				break;
		
				case BATTLE_PAGES.FIGHT:
					enemy_list(BATTLE_PAGES.FIGHT_ACTION,true);
				break;
		
				case BATTLE_PAGES.ACT_CHOOSE:
					if (lr != 0) {
						var line  = index.current mod row_length, collum = index.current div row_length;
						var _in = (collum+lr) * row_length + line;
						_in = wrap(_in,0,row_length+line)
					    index.current = _in;
					}

					for(var i = 0; i < array_length(target_enemy.instance.action); i++) {
						var act = target_enemy.instance.action[i]
						var __y = txt.y+32*(i mod row_length), __x = (txt.x+heart_offset.space)+250*(i div row_length)
						doodle_draw(__x,__y,"* "+act.name)

						if (index.current == i) {set_heart(__x+heart_offset.x-heart_offset.space,__y+heart_offset.y)}
					}
				break;
		
				case BATTLE_PAGES.ITEM:
					if (lr != 0) {
						var line  = index.current mod row_length, collum = index.current div row_length;
						var _in = (collum+lr) * row_length + line;
						_in = wrap(_in,0,row_length+line)
					    index.current = _in;
					}

					for(var i = 0; i < array_length(global.inventory); i++) {
						var itm = global.inventory[i]
						var __y = txt.y+32*(i mod row_length), __x = (txt.x+heart_offset.space)+125*(i div row_length)
						doodle_draw(__x,__y,"* "+item_name(itm,"short"))
						if (index.current == i) {set_heart(__x+heart_offset.x-heart_offset.space,__y+heart_offset.y)}
					}
				break
		
				case BATTLE_PAGES.MERCY:
					for(var i = 0; i < array_length(mercy_actions); i++) {
						var __y = txt.y+36*i, __x = txt.x+heart_offset.space, c = TEXTconfig.color
						for (var j = 0; j < array_length(enemy); j++) {
							if (enemy[j].spareable && i == 0) {
								c = TEXTconfig.color2
							}
						}
						doodle_draw(__x,__y,"* "+mercy_actions[i],,,c);

						if (index.current == i ) {set_heart(__x+heart_offset.x-heart_offset.space,__y+heart_offset.y+2)}
					}
				break;
			}
		break;

		case BATTLE_TURNS.END:
			if (box_is_normal()) {
				doodle_draw(txt.x,txt.y,$"* YOU WON!<w,1>\nYou earned {lootbox.xp} XP and {lootbox.gold} GOLD",,,,,,,,,box.bbox_right-txt.x,"*",1,c_black,win_writer)
			}
		break;
	}
	draw_set_font(-1)
}