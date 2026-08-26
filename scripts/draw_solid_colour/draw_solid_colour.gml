// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function draw_solid_colour(colour=draw_get_colour(),alpha=draw_get_alpha()){
	shader_set(shader_solid_color)
	var r = colour_get_red(colour)/255
	var g = colour_get_green(colour)/255
	var b = colour_get_blue(colour)/255
	shader_set_uniform_f(shader_get_uniform(shader_solid_color,"uv_color"),r,g,b,alpha)
}