if (instance_exists(creator)) {
	if (creator == obj_shopManager || object_get_parent(creator.object_index) == parShopKeeper) {type = BOX_TYPE.shop}
}