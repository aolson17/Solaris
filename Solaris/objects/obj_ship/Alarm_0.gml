/// @description Set up ship stats




for(var i = 0; i < ds_list_size(ship_externals); i++){
	mass += ship_externals[|i].mass
	
	if object_is_ancestor(ship_externals[|i].object_index,par_thruster){
		thrust_up += ship_externals[|i].thrust_up
		thrust_down += ship_externals[|i].thrust_down
		thrust_left += ship_externals[|i].thrust_left
		thrust_right += ship_externals[|i].thrust_right
	}
}
for(var i = 0; i < ds_list_size(hull_chunks); i++){
	var this_chunk = hull_chunks[|i]
	var material = this_chunk.material
	var mat_mass = global.materials[material][mat_data.mass]
	var chunk_mass = mat_mass*this_chunk.w*this_chunk.h
	if this_chunk.shape = shapes.rectangle{
		mass += chunk_mass
	}else{
		mass += chunk_mass/2
	}
}

/*show_debug_message("Mass: "+string(mass))
show_debug_message("Thrust up: "+string(thrust_up))
show_debug_message("Thrust down: "+string(thrust_down))
show_debug_message("Thrust left: "+string(thrust_left))
show_debug_message("Thrust right: "+string(thrust_right))



