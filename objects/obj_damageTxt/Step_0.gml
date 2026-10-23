switch(string_lower(state)) {
	case "intro":
		if (y-(ystart) <= 0) {state = "outro"; vsp/=2}
	break;
	
	case "outro":
		vsp += 1/spd;
		if (y-ystart >= 1) {
			y = ystart;
			vsp=0;
			state = "end";
		}
	break;
	
	case "end":
		
	break;
}

y += vsp;