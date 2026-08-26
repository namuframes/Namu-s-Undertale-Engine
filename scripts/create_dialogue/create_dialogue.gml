function create_dialogue(dialogue, _target=id,_creator=id, offx=undefined, offy=undefined){
	var box = -1
	var txt = is_array(dialogue) ? dialogue : [dialogue]

	with (obj_txtbox) {
		var match = true;
		for (var i = 0; i < array_length(txt); i++) {
			if (text[i] != txt[i] || target != _target) {match = false break;}
		}
		if (match) {box = id;}
	}

	if (box = -1) {
		box = instance_create_depth(0,0,0,obj_txtbox);
		box.target = _target;
		box.creator = _creator;
		
		if (is_numeric(offx)) {box.x = offx}
		if (is_numeric(offy)) {box.y = offy}
		
		box.text = txt;
	}

	return box;
}