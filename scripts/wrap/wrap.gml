//This is an type of clamp, but, like
//It just makes the value return to minium of max when he surpasses
//the limit or minimun
function wrap(variable,_min,_max){
	if (variable < _min) {variable = _max};
	if (variable > _max) {variable = _min};
	return variable
}