var ps = sprite_index, is_me = false;
with(obj_txtbox) {if (target = other.id) {is_me=true}};


if (is_me) {
	sprite_index = get_sprite(face)[1]
	if (talk) {image_speed = 1} else {
		if (wait_index([0])) {image_speed=0};
	};
}
interaction_behaviour();	

if (!instance_exists(my_scene)) {
	if (reset_sprite) {
		sprite_index = prev_sprite;
		image_speed = prev_image_speed;
		face = prev_face;
		image_index=0;
		reset_sprite=false;
	} else {
		prev_face = face;
		prev_sprite = sprite_index;
		prev_image_speed = image_speed;
	}
	sprite_index = get_sprite(face)[0];
};

step();