setup_menu()

function create_enemies() {
	var centerX = room_width/2, pw = 0,	space=6;
	var length = array_length(enemy)
	if (!is_array(enemy)) {enemy = [enemy]}
	for(var i = 0; i < length; i++) {
		enemy[i] = instance_create_depth(0,0,depth+20,enemy[i]);
		with(enemy[i]) {
			x += (centerX-((sprite_width+space)*length)/2)+pw;
			y += obj_bulletBorder.bbox_top-sprite_height;
			depth -= i;
			x += sprite_xoffset; y += sprite_yoffset;
			xstart = x;	ystart = y;
			pw += sprite_width+space;
			event_user(ENEMY_EVENTS.START);
		}
	}
}

function battle_end() {
	battle_set_turn(BATTLE_TURNS.END)//If the enemy array is empty, the battle is OVER!!
}

function enemy_list(_page=page.current, _show_hp=false) {
	//Drawin' the enemy list
	if (event_type == ev_gui || event_type == ev_draw) {
		for(var i = 0; i < array_length(enemy); i++) {
			var name = "* "+enemy[i].name
			var __x = txt.x+heart_offset.space, __y = txt.y+32*i
			var c = enemy[i].spareable ? TEXTconfig.color2 : TEXTconfig.color
			var mp = draw_each_letter(__x,__y,name,,,c,main_font)
			if (index.current == i) {set_heart(__x+heart_offset.x-heart_offset.space,__y+heart_offset.y)}
			if (_show_hp) {
				var width = mp.width
				var hp_x = __x+width+16, hp_y = __y+8
				draw_hp(hp_x,hp_y,100,16,enemy[i].hp,enemy[i].hpmax,c_lime,c_red)
			}
		}
	} else {
		if (input_pressed(INPUT_CONFIRM)) { //If enter is pressed, go to the setted page and set target enemy
			set_target_enemy(index.current)
			set_page(_page)	
		}
	}
}
function no_cutscene() {
	var endd = true //Checking if there isn't any cutscene from myself or the enemies
	with(parEnemy) {
		if (on_battle()) {
			if (instance_exists(my_scene)) {endd = false}
		}
	}

	with(parTurn) {if (instance_exists(my_scene)) {endd=false}};

	if (instance_exists(my_cutscene) || instance_exists(parCutscene)) {endd = false}
	//if (instance_exists(parCutscene) || instance_exists(my_cutscene) || delay > 0) {endd = false}
	return endd
}

function set_target_enemy(_index) {
	//Set the target enemy
	target_enemy.index = _index //Grabbing index
	target_enemy.instance = enemy[_index] //Grabbing instance
}
	
function battle_soul_position(_x,_y,_smth=undefined) {
	set_heart(_x,_y,_smth)	
}

function update_enemy_array() {
	with(parEnemy) {
		if (on_battle()) {
			if (spared || dead) {enemy_remove(id);}
		}
	}
}
	
function turn_event(event,object=parTurn) {
	with(object) {
		if (object_index == parTurn || object_get_parent(object_index) == parTurn) {
			event_user(event); 
			check_custenceCommands() //Making the cutscene create with c_name be created instantly
		} else {show_error("invalid turn!\nturn_event()",true)}
	}
}

main_button = function(_sprite) constructor {
	sprite = asset_get_type(_sprite) == asset_sprite ? _sprite : spr_bt_fight
	selectable = true;
}

if (!instance_exists(obj_soul)) {instance_create_depth(obj_bulletBorder.x,obj_bulletBorder.y,obj_bulletBorder.depth-1,obj_soul)};
battle_soul_state(STATE.frozen)

main_font = lang_font(fnt_main_mono)

TURN = BATTLE_TURNS.PLAYER_INIT

READY = true

global.BATTLE_TIME = 0;
global.turn = 0;
did_scene = false;
enemy = [];
song = undefined;
oneshot = true;
play_song = true

flavor_text = "* Flavor text"
flavor_writer = new typer()
flavor_writer.sound("battle");

win_writer = new typer();
win_writer.sound("battle");

event_user(0)

lootbox = {
	xp: 0,
	gold: 0
}

buttons = [obj_bt_fight,obj_bt_act,obj_bt_item,obj_bt_mercy]

array_foreach(buttons,function(val,i) {
	if (asset_get_type(val) == asset_object) {
		var _x = 32+(sprite_get_width(spr_bt_fight)+43)*i, _y = 432;
		var offx = sprite_get_xoffset(spr_bt_fight), offy = sprite_get_yoffset(spr_bt_fight)
		buttons[i] = instance_create_depth(_x+offx,_y+offy,depth,val);
		buttons[i].w = i;
	}
})

mercy_actions = ["Spare","Flee"]
wait_damage = false; //For damage animation
my_cutscene = undefined;

heart_offset = {
	x: (sprite_get_xoffset(spr_soul)),
	y: (sprite_get_yoffset(spr_soul))+6,
	space: (sprite_get_width(spr_soul))+18
}

target_enemy = {
	instance: undefined,
	index: 0
}
	
txt = {
	x: 0,
	y: 0
}

page.current = BATTLE_PAGES.MAIN