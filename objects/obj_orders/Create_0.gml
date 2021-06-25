

if instance_exists(obj_ship){
	selected_ship = instance_nearest(x,y,obj_ship)
}else{
	selected_ship = noone
}


selected_crew = ds_list_create()


selected_area_x = 0
selected_area_y = 0

selected_area_min = 10 // How many pixels minimum to be considered selecting an area

#region Order queue for move orders

function queued_move(_crew,_goal_x,_goal_y,_ship) constructor{
	crew = _crew
	goal_x = _goal_x // Position of goal NOT relative to the ship
	goal_y = _goal_y
	ship = _ship
}

move_queue = ds_queue_create()

#endregion

#region Pathfinding

elevator_offset_x = 16 // Where to enter and exit elevator relative to elevator position
elevator_offset_y = 8

// Help from https://gamedevelopment.tutsplus.com/tutorials/understanding-goal-based-vector-field-pathfinding--gamedev-9007

function path_field(_ship,_target_grid_str,_grid,_goal_x,_goal_y) constructor{
	ship = _ship
	target_grid_str = _target_grid_str
	grid = _grid
	goal_x = _goal_x // The top left position of the goal cells relative to the ship
	goal_y = _goal_y
}

function path_field_cell(_vec_x,_vec_y,_dis,_needed) constructor{
	vec_x = _vec_x
	vec_y = _vec_y
	dis = _dis
	needed = _needed // If the path system is needed from this location. Not needed if there is a straight line to the goal from here.
}


path_fields = ds_list_create() // List of path_fields that hold info for vector field pathfinding

#endregion
