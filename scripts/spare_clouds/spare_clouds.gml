function spare_clouds(amount_min, amount_max=amount_min){
	var amount = irandom_range(amount_min,amount_max)
	for (var n = 0; n < amount; n += 1) {
		var r_x = random_range(-sprite_width,sprite_width)  *0.1
		var r_y = random_range(-sprite_height,sprite_height)*0.1
		var i = instance_create_depth((bbox_left+sprite_width/2)+r_x,(bbox_top+sprite_height/2)+r_y, depth-1, obj_spare_cloud);
		i.direction = ((360/amount)*n)
	}
}