/// @description HURT
create_damage_text();
if (is_numeric(damage_taken)) {hp -= damage_taken;}
c_shake(id,hp_previous-hp,0,1.5);
c_custom(function() {
	if (obj_damageTxt.state = "end" && !shake_exists(id)) {end_action()};
})
c_wait(.5);
c_destroy(obj_damageTxt)