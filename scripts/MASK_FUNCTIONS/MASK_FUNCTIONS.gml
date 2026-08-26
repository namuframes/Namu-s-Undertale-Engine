// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function draw_set_mask(render_target,alphatestref=127){
	gpu_set_stencil_enable(true);
	draw_clear_stencil(0);
	gpu_set_stencil_ref(render_target);
	gpu_set_stencil_func(cmpfunc_always)
	gpu_set_stencil_pass(stencilop_replace)

	gpu_set_colourwriteenable(0,0,0,0);
	gpu_set_alphatestenable(true)
	gpu_set_alphatestref(alphatestref)
}

function draw_reset_mask(){
	gpu_set_colourwriteenable(1,1,1,1);
	gpu_set_alphatestenable(false)
}

function draw_on_mask(){
	gpu_set_stencil_func(cmpfunc_equal)
}

function draw_not_on_mask(){
	gpu_set_stencil_enable(false);
}