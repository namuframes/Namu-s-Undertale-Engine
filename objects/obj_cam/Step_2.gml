view = view_camera[view_current];
var w = width/(zoom+offzoom);
var h = height/(zoom+offzoom);

if (instance_exists(target)) {update_pos(target.x,target.y)} else {limit_camera()};
final_x = lerp(final_x,x+offx+shake_x,1);
final_y = lerp(final_y,y+offy+shake_y,1);
camera_set_view_pos(view_camera[0],(final_x-w/2),(final_y-h/2));
camera_set_view_size(view_camera[0],w,h);