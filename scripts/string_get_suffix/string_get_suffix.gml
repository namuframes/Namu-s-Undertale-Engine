function string_get_suffix(_str,pos=undefined) {
	var parts = string_split(_str, "_");
	
	if (array_length(parts) <= 1) return "";
	
	var last = is_real(pos) ? parts[pos] : array_last(parts);
	var result = "";
	for (var i = 1; i <= string_length(last); i++) {
		var c = string_char_at(last, i);
		if (c >= "0" && c <= "9") break;
		result += c;
	}
	
	return result;
}