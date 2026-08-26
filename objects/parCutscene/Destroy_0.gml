if (array_length(my_box) > 0) {
	for(var i = 0; i < array_length(my_box); i++) {
		instance_destroy(my_box[i])	
	}
}

//show_message("I was destroyed!")