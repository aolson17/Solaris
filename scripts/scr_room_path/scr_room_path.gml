

#region Breadth first search
///@description     Find the path between two rooms and record it in a returned struct with an array and an array length or return undefined if no possible path
///@param _origin	The floor_grid struct of the starting floor
///@param _goal	The floor_grid struct of the goal floor
function find_floor_grid_path(_origin,_goal,_ship){
	var queue = ds_queue_create()
	ds_queue_enqueue(queue,_origin)
	
	for (var i = 0; i < ds_list_size(_ship.floor_grids);i++){
		var this_floor_grid_str = _ship.floor_grids[|i]
		this_floor_grid_str.visited = false
		this_floor_grid_str.visited_from = undefined
	}
	
	_origin.visited = true
	
	var found_path = false
	
	while(!ds_queue_empty(queue) && !found_path){
		var current = ds_queue_dequeue(queue)
		
		if current = _goal{
			found_path = true
		}else{
			// Enque all unvisited connected floors
			for(var i = 0; i < current.elev_dests_count; i++){
				var next = current.elev_dests[i].dest
				if next.visited = false{
					ds_queue_enqueue(queue,next)
					next.visited = true
					next.visited_from = current
				}
			}
		}
	}
	ds_queue_destroy(queue)
	
	if !found_path{
		return undefined // Returns undefined if no path was found
	}else{
		// Add all elements of the path to an array in a struct
		var path_info = {
			floors : [],
			floors_count : 0
		}
		
		// Start with adding the goal floor to the path
		path_info.floors[path_info.floors_count] = _goal
		path_info.floors_count++
		// Then continue with the rest leading away fromt the goal
		add_to_path(_origin,_goal,path_info)
		
		// Reset visited from to prevent any self recurssion in the structs
		for (var i = 0; i < ds_list_size(_ship.floor_grids);i++){
			var this_floor_grid_str = _ship.floor_grids[|i]
			this_floor_grid_str.visited_from = undefined
		}
		
		return path_info
	}
}

function add_to_path(_origin,_current,_path_info){
	// Goes through each node connected by visited_from to the target
	
	if is_struct(_current[$ "visited_from"]){
		_path_info.floors[_path_info.floors_count] = _current[$ "visited_from"]
		_path_info.floors_count++
	
		add_to_path(_origin,_current[$ "visited_from"],_path_info)
	}
}
#endregion
