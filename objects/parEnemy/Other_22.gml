/// @description HURT
create_damage_text();
if (is_numeric(damage_taken)) {hp -= damage_taken;}
c_shake(id,"x",hp_previous-hp,2);
c_custom(function() {
	if (obj_damageTxt.state = "end" && !instance_exists(obj_shaker)) {end_action()};
})
c_wait(.5);
c_destroy(obj_damageTxt)