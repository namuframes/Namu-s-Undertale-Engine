if (!instance_exists(obj_cam)) {
	instance_create_depth(0,0,0,obj_cam);
}
global.region = string_get_suffix(room_get_name(room),1)
if (!ds_map_exists(global.region_kills,global.region)) {
	ds_map_add(global.region_kills,global.region,0)	
}