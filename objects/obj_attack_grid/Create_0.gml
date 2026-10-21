state = ATTACK_STATE.INTRO;
damage = 0;
cutscene = undefined;
oneshot = true;
target = undefined;
attacked = false;
anim = true;

calculate_damage = function(bar,divided=1,random_value=2) {
	var dist = point_distance(x,y,bar.x,bar.y)
	var presision = 1-clamp(dist/x,0,1)
	
	var val = ((global.stat.attack/divided)*presision)+irandom(2)
	val = round((val-target.defense));
	return val
}

event_user(0);