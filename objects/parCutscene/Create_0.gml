creator = undefined;
index = 0
moves = [];
variable_instance_set(id,CUTSCENE_VARIABLE,[])


player_nocontrol = false

wait = {
	time: -1,
}

tween_list = array_create(0)
my_box = []

do_action = function() {
	var array = variable_instance_get(id,CUTSCENE_VARIABLE)
	if (index > array_length(array)-1) {
		if (array_length(my_box) <= 0 && array_length(moves) <= 0) {
			instance_destroy()
		}
	} else {
		var action = array[index]
		var agrs = action.args
		script_execute_ext(action.script,action.args,0);
	}
}

moves = [];

do_movement = function() {
	if (array_length(moves) > 0) {
		for (var i = 0; i < array_length(moves); i++) {
			var stru = moves[i];
			stru.target.x = linearVar(stru.target.x,stru.x,stru.speed);
			stru.target.y = linearVar(stru.target.y,stru.y,stru.speed);
			if (stru.auto_sprite) {
				with(stru.target) {
					var hsp = sign(x-xprevious); 
					var vsp = sign(y-yprevious);

					face_forward(hsp,vsp);
					face_at(face);
					image_speed = 1;
				}
			}	
			if (stru.target.x == stru.x && stru.target.y == stru.y) {
				if (stru.auto_sprite) {
					stru.target.image_speed = 0;
					stru.target.image_index = 0;
				}	
				array_delete(moves,i,1)
			}
		}
	}	
}
alarm[0] = 1;