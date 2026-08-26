/// @description 
check_custenceCommands();
if (on_battle()) { //If i'm on battle
	if (hp_previous != hp) {attacked = true;}
	var attack_is_higher = hp+defense <= global.stat.attack
	if (attack_is_higher && surrender) {spareable = true} //If player damage is higher than my life, PLEASE SPARE ME AAGGGGHHHHH
	if (obj_battle_control.TURN >= BATTLE_TURNS.TURN_PREPARATION) {//If battle turn is preparation
		attacked = false
	}
	
	if (!attacked) {//If i wasn't attacked, proceed
		//Making the HP bar follow me just NOW to not make it shake when i get attacked
		hpbar.x = ((bbox_left+sprite_width/2)-hpbar.width/2)+hpbar.xoffset;
		hpbar.y = (bbox_top-hpbar.height)+hpbar.yoffset;
		hp_previous = hp //Updating previous HP
	}
	if (can_die && hp <= 0) {dead = true}
}