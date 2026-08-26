function heal_player(quantity){
	global.stat.hp += quantity
	global.stat.hp = clamp(global.stat.hp,0,global.stat.hp_max)
}