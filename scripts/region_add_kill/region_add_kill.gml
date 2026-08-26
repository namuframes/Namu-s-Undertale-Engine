function region_add_kill(amount){
	if (ds_map_exists(global.region_kills, global.region)) {
		global.region_kills[?global.region] += real(amount)
	}
}