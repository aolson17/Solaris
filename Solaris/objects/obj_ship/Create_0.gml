

spd = 2 // For testing


ship_rooms = ds_list_create() // Holds ids of room objects
ship_externals = ds_list_create() // Holds ids of external objects
hull_chunks = ds_list_create() // Holds hull chunk structs


if room != rm_builder{
	
	sprite_index = sprite_add("ship_hull.png",0,false,false,0,0)
	
	
	ini_open("ship.ini")
	var i = 0
	while(true){
		if ini_key_exists("Hull Chunks", string(i)){
			var str = ini_read_string("Hull Chunks", string(i), "")
			ds_list_add(hull_chunks,snap_from_json(str))
			i++
		}else{
			// End when nothing else to add to list
			break
		}
	}
	var i = 0
	while(true){
		if ini_key_exists("Externals", "x "+string(i)){
			var new_object_index = ini_read_real("Externals", "object_index "+string(i), par_external)
			var new_x = x+ini_read_real("Externals", "x "+string(i), 0)
			var new_y = y+ini_read_real("Externals", "y "+string(i), 0)
			
			var new_obj = instance_create_layer(new_x,new_y,"Externals",new_object_index)
			new_obj.image_angle = ini_read_real("Externals", "image_angle "+string(i), 0)
			new_obj.anchor_chunk = ini_read_real("Externals", "anchor_chunk "+string(i), 0)
			
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
			
			ds_list_add(ship_rooms,new_obj)
			i++
		}else{
			// End when nothing else to add to list
			break
		}
	}
	ini_close()
}


//ship_wall = ds_grid_create(max_size,max_size) // Holds arrays of wall data



//ship_edge = spr_backmetal_back // The sprite used to create the main edge of the ship
//room_edge = spr_backmetal_back
//room_edge_size = 4
//room_edge_corner_size = 3
