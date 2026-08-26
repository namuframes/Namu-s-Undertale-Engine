global.INPUT = {};

function input_set(_tag,_input_array) {
	struct_set(global.INPUT,_tag,_input_array);
};

function input_get(_input) {
	return struct_get(global.INPUT,_input);
};

function input_pressed(_input) {
	var key = input_get(_input);
	if (keyboard_check_pressed(vk_anykey)) {
		for(var i = 0; i < array_length(key); i++) {
			if (keyboard_check_pressed(key[i])) {return true}
		};
	};
	return false;
}

function input_check(_input) {
	var key = input_get(_input);
	if (keyboard_check(vk_anykey)) {
		for(var i = 0; i < array_length(key); i++) {
			if (keyboard_check(key[i])) {return true}
		};
	}
	return false;
}

function input_released(_input) {
	var key = input_get(_input);
	if (keyboard_check_released(vk_anykey)) {
		for(var i = 0; i < array_length(key); i++) {
			if (keyboard_check_released(key[i])) {return true}
		}
	};
	return false;
};

#macro INPUT_LEFT		"INPUT_LEFT"
#macro INPUT_DOWN		"INPUT_DOWN"
#macro INPUT_RIGHT		"INPUT_RIGHT"
#macro INPUT_UP			"INPUT_UP"
#macro INPUT_CONFIRM	"INPUT_CONFIRM"
#macro INPUT_CANCEL		"INPUT_CANCEL"
#macro INPUT_SPECIAL	"INPUT_SPECIAL"

input_set(INPUT_LEFT,		[vk_left,	ord("A")]);
input_set(INPUT_DOWN,		[vk_down,	ord("S")]);
input_set(INPUT_RIGHT,		[vk_right,	ord("D")]);
input_set(INPUT_UP,			[vk_up,	ord("W")]);
input_set(INPUT_CONFIRM,	[ord("Z"),	vk_enter]);
input_set(INPUT_CANCEL,		[ord("X"),	vk_shift]);
input_set(INPUT_SPECIAL,	[ord("C"),	vk_control]);