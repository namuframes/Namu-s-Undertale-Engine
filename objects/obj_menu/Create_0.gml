enum menu {
	item,
	status,
	cell,
}

function optionStruct(_name,_type=-1, _selectable=true) constructor {
	type = 	_type;
	name = _name;
	selectable = _selectable;
}
options = []

options[0] = new optionStruct("ITEM",menu.item)
options[1] = new optionStruct("STAT",menu.status)
options[2] = new optionStruct("CELL",menu.cell,false)


update_selectable = function() {
	for(var i = 0; i < array_length(options); i++) {
		switch(options[i].type) {
			case menu.item:
				options[i].selectable = array_length(global.inventory) > 0 
			break;
		}
	}
}

update_selectable();

index = 0;

ui_heart ={
	x: 0,
	y: 0,
}

im_focus = true;
decided = false;