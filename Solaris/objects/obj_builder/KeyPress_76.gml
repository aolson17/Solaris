/// @description Exit builder




sprite_save(obj_ship.sprite_index,0,"ship_hull.png")


file_delete("ship.ini") // Start from a new file
ini_open("ship.ini")

for (var i = 0; i < ds_list_size(hull_chunks);i++){
	var current_hull_chunk = hull_chunks[|i]
	current_hull_chunk.x = current_hull_chunk.x-obj_ship.x
	current_hull_chunk.y = current_hull_chunk.y-obj_ship.y
	
	var str = snap_to_json(hull_chunks[|i], true)
	ini_write_string("Hull Chunks", string(i), str)
}
var i = 0
with(par_external){
	ini_write_real("Externals", "object_index "+string(i), object_index)
	ini_write_real("Externals", "x "+string(i), x-obj_ship.x)
	ini_write_real("Externals", "y "+string(i), y-obj_ship.x)
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
ini_close()


room_goto(rm_space)
