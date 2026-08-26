function shader_outline(texture,size=1){
	shader_set(sh_outline);
	var u =  shader_get_uniform(sh_outline,"texelSize")
	//var c =  shader_get_uniform(sh_outline,"color")

	shader_set_uniform_f(u,texture_get_texel_width(texture),texture_get_texel_height(texture))
	//shader_set_uniform_f(c,0,0,0)
}