global.name = "Chara";
global.time = 0
global.stat = {
	weapon: "",
	attack: 0,
	armor: new item_bandage(),
	defense: 0,
	level: 1,
	hp: 20,
	hp_max: 20,
	gold: 100,
	xp: 0
};

global.saved_player = {
	x: 0,
	y: 0,
	room: 0,
	face: DIR.DOWN
}

global.inventory = []

global.fullscreen = false;

global.ENCOUNTER_ID = ENCOUNTER_ID.SPECIAL_WHIMSUN;
global.debug = false;
global.border = false;
global.party = [];

global.region_kills = ds_map_create();
global.region_population = ds_map_create();
global.region = string_get_suffix(room_get_name(room))

global.room_player_info = ds_map_create()

item_add(new item_toy_knife())
item_add(new item_bandage())