
#region Depth first search
///@function        find_room_path(_origin, _target)
///@description     Find the path between two rooms and record it in the room_path list or returns false if to possible path
///@param _origin	The id of the starting room
///@param _target	The id of the ending room
///@param _officer	The id of the object running the path
function find_room_path(_origin,_target){
	with (obj_room){
		visited = false
		correct_path = false
	}
	
	if find_room_path_recursion(_origin,_target,id){
		my_room = pos_room(x,y)
		if ds_list_find_index(room_path,my_room) != -1{
			ds_list_delete(room_path,ds_list_find_index(room_path,my_room))
		}
		return true
	}else{
		return false // Returns false if no path was found
	}
}

function find_room_path_recursion(_current,_target,_officer){
	
	with(_current){
		visited = true
		if id = _target{
			correct_path = true
			ds_list_add(_officer.room_path,id)
			return true
		}
		for(var i = 0; i < ds_list_size(paths_all); i++){
			var next = paths_all[|i]
			if next.visited = false{
				if find_room_path_recursion(next,_target,_officer){
					correct_path = true
					ds_list_add(_officer.room_path,id)
					return true
				}
			}
		}
		correct_path = false
	}
	
	return false // Returns false if no further path was found from here
}
#endregion

#region Breadth first search
///@function        find_room_path_bfs(_origin, _target)
///@description     Find the path between two rooms and record it in the room_path list or returns false if to possible path
///@param _origin	The id of the starting room
///@param _target	The id of the ending room
///@param _officer	The id of the object running the path
function find_room_path_bfs(_origin,_target){
	var queue = ds_queue_create()
	ds_queue_enqueue(queue,_origin)
	
	
	with (obj_room){
		visited = false
		correct_path = false
		visited_from = noone
	}
	
	with(_origin){
		visited = true
		correct_path = true
	}
	var found_path = false
	
	while(ds_queue_size(queue)>0 && !found_path){
		var current = ds_queue_dequeue(queue)
		
		with(current){
			if id = _target{
				found_path = true
				break
			}
			for(var i = 0; i < ds_list_size(paths_all); i++){
				var next = paths_all[|i]
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
		return false// Returns false if no path was found
	}else{
		// Add all elements of the path to room_path
		add_to_path(_origin,_target)
		return true
	}
}

function add_to_path(_origin,_current){
	// Goes through each node connected by visited_from to the target
	if _current != _origin{
		_current.correct_path = true
		ds_list_add(room_path,_current)
		add_to_path(_origin,_current.visited_from)
	}
}
#endregion
