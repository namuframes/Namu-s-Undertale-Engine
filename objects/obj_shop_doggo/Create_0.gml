event_inherited();
bgm_set(bgm_shop)

x = room_width/2;
y = (room_height/2)+10;
ystart = y;
speech = {
	main: "* Ey.",
	buying: "Get anythin'",
	buyed: "Get more\nGet more!",
	denied: "Awww\nDang it",
	no_cash: "Nope.",
	talk: "What ya need?"
}
background = spr_shop_doggo_bg

sino = {
	x: x+90,
	y: y-12,
	image_index: 0,
	turned: false,
	sprite_index: spr_shop_doggo_sino
};

add_talk("Pet",function() {
	var r = random_range(0.25,1)
	audio_play_sound(snd_dog,0,0,2,0,random_range(0.5,0.4))
	y = ystart+5*r;
	image_xscale += .15*r;
	image_yscale -= .1*r
})

add_talk("Move",function() {
	c_dialogue("* <wave>*Sniff, Sniff*<wave><z>\nDon't even dare.")	
})

add_storage(new item_stick(),2)
add_storage(new item_bandage(),4)
add_storage(new item_toy_knife() , 5)

if (!instance_exists(obj_mouse)) {instance_create_depth(0,0,0,obj_mouse)}