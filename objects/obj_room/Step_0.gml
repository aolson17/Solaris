

if global.mode = mode.build && global.player_ship = ship && obj_control.schematics_cat[|obj_control.selected_schematic] = cat.misc{
	
	if ship.mouse_index_x = index_x && ship.mouse_index_y = index_y{
		
		if mouse_check_button_released(mb_left) && device_mouse_y_to_gui(0) < obj_control.build_area_height*obj_control.gui_height {
			var module_pos = clamp(floor((mouse_x-x)/sprite_width*4),0,3)
			
			
			var new_module = instance_create_layer(x,y,"Modules",obj_control.schematics[|obj_control.selected_schematic])
			
			new_module.rm = id
			new_module.module_pos = module_pos
			
			module[module_pos] = new_module
			
			with (par_module){
				scr_update_module_top()
			}
		}
		
	}
	
	
	
	
}




