c_dialogue("");
c_question("Shop (Buggy)",function(){create_shop(parShopKeeper)});
c_question("Encounter",function(){battle_start(0)});
c_question("Fake Encounter",function(){battle_start(0,true,,,,true)});