function region_get_kill(){
	if (ds_map_exists(global.region_kills, global.region)) {
		return global.region_kills[?global.region]
	}
	return false
}