

function get_floor_type(_x,_y,_floor_grid_str,_ship){
	// Make sure there actually is a valid floor grid struct
	if !is_struct(_floor_grid_str){
		return floor_types.wall // If there isn't a valid floor grid then don't go here
	}
	var grid_x = floor((_x-_ship.x-_floor_grid_str.x)/floor_size)
	var grid_y = floor((_y-_ship.y-_floor_grid_str.y)/floor_size)
	
	if grid_x >= 0 && grid_x < ds_grid_width(_floor_grid_str.grid){
		if grid_y >= 0 && grid_y < ds_grid_height(_floor_grid_str.grid){
			return _floor_grid_str.grid[# grid_x,grid_y]
		}
	}
	return floor_types.wall
}

// Find the current floor grid
my_floor_grid_str = undefined
for(var i = 0; i < ds_list_size(current_ship.floor_grids); i++){
	var cur_struct = current_ship.floor_grids[|i]
	var cur_grid = cur_struct.grid
	var cur_x = cur_struct.x
	var cur_y = cur_struct.y
		
	if point_in_rectangle(x-current_ship.x,y-current_ship.y,cur_x,cur_y,cur_x+ds_grid_width(cur_grid)*floor_size,cur_y+ds_grid_height(cur_grid)*floor_size){
		my_floor_grid_str = cur_struct
		break
	}
}

// Move toward a given destination
function move_to(_x,_y){
	if x < _x{
		image_xscale = 1
	}else if x > _x{
		image_xscale = -1
	}
	
	var dir = point_direction(x,y,_x,_y)
	
	// Don't go too fast and skip destination
	if point_distance(x,y,_x,_y) < spd{
		var xsp = _x-x
		var ysp = _y-y
	}else{
		var xsp = lengthdir_x(spd,dir)
		var ysp = lengthdir_y(spd,dir)
	}
	
	if get_floor_type(x+xsp,y,my_floor_grid_str,current_ship) = floor_types.empty{
		x += xsp
	}
	if get_floor_type(x,y+ysp,my_floor_grid_str,current_ship) = floor_types.empty{
		y += ysp
	}
}


// See if there is an existing order that leads to the target position
order_path_field = undefined
if moving{
	for(var i = 0; i < ds_list_size(obj_orders.path_fields); i++){
		var this_path_field = obj_orders.path_fields[|i]
	
		if this_path_field.ship = current_ship{
			if this_path_field.target_grid_str = my_floor_grid_str{
				if target_x >= this_path_field.goal_x && target_x <= this_path_field.goal_x+floor_size{
					if target_y >= this_path_field.goal_y && target_y <= this_path_field.goal_y+floor_size{
						order_path_field = this_path_field
					}
				}
			}
		}
	}

	if order_path_field != undefined{
		var grid_x = floor((x-current_ship.x-my_floor_grid_str.x)/(floor_size/2))
		var grid_y = floor((y-current_ship.y-my_floor_grid_str.y)/(floor_size/2))
	
		var cur_path_cell = order_path_field.grid[# grid_x,grid_y]
	
		if is_struct(cur_path_cell) && cur_path_cell.needed{
			vec_x = cur_path_cell.vec_x
			vec_y = cur_path_cell.vec_y
	
			move_to(x+vec_x*spd,y+vec_y*spd)
		}else{
			move_to(target_x+current_ship.x,target_y+current_ship.y)
		}
	}else{
		// There is no existing path to use
		
		with(obj_orders){
			scr_new_path(other.target_x+other.current_ship.x,other.target_y+other.current_ship.y,other.current_ship)
		}
	}
}

if !ds_list_empty(orders){ // If there are orders to do
	var current_order = orders[|0]
	
	// Default to moving to the goal of the order
	var order_x = current_order.x
	var order_y = current_order.y
	var move_type = move_types.walk
	
	// See if already at goal
	if point_distance(x,y,order_x+current_ship.x,order_y+current_ship.y) < 1{
		ds_list_delete(orders,0)
	}else{
		// Not at goal yet
		
		// Check if there are multiple steps to the order
		if current_order.steps_count > 0{
			var current_step = current_order.current_step
		
			if current_step < current_order.steps_count{ // If not at the end of the steps
				// Go to this step of the order
				order_x = current_order.steps[current_step].x
				order_y = current_order.steps[current_step].y
				move_type = current_order.steps[current_step].type
			}
		}
	
		if move_type = move_types.walk{
			//move_to(order_x+current_ship.x,order_y+current_ship.y)
			target_x = order_x
			target_y = order_y
			if point_distance(x,y,order_x+current_ship.x,order_y+current_ship.y) < 1{
				current_order.current_step++
			}
		}else if move_type = move_types.elevator{
			// Taking an elevator instantly moves the crew to the next floor
			x = order_x+current_ship.x
			y = order_y+current_ship.y
			target_x = x-current_ship.x
			target_y = y-current_ship.y
			current_order.current_step++
		}
	}
}



