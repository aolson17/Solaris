
if room != rm_builder || obj_builder.moving != id{
	// Room has already been placed
	if prev_moving = true{
		// Room was just placed
		
		ds_list_clear(internals)
		repeat(sections_wide){ // Set up internals array as empty but the correct size
			ds_list_add(internals,noone)
		}
	}
}

if room = rm_builder{
	prev_moving = (obj_builder.moving = id)
}
