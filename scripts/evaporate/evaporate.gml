function evaporate(target){
	var i = instance_create_depth(x,y,depth,obj_evaporator, {target})
	with(i) {event_perform(ev_create,0)}
	return i
}