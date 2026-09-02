
var q = 6;
alarm[0] = q;
if (!proceed) {exit}


var box = obj_bulletBorder
var space = (sprite_get_width(spr_soul)+sprite_get_width(spr_bButterfly))

t+= (q*.1)*DELTA()
pointx = sin(t)
var t_x = box.x+25*pointx
instance_create_depth(t_x-space,box.y+80,0,obj_bullet_butterfly)
instance_create_depth(t_x+space,box.y+80,0,obj_bullet_butterfly)
with(obj_bullet_butterfly) {
	image_angle = 90;
	vspeed = -3;
	if (bbox_bottom < box.bbox_top) {instance_destroy();}
}