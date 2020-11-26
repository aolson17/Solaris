



if instance_number(obj_room) > 0{
	with(pos_room(global.unrotated_mouse_x,global.unrotated_mouse_y)){
		other.floor_mouse_x = global.unrotated_mouse_x
		other.floor_mouse_y = clamp(global.unrotated_mouse_y,y+(sections_tall)*section_size,y+(sections_tall+2)*section_size)
	}
}else{
	floor_mouse_x = global.unrotated_mouse_x
	floor_mouse_y = global.unrotated_mouse_y
}



if keyboard_check_pressed(ord("C")){
	var new_crew = instance_create_layer(floor_mouse_x,floor_mouse_y,"Instances",obj_crew)
	new_crew.my_ship = instance_nearest(x,y,obj_ship)
	new_crew.current_ship = new_crew.my_ship
	ds_list_add(new_crew.current_ship.ship_crew,new_crew)
}

if keyboard_check_pressed(ord("V")){
	with(obj_crew){
		
		ds_list_delete(current_ship.ship_crew,ds_list_find_index(current_ship.ship_crew,id))
		
		instance_destroy()
	}
}


if move_order{ // Giving move order
	for (var i = 0; i < ds_list_size(selected_crew); ++i){
		with (selected_crew[|i]){
			#region Clear previous orders unless there is elevator use
			if !ds_list_empty(orders){
				// Clear orders after any sort of elevator use
				var clear_after_index = 0
				var stage = orders[|0].elevator_stage
				while(stage != elevator_stages.none){
					clear_after_index++
					if clear_after_index = ds_list_size(orders){
						break
					}
					stage = orders[|clear_after_index].elevator_stage
				}
				
				while(ds_list_size(orders)>clear_after_index){
					ds_list_delete(orders,clear_after_index)
				}
				// Check if the list ended up being cleared. Happens when there are no immediate orders that have elevator use
				if !ds_list_empty(orders){
					// Consider the room to start the new orders from to be after the existing orders
					var my_room = pos_room(orders[|ds_list_size(orders)-1].x+current_ship.x,orders[|ds_list_size(orders)-1].y+current_ship.y)
				}else{ // If the list was cleared
					var my_room = pos_room(x,y)
				}
			}else{
				// No existing orders
				my_room = pos_room(x,y)
			}
			#endregion
			
			if my_room != noone{
				target_room = pos_room(global.unrotated_mouse_x,global.unrotated_mouse_y)
				if target_room != noone{
					target_x = other.floor_mouse_x
					target_y = other.floor_mouse_y
					ds_list_clear(room_path)
					find_room_path_bfs(my_room,target_room)
					// Go through room_path and give an order for each point to move between
					for(var j = ds_list_size(room_path)-1; j >= 0;j--){
						var current_room = room_path[|j]
						
						if j = 0{ // If there are no more rooms to go to
							// Just go to the target spot
							var new_move_order = new order(target_x-current_ship.x,target_y-current_ship.y,noone,false)
							//show_debug_message("final order at room "+string(pos_room(target_x,target_y)))
							ds_list_add(orders,new_move_order)
						}else{ // If there are more rooms to go to
							var current_next_room = room_path[|j-1]
							
							// If there have been no orders or the last order will bring the crew member to the floor height for this room
							// Don't do this when not brought to this floor height because it might have skipped going all the way down the elevator and got off early into the next room
							if ds_list_size(orders) = 0 || orders[|ds_list_size(orders)-1].y+current_ship.y = current_room.floor_y{
								// Move to edge of current room floor toward the side of the next room
								if current_room.x < current_next_room.x{
									var next_path_x = current_room.floor_x_r
								}else{
									var next_path_x = current_room.floor_x_l
								}
								var next_path_y = current_room.floor_y
							
								var new_move_order = new order(next_path_x-current_ship.x,next_path_y-current_ship.y,noone,false)
								//show_debug_message("move to edge of current room at "+string(pos_room(next_path_x,next_path_y)))
								ds_list_add(orders,new_move_order)
							}
							
							// Enter to the side of the next room
							
							if ds_list_find_index(current_room.paths,current_next_room) != -1{ // If you can walk to the following room
								// Go to the next room horizontally
								if current_room.x < current_next_room.x{
									var next_path_x = current_next_room.floor_x_l
								}else{
									var next_path_x = current_next_room.floor_x_r
								}
								// But either room vertically, it does not matter if no elevator is necessary
								var next_path_y = current_room.floor_y // floor_y should be the same in both rooms
								
								var new_move_order = new order(next_path_x-current_ship.x,next_path_y-current_ship.y,noone,false)
								//show_debug_message("walk into room "+string(pos_room(next_path_x,next_path_y)))
								ds_list_add(orders,new_move_order)
							}else{ // If you must take an elevator
								
								if current_room.floor_y > current_next_room.floor_y{ // If crew must take elevator up
									// Go up the elevator
									
									// Stay in this room horizontally
									if current_room.x < current_next_room.x{
										var next_path_x = current_room.floor_x_r
									}else{
										var next_path_x = current_room.floor_x_l
									}
									// But the next room vertically
									var next_path_y = current_next_room.floor_y
									
									var new_move_order = new order(next_path_x-current_ship.x,next_path_y-current_ship.y,noone,elevator_stages.in) // In an elevator this time
									//show_debug_message("move up in elevator in room "+string(pos_room(next_path_x,next_path_y)))
									ds_list_add(orders,new_move_order)
									
									// Then move into the next room
									
									// Go to the next room room horizontally
									if current_room.x < current_next_room.x{
										var next_path_x = current_next_room.floor_x_l
									}else{
										var next_path_x = current_next_room.floor_x_r
									}
									// But the next room vertically, which should be what the player is already at after the elevator
									var next_path_y = current_next_room.floor_y
									
									var new_move_order = new order(next_path_x-current_ship.x,next_path_y-current_ship.y,noone,elevator_stages.leave)
									//show_debug_message("move out of elevator into room "+string(pos_room(next_path_x,next_path_y)))
									ds_list_add(orders,new_move_order)
									
									
									
								}else{ // If crew must take the elevator down
									// Move into the next room
									
									// Go to the next room room horizontally
									if current_room.x < current_next_room.x{
										var next_path_x = current_next_room.floor_x_l
									}else{
										var next_path_x = current_next_room.floor_x_r
									}
									// But still this room vertically, because the elevator hasn't been taken yet
									var next_path_y = current_room.floor_y
									
									var new_move_order = new order(next_path_x-current_ship.x,next_path_y-current_ship.y,noone,elevator_stages.enter)
									//show_debug_message("move to elevator in room "+string(pos_room(next_path_x,next_path_y)))
									ds_list_add(orders,new_move_order)
									
									// Then take the elevator down
									
									// Stay in ther next room's elevator horizontally
									if current_room.x < current_next_room.x{
										var next_path_x = current_next_room.floor_x_l
										
										var elevator_side = "left"
									}else{
										var next_path_x = current_next_room.floor_x_r
										
										var elevator_side = "right"
									}
									// But the next room vertically
									var next_path_y = current_next_room.floor_y
									
									// See if this crew should take the elevator directly to the room after the next room
									if j-2 >= 0{ // If there is a room to go to after the next room
										var room_after_next = room_path[|j-2]
										// See if this crew should take the elevator directly there
										if elevator_side = "right"{
											// If the room after next is connected to the next room on the correct side
											if ds_list_find_index(current_next_room.paths_elevator_r,room_after_next) != -1{
												 next_path_y = room_after_next.floor_y
											}
										}else{
											// If the room after next is connected to the next room on the correct side
											if ds_list_find_index(current_next_room.paths_elevator_l,room_after_next) != -1{
												 next_path_y = room_after_next.floor_y
											}
										}
									}
									
									
									
									var new_move_order = new order(next_path_x-current_ship.x,next_path_y-current_ship.y,noone,elevator_stages.in)
									//show_debug_message("Move down in elevator in room "+string(pos_room(next_path_x,next_path_y)))
									ds_list_add(orders,new_move_order)
								}
							}
						}
					}
				}
			}
		}
	}
}

