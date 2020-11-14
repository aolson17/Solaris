function scr_update_cat_surf() {
	
	if selected_cat != cat.hull{
		surface_set_target(cat_surf)
		draw_clear_alpha(c_black,0)

		var spr_scale = 2

		var pos = 0

		var schematics = obj_inventory.schematics
		var schematics_cat = obj_inventory.schematics_cat
		var schematics_spr = obj_inventory.schematics_spr
		var schematics_cost = obj_inventory.schematics_cost
		var schematics_name = obj_inventory.schematics_name
		var schematics_size = ds_list_size(schematics)

		for(var i = 0; i < schematics_size; i++){
	
			if ds_list_find_value(schematics_cat,i) = selected_cat{
		
				var spr = ds_list_find_value(schematics_spr,i)
				var cost = ds_list_find_value(schematics_cost,i)
				var name = ds_list_find_value(schematics_name,i)
		
		
		
				draw_sprite_ext(spr,0,square_size * pos,20,spr_scale,spr_scale,0,c_white,1)
		
				if i = selected_schematic{
					draw_set_color(c_blue)
					draw_set_alpha(.6)
					draw_rectangle(square_size * pos,0,square_size * (pos+1),surface_get_height(cat_surf),false)
					draw_set_alpha(1)
				}
		
				draw_set_color(c_white)
		
				draw_text(square_size * pos,0,name)
		
				draw_set_halign(fa_right)
				draw_text(square_size * (pos+1),surface_get_height(cat_surf)-30,"$"+string(cost))
				draw_set_halign(fa_left)
		
				pos++
			}
	
		}
		
		surface_reset_target()
	}else{
		// If in hull category
		
		surface_set_target(cat_surf)
		draw_clear_alpha(c_black,0)

		var spr_scale = 2
		
		var mat_size = array_length(global.materials)

		for(var i = 0; i < mat_size; i++){
			
			var mat_info = global.materials[i]
			
			var spr = mat_info[mat_data.texture]
			var col = mat_info[mat_data.color]
			var cost = mat_info[mat_data.cost]
			var name = mat_info[mat_data.name]
			
			draw_sprite_ext(spr,0,square_size * i,20,spr_scale,spr_scale,0,col,1)
		
			if i = brush_mat{
				draw_set_color(c_blue)
				draw_set_alpha(.6)
				draw_rectangle(square_size * i,0,square_size * (i+1),surface_get_height(cat_surf),false)
				draw_set_alpha(1)
			}
		
			draw_set_color(c_white)
		
			draw_text(square_size * i,0,name)
		
			draw_set_halign(fa_right)
			draw_text(square_size * (i+1),surface_get_height(cat_surf)-30,"$"+string(cost))
			draw_set_halign(fa_left)
		}
		
		surface_reset_target()
		
		
	}
}
