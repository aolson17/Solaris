///@description Looks at a position in the ship grid and sees if it is another object
///@param target_rm
///@param pos_x
///@param pos_y
///@return success
function scr_find_border_room(argument0, argument1, argument2) {


	var target_rm = argument0
	var pos_x = argument1
	var pos_y = argument2

	var success = false

	if pos_x = clamp(pos_x,0,max_size-1) && pos_y = clamp(pos_y,0,max_size-1){
		// If within max ship area
	
		var neighbor_room = ds_grid_get(ship,pos_x,pos_y)
				
		if neighbor_room != 0{
			if neighbor_room.object_index = target_rm{ // If this neighboring room is what the part needs to border
				success = true
					
			}
		}
	}

	return success


}