//Likely also decide between a kickstarter and a publisher. I think that we should try publishers first and do this if we can't find a good enough deal.

if mouse_check_button_pressed(mb_left){
	selected_area_x = global.unrotated_mouse_x
	selected_area_y = global.unrotated_mouse_y
}

// If selected an area by hold clicking
if mouse_check_button_released(mb_left) && point_distance(global.unrotated_mouse_x,global.unrotated_mouse_y,selected_area_x,selected_area_y) > selected_area_min{
	ds_list_clear(selected_crew)
	
	// Find the selection area with rotation
	
	// Rotate x and y around the center of the ship
	var rotated_select_x = scr_x_rotated_around_point(selected_area_x,selected_area_y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)
	var rotated_select_y = scr_y_rotated_around_point(selected_area_x,selected_area_y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)
	
	// The scalar projection of b onto a is |b|cos(theta)
	var hypotenuse_dis = point_distance(rotated_select_x,rotated_select_y,mouse_x,mouse_y)
	var hyp_ship_theta = angle_difference(point_direction(rotated_select_x,rotated_select_y,mouse_x,mouse_y),selected_ship.angle)
	var distance_to_other_points = hypotenuse_dis*cos(degtorad(hyp_ship_theta))
	
	
	// Iterate through each crew member
	for (var i = 0; i < instance_number(obj_crew); ++i){
		// TODO check if crew has correct ship to order
		var current_crew = instance_find(obj_crew,i)
		// If this crew member is in the area then add it to selected crew
		
		var x1 = rotated_select_x
		var y1 = rotated_select_y
		var x2 = rotated_select_x+lengthdir_x(distance_to_other_points,selected_ship.angle)
		var y2 = rotated_select_y+lengthdir_y(distance_to_other_points,selected_ship.angle)
		var x3 = mouse_x
		var y3 = mouse_y
		var x4 = mouse_x-lengthdir_x(distance_to_other_points,selected_ship.angle)
		var y4 = mouse_y-lengthdir_y(distance_to_other_points,selected_ship.angle)
		
		// Rotate x and y of crew around the center of the ship
		var adj_x = scr_x_rotated_around_point(current_crew.x,current_crew.y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)
		var adj_y = scr_y_rotated_around_point(current_crew.x,current_crew.y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)
		
		if point_in_triangle(adj_x,adj_y,x1,y1,x2,y2,x3,y3)||point_in_triangle(adj_x,adj_y,x3,y3,x4,y4,x1,y1){
			ds_list_add(selected_crew,current_crew)
		}
	}
	
}

if mouse_check_button_pressed(mb_left){
	
	selected_ship = instance_nearest(mouse_x,mouse_y,obj_ship)
	
}
