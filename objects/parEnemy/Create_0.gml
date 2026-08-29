//Searching for a variable that isn't here?
//Check variable definitions, probably it's there
image_xscale = 2;
image_yscale = 2;

on_battle = function() { //Returns weather the enemy is on battle or not
	var arry = obj_battle_control.enemy;
	for(var i = 0; i < array_length(arry); i++) {
		if (arry[i] == id) {return true};
	}
	return false;
}

in_battle = function() {return on_battle()} //Same shit as on battle lol

function set_action(_name,_script=undefined,index=array_length(action)) {
	//If you want to set an action, this is function is quite usefull
	action[index] = {
		name: _name, //Name of the action, this will appear in the menu!
		script: _script //the script it'll execute
		//if it isn't a script, battle_controller will execute an user event based on the index
	}	
}

function show_hp(boolean = (hp_previous != hp)) { //Use this on DRAWs!
	if (boolean) { //If condition is meet, execute the code!
		//Fake hp is used on the HP bar to do the cool hp drain effect
		do_tween(id,"hpTween","fakehp",hp,EASE_LINEAR,2)	
		//Drawing the HP bar
		if (is_numeric(damage_taken)) {
			draw_hp(hpbar.x, hpbar.y,hpbar.width,hpbar.height,fakehp,hpmax,c_lime,#4C4C4C); //Drawing the hp bar
		}
	}
}
	
create_damage_text = function() {
	var i = instance_create_depth(x,hpbar.y-hpbar.height,depth-1,obj_damageTxt);
	i.text = damage_taken;
	if (betrail_kill && spareable) {
		i.text = hpmax*irandom_range(50,200)+irandom_range(100,200);
		hp=0;
	}
	if (is_numeric(damage_taken)) {
		if (damage_taken > 0) {
			i.image_blend = c_red;
			audio_play_sound(snd_hit,0,0)
		} else {
			i.image_blend = c_gray;
			i.text = "miss"
		}
	} else {i.image_blend = c_gray}
	return i
}


hp = hpmax;
hp_previous = hp;
fakehp = hp;

attacked = false;

spareable = false;
spared = false;

my_scene = undefined;

dead = false
can_die = true //Allows death

damage_taken = 0;
action = []

speech_bubble = { //The position that the bubble is supposed to be!
	left:		0,
	right:		0,
	top:		0,
	bottom:		0,
	centerX:	0,
	centerY:	0
}

hpbar = { //Hp bar info
	x:0,
	y:0,
	width: clamp(hpmax,80,180+hpmax/2),
	height: 20,
	alpha: 0,
	xoffset: 0, //offset x
	yoffset: 0 //offset y
}


set_action("Check",0) // Creating "Check" action

