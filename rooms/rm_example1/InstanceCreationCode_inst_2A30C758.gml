fuckyouscene =  function() {
	c_canMove(false)
	c_move(id,lengthdir_x(10,obj_player.face),lengthdir_y(10,obj_player.face),10,true)
	c_sprite(id,get_sprite(face),0,1)
	c_shake(id,2,0,1);
	c_wait_shake(id);
	c_wait(.1)
	c_sprite(id,get_sprite(face),0,0)
	c_wait(.5)
	c_dialogue("<face,gaster,oh>* Calm down...")
	c_wait_dialogue()
};

addscene(function() {
	c_dialogue("<face,gaster>* I am wing gaster.")
	c_question("Fuck you", fuckyouscene);
})

addscene(function() {
	c_canMove(false)
	look_at_player()
	c_dialogue("<talker,noone>* I'm sorry?")
	c_question("Fuck you", fuckyouscene);
	c_question("Sorry", function() {
		c_dialogue("<face,gaster,blink><spr_facee,*> Awwww geez\nTinkers")
		c_wait_dialogue()
	});
})