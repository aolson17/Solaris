

// Find a floor grid at a position in a ship from position in room(not relative to ship)
function scr_get_floor_grid(_x,_y,_ship){
	for(var i = 0; i < ds_list_size(_ship.floor_grids); i++){
		var cur_struct = _ship.floor_grids[|i]
		var cur_grid = cur_struct.grid
		var cur_x = cur_struct.x
		var cur_y = cur_struct.y
		
		if point_in_rectangle(_x-_ship.x,_y-_ship.y,cur_x,cur_y,cur_x+ds_grid_width(cur_grid)*floor_size,cur_y+ds_grid_height(cur_grid)*floor_size){
			return _ship.floor_grids[|i]
		}
	}
	return undefined // If no floor grid was found at the position
}