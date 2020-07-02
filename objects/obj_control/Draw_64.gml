
if !surface_exists(cat_surf){
	cat_surf = surface_create(gui_width,gui_height*(1-build_area_height))
	update_cat_surf = true
}
if update_cat_surf{
	scr_update_cat_surf()
	update_cat_surf = false
}

if global.mode = mode.build{
	draw_set_color(c_white)
	draw_text(10,10,"BUILD MODE")
	
	
	draw_set_color(c_gray)
	draw_set_alpha(.5)
	draw_rectangle(gui_width*.2,gui_height*.8,gui_width,gui_height,false)
	draw_set_alpha(1)
	
	
	
	draw_surface(cat_surf,gui_width*.21,gui_height*build_area_height)
	
	if mouse_check_button_released(mb_left) && device_mouse_y_to_gui(0) >= obj_control.build_area_height*obj_control.gui_height {
		var selected_pos = floor((device_mouse_x_to_gui(0)-gui_width*.21)/square_size)
		var pos = 0
		for(var i = 0; i < ds_list_size(schematics); i++){
			if ds_list_find_value(schematics_cat,i) = selected_cat{
				if selected_pos = pos{
					selected_schematic = i
				}
				pos++
			}
		}
		update_cat_surf = true
	}
	
}

