collisions[left].image_xscale = scale_to_width(sprite_width);
collisions[up].image_yscale = scale_to_height(sprite_height);
collisions[right].image_xscale = scale_to_width(-sprite_width+thickness);
collisions[down].image_yscale = scale_to_width(-sprite_height+thickness);



var w = sprite_width
var h = sprite_height

// Obter a origem do sprite
var ox = sprite_get_xoffset(sprite_index) * image_xscale;
var oy = sprite_get_yoffset(sprite_index) * image_yscale;

// Posição relativa dos cantos ao ponto de origem
var corners = [
    [ -ox,    -oy ],         // Top-left
    [ -ox+w-thickness,  -oy ],         // Top-right
    [ -ox+w,  -oy+h-thickness ],       // Bottom-right
    [ -ox,    -oy+h ]        // Bottom-left
];

// Rotacionar e desenhar os cantos
if (array_length(collisions) > 0) { 
	for (var i = 0; i < 4; i++) {
		var c = collisions[i]
	    var cx = corners[i][0];
	    var cy = corners[i][1];
	    var dist = point_distance(0, 0, cx, cy);
	    var angle = point_direction(0, 0, cx, cy) + round(image_angle);

	    var px = x + lengthdir_x(dist, angle);
	    var py = y + lengthdir_y(dist, angle);
		c.x = px
		c.y = py
		c.image_angle = image_angle
	}
}
