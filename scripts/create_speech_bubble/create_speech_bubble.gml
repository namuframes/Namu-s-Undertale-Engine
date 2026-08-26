function create_speech_bubble(dialogue, _target=id,_side=-1){
	var box = -1
	var txt = is_array(dialogue) ? dialogue : [dialogue]

	if (box = -1) {
		box = instance_create_depth(0,0,0,obj_speech_bubble)
		box.target = _target
		box.side = _side
		box.text = txt;
	}

	return box;
}