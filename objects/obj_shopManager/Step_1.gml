check_custenceCommands("cutscene")
if (!instance_exists(shop)) {instance_create_depth(0,0,depth-1,shop)};

in_cutscene = (instance_exists(cutscene) || instance_exists(shop.cutscene))
if (in_cutscene) {set_page("cutscene",false)}

speech = shop.speech;
storage = shop.storage;
options = shop.options;
talk = shop.talk;