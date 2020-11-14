function scr_update_elevator_options() {


		
	var index_x = rm.index_x
	var index_y = rm.index_y

	ds_list_clear(options)

	for (var j = 0; j < rm.ship.max_size; j++){ // Check each row to see if there is another elevator to go to
		if j != index_y{
			var other_rm = ds_grid_get(rm.ship.ship,index_x,j)
		
			if other_rm != 0{ // If there is a room on this row obove this object's room
				if object_is_ancestor(other_rm.object_index,par_module_room){
					if other_rm.module[module_pos] != noone{
						if other_rm.module[module_pos].object_index = object_index{ // If there is an elevator in the correct module position
							ds_list_add(options,other_rm.module[module_pos])
						}
					}
				}
			}	
		}
	}




}
