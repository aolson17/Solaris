


///@description Create a new path field and add it to the list

function scr_new_path(_goal_x,_goal_y,_ship){
	
	var target_grid_str = scr_get_floor_grid(_goal_x,_goal_y,_ship)
	
	if target_grid_str != undefined{
		var goal_x = _goal_x-_ship.x // Make the goal relative to the ship
		var goal_y = _goal_y-_ship.y
		
		var cur_x = target_grid_str.x // The top left position of the target floor grid
		var cur_y = target_grid_str.y
		
		// Find top left cell in the target 4 cells. 4 cells in path grid because path grid is half the size of the floor grid
		target_cell_x = floor(floor((goal_x-cur_x)/(floor_size/2))/2)*2
		target_cell_y = floor(floor((goal_y-cur_y)/(floor_size/2))/2)*2
			
		// Path grid is twice the size of the target grid, for smoother pathing and preventing local optima
		var path_grid_w = ds_grid_width(target_grid_str.grid)*2
		var path_grid_h = ds_grid_height(target_grid_str.grid)*2
		var path_grid = ds_grid_create(path_grid_w,path_grid_h)
	
		ds_grid_clear(path_grid,-1)
	
		var queue = ds_queue_create() // Queue of cells to propogate to
			
		// Holds a position in a grid
		function cell(_x,_y) constructor{
			x = _x
			y = _y
		}
			
		path_grid[# target_cell_x,target_cell_y] = new path_field_cell(0,0,0,false)
		path_grid[# target_cell_x+1,target_cell_y] = new path_field_cell(0,0,0,false)
		path_grid[# target_cell_x,target_cell_y+1] = new path_field_cell(0,0,0,false)
		path_grid[# target_cell_x+1,target_cell_y+1] = new path_field_cell(0,0,0,false)
		ds_queue_enqueue(queue,new cell(target_cell_x,target_cell_y))
		ds_queue_enqueue(queue,new cell(target_cell_x+1,target_cell_y))
		ds_queue_enqueue(queue,new cell(target_cell_x,target_cell_y+1))
		ds_queue_enqueue(queue,new cell(target_cell_x+1,target_cell_y+1))
			
		// Set up the next cell if there should be a cell there and add it to the queue
		// Returns struct with whether or not a new cell was made and if not why
		// 0 = Out of grid bounds
		// 1 = Found wall
		// 2 = Found existing cell
		function attempt_cell_queue(_queue,_next_cell,_cur_val,_path_grid_w,_path_grid_h,_path_grid,_target_grid){
			if _next_cell.x >= 0 && _next_cell.x < _path_grid_w && _next_cell.y >= 0 && _next_cell.y < _path_grid_h{
				if _target_grid[# floor(_next_cell.x/2),floor(_next_cell.y/2)] != floor_types.wall{
					if _path_grid[# _next_cell.x,_next_cell.y] = -1{
						ds_queue_enqueue(_queue,_next_cell)
							
						//var has_los_goal = check_los_goal(_next_cell, new cell(target_cell_x,target_cell_y))
							
						_path_grid[# _next_cell.x,_next_cell.y] = new path_field_cell(0,0,_cur_val+1,false)
						return {
							success : true
						}
					}else{
						return {
							success : false,
							fail_reason : 2 // There was an existing cell
						}
					}
				}else{
					return {
						success : false,
						fail_reason : 1 // There was a wall. Means the path cells should start being needed
					}
				}
			}else{
				return {
					success : false,
					fail_reason : 0 // Out of grid bounds
				}
			}
		}
			
		function set_cell_needed(_cell,_path_grid_w,_path_grid_h,_path_grid){
			if _cell.x >= 0 && _cell.x < _path_grid_w && _cell.y >= 0 && _cell.y < _path_grid_h{
				if is_struct(_path_grid[# _cell.x,_cell.y]){
					_path_grid[# _cell.x,_cell.y].needed = true
				}
			}
		}
	
		while(!ds_queue_empty(queue)){
			var cur_cell = ds_queue_dequeue(queue)
			var cur_val = path_grid[# cur_cell.x,cur_cell.y].dis
				
			var needed = false // If pathfinding from this cell is necessary. Becomes necessary when it runs into anything other than empty cells
				
			var set_left = true // Whether or not algorithm expanded from this cell in each direction
			var set_right = true
			var set_up = true
			var set_down = true
				
			var next_cell = new cell(cur_cell.x+1,cur_cell.y)
			var attempt = attempt_cell_queue(queue,next_cell,cur_val,path_grid_w,path_grid_h, path_grid, target_grid_str.grid)
			if !attempt.success{
				set_right = false
				if attempt.fail_reason = 1{
					needed = true
				}
			}
		
			var next_cell = new cell(cur_cell.x-1,cur_cell.y)
			var attempt = attempt_cell_queue(queue,next_cell,cur_val,path_grid_w,path_grid_h, path_grid, target_grid_str.grid)
			if !attempt.success{
				set_left = false
				if attempt.fail_reason = 1{
					needed = true
				}
			}
		
			var next_cell = new cell(cur_cell.x,cur_cell.y+1)
			var attempt = attempt_cell_queue(queue,next_cell,cur_val,path_grid_w,path_grid_h, path_grid, target_grid_str.grid)
			if !attempt.success{
				set_down = false
				if attempt.fail_reason = 1{
					needed = true
				}
			}
		
			var next_cell = new cell(cur_cell.x,cur_cell.y-1)
			var attempt = attempt_cell_queue(queue,next_cell,cur_val,path_grid_w,path_grid_h, path_grid, target_grid_str.grid)
			if !attempt.success{
				set_up = false
				if attempt.fail_reason = 1{
					needed = true
				}
			}
				
			// Begin or propagate being needed
			if needed || path_grid[# cur_cell.x,cur_cell.y].needed{
				//show_message("Needed")
				path_grid[# cur_cell.x,cur_cell.y].needed = true
				if set_left{
					set_cell_needed(new cell(cur_cell.x-1,cur_cell.y),path_grid_w,path_grid_h, path_grid)
				}
				if set_right{
					set_cell_needed(new cell(cur_cell.x+1,cur_cell.y),path_grid_w,path_grid_h, path_grid)
				}
				if set_down{
					set_cell_needed(new cell(cur_cell.x,cur_cell.y+1),path_grid_w,path_grid_h, path_grid)
				}
				if set_up{
					set_cell_needed(new cell(cur_cell.x,cur_cell.y-1),path_grid_w,path_grid_h, path_grid)
				}
			}
		}
			
		// Make path not needed at goal cells
			
		path_grid[# target_cell_x,target_cell_y].needed = false
		path_grid[# target_cell_x+1,target_cell_y].needed = false
		path_grid[# target_cell_x,target_cell_y+1].needed = false
		path_grid[# target_cell_x+1,target_cell_y+1].needed = false
	
		// Calculate vectors
	
		function other_cell_dis(_other_cell,_path_grid_w,_path_grid_h,_path_grid){
			if _other_cell.x >= 0 && _other_cell.x < _path_grid_w && _other_cell.y >= 0 && _other_cell.y < _path_grid_h{
				if _path_grid[# _other_cell.x,_other_cell.y] != -1{
					return _path_grid[# _other_cell.x,_other_cell.y].dis
				}
			}
			return -1
		}
	
		for(var i = 0; i < ds_grid_width(path_grid);i++){
			for(var j = 0; j < ds_grid_height(path_grid);j++){
				var cur_path_cell = path_grid[# i,j]
			
				if cur_path_cell != -1{
					if cur_path_cell.dis = 0{
						// This is the goal cell
						cur_path_cell.vec_x = 0
						cur_path_cell.vec_y = 0
					}else{
						// Not the goal cell
						var other_cell = new cell(i-1,j)
						
						var left_dis = other_cell_dis(other_cell,path_grid_w,path_grid_h, path_grid)
						if left_dis = -1{
							left_dis = cur_path_cell.dis
						}
						other_cell = new cell(i+1,j)
						var right_dis = other_cell_dis(other_cell,path_grid_w,path_grid_h, path_grid)
						if right_dis = -1{
							right_dis = cur_path_cell.dis
						}
						other_cell = new cell(i,j-1)
						var up_dis = other_cell_dis(other_cell,path_grid_w,path_grid_h, path_grid)
						if up_dis = -1{
							up_dis = cur_path_cell.dis
						}
						other_cell = new cell(i,j+1)
						var down_dis = other_cell_dis(other_cell,path_grid_w,path_grid_h, path_grid)
						if down_dis = -1{
							down_dis = cur_path_cell.dis
						}
			
						cur_path_cell.vec_x = left_dis-right_dis
						cur_path_cell.vec_y = up_dis-down_dis
			
						// Normalize the vector
						var dir = point_direction(0,0,cur_path_cell.vec_x,cur_path_cell.vec_y)
			
						cur_path_cell.vec_x = lengthdir_x(1,dir)
						cur_path_cell.vec_y = lengthdir_y(1,dir)
					}
				}
			}
		}
			
		// Add the new path grid to a path field and add that to the list of path fields
		var goal_cell_x = target_cell_x/2*floor_size+cur_x
		var goal_cell_y = target_cell_y/2*floor_size+cur_y
		ds_list_add(path_fields, new path_field(_ship,target_grid_str,path_grid,goal_cell_x,goal_cell_y))
			
		// Clean up
		ds_queue_destroy(queue)
	}
}



