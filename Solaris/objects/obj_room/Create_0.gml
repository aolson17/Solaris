


section_size = 32 // How many pixels wide each section is and how much the height increments in


if room = rm_builder{
	//placing = true
}else{
	//placing = false
}
//prev_placing = placing // Used to detect when room is placed
prev_moving = false


sections_tall = 2
sections_wide = 2


internals = [] // Holds the ids of each internal or noone if not filled. Offset in section by one to make room for floor elevators


#region Pathfinding

paths = ds_list_create() // Other rooms connected by the same floor as normal
//paths_elevator = ds_list_create() // Other rooms connected by a normal elevator
paths_elevator_l = ds_list_create() // Other rooms connected by the left floor elevator
paths_elevator_r = ds_list_create() // Other rooms connected by the right floor elevator

paths_all = ds_list_create()

update_paths = true

// Where crew should walk to and from to enter and exit the room. Updated when placed
floor_x_l = x
floor_x_r = x
floor_y = y


#endregion

