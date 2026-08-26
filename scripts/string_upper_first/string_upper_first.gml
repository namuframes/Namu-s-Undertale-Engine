function string_upper_first(_string){
	var output = _string;
	var l = string_upper(string_copy(output,1,1))
	output = string_delete(output,1,1)
	output = string_insert(l,output,1)
	return output
}