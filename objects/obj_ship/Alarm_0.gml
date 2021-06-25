/// @description Set up ship stats




for(var i = 0; i < ds_list_size(ship_externals); i++){
	mass += ship_externals[|i].mass
	
	if object_is_ancestor(ship_externals[|i].object_index,par_thruster){
		thrust_up += ship_externals[|i].thrust_up
		thrust_down += ship_externals[|i].thrust_down
		thrust_left += ship_externals[|i].thrust_left
		thrust_right += ship_externals[|i].thrust_right
	}
}
for(var i = 0; i < ds_list_size(hull_chunks); i++){
	var this_chunk = hull_chunks[|i]
	var material = this_chunk.material
	var mat_mass = global.materials[material][mat_data.mass]
	var chunk_mass = mat_mass*this_chunk.w*this_chunk.h
	if this_chunk.shape = shapes.rectangle{
		mass += chunk_mass
	}else{
		mass += chunk_mass/2
	}
}


#region Set up floor grids

if ds_list_size(ship_rooms) > 0{
	
	// Mark rooms as unvisited
	for(var i = 0; i < ds_list_size(ship_rooms);i++){
		ship_rooms[|i].visited = false
	}
	
	#region Helper methods
	
	function add_connected_floors(_connected_rooms, _y, _index){
		var c_room = ship_rooms[|_index] // The current room to search from
		// Position of the current floor
		var left_x = c_room.x
		var right_x = c_room.x+c_room.sections_wide*section_size
		
		// Look through other rooms and see if they connect
		for(var i = 0; i < ds_list_size(ship_rooms);i++){
			var other_room = ship_rooms[|i]
			if !other_room.visited{
				if other_room.y+other_room.sections_tall*section_size-y = _y{
					// This other room is the correct height
					var other_left_x = other_room.x
					var other_right_x = other_room.x+other_room.sections_wide*section_size
				
					// Check if the current room is horizontally next to this other room
					if right_x = other_left_x || left_x = other_right_x{
						// If it is then add it to the current list of contiguous rooms
						ds_list_add(_connected_rooms,ship_rooms[|i])
						other_room.visited = true // Set visited so this room is not added to any other grids
						add_connected_floors(_connected_rooms,_y, i)
					}
				}
			}
		}
	}
	
	function create_floor_grid_from_list(_list){
		// Find the dimensions of the grid by going through all rooms in the given list
		var ship_floor_x1 = 999999 // The bounds of the floor area across the whole ship in pixels relative to the ship
		var ship_floor_y1 = 999999
		var ship_floor_x2 = -999
		var ship_floor_y2 = -999
		for(var i = 0; i < ds_list_size(_list);i++){
			// Relative bounds of this room relative to the ship
			var this_room_x1 = _list[|i].x-x
			var this_room_y1 = _list[|i].y+_list[|i].sections_tall*section_size-y
			var this_room_x2 = this_room_x1+_list[|i].sections_wide*section_size
			var this_room_y2 = this_room_y1+2*section_size
	
			if this_room_x1 < ship_floor_x1{
				ship_floor_x1 = this_room_x1
			}
			if this_room_y1 < ship_floor_y1{
				ship_floor_y1 = this_room_y1
			}
			if this_room_x2 > ship_floor_x2{
				ship_floor_x2 = this_room_x2
			}
			if this_room_y2 > ship_floor_y2{
				ship_floor_y2 = this_room_y2
			}
		}

		var ship_floor_w = ceil(((ship_floor_x2-ship_floor_x1)/section_size)*(section_size/floor_size)) // How wide the floor grid is
		var ship_floor_h = ceil(((ship_floor_y2-ship_floor_y1)/section_size)*(section_size/floor_size)) // How tall the floor grid is

		var ship_floor = ds_grid_create(ship_floor_w,ship_floor_h) // A grid across the ship to manage walkable cells on the floor
		
		ds_grid_clear(ship_floor, floor_types.empty)
		
		// TODO add walls based on collisions
		
		// For testing, make props impassable
		for(var i = 0; i < ds_list_size(ship_props);i++){
			
			if point_in_rectangle(ship_props[|i].x-x,ship_props[|i].y-y,ship_floor_x1,ship_floor_y1,ship_floor_x2,ship_floor_y2){
				
				var x1 = floor((ship_props[|i].bbox_left-x-ship_floor_x1)/floor_size)
				var y1 = floor((ship_props[|i].bbox_top-y-ship_floor_y1)/floor_size)
				var x2 = floor((ship_props[|i].bbox_right-x-ship_floor_x1)/floor_size)
				var y2 = floor((ship_props[|i].bbox_bottom-y-ship_floor_y1)/floor_size)
				
				ds_grid_set_region(ship_floor,x1,y1,x2,y2,floor_types.wall)
			}
		}
		
		return new floor_grid(ship_floor_x1,ship_floor_y1,ship_floor)
	}
	
	#endregion
	
	// Go through unvisited rooms and create a grid for all connecting rooms
	for(var i = 0; i < ds_list_size(ship_rooms);i++){
		if !ship_rooms[|i].visited{
			connected_rooms = ds_list_create()
			ds_list_add(connected_rooms,ship_rooms[|i]) // List of all rooms connected to ship_rooms[|i]
			ship_rooms[|i].visited = true
			
			var floor_y = ship_rooms[|i].y+ship_rooms[|i].sections_tall*section_size-y // Height of the top of the floor relative to ship
			
			// Fill the list of connected rooms
			add_connected_floors(connected_rooms,floor_y, i)
			
			// Make the grid and add it to the list of floor grids
			ds_list_add(floor_grids,create_floor_grid_from_list(connected_rooms))
			
			ds_list_destroy(connected_rooms)
		}
	}
	
	// Set up elevators and their destinations for their floor_grid
	
	// First go through elevators and see if there is a valid destination elevator
	for(var i = 0; i < ds_list_size(ship_internals);i++){
		var this_internal = ship_internals[|i]
		if this_internal.object_index = obj_elevator{
			// Found an elevator, now find the floor_grid it's on
			var this_floor_grid = scr_get_floor_grid(this_internal.x,this_internal.y+1,id)
			// Look through other elevators
			for(var j = 0; j < ds_list_size(ship_internals);j++){
				var other_internal = ship_internals[|j]
				if other_internal != this_internal && this_internal.object_index = obj_elevator{
						
					if other_internal.x = this_internal.x{
						// Should be a valid destination above or below this_internal elevator
							
						var other_floor_grid = scr_get_floor_grid(other_internal.x,other_internal.y+1,id)
						
						this_floor_grid.add_dest(other_floor_grid,this_internal)
						
					}
						
						
				}
			}
		}
	}
}


#endregion

