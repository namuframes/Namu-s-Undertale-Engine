if (abs(angle) >= 360) {angle = 0};
image_xscale = (width+thickness)/sprite_get_width(sprite_index);
image_yscale = (height+thickness)/sprite_get_height(sprite_index);
image_angle = angle;