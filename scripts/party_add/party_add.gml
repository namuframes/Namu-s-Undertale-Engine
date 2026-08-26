function party_add(instance=object_index,ignore_contain=false){
	if (!array_contains(global.party,instance) || ignore_contain) {
		array_push(global.party,instance);
		follow_index=array_length(global.party)*10
	}
}