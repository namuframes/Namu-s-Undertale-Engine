function follow_depth(_bool=true,_instance=id){
	with(_instance) {
		var a = obj_depthManager.instances
		if (_bool) {
			if (!array_contains(a,id)) {array_push(a,id)};
		} else {
			if (array_contains(a,id)) {array_delete(a,array_get_index(a,id),1)};	
		}
	}	
}