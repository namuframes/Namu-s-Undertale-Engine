var fadein_tag	=  $"{id}_FADEIN"
var fadeout_tag	= $"{id}_FADEOUT"
switch(state) {
	case 0: //Fading in
		if (oneshot) {
			tween(id,fadein_tag,"alpha",1,fadein_ease,fadein_speed);
			oneshot=false;	
		}
		if (!tween_exists(fadein_tag)) { //End
			alpha = 1;
			state++;
			if (is_method(fadein_end)) {script_execute(fadein_end)};
		}
	break;
	
	case 1: //Waiting...
		if (fade_wait <= 0) {
			state++;	
			if (is_method(fadeout_start)) {script_execute(fadeout_start)};
		} else {fade_wait-=1*DELTA()};
	break;
	
	case 2: //Fading out
		if (oneshot) {
			tween(id,fadeout_tag,"alpha",0,fadeout_ease,fadeout_speed);
			oneshot=false;	
		}
		if (!tween_exists(fadeout_tag)) {instance_destroy()};
	break;
};
	
if (is_method(step)) {script_execute(step)};
	
if (sp != state) {
	oneshot = true;
	sp = state;
}