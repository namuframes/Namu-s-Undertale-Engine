var _num = instance_number(parDepth);
var _grid = grid
ds_grid_resize(_grid,2,_num)
for (var i = 0; i < _num; i++) {
	with(parDepth) {
		if (!exception)	{
			_grid[# 0, i] = id;
			_grid[# 1, i] = bbox_bottom;
			i++;
		}
	}
}
ds_grid_sort(_grid, 1, true);
for (var i = 0; i < ds_grid_height(_grid); i++) {
	var _inst = _grid[# 0, i]
	with (_inst) {event_perform(ev_draw,0)}
}