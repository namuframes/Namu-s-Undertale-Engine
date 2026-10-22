if (array_length(instances) > 0) {
	array_sort(instances,function(c,n) {
		var cb = c.bbox_bottom+layer_get_depth(c.layer)
		var nb = n.bbox_bottom+layer_get_depth(n.layer)
		return 	cb - nb
	});
	
	for(var i = 0; i < array_length(instances); i++) {
		with(instances[i]) {
			visible = false;
			event_perform(ev_draw,0)
		};
	};
}