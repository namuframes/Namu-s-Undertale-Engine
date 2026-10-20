function hex_to_rgb(str) { //By @tales_4rt on Twitter/Youtube
    var _str = string_upper(str);
    if (string_char_at(_str, 1) == "#") _str = string_delete(_str, 1, 1);
    var abc = "0123456789ABCDEF";
    var color = [0, 0, 0];

    for (var i = 0; i < 3; i++) {
        var numb1 = string_char_at(_str, i * 2 + 1);
        var numb2 = string_char_at(_str, i * 2 + 2);

        numb1 = (string_pos(numb1, abc) - 1) * 16;
        numb2 = string_pos(numb2, abc) - 1;

        color[i] = numb1 + numb2;
    }

    return make_colour_rgb(color[0], color[1], color[2]);
}