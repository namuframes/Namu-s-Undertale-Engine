step_calculate = function(step_amount, _population, rand_range) {
    var populationfactor;
	var kills=region_get_kill();
    if ((_population - kills) > 0) {
		populationfactor = _population / (_population - kills);
		populationfactor = clamp(populationfactor, 1, 8);
		
		step_required = (step_amount + irandom(rand_range)) * populationfactor;
    }
	step_required = ceil(step_required)
}

encounter_add = function(value) {
	array_push(encounters,value)
}

step_required=1
steps = 0
step_calculate(step_amount,population,step_random);

encounters = array_create(0);
