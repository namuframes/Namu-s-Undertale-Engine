function evaporate(target){
	var i = instance_create_depth(x,y,depth-1,obj_evaporator, {target: target})
	with(i) {event_perform(ev_create,0)}
	return i
}