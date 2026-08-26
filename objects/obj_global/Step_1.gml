global.time+=1*DELTA
var damage = is_struct(global.stat.weapon) ? global.stat.weapon.stats.damage : 0
var defense = is_struct(global.stat.armor) ? global.stat.armor.stats.defense : 0
global.stat.attack = (2*global.stat.level) + damage
global.stat.defense = (round(global.stat.level/4)) + defense

if (DEVELOPER_MODE) {
	if (keyboard_check_pressed(vk_f1)) {
		global.debug = !global.debug;
	}
	
	if (keyboard_check_pressed(vk_f2)) {
		show_message("Restarting game...")
		game_restart();
	}
	
	if (keyboard_check_pressed(vk_f3)) {
		show_message("Restarting room...")
		room_restart();
	}
	
	if (keyboard_check_pressed(vk_f5)) {
		if (!instance_exists(obj_room_chooser)) {
			instance_create_depth(0,0,-99,obj_room_chooser)	
		} else {
			instance_destroy(obj_room_chooser)	
		}
	}
	
	if (keyboard_check_pressed(vk_f6)) {
		border(!global.border);
	}
	
	if (keyboard_check_pressed(vk_f7)) {
		battle_start(0)
	}
	
	if (keyboard_check_pressed(vk_f12)) {
		var numb = 0;
		var tag = "ENGINE_SCREENSHOT_"
		while(file_exists(tag+string(numb)+".png")) {
			numb++;	
		}
		var name = $"{tag}{numb}"
		screen_save(name+".png")
		show_message($"Screenshot taken\n{name}")
	}
}
	
if (keyboard_check_pressed(vk_f4)) {
	global.fullscreen = !global.fullscreen;
	
	if (global.fullscreen) {
		window_set_showborder(false)
		var w, h, scale_x, scale_y
		if (global.border) {
			scale_x = DISPLAY_WIDTH/BORDER_WIDTH;
			scale_y = DISPLAY_HEIGHT/BORDER_HEIGHT;
			w = BORDER_WIDTH*scale_x;
			h = BORDER_HEIGHT*scale_y;
		} else {
			scale_x = DISPLAY_WIDTH/WINDOW_WIDTH;
			scale_y = DISPLAY_HEIGHT/WINDOW_HEIGHT;
			w = WINDOW_WIDTH*scale_x;
			h = WINDOW_HEIGHT*scale_y;
		}
		window_set_size(w,h)
		window_center()
	} else {
		window_set_showborder(true)
		if (!global.border) {
			window_set_size(WINDOW_WIDTH,WINDOW_HEIGHT)
		} else {
			window_set_size(BORDER_WIDTH,BORDER_HEIGHT)	
		}
		window_center()
	}
}