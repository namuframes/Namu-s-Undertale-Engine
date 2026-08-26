addscene(function() {
	c_dialogue("* This shop is bugged since it isn't set to anything, open it?")
	c_question("Yes", function() {
		create_shop()	
	})
	c_question("No")
})