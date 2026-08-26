function do_tween(_object, _tag, _var, _value, _type, _speed, overwrite=true,destroy_method=undefined) {
	var t = noone
	with (obj_tweenHandler) {
	    if (variable_instance_exists(id, string(_tag))) {
			t = id;
		};
	};

	if (variable_instance_get(_object,_var) != _value) {
		static create_tween = function(_object, _tag, _var, _value, _type, _speed, destroy_method=undefined, creator=id) {
			var t = instance_create_depth(0, 0, 0, obj_tweenHandler);
			t.object = _object;
			t.var_name = _var;
			t.end_value = _value;
			t.curve_type = _type;
			t.curve.speed = _speed;
			t.destroy_method = destroy_method;
			t.creator = creator;
		
			t.initialize = true;
			t.creator = id

			variable_instance_set(t, string(_tag), true);
			return t;
		};

	    if (!instance_exists(t)) {
			t = create_tween(_object, _tag, _var, _value, _type, _speed, destroy_method,id);
		} else if (overwrite) {
	        t.object			= _object;
	        t.var_name			= _var;
	        t.end_value			= _value;
	        t.curve_type		= _type;
	        t.curve.speed		= _speed;
			t.destroy_method	= destroy_method;
			t.creator			= id;
		};
		
	};
	return t;
};

function tween_set_value(_tag,_value) {
	with(obj_tweenHandler) {
		if (variable_instance_exists(id,_tag)) {end_value = _value};
	};
};
