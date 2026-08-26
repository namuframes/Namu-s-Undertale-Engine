if (state == "intro") {
	if (y-(ystart) <= 0) {state = "outro"; vsp/=2}
}
if (state == "outro") {
	vsp += 1/spd;
	if (y-ystart >= 1) {
		y = ystart;
		vsp=0;
		state = "end";
	}
}
y += vsp;