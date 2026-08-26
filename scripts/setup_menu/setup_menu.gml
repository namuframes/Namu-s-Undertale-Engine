function setup_menu() {
	index = {
		current: 0,
		previous: [],
		input: 0,
		limit: 0
	}

	page = {
		current: 0,
		previous: []
	}
	
	function previous_page() {
		//If i have a previous page/index, go to it and then remove it from the array
		if (array_length(page.previous) > 0) {
			page.current = array_pop(page.previous)
			
			////if (object_index == obj_battle_control) then with (obj_battle_control) {
			////	if (TURN == BATTLE_TURNS.PLAYER) {enemy_event(ENEMY_EVENTS.MENU_SWITCH)}
			////}
		};
		if (array_length(index.previous) > 0) {index.current = array_pop(index.previous)};
	}
	
	function set_page(_page,do_sound=true) {
		//Save previous page and index info and go to the page that was setted
		if (_page != page.current) {
			array_push(index.previous,index.current);
			array_push(page.previous,page.current);
			page.current = _page;
			index.current = 0;
			if (do_sound) audio_play_sound(snd_confirm,0,0)
		}
	}



	
	function set_controls(inputs,limit) {
		//Define the input that index will follow
		//And it allows the player to go back at the previous page
		var prev_current = index.current
		index.input = inputs; index.limit = limit
		index.current += index.input
		index.current = wrap(index.current, 0, index.limit)
		if (prev_current != index.current) {audio_play_sound(snd_select,0,0)}
	}
	
	show_soul = function(_sprite=spr_soul) { //Drawing the soul in it proper position u_u
		var scale = .5
		if (_sprite == spr_small_heart) {scale = 1}
		draw_sprite_ext(_sprite,0,ui_heart.x,ui_heart.y,scale,scale,0,c_white,1)	
	}

}