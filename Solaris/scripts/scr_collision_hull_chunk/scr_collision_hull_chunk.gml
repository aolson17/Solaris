
///@description Check rectangle for collisions with chunks, rooms, and externals
function collision_hull_chunk(_x,_y,_w,_h){
	// Check if a given rectangle is colliding with an existing chunk
	for (var i = 0; i < ds_list_size(obj_builder.hull_chunks); i++){
		var current_hull_chunk = obj_builder.hull_chunks[|i]
		
		var adj_w = current_hull_chunk.w*obj_builder.brush_size-1
		var adj_h = current_hull_chunk.h*obj_builder.brush_size-1
		
		if rectangle_in_rectangle(_x,_y,_x+_w-1,_y+_h-1,current_hull_chunk.x,current_hull_chunk.y,current_hull_chunk.x+adj_w,current_hull_chunk.y+adj_h){
			return true
		}
	}
	// Check if a given rectangle is colliding with a room
	if collision_rooms(_x,_y,_w,_h){
		return true
	}
	// Check if a given rectangle is colliding with an external object
	ds_list_clear(obj_builder.external_col_list)
	if collision_rectangle_list(_x,_y,_x+_w-1,_y+_h-1,par_external,true,true,obj_builder.external_col_list,false) > 0{
		for (var i = 0; i < ds_list_size(obj_builder.external_col_list);i++){
			if obj_builder.external_col_list[|i] != obj_builder.moving{
				return true
			}
		}
	}
	
	return false
}


///@description Check rectangle for collisions with rooms
function collision_rooms(_x,_y,_w,_h){
	with (obj_room){
		if other.object_index = obj_room{
			if id = other.id{
				continue // Don't trigger collision on itself
			}
		}
		if id = obj_builder.moving{
			continue // Don't trigger collision on what is being moved
		}
		var adj_w = sections_wide*obj_builder.section_size-1
		var adj_h = (sections_tall+2)*obj_builder.section_size-1
		
		if rectangle_in_rectangle(_x,_y,_x+_w-1,_y+_h-1,x,y,x+adj_w,y+adj_h){
			return true
		}
	}
	
	return false
}