



// Show which rooms are connected
if (room != rm_builder || id != obj_builder.moving) && point_in_rectangle(mouse_x,mouse_y,x,y,x+sections_wide*section_size,y+(sections_tall+2)*section_size) && keyboard_check(ord("O")){
	draw_set_color(c_red)
	draw_set_alpha(.1)
	draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
	
	draw_set_color(c_blue)
	for(var i = 0; i < ds_list_size(paths);i++){
		with(paths[|i]){
			draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
		}
	}
	draw_set_color(c_lime)
	for(var i = 0; i < ds_list_size(paths_elevator_l);i++){
		with(paths_elevator_l[|i]){
			draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
		}
	}
	for(var i = 0; i < ds_list_size(paths_elevator_r);i++){
		with(paths_elevator_r[|i]){
			draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
		}
	}
	
	//show_debug_message(" -------------- "+string(id))
	//show_debug_message("# of paths: "+string(ds_list_size(paths)))
	//show_debug_message("# of paths l: "+string(ds_list_size(paths_elevator_l)))
	//show_debug_message("# of paths r: "+string(ds_list_size(paths_elevator_r)))
	//show_debug_message("adj x: "+string(x/section_size))
	//show_debug_message("adj y: "+string(y/section_size))
	//show_debug_message("first: "+string(paths[|0]))
	
	draw_set_alpha(1)
}

if keyboard_check(ord("P")){
	if correct_path{
		draw_set_color(c_green)
		draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
	}else{
		draw_set_color(c_red)
		draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
	}
}

if room = rm_builder{
	// Show if selecting
	if id = obj_builder.selecting{
		draw_set_alpha(.2)
		draw_set_color(c_blue)
		draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
		draw_set_alpha(1)
	}
}

