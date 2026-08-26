event_inherited();

image_speed = 0;
min_time = 10
max_time = 90
blink_time = irandom_range(min_time,max_time)
oneshot = false

scared_asf=false
set_action("Terrorize",function() {
	c_shake(id,"x",4,2)
	c_dialogue("* You move your fingers meanincingly")
	c_wait_dialogue()
	set_flavor("* Loox is scared\nWhy would you do that?")
	spareable=true
	scared_asf=true
})