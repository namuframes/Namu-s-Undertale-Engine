surf      = -1;
vb        = -1;
vf        = -1;
surf_buff = -1;   // backup of the (cropped) surface pixels, used to restore it if it gets lost
t         = 0;

// Defaults = the original values. Anything passed in the creation struct wins.
var _d = {
	size: 2, scale: 1, 
	spd_mul: 0.5,
	velx_max: 2,
	vely_min: -8, vely_max: -4, 
	smh_max: 1,
	alpha_loss: 0.025, 
	vely_add: 0.5, 
	rise_mul: 0.1, 
	smh_lerp: 0.1, 
	size_loss: 0.01
};
var _n = variable_struct_get_names(_d);
for (var k = 0; k < array_length(_n); k++) {
    if (!variable_instance_exists(id, _n[k])) {
		variable_instance_set(id, _n[k], variable_struct_get(_d, _n[k]));
    }
}

if (!variable_instance_exists(id, "src_surf") || !surface_exists(src_surf)) {
	instance_destroy();
	exit;
}

// Cache uniforms
u_time = shader_get_uniform(sh_evaporate, "u_time");
u_siz  = shader_get_uniform(sh_evaporate, "u_size");
u_spd  = shader_get_uniform(sh_evaporate, "u_spd");
u_orig = shader_get_uniform(sh_evaporate, "u_origin");
u_ssz  = shader_get_uniform(sh_evaporate, "u_surfSize");
u_al   = shader_get_uniform(sh_evaporate, "u_alphaLoss");
u_va   = shader_get_uniform(sh_evaporate, "u_velyAdd");
u_ri   = shader_get_uniform(sh_evaporate, "u_rise");
u_sl   = shader_get_uniform(sh_evaporate, "u_smhLerp");
u_sz   = shader_get_uniform(sh_evaporate, "u_sizeLoss");

// ---- Working copy at the final scale (skipped when scale == 1) ----
var w = ceil(surface_get_width(src_surf)  * scale);
var h = ceil(surface_get_height(src_surf) * scale);
var _tmp = src_surf;
if (scale != 1) {
	_tmp = surface_create(w, h);
	surface_set_target(_tmp);
	draw_clear_alpha(c_black, 0);
	gpu_set_blendenable(false);
	draw_surface_ext(src_surf, 0, 0, scale, scale, 0, c_white, 1);
	gpu_set_blendenable(true);
	surface_reset_target();
}

// ---- Scan: collect visible blocks + their bounding box ----
var full = buffer_create(w * h * 4, buffer_fixed, 1);
buffer_get_surface(full, _tmp, 0);

var blocks = [];   // x, y pairs of visible blocks, row-major (the original order)
var minx = w, miny = h, maxx = 0, maxy = 0;
for (var yy = 0; yy < h; yy += size) {
	for (var xx = 0; xx < w; xx += size) {
		var _visible = false;
		for (var j = 0; j < size && !_visible; j++) {
			for (var i = 0; i < size; i++) {
				if (xx + i < w && yy + j < h
				 && buffer_peek(full, ((yy + j) * w + xx + i) * 4 + 3, buffer_u8) > 0) {
					_visible = true;
					break;
				}
			}
		}
		if (_visible) {
			array_push(blocks, xx, yy);
			minx = min(minx, xx);       miny = min(miny, yy);
			maxx = max(maxx, xx + size); maxy = max(maxy, yy + size);
		}
	}
}
buffer_delete(full);

var count = array_length(blocks) div 2;
if (count == 0) {   // nothing visible
	if (_tmp != src_surf) surface_free(_tmp);
	instance_destroy();
	exit;
}

// ---- Crop the surface to the visible area (minx/miny are multiples of size, so the grid is unchanged) ----
var cw = min(maxx, w) - minx;
var ch = min(maxy, h) - miny;
surf_w = cw;
surf_h = ch;
spd = ch * spd_mul;

surf = surface_create(cw, ch);
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
gpu_set_blendenable(false);
draw_surface_part(_tmp, minx, miny, cw, ch, 0, 0);
gpu_set_blendenable(true);
surface_reset_target();
if (_tmp != src_surf) surface_free(_tmp);

// Move the instance so the effect plays in the same place as the uncropped surface
x += minx;
y += miny;

// Backup of the cropped pixels, used to restore the surface if it gets lost
surf_buff = buffer_create(cw * ch * 4, buffer_fixed, 1);
buffer_get_surface(surf_buff, surf, 0);

// ---- Vertex buffer: only visible blocks, index = order among visible blocks ----
// Vertex format: block origin | corner (0/1) | velx, vely, smh, index
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_custom(vertex_type_float4, vertex_usage_texcoord);
vf = vertex_format_end();

vb = vertex_create_buffer();
vertex_begin(vb, vf);

var _v = function(_vb, _px, _py, _cx, _cy, _vx, _vy, _sm, _i) {
	vertex_position(_vb, _px, _py);
	vertex_texcoord(_vb, _cx, _cy);
	vertex_float4(_vb, _vx, _vy, _sm, _i);
};

for (var b = 0; b < count; b++) {
	var bx = blocks[b * 2]     - minx;
	var by = blocks[b * 2 + 1] - miny;
	var vx = irandom_range(-velx_max, velx_max);
	var vy = random_range(vely_min, vely_max);
	var sm = random_range(0, smh_max);
	_v(vb, bx, by, 0, 0, vx, vy, sm, b);
	_v(vb, bx, by, 1, 0, vx, vy, sm, b);
	_v(vb, bx, by, 0, 1, vx, vy, sm, b);
	_v(vb, bx, by, 1, 0, vx, vy, sm, b);
	_v(vb, bx, by, 1, 1, vx, vy, sm, b);
	_v(vb, bx, by, 0, 1, vx, vy, sm, b);
}
vertex_end(vb);
vertex_freeze(vb);

var life = ceil(min(1 / alpha_loss, (size_loss > 0) ? size / size_loss : 1000000));
end_time = ceil(max(count - 2, 0) / spd) + life + 1;