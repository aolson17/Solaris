



if instance_number(obj_room) > 0{
	with(pos_room(mouse_x,mouse_y)){
		other.floor_mouse_x = mouse_x
		other.floor_mouse_y = clamp(mouse_y,y+(sections_tall)*section_size,y+(sections_tall+2)*section_size)
	}
}else{
	floor_mouse_x = mouse_x
	floor_mouse_y = mouse_y
}



if keyboard_check_pressed(ord("C")){
	instance_create_layer(floor_mouse_x,floor_mouse_y,"Instances",obj_crew)
}

if keyboard_check_pressed(ord("X")){
	instance_destroy(obj_crew)
}
