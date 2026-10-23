/// @description HURT
create_damage_text();
receive_damage();
c_shake(id,(hp_previous-hp)/2,0,1.5);
c_custom(function() {
	if (obj_damageTxt.state = "end" && !shake_exists(creator.id) && !tween_exists($"{creator.id}:hpTween")) {
		end_action()
	};
})

c_wait(.5);
c_instance_destroy(obj_damageTxt)