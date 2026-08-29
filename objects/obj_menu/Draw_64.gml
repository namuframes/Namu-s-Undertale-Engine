var position;
var box_stat = {x:16, y: 26};
draw_box(box_stat.x,box_stat.y+136*!get_if_top(),71,55);
position = {x: box_stat.x+7, y: box_stat.y+4};
draw_lang_font(fnt_main);
draw_text(position.x,position.y+136*!get_if_top(),string_upper(global.name));
draw_set_font(-1);
var info = "";
info += $"lv {global.stat.level}\n"
info += $"hp {global.stat.hp}/{global.stat.hp_max}\n"
info += $"g  {global.stat.gold}\n"
draw_lang_font(fnt_crypt)
draw_text_ext(position.x,position.y+21+136*!get_if_top(),info,9,-1)
draw_set_font(-1)
var box_options = {x: 16,	y: 84}
var e = array_length(options) > 3 ? 10*array_length(options) : 30
draw_box(box_options.x,box_options.y,71,44+e)
for(var i = 0; i < array_length(options); i++) {
	position = {x: box_options.x+26, y: box_options.y+10+18*i}
	var c = TEXTconfig.color;
	if (!options[i].selectable) {c = c_gray};

	draw_each_letter(position.x,position.y,options[i].name,,,c,lang_font(fnt_main))

	if (index == i) set_heart(position.x-14,position.y+4)
}

if (im_focus) {draw_sprite_ext(spr_small_heart,0,ui_heart.x,ui_heart.y,1,1,0,c_white,1)}

if (decided) {
	switch(index) {
		case menu.status:
			draw_lang_font(fnt_main)
			var my_pos = {x: box_stat.x+78, y: 26}
			draw_box(my_pos.x,my_pos.y,173,209)
			draw_text(my_pos.x+14,my_pos.y+16,$"\"{string_upper(global.name)}\"")
			var stats = [];
			var weapon = is_struct(global.stat.weapon) ? [item_name(global.stat.weapon),global.stat.weapon.stats.damage] : ["(NONE)",0]
			var armor = is_struct(global.stat.armor) ? [item_name(global.stat.armor),global.stat.armor.stats.defense] : ["(NONE)",0]

			var msg = "";
			array_push(stats, $"LV: {global.stat.level}")
			array_push(stats, $"HP: {global.stat.hp} / {global.stat.hp_max}")
			array_push(stats, $"\nAT: {global.stat.attack-weapon[1]} ({weapon[1]})")
			array_push(stats, $"DF: {global.stat.defense-armor[1]} ({armor[1]})")
			array_push(stats, $"\nWEAPON: {weapon[0]}")
			array_push(stats, $"ARMOR: {armor[0]}")
			array_push(stats, $"EXP: {global.stat.xp}")
			for(var i = 0; i < array_length(stats); i++) {
				msg += stats[i]+"\n"	
			}
			
			draw_text_ext(my_pos.x+14,my_pos.y+46,msg,16,-1)
			
			
		break;
	}
}
draw_set_font(-1)