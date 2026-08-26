spd = 0.1
if (state == 0) {
	image_alpha = linearVar(image_alpha,2,spd)
	if (image_alpha >= 1.3) {state = 1; room_goto(destiny.rm);}
} 
else if (state == 1) {	
	image_alpha = linearVar(image_alpha,0,spd)
	if (image_alpha <= 0) {instance_destroy()}
}