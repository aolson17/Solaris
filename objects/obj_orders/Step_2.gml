


// Create crew assigned to selected ship
if keyboard_check_pressed(ord("C")){
	var new_crew = instance_create_layer(mouse_x,mouse_y,"Instances",obj_crew)
	new_crew.my_ship = selected_ship
	new_crew.current_ship = new_crew.my_ship
	ds_list_add(new_crew.current_ship.ship_crew,new_crew)
}

// Delete all crew
if keyboard_check_pressed(ord("V")){
	with(obj_crew){
		
		ds_list_delete(current_ship.ship_crew,ds_list_find_index(current_ship.ship_crew,id))
		
		instance_destroy()
	}
}

#region Give orders to selected crew

// Add new move orders to queue
if move_order{ // Giving move order
	for (var i = 0; i < ds_list_size(selected_crew); ++i){
		ds_queue_enqueue(move_queue, new queued_move(selected_crew[|i],mouse_x,mouse_y,selected_ship))
	}
}

// Calculate move orders in queue
if !ds_queue_empty(move_queue){
	var this_queued_move = ds_queue_dequeue(move_queue)
	
	with (this_queued_move.crew){
			
		var goal_x = this_queued_move.goal_x-current_ship.x
		var goal_y = this_queued_move.goal_y-current_ship.y
			
		var goal_floor_grid_str = scr_get_floor_grid(this_queued_move.goal_x,this_queued_move.goal_y,current_ship)
			
		// Maker sure there is a valid destination
		if goal_floor_grid_str != undefined{
			var new_order = new order(goal_x,goal_y,noone)
			
			// If the goal is on a different floor than there will be multiple steps to reach it
			if my_floor_grid_str != goal_floor_grid_str{
				
				var path_info = find_floor_grid_path(my_floor_grid_str,goal_floor_grid_str,this_queued_move.ship)
					
				// Go through the path info and find each position to move to
				var current_floor = my_floor_grid_str
				for(var j = path_info.floors_count-1; j >= 0; j--){
					var next_floor = path_info.floors[j]
						
					// Find the elevator to the next floor
					// Look through all of the elevators in the current floor and see which one leads to the next floor
					for(var k = 0; k < current_floor.elev_dests_count; k++){
						var elev_dest = current_floor.elev_dests[k].dest
						if elev_dest = next_floor{
							var elevator = current_floor.elev_dests[k].elev
							// Add the location of the elevator leading to the next floor to the order
							new_order.add_step(elevator.x-this_queued_move.ship.x+other.elevator_offset_x,elevator.y-this_queued_move.ship.y+other.elevator_offset_y,move_types.walk)
							// Add the order for actually taking the elevator to the next floor
							new_order.add_step(elevator.x-this_queued_move.ship.x+other.elevator_offset_x,next_floor.y+other.elevator_offset_y,move_types.elevator)
								
							break
						}
					}
					current_floor = next_floor
				}
			}
			
			ds_list_add(orders,new_order)
			
			moving = true
		}
	}
}


#endregion

#region Select Area

if mouse_check_button_pressed(mb_left){
	selected_area_x = mouse_x
	selected_area_y = mouse_y
}

// If selected an area by hold clicking
if mouse_check_button_released(mb_left) && point_distance(mouse_x,mouse_y,selected_area_x,selected_area_y) > selected_area_min{
	ds_list_clear(selected_crew)
	
	// Iterate through each crew member
	for (var i = 0; i < instance_number(obj_crew); ++i){
		var current_crew = instance_find(obj_crew,i)
		
		if current_crew.my_ship = selected_ship{ // If this crew member is crew to the selected ship
			// If this crew member is in the area then add it to selected crew
			
			if mouse_x < selected_area_x{
				var left_x = mouse_x
				var right_x = selected_area_x
			}else{
				var left_x = selected_area_x
				var right_x = mouse_x
			}
			
			if mouse_y < selected_area_y{
				var top_y = mouse_y
				var bottom_y = selected_area_y
			}else{
				var top_y = selected_area_y
				var bottom_y = mouse_y
			}
			
			if point_in_rectangle(current_crew.x,current_crew.y,left_x,top_y,right_x,bottom_y){
				ds_list_add(selected_crew,current_crew)
			}
		}
	}
}

#endregion

// Change selected ship
if keyboard_check_pressed(vk_control){
	var other_ship = instance_nearest(mouse_x,mouse_y,obj_ship)
	if other_ship.faction_index = 0{ // If the other ship is in the Player faction
		selected_ship = other_ship
	}
}
