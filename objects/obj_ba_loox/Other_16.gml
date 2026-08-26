///@description PREPARATION
if (scared_asf) {
	c_speech_bubble("<shake,0.5>P-Please don't hurt me")
	scared_asf=false
} else {
	var c = choose("Fuck","Fuck2","Fuck3")
	c_speech_bubble("<wave,0.5>"+c)	
}

instance_create_depth(0,0,0,obj_turn_loox)