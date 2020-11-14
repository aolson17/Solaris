/// @description Exit builder


ship_name = get_string("Ship Name to Save?","")

if ship_name != ""{
	
	sprite_save(obj_ship.sprite_index,0,ship_name+".png")
	
	if file_exists(ship_name+".ini"){
		var overwrite = string_upper(get_string("Existing ship of that name, overwrite files? (Yes or y to overwrite)",""))
		if overwrite != "YES" && overwrite != "Y"{
			show_message("Did not overwrite")
			exit
		}
	}
	
	file_delete(ship_name+".ini") // Start from a new file
	ini_open(ship_name+".ini")
	
	for (var i = 0; i < ds_list_size(hull_chunks);i++){
		var current_hull_chunk = hull_chunks[|i]
		current_hull_chunk.x = current_hull_chunk.x-obj_ship.x
		current_hull_chunk.y = current_hull_chunk.y-obj_ship.y
	
		var str = snap_to_json(hull_chunks[|i], false) // ini_read_string cannot read from pretty mode
		str = string_replace_all(str,"\"","'") // Replace double quotes because they confuse ini_read_string
		ini_write_string("Hull Chunks", string(i), str)
	}
	var i = 0
	with(par_external){
		ini_write_string("Externals", "object_name "+string(i), object_get_name(object_index)) // Use the name of the object instead of the index because the index can change when new objects are added
		ini_write_real("Externals", "x "+string(i), x-obj_ship.x)
		ini_write_real("Externals", "y "+string(i), y-obj_ship.y)
		ini_write_real("Externals", "image_angle "+string(i), image_angle)
		ini_write_real("Externals", "anchor_chunk "+string(i), anchor_chunk)
		i++
	}
	var i = 0
	with(obj_room){
		ini_write_real("Rooms", "x "+string(i), x-obj_ship.x)
		ini_write_real("Rooms", "y "+string(i), y-obj_ship.y)
		ini_write_real("Rooms", "sections_tall "+string(i), sections_tall)
		ini_write_real("Rooms", "sections_wide "+string(i), sections_wide)
		i++
	}
	var i = 0
	with(par_internal){
		ini_write_string("Internals", "object_name "+string(i), object_get_name(object_index))
		ini_write_real("Internals", "x "+string(i), x-obj_ship.x)
		ini_write_real("Internals", "y "+string(i), y-obj_ship.y)
		i++
	}
	var i = 0
	with(par_prop){
		ini_write_string("Props", "object_name "+string(i), object_get_name(object_index))
		ini_write_real("Props", "x "+string(i), x-obj_ship.x)
		ini_write_real("Props", "y "+string(i), y-obj_ship.y)
		i++
	}
	ini_close()
}
	
//room_goto(rm_space)
