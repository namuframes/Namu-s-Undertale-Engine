var _w = sprite_width/col_sw;
var _h = sprite_height/col_sh;
var _l = -sprite_xoffset;
var _t = -sprite_yoffset;

var _c = dcos(image_angle);
var _s = dsin(image_angle);

var _rx = _l + sprite_width-thickness;
var _by = _t + sprite_height-thickness;
wall_set(collisions[left], _l, _t, col_tick, _h,x, y, _c, _s, image_angle);
wall_set(collisions[top], _l,_t,_w,col_tick,x, y, _c, _s, image_angle);
wall_set(collisions[right], _rx, _t, col_tick, _h, x, y, _c, _s, image_angle);
wall_set(collisions[bottom], _l, _by, _w, col_tick, x, y, _c, _s, image_angle);