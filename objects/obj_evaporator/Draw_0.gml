if (target == undefined) {exit}
if (surface_exists(surf)) {
    for (var i = 0; i < array_length(pixels); i++) {
        var p = pixels[i];
        draw_surface_part_ext(
            surf,
            p.x, p.y, size+p.offsize, size+p.offsize,
            p.ox + p.x + p.offx,
            p.oy + p.y + p.offy,
            1, 1,
            c_white,
            p.alpha
        );
    }
    draw_set_alpha(1);
}