


depth = -y

if mouse_check_button_released(mb_right) && !using_elevator{
	my_room = pos_room(x,y)
	if my_room != noone{
		target_room = pos_room(mouse_x,mouse_y)
		if target_room != noone{
			target_x = mouse_x
			target_y = clamp(mouse_y,target_room.y+(target_room.sections_tall)*target_room.section_size,target_room.y+(target_room.sections_tall+2)*target_room.section_size)
			find_room_path_bfs(my_room,target_room)
			moving = true
		}
	}
	using_elevator = false // Reset elevator tracker
	used_elevator = false
	needs_elevator = false
	elevator_start_room = noone
	elevator_side = "none"
}


function move_to(_x,_y){
	
	var dir = point_direction(x,y,_x,_y)
	
	if point_distance(x,y,_x,_y) < spd{
		x = _x
		y = _y
	}else{
		x += lengthdir_x(spd,dir)
		y += lengthdir_y(spd,dir)
	}
	
	if !using_elevator{
		if x < _x{
			image_xscale = 1
		}else{
			image_xscale = -1
		}
	}
	
}

if moving{
	my_room = pos_room(x,y)
	next_room = room_path[|ds_list_size(room_path)-1]
	
	if my_room != noone{
		if (my_room = target_room && !needs_elevator) || (my_room = target_room && needs_elevator && used_elevator){
			if point_distance(x,y,target_x,target_y) < 2{
				moving = false
				using_elevator = false // Reset elevator tracker
				used_elevator = false
				needs_elevator = false
				elevator_start_room = noone
				elevator_side = "none"
			}else{
				move_to(target_x,target_y,xspd,yspd)
			}
		}else{
		
			if ds_list_find_index(my_room.paths,next_room) != -1{
				if x < next_room.x{
					next_path_x = next_room.floor_x_l
				}else{
					next_path_x = next_room.floor_x_r
				}
				next_path_y = next_room.floor_y
				elevator_side = "none"
			}else if ds_list_find_index(my_room.paths_elevator_l,next_room) != -1{
				// If the officer must use an elevator on the left
				elevator_side = "left"
			}else if ds_list_find_index(my_room.paths_elevator_r,next_room) != -1{
				// If the officer must use an elevator on the right
				elevator_side = "right"
			}
			
			if elevator_side != "none"{
				// If the officer must use an elevator
				needs_elevator = true
				if elevator_start_room = noone{
					elevator_start_room = my_room
				}
				if elevator_start_room.floor_y < next_room.floor_y{
					// If must use elevator to go down
					if elevator_side = "left"{// Find the elevator position
						next_path_elevator_x = next_room.floor_x_r
					}else{
						next_path_elevator_x = next_room.floor_x_l
					}
				}else{
					// If must use elevator to go up
					if elevator_side = "left"{// Find the elevator position
						next_path_elevator_x = elevator_start_room.floor_x_l
					}else{
						next_path_elevator_x = elevator_start_room.floor_x_r
					}
				}
				next_path_elevator_y = elevator_start_room.floor_y
				
				if !using_elevator && !used_elevator{
					// Has not reached elevator yet
					if point_distance(x,y,next_path_elevator_x,next_path_elevator_y) < 2{
						using_elevator = true // Reached elevator
					}else{
						next_path_x = next_path_elevator_x // Move toward elevator
						next_path_y = next_path_elevator_y
					}
				}else if using_elevator && !used_elevator{
					// Is taking the elevator
					if point_distance(x,y,next_path_elevator_x,next_room.floor_y) < 2{
						used_elevator = true // Reached end of elevator
						using_elevator = false
					}else{
						next_path_x = next_path_elevator_x // Move to end of elevator
						next_path_y = next_room.floor_y
					}
				}else{
					// Is done using the elevator
					// Move to next room
					if elevator_side = "left"{
						next_path_x = next_room.floor_x_r
					}else{
						next_path_x = next_room.floor_x_l
					}
					next_path_y = next_room.floor_y
				}
			}
		
			if (my_room = next_room && !needs_elevator) || (needs_elevator && used_elevator && my_room = next_room){
				ds_list_delete(room_path,ds_list_size(room_path)-1)
				using_elevator = false // Reset elevator tracker
				used_elevator = false
				needs_elevator = false
				elevator_start_room = noone
				elevator_side = "none"
			}else{
				if using_elevator{
					move_to(next_path_x,next_path_y,0,yspd*3)
				}else{
					move_to(next_path_x,next_path_y,xspd,yspd)
				}
			}
		}
	}
}




//show_debug_message("player x " + string(x))
//show_debug_message("player y " + string(y))


