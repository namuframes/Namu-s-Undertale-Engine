#macro CUTSCENE_VARIABLE "cutsceneActions"
function end_action() {
	wait.time = -1;
	index++;
	do_action()
}

function c_cmd(_argsArray, _script) {
	var command = {
		args: _argsArray,
		script: _script
	}
	while (!variable_instance_exists(id,CUTSCENE_VARIABLE)) {variable_instance_set(id,CUTSCENE_VARIABLE,[])}
	var v = variable_instance_get(id,CUTSCENE_VARIABLE)
	array_push(v, command);
}

function c_custom(_function,_args=[]) {
	c_cmd([_function],function(_function){
		script_execute(_function)
	})
}

function c_bgm_set(bgm,fade_out=undefined,fade_in=undefined) {
	c_cmd([bgm,fade_out,fade_in],function(bgm,fade_out,fade_in) {
		bgm_set(bgm,fade_out,fade_in)
		end_action()
	})	
}

function c_bgm_pause() {
	c_cmd([],function() {
		bgm_pause()
		end_action()
	})	
}

function c_wait_input(_input) {
	c_cmd([_input], function(_input) {
		if (input_pressed(_input)) {end_action()};
	})
};

function c_bgm_resume() {
	c_cmd([],function() {
		bgm_resume()
		end_action()
	})	
}

function c_instance_create(x,y,depth,obj) {
	c_cmd([x,y,depth,obj],function(x,y,depth,obj){
		instance_create_depth(x,y,depth,obj)
		end_action()
	})
}

function c_instance_destroy(instance) {
	c_cmd([instance],function(instance){
		instance_destroy(instance)
		end_action()
	})
}

function c_wait_anim(obj) {
	c_cmd([obj],function(obj){
		if (floor(obj.image_index) >= obj.image_number-1) {end_action()}
	})
}

function c_wait_shake(obj) {
	c_cmd([obj],function(obj){
		if (!shake_exists(obj)) {end_action()};
	})
}

function c_sound(soundid,priority,loops,gain=1,offset=0,pitch=1) {
	c_cmd([soundid,priority,loops,gain,offset,pitch],
	function(soundid,priority,loops,gain,offset,pitch) {
		audio_play_sound(soundid,priority,loops,gain,offset,pitch)
		end_action();
	})
}

function c_tween(obj,tag,_var,value,type,speed) {
	c_cmd([obj,tag,_var,value,type,speed],
	function(obj,tag,_var,value,type,speed) {
		var _tweenInstance = do_tween(obj,tag,_var,value,type,speed)
		array_push(tween_list,_tweenInstance)
		end_action();
	})	
}

function c_destroy(obj) {
	c_cmd([obj],
	function(obj) {
		if (instance_exists(obj)) {instance_destroy(obj)}
		end_action()
	})
}

function c_wait(_time) {
	c_cmd([_time],
	function(_time) {
		if (wait.time <= -1) {wait.time = _time*NATIVE_FPS;}
		if (wait.time <= 0) {end_action()}
	})
}
	
function c_shake(object,x_range,y_range,time) {
	c_cmd([object,x_range,y_range,time],
	function(object,x_range,y_range,time) {
		shake(object,x_range,y_range,time);
		end_action();
	})
}

function c_sprite(obj, sprite, imgSpeed=1, imgIndex=0) {
	c_cmd([obj, sprite, imgSpeed, imgIndex],
	function(obj, sprite, imgSpeed, imgIndex) {
		obj.sprite_index = sprite;	obj.image_speed = imgSpeed;
		obj.image_index = imgIndex
		end_action();
	})
}

function c_face_at(obj, _direction) {
	c_cmd([obj, _direction],
	function(obj, _direction) {
		if (object_get_parent(obj.object_index) == parActor) {
			obj.face = _direction;
			obj.sprite_index = obj.get_sprite(obj.face);
		}
		end_action();
	})
}

function c_canMove(_bool) {
	c_cmd([_bool],
	function(_bool) {
		player_nocontrol = !_bool
		end_action();
	})
}

function c_dialogue(_dia,_target=undefined, _creator=id, offx=undefined, offy=undefined) {
	c_cmd([_dia,_target, _creator, offx, offy], 
	function(_dia,_target,_creator,offx, offy) {
		var bx = create_dialogue(_dia,!instance_exists(_target)  ? creator : _target, !instance_exists(_creator)  ? creator : _creator, offx, offy)
		array_push(my_box,bx);
		end_action()
	})
}

function c_question(_name,_script=function(){}) {
	c_cmd([_name,_script], 
	function(_name,_script) {
		var b = array_last(my_box)
		array_push(b.questions,[_name,_script])
		end_action()
	})
}

function c_speech_bubble(_dialogue,_target=undefined,_side=-1) {
	c_cmd([_dialogue,_target,_side], 
	function(_dialogue,_target,_side) {
		var bx = create_speech_bubble(_dialogue,instance_exists(_target) ? _target : creator, _side)
		array_push(my_box,bx);
		end_action()
	})
}

function c_wait_dialogue() {
	c_cmd([], function() {
		if (array_length(my_box) <= 0) {end_action()}
	})	
}
	
function c_wait_box(number) {
	c_cmd([number], function(number) {
		if (array_length(my_box) > 0) {
			if (array_first(my_box).curtxt == number) {end_action()}
		} else {end_action();}
	})	
}

function c_var(obj,values=[]) {
	c_cmd([obj,values],
	function(obj,values) {
		if (is_array(values[0])) {
			for (var j = 0; j < array_length(values); j++) {
				variable_instance_set(obj,string(values[j][0]),values[j][1])
			}
		} else {variable_instance_set(obj,string(values[0]),values[1])}
		
		end_action();
	})	
}

function c_move(obj,x,y,speed,additive=false,walksprites=false) {
	c_cmd([obj,x,y,speed,additive,walksprites],
		function(obj,x,y,speed,additive,walksprites) {
			var _finalPos = !additive ? {x: x,y: y} : {x: obj.x+x, y: obj.y+y};
			var spd = speed; var varname = "movement-"+string(array_length(moves));
			variable_instance_set(id, varname, {target: obj, x: _finalPos.x, y: _finalPos.y, speed: spd, auto_sprite: walksprites})
			array_push(moves, variable_instance_get(id,varname))
			end_action()
		}
	)
}

function c_wait_move(obj,_pos=1) {
	c_cmd([obj,_pos], function(obj,_pos) {
		if (instance_exists(obj)) {
			var has = false;
			for(var i = 0; i < array_length(moves); i++) {if (moves[i].target == obj) {has = true}}
			if (!has) {end_action()}
		}
	})
}

function c_wait_tween(tag,value=1) {
	c_cmd([tag,value],
	function(tag,value) {
		var instance = noone;
		if (instance_exists(obj_tweenHandler)) {
			with (obj_tweenHandler) {if (variable_instance_exists(id, string(tag))) {instance = id}};
		} else {end_action()}

		if (instance_exists(instance)) {
			var curve_pos = instance.curve.time;
			if (curve_pos >= value) {end_action()}
		}
	})	
}


function c_end() {
	c_cmd([],
	function() {
		instance_destroy()
		end_action()
	})
}