switch(type) {
	case BOX_TYPE.battle:
		depth = obj_battle_box.depth-1
		var _x = obj_battle_control.txt.x
		text_draw(_x,obj_battle_control.txt.y,obj_battle_box.bbox_right-_x)
	break;
}