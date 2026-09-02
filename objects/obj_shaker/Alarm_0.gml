if (instance_exists(target)) {
	var t =  (time*1.5);
	var loss = ((range*.25)/t)*DELTA();
	if (range_x <= 0 && range_y <= 0) {instance_destroy()}
	with(target) {
		var o = other;
		if (variable_instance_exists(id,"shake_x")) {shake_x = o.range_x*o.val};
		if (variable_instance_exists(id,"shake_y")) {shake_y = o.range_y*o.val};
	};
	range_x -= loss;	range_y -= loss;
	range_x = clamp(range_x,0,infinity);	range_y = clamp(range_y,0,infinity);
	val = -val;
	alarm[0] = t;
} else {instance_destroy(id,false)};