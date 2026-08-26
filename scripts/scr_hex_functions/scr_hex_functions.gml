function hex_to_rgb(str){ //By @tales_4rt on Twitter/Youtube
	
	var _str = string_upper(string_delete(str, 1, 1));
	var abc = "0123456789ABCDEF";
	
	var color = [0, 0, 0];
	
	var i = 1
	repeat (3){
		var numb1 = string_char_at(_str, i*2);
		var numb2 = string_char_at(_str, i*2+1);

		numb1 = (string_pos(numb1, abc)-1)*16;
		numb2 = string_pos(numb2, abc)-1;
	
		color[i-1] = numb1+numb2
		i++;
	}
	
	return make_colour_rgb(color[0],color[1],color[2]);
}

function hexa_to_rgba(str){
	
	var _str = string_upper(string_delete(str, 1, 1));
	var abc = "0123456789ABCDEF";
	
	var color = [0, 0, 0];
	
	var i = 1
	repeat (3){
		
		var numb1 = string_char_at(_str, i*2);
		var numb2 = string_char_at(_str, i*2+1);

		numb1 = (string_pos(numb1, abc)-1)*16;
		numb2 = string_pos(numb2, abc)-1;
	
		color[i-1] = numb1+numb2
		i++;
	}
	
	return make_colour_rgb(color[0],color[1],color[2]);
}