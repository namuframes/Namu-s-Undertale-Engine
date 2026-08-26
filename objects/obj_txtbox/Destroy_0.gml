/// @description 
if (instance_exists(target)) {
	if (object_get_parent(target.object_index) == parActor || target.object_index == parActor) {target.talk = false}
}
if (instance_exists(portrait)) {
	instance_destroy(portrait);
};