switch(type) {
	case BOX_TYPE.battle:
		depth = obj_bulletBorder.depth-1
		var _x = obj_battle_control.txt.x
		text_draw(_x,obj_battle_control.txt.y,obj_bulletBorder.bbox_right-_x)
	break;
}