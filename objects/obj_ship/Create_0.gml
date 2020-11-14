


#region Load ship

ship_rooms = ds_list_create() // Holds ids of room objects
ship_externals = ds_list_create() // Holds ids of external objects
ship_internals = ds_list_create() // Holds ids of internal objects
ship_props = ds_list_create() // Holds ids of prop objects
hull_chunks = ds_list_create() // Holds hull chunk structs

ship_crew = ds_list_create() // Holds ids of each crew member on the ship

ship_name = get_string("Ship Name to Load?","")
	
if room != rm_builder{
	if ship_name = ""{
		instance_destroy()
		exit
	}
}else{
	if ship_name = ""{
		exit
	}
}
	
sprite_index = sprite_add(ship_name+".png",0,false,false,0,0)
	
	
ini_open(ship_name+".ini")
	
var i = 0
while(true){
	if ini_key_exists("Hull Chunks", string(i)){
		//show_message("found")
		var str = ini_read_string("Hull Chunks", string(i), "")
		str = string_replace_all(str,"'","\"") // Turn single quotes back to double quotes after they were changed to not confuse ini_read_string
		//show_message(str)
		ds_list_add(hull_chunks,snap_from_json(str))
		i++
	}else{
		// End when nothing else to add to list
		break
	}
}
	
if room = rm_builder{
	// Change hull chunk position to absolute instead of relative to the ship
	for (var i = 0; i < ds_list_size(hull_chunks);i++){
		var current_hull_chunk = hull_chunks[|i]
		current_hull_chunk.x = current_hull_chunk.x+obj_ship.x
		current_hull_chunk.y = current_hull_chunk.y+obj_ship.y
	}
}

	
var i = 0
while(true){
	if ini_key_exists("Externals", "x "+string(i)){
		var new_object_name = ini_read_string("Externals", "object_name "+string(i), "noone")
		var new_object_index = asset_get_index(new_object_name)
		var new_x = x+ini_read_real("Externals", "x "+string(i), 0)
		var new_y = y+ini_read_real("Externals", "y "+string(i), 0)
		
		var new_obj = instance_create_layer(new_x,new_y,"Externals",new_object_index)
		
		new_obj.image_angle = ini_read_real("Externals", "image_angle "+string(i), 0)
		new_obj.anchor_chunk = ini_read_real("Externals", "anchor_chunk "+string(i), 0)
		new_obj.my_ship = id
			
		ds_list_add(ship_externals,new_obj)
		i++
	}else{
		// End when nothing else to add to list
		break
	}
}
i = 0
while(true){
	if ini_key_exists("Rooms", "x "+string(i)){
		var new_x = x+ini_read_real("Rooms", "x "+string(i), 0)
		var new_y = y+ini_read_real("Rooms", "y "+string(i), 0)
			
		var new_obj = instance_create_layer(new_x,new_y,"Floor",obj_room)
		new_obj.sections_tall = ini_read_real("Rooms", "sections_tall "+string(i), 0)
		new_obj.sections_wide = ini_read_real("Rooms", "sections_wide "+string(i), 0)
		new_obj.my_ship = id

		new_obj.internals = array_create(new_obj.sections_wide-2,noone)
		
		ds_list_add(ship_rooms,new_obj)
		i++
	}else{
		// End when nothing else to add to list
		break
	}
}
var i = 0
while(true){
	if ini_key_exists("Internals", "x "+string(i)){
		var new_object_name = ini_read_string("Internals", "object_name "+string(i), "noone")
		var new_object_index = asset_get_index(new_object_name)
		var new_x = x+ini_read_real("Internals", "x "+string(i), 0)
		var new_y = y+ini_read_real("Internals", "y "+string(i), 0)
			
		var new_obj = instance_create_layer(new_x,new_y,"Internals",new_object_index)
		new_obj.sections_tall = ini_read_real("Internals", "sections_tall "+string(i), 0)
		new_obj.sections_wide = ini_read_real("Internals", "sections_wide "+string(i), 0)
		new_obj.internals_index = ini_read_real("Internals", "internals_index "+string(i), -1)
		new_obj.anchor_room = collision_rooms(new_x,new_y,1,1,false)
		new_obj.my_ship = id
			
		// Add this internal to the anchor object's internals array for as many positions as the width
		for(var j = 0; j < new_obj.sections_wide;j++){
			new_obj.anchor_room.internals[new_obj.internals_index+j] = new_obj
		}
		// Add this internal to the ship's props list
		ds_list_add(ship_internals,new_obj)
		i++
	}else{
		// End when nothing else to add to list
		break
	}
}
var i = 0
while(true){
	if ini_key_exists("Props", "x "+string(i)){
		var new_object_name = ini_read_string("Props", "object_name "+string(i), "noone")
		var new_object_index = asset_get_index(new_object_name)
		var new_x = x+ini_read_real("Props", "x "+string(i), 0)
		var new_y = y+ini_read_real("Props", "y "+string(i), 0)
			
		var new_obj = instance_create_layer(new_x,new_y,"Instances",new_object_index)
		new_obj.sections_tall = ini_read_real("Props", "sections_tall "+string(i), 0)
		new_obj.sections_wide = ini_read_real("Props", "sections_wide "+string(i), 0)
		new_obj.anchor_room = collision_rooms(new_x,new_y,1,1,false)
		new_obj.my_ship = id
			
		// Add this prop to the anchor object's props list
		ds_list_add(new_obj.anchor_room.props,new_obj)
		// Add this prop to the ship's props list
		ds_list_add(ship_props,new_obj)
		i++
	}else{
		// End when nothing else to add to list
		break
	}
}
ini_close()

#endregion

#region Ship stats

ship_center_x = 0 // How far away from the top left of the ship the center is
ship_center_y = 0

mass = 0
thrust_up = 0
thrust_down = 0
thrust_left = 0
thrust_right = 0

thrust_cw = .3
thrust_ccw = .3

alarm[0] = 2


#endregion



xsp = 0
ysp = 0
rsp = 0


angle = 0




//ship_wall = ds_grid_create(max_size,max_size) // Holds arrays of wall data


//ship_edge = spr_backmetal_back // The sprite used to create the main edge of the ship
//room_edge = spr_backmetal_back
//room_edge_size = 4
//room_edge_corner_size = 3
