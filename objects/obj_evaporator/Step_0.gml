if (target == undefined) {exit}
var w = sprite_get_width(spr);
var h = sprite_get_height(spr);

for (var i = 0; i < array_length(pixels); i++) {
	var p = pixels[i]
	if (peee >= i) {
		if (p.alpha > 0) {p.alpha-=p.alpha_loss*DELTA}
		p.smh = lerp(p.smh,0,.1)
		p.vely += .5*DELTA
		p.offy -= (p.vely*.1)*DELTA;
	    p.offx += (p.velx*p.smh)*DELTA;
		if (p.offsize > -size) {p.offsize -= .01*DELTA}
	}
	
	if (p.alpha <= 0 || p.offsize <= -size) {
		array_delete(pixels,i,1)
	}
}

if (peee < array_length(pixels)) {peee+=spd*DELTA}
if (array_length(pixels) <= 0) {instance_destroy()}