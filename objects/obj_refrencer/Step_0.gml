if (keyboard_check(vk_alt)) {
	var w = (mouse_wheel_up()-mouse_wheel_down())
	refalpha += 0.25*w;
	refalpha = clamp(refalpha,0,1)
	
	index += input_pressed(INPUT_RIGHT)-input_pressed(INPUT_LEFT)
}