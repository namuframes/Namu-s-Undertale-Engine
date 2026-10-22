if (!surface_exists(surf)) {
    surf = surface_create(surf_w, surf_h);
    buffer_set_surface(surf_buff, surf, 0);
}

var _f = gpu_get_tex_filter();
gpu_set_tex_filter(false);

shader_set(sh_evaporate);
shader_set_uniform_f(u_time, t);
shader_set_uniform_f(u_siz, size);
shader_set_uniform_f(u_spd, spd);
shader_set_uniform_f(u_orig, x, y);
shader_set_uniform_f(u_ssz, surf_w, surf_h);
shader_set_uniform_f(u_al, alpha_loss);
shader_set_uniform_f(u_va, vely_add);
shader_set_uniform_f(u_ri, rise_mul);
shader_set_uniform_f(u_sl, smh_lerp);
shader_set_uniform_f(u_sz, size_loss);
vertex_submit(vb, pr_trianglelist, surface_get_texture(surf));
shader_reset();

gpu_set_tex_filter(_f);