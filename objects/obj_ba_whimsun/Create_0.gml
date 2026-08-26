y -= 60
event_inherited();
terrified = false
set_action("Terrorize", function() {
	c_dialogue("* You raise your arms and wiggle your fingers.\n<w>Whimsun freaks out!");
	terrified = true;
})

set_action("Console", function() {
	c_dialogue("* Halfway through your first\nword, Whimsun bursts into\ntears and runs away.")
	c_wait_dialogue()
	c_var(id,["spared",true])
})

time = random_range(0,120)

wont_die = false;
c = random_range(-100,100);
image_index = irandom(image_number)
speech_bubble.y -= 20;