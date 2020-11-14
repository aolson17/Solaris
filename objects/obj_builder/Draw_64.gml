
if !surface_exists(cat_surf){
	cat_surf = surface_create(gui_width,gui_height*(1-build_area_height))
	update_cat_surf = true
}
if update_cat_surf{
	scr_update_cat_surf()
	update_cat_surf = false
}

draw_set_color(c_white)
draw_text(10,10,"BUILD MODE")
	
if global.delete_mode{
	draw_text(10,30,"DELETE MODE")
}




draw_set_color(c_gray)
draw_set_alpha(.5)
draw_rectangle(gui_width*.2,gui_height*.8,gui_width,gui_height,false)
draw_set_alpha(1)



draw_surface(cat_surf,gui_width*.21,gui_height*build_area_height)

if gui_lmb{
	if selected_cat != cat.hull{
		// If not selecting a new material
		var schematics = obj_inventory.schematics
		var schematics_cat = obj_inventory.schematics_cat
		var schematics_spr = obj_inventory.schematics_spr
		var schematics_cost = obj_inventory.schematics_cost
		var schematics_name = obj_inventory.schematics_name
		var schematics_size = ds_list_size(schematics)

		var selected_pos = floor((device_mouse_x_to_gui(0)-gui_width*.21)/square_size)
		var pos = 0
		for(var i = 0; i < schematics_size; i++){
			if ds_list_find_value(schematics_cat,i) = selected_cat{
				if selected_pos = pos{
					selected_schematic = i
				}
				pos++
			}
		}
		update_cat_surf = true
		
		if moving != noone{
			instance_destroy(moving)
			moving = noone
		}
		
		if selected_cat = cat.external{
			var cat_layer = "Externals"
		}else if selected_cat = cat.prop{
			var cat_layer = "Instances"
		}else{
			var cat_layer = "Internals"
		}
		
		moving = instance_create_layer(mouse_x,mouse_y,cat_layer,schematics[|selected_schematic])
	}else{
		// If selecting a new material
		
		var mat_size = array_length(global.materials)
		var selected_pos = floor((device_mouse_x_to_gui(0)-gui_width*.21)/square_size)
		if selected_pos < mat_size && selected_pos >= 0{
			brush_mat = selected_pos
		}
		update_cat_surf = true
	}
}

