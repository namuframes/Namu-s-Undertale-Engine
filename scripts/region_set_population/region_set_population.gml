function region_set_population(str,amount){
	str = string_get_suffix(str);
	global.region_population[?str] = amount;
}