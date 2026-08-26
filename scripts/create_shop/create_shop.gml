function create_shop(shop=parShopKeeper){
	if (!instance_exists(obj_shopManager)) {
		var i = instance_create_depth(0,0,0,obj_shopManager)
		i.shop = shop
		return i;
	}
}