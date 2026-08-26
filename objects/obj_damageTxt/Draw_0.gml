draw_set_font(fnt_hachiro); draw_set_halign(fa_middle); draw_set_valign(fa_center);
draw_text_transformed_colour(x,y,text,image_xscale*4,image_yscale*4,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha);
draw_set_font(-1); draw_set_halign(fa_left); draw_set_valign(fa_left);