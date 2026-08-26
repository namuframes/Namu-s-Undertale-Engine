function get_if_top(){
	var vw = view_camera[0]
	var cam_x = camera_get_view_x(vw)
	var cam_y = camera_get_view_y(vw)
	var rec = collision_rectangle(cam_x,cam_y+BASE_HEIGHT*.67,cam_x+BASE_WIDTH,BASE_HEIGHT,obj_player,false,false)
	return !rec
}