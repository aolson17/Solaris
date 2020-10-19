

if room != rm_builder || obj_builder.moving != id{
	// Room has already been placed
	if prev_moving = true{
		// Room was just placed
		
		
		update_paths = true
		
		if sections_wide > 2{
			for (var i = 1; i < sections_wide; i++){
				internals[i-1] = noone
			}
		}
		
		floor_x_l = x+10
		floor_x_r = x+sections_wide*section_size-10
		floor_y = y+(sections_tall+1.2)*section_size
	}
	#region Set up pathfinding lists
	if update_paths{
		update_paths = false
		// Figure out paths and determine if there should be floor elevators for all rooms
		
		with(obj_room){
			
			ds_list_clear(paths)
			//ds_list_clear(paths_elevator)
			ds_list_clear(paths_elevator_l)
			ds_list_clear(paths_elevator_r)
			
			with(obj_room){
				if id != other.id && id != obj_builder.moving{
					var adj_x = other.x/section_size // The position of the room being updated now
					var adj_y = other.y/section_size
				
					var this_adj_x = x/section_size // The position of another room possibly connecting
					var this_adj_y = y/section_size
				
					room_side = "none" // Which list to add the room to for side elevators or "none" if not applicable
				
					// Check if the updating room is horizontally next to this room
					if adj_x + other.sections_wide = this_adj_x{
						// Updating room is to the left of this room
						room_side = "right"
					}else if adj_x = this_adj_x + sections_wide{
						// Updating room is to the right of this room
						room_side = "left"
					}
				
					if room_side != "none"{
						if adj_y + (other.sections_tall-2) = this_adj_y + (sections_tall-2){
							// If the floors are at the same height
							ds_list_add(other.paths,id)
						}else{
							if adj_y + (other.sections_tall-2) < this_adj_y + (sections_tall-2){
								// If this room is below the updating room
								if adj_y + (other.sections_tall-2) >= this_adj_y{
									// If this room reaches the other room
									if room_side = "left"{
										ds_list_add(other.paths_elevator_l,id)
										//show_message("added to the left 1")
									}else{
										ds_list_add(other.paths_elevator_r,id)
										//show_message("added to the right 1")
									}
								}
							}else{
								// If this room is above the updating room
								if this_adj_y + (sections_tall-2) >= adj_y{
									// If the other room reaches this room
									if room_side = "left"{
										ds_list_add(other.paths_elevator_l,id)
										//show_message("added to the left 2")
									}else{
										ds_list_add(other.paths_elevator_r,id)
										//show_message("added to the right 2")
									}
								}
							}
						}
					}
				}
			}
			// Add all of the paths into one paths_all list
			ds_list_clear(paths_all)
			for(var i = 0; i < ds_list_size(paths); i++){
				ds_list_add(paths_all,paths[|i])
			}
			for(var i = 0; i < ds_list_size(paths_elevator_l); i++){
				ds_list_add(paths_all,paths_elevator_l[|i])
			}
			for(var i = 0; i < ds_list_size(paths_elevator_r); i++){
				ds_list_add(paths_all,paths_elevator_r[|i])
			}
		}
	}
	#endregion
}

if room = rm_builder{
	prev_moving = (obj_builder.moving = id)
}
