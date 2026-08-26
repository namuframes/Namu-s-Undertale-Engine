if (!instance_exists(shop)) {exit}
if (asset_get_type(shop.background) == asset_sprite) {draw_sprite(shop.background,0,0,0)}