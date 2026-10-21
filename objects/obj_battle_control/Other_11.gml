///@description Drawing the rest of the UI

var box = obj_battle_box
draw_set_font(main_font)
var spacing = string_height("I")*2
txt = {
	x: box.bbox_left+20,
	y: box.bbox_top+16
}

if (TURN == BATTLE_TURNS.PLAYER && page.current == BATTLE_PAGES.MAIN && READY) {	
	doodle_draw(txt.x,txt.y,flavor_text,,,,,,,,,box.bbox_right-txt.x,"*",,,flavor_writer)
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
				for(var i = 0; i < array_length(target_enemy.instance.action); i++) {
					var act = target_enemy.instance.action[i]
					var __y = txt.y+spacing*(i mod row_length), __x = (txt.x+heart_offset.space)+250*(i div row_length)
					doodle_draw(__x,__y,"* "+act.name)

					if (index.current == i) {set_heart(__x+heart_offset.x-heart_offset.space,__y+heart_offset.y)}
				}
			break;
	
			case BATTLE_PAGES.ITEM:
				var w = obj_battle_box.width;
				var length = array_length(paged_inventory);
				var _page_text = $"PAGE {inventory_page+1}"
				var page_array = paged_inventory[inventory_page];
				var offx = txt.x+heart_offset.space
				for(var i = 0; i < array_length(page_array); i++) {
					var itm = page_array[i]
					var line = i mod row_length,	collum = i div row_length
					
					var __y = txt.y+spacing*line, __x = offx+(w/2)*collum
					doodle_draw(__x,__y,"* "+item_name(itm,"short"))
					if (index.current == i) {set_heart(__x+heart_offset.x-heart_offset.space,__y+heart_offset.y)}
				}
				
				draw_text_transformed(offx+w*0.6,txt.y+76,_page_text,2,2,0)
			break
	
			case BATTLE_PAGES.MERCY:
				for(var i = 0; i < array_length(mercy_actions); i++) {
					var __y = txt.y+spacing*i, __x = txt.x+heart_offset.space, c = TEXTconfig.color
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