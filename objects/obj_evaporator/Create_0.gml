spr = target.sprite_index;
img_index = target.image_index;
fade = 0;	
x = target.x - sprite_get_xoffset(spr)*2
y = target.y - sprite_get_yoffset(spr)*2
target.image_alpha = 0
surf = -1
pixels = [];
peee = 1
var w = sprite_get_width(spr)*2;
var h = sprite_get_height(spr)*2;
size = 2;
spd = h*0.85
if (!surface_exists(surf)) {
	surf = surface_create(w, h);
	// Load sprite into surface
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	var ox = sprite_get_xoffset(spr)*2;
	var oy = sprite_get_yoffset(spr)*2;
	draw_sprite_ext(spr, img_index, ox, oy, 2, 2, 0, c_white, 1);
	surface_reset_target();

	// Create pixel array
	for (var yy = 0; yy < h; yy+=size) {
	    for (var xx = 0; xx < w; xx+=size) {
	        array_push(pixels, {
				ox: x,
				oy: y,
	            x: xx,
	            y: yy,
	            offx: 0,
	            offy: 0,
	            velx: irandom_range(-2,2),
	            vely: random_range(-8,-4),
				alpha: 1,
				smh: random_range(0,1),
				alpha_loss: 0.025,
				offsize: 0
	        });
	    }
	}
}