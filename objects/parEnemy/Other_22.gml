/// @description HURT
create_damage_text();
receive_damage();
c_shake(id,(hp_previous-hp)/2,0,1.5);
c_custom(function() {
	var t = instance_exists(obj_damageTxt) ? obj_damageTxt.state == "end" : true
	if (t && !shake_exists(creator.id) && !tween_exists($"{creator.id}:hpTween")) {
		end_action()
	};
})

c_wait(.5);
c_instance_destroy(obj_damageTxt)