if (array_length(instances) > 0) {
	if (inst_previous != instances) {// If array changed
		for (var i = 0; i < array_length(instances); i++) {
			if (!instance_exists(instances[i])) {array_delete(instances, i, 1)};
		}
		inst_previous = variable_clone(instances);
	}
	
	array_sort(instances, function(c, n) {
		var cb = c.bbox_bottom-layer_get_depth(c.layer)
		var nb = n.bbox_bottom-layer_get_depth(n.layer)
		var res = cb - nb
		if (res == 0) {res = -1}
		return res
	});
	
	for(var i = 0; i < array_length(instances); i++) {
		with(instances[i]) {
			visible = false;
			event_perform(ev_draw,0)
		};
	};
}