enum ITEM_TYPES {
	CONSUMEABLE,
	ARMOR,
	WEAPON,
	SPECIAL
}

function item() constructor {
	is_item=true
	name = {
		normal: "name.normal",
		short: ""
	};
	description = {
		overworld: "description.overworld",
		shop: "description.short"
	}
	type = ITEM_TYPES.CONSUMEABLE;
	stats = {
		defense: 0,
		damage: 0,
		heal: 0
	}
}

function item_weapon() : item() constructor {type = ITEM_TYPES.WEAPON};

function item_armor() : item() constructor {type = ITEM_TYPES.ARMOR};

function item_consumeable() : item() constructor {type = ITEM_TYPES.CONSUMEABLE};

function item_special() : item() constructor {
	type = ITEM_TYPES.SPECIAL;
	remove_self = true;
	func = function(){}
};

function item_stick() : item_weapon() constructor {
	name.normal = "Stick";
	description.overworld = "* \"Stick\" - Weapon AT 0\n* Its bark is worse than\nits bite."
	description.shop = "<spr_stick>"
	stats.damage = 2;
};

function item_toy_knife() : item_weapon() constructor {
	name.normal = "Toy Knife";
	description.overworld =  "* \"Toy Knife\" - Weapon AT 3";
	stats.damage = 3;
};

function item_bandage() : item_consumeable() constructor {
	name.normal = "Bandage";
	description.overworld = "* \"Bandage\" - Heals 10 HP\n* It has already been used several times.";
	stats.heal = 10;
};

//==============================================================\\

function item_is_valid(_item) {
	if (is_struct(_item)) {
		if (variable_struct_exists(_item,"is_item")) {
			return true
		}
	}
	return false
}

function item_add(_item) {
	if (item_is_valid(_item)) {array_push(global.inventory,_item);	}
}

function item_name(ITEM,WICH="normal") {
	if (item_is_valid(ITEM)) {
		var output = ITEM.name.normal;
		if (struct_exists(ITEM.name,WICH)) {
			var s = struct_get(ITEM.name,WICH)
			if (string_length(s) > 0) {output = s}
		}
		return output
	}
}
	
function item_get_index(_item, _array=global.inventory) {
	return array_get_index(_array,_item)
}

function item_description(ITEM,WICH="overworld") {
	if (item_is_valid(ITEM)) {
		var output = ITEM.description.overworld;
		if (struct_exists(ITEM.description,WICH)) {
			output = struct_get(ITEM.description,WICH)	
		}
		return output
	}
}

function item_use(_item) {
	if (!item_is_valid(_item)) {show_message("Not an valid item"); exit}

	var in = item_get_index(_item);
	var cutscene = undefined
	if (_item.type == ITEM_TYPES.ARMOR || _item.type == ITEM_TYPES.WEAPON) {
		var weapon = global.stat.weapon, armor = global.stat.armor
		cutscene = create_dialogue($"* You equipped the {item_name(_item)}.")
	
		array_delete(global.inventory,in,1)
	
		if (_item.type == ITEM_TYPES.WEAPON && is_struct(weapon)) {array_insert(global.inventory,in,weapon)}
		else if (_item.type == ITEM_TYPES.ARMOR && is_struct(armor)) {array_insert(global.inventory,in,armor)}
	
		equip_item(_item)
	} else if (_item.type == ITEM_TYPES.CONSUMEABLE) {
		var ex = ""
		heal_player(_item.stats.heal);
		if (global.stat.hp >= global.stat.hp_max) { 
			ex = "\n<z>Your HP was maxed out!";
			cutscene = create_dialogue($"* You ate the {item_name(_item)}.{ex}");
		}
		audio_play_sound(snd_heal_c,0,0);
		array_delete(global.inventory,in, 1);
	} else if (_item.type == ITEM_TYPES.SPECIAL) {
		if (is_method(_item.func)) {
			cutscene = script_execute(_item.func)	
		}
		if (_item.remove_self) {array_delete(global.inventory,in, 1)}
	}
	return cutscene
}

function equip_item(_item) {
	if (_item.type == ITEM_TYPES.ARMOR) {global.stat.armor = _item;}
	if (_item.type == ITEM_TYPES.WEAPON) {global.stat.weapon = _item;}
}