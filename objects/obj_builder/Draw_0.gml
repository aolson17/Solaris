
if !surface_exists(hull_surf){
	hull_surf = surface_create(1,1)
}
if !surface_exists(hull_mat_surf){
	hull_mat_surf = surface_create(1,1)
}
if !surface_exists(hull_mat_edges_surf){
	hull_mat_edges_surf = surface_create(1,1)
}

if keyboard_check(ord("I")) || update_surf{
	update_surf = false
	// Make hull texture
	
	// Find dimensions of ship
	
	ship_x = infinity
	ship_y = infinity
	ship_x2 = -infinity
	ship_y2 = -infinity
	
	for (var i = 0; i < ds_list_size(hull_chunks); i++){
		var current_hull_chunk = hull_chunks[|i]
		if current_hull_chunk.x < ship_x{
			ship_x = current_hull_chunk.x
		}
		if current_hull_chunk.y < ship_y{
			ship_y = current_hull_chunk.y
		}
		if current_hull_chunk.x + current_hull_chunk.w*brush_size > ship_x2{
			ship_x2 = current_hull_chunk.x + current_hull_chunk.w*brush_size
		}
		if current_hull_chunk.y + current_hull_chunk.h*brush_size > ship_y2{
			ship_y2 = current_hull_chunk.y + current_hull_chunk.h*brush_size
		}
	}
	
	ship_x = floor(ship_x)
	ship_y = floor(ship_y)
	ship_x2 = ceil(ship_x2)
	ship_y2 = ceil(ship_y2)
	
	if ship_x2-ship_x > 0 && ship_y2-ship_y > 0{
		
		//show_debug_message("Surface Dimensions:")
		//show_debug_message("w: "+string(ship_x2-ship_x))
		//show_debug_message("h: "+string(ship_y2-ship_y))
		
		
		surface_resize(hull_surf,ship_x2-ship_x,ship_y2-ship_y)
		surface_resize(hull_mat_surf,ship_x2-ship_x,ship_y2-ship_y)
		// This helper surface has extra space around for the edges
		surface_resize(hull_mat_edges_surf,ship_x2-ship_x+hull_surf_edge_space*2,ship_y2-ship_y+hull_surf_edge_space*2)
		
		// Prepare the main hull_surf for new hull texures by clearing it
		surface_set_target(hull_surf)
		draw_clear_alpha(c_black,0)
		surface_reset_target()
		
		
		// Find how many materials are being used
		ds_list_clear(hull_mats_found)
		for (var i = 0; i < ds_list_size(hull_chunks); i++){
			var current_hull_chunk = hull_chunks[|i]
			var current_mat = current_hull_chunk.material
			if ds_list_find_index(hull_mats_found,current_mat) = -1{
				// If this material has not been found yet add it to the list
				ds_list_add(hull_mats_found,current_mat)
			}
		}
		
		// Go through each material being used and apply textures, then draw to the hull surface
		for (var i = 0; i < ds_list_size(hull_mats_found); i++){
			var drawing_mat = hull_mats_found[|i] // The material being drawn now
			var mat_info = global.materials[drawing_mat]
			
			var col = mat_info[mat_data.color]
			var texture = mat_info[mat_data.texture]
			var texture_edge = mat_info[mat_data.edge]
			var edge_size = mat_info[mat_data.edge_size]
			var edge_corner_size = mat_info[mat_data.edge_corner_size]
			var name = mat_info[mat_data.name]
			
			if string_pos("Glass", name) != 0{
				var mat_alpha = glass_alpha
			}else{
				var mat_alpha = 1
			}
			
			draw_set_color(c_white)
			
			#region Create surface with all of the hull parts of this material and apply texture
			surface_set_target(hull_mat_surf)
			draw_clear_alpha(c_black,0)
			
			for (var j = 0; j < ds_list_size(hull_chunks); j++){
				var current_hull_chunk = hull_chunks[|j]
				var current_mat = current_hull_chunk.material
				// Check if this hull chunk should be drawn now
				if current_mat = drawing_mat{
					// This hull chunk should be drawn now
					draw_hull_chunk(current_hull_chunk.shape,current_hull_chunk.x-ship_x,current_hull_chunk.y-ship_y,current_hull_chunk.w,current_hull_chunk.h,current_hull_chunk.dir)
				}
			}
			
			// Apply the main texture
			//gpu_set_blendmode_ext(bm_dest_alpha, bm_one)
			gpu_set_blendmode_ext_sepalpha(bm_dest_alpha, bm_inv_src_alpha,bm_dest_alpha,bm_dest_alpha)
			//draw_sprite_tiled(texture,0,0,0)//
			draw_sprite_tiled_ext(texture,0,0,0,1,1,c_white,1)
			gpu_set_blendmode(bm_normal)
			
			surface_reset_target()
			#endregion
			
			#region Create edges surface by taking out material area from the edge texture
			surface_set_target(hull_mat_edges_surf)
			draw_clear(c_black) // Make entirely black
			gpu_set_blendmode(bm_subtract)
			// Take the wall area out of the black
			for (var j = 0; j < ds_list_size(hull_chunks); j++){
				var current_hull_chunk = hull_chunks[|j]
				var current_mat = current_hull_chunk.material
				// Check if this hull chunk should be drawn now
				if current_mat = drawing_mat{
					// This hull chunk should be drawn now
					draw_hull_chunk(current_hull_chunk.shape,current_hull_chunk.x-ship_x+hull_surf_edge_space,current_hull_chunk.y-ship_y+hull_surf_edge_space,current_hull_chunk.w,current_hull_chunk.h,current_hull_chunk.dir)
				}
			}
			gpu_set_blendmode_ext(bm_dest_alpha, bm_one)
			// Make the black area that is left the edge texture
			//draw_sprite_tiled(texture_edge,0,0,0)//
			draw_sprite_tiled_ext(texture_edge,0,0,0,1,1,c_white,1)
			gpu_set_blendmode(bm_normal)
			surface_reset_target()
			#endregion
			
			#region Draw hull_mat_edges_surf over the hull_mat_surf with offsets to apply its edge texture
			surface_set_target(hull_mat_surf)
			
			gpu_set_blendmode_ext_sepalpha(bm_dest_alpha, bm_inv_src_alpha,bm_dest_alpha,bm_dest_alpha)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space+edge_size,-hull_surf_edge_space)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space,-hull_surf_edge_space+edge_size)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space-edge_size,-hull_surf_edge_space)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space,-hull_surf_edge_space-edge_size)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space-edge_corner_size,-hull_surf_edge_space-edge_corner_size)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space+edge_corner_size,-hull_surf_edge_space+edge_corner_size)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space-edge_corner_size,-hull_surf_edge_space+edge_corner_size)
			draw_surface(hull_mat_edges_surf,-hull_surf_edge_space+edge_corner_size,-hull_surf_edge_space-edge_corner_size)
			gpu_set_blendmode(bm_normal)
			
			surface_reset_target()
			#endregion
			
			
			// Now add the textured material chunks to the hull surface
			surface_set_target(hull_surf)
			
			draw_surface_ext(hull_mat_surf,0,0,1,1,0,col,mat_alpha)
			
			surface_reset_target()
		}
		if made_spr_ship_hull{
			sprite_delete(spr_ship_hull)
		}
		made_spr_ship_hull = true
		spr_ship_hull = sprite_create_from_surface(hull_surf,0,0,ship_x2-ship_x,ship_y2-ship_y,false,false,0,0)
		obj_ship.sprite_index = spr_ship_hull
		obj_ship.x = ship_x
		obj_ship.y = ship_y
	}
}

//Shown for bug test
//draw_text(mouse_x,mouse_y,"w: "+string(mouse_x-ship_x))
//draw_text(mouse_x,mouse_y+20,"h: "+string(mouse_y-ship_y))



/*
for (var i = 0; i < ds_list_size(hull_chunks); i++){
	var current_hull_chunk = hull_chunks[|i]
	var current_mat = current_hull_chunk.material
	var mat_info = global.materials[current_mat]
	
	var col = mat_info[mat_data.color]
	
	draw_set_color(col)
	
	draw_hull_chunk(current_hull_chunk.shape,current_hull_chunk.x,current_hull_chunk.y,current_hull_chunk.w,current_hull_chunk.h,current_hull_chunk.dir)
}
*/

//draw_surface(hull_surf,ship_x,ship_y)
//draw_surface(hull_mat_edges_surf,ship_x,ship_y)
//draw_surface(hull_mat_surf,ship_x,ship_y)



if selecting != -1 {
	if selected_cat = cat.hull{
		// Show which hull chunk can be selected
		var current_hull_chunk = hull_chunks[|selecting]
		draw_set_color(c_blue)
		draw_hull_chunk(current_hull_chunk.shape,current_hull_chunk.x,current_hull_chunk.y,current_hull_chunk.w,current_hull_chunk.h,current_hull_chunk.dir)
	}
}

/*with(obj_ship){
	for (var i = 0; i < ds_list_size(hull_chunks);i++){
		//show_message("testing")
		var current_hull_chunk = hull_chunks[|i]
		draw_set_color(c_blue)
		draw_hull_chunk(current_hull_chunk.shape,current_hull_chunk.x,current_hull_chunk.y,current_hull_chunk.w,current_hull_chunk.h,current_hull_chunk.dir)
	}
}*/


// Draw Current Brush
if selected_cat = cat.hull && selecting = -1{
	if brush_col{
		draw_set_color(c_red)
	}else{
		//draw_set_color(c_gray)
		var mat_info = global.materials[brush_mat]
		
		var col = mat_info[mat_data.color]
		draw_set_color(col)
	}
	draw_hull_chunk(brush_shape,brush_x,brush_y,brush_w,brush_h,brush_dir)
}


// Draw selected brush size area
if brush_area_selecting{
	draw_set_color(c_white)
	draw_rectangle(brush_area_start_x,brush_area_start_y,mouse_x,mouse_y,true)
}



//draw_text(mouse_x,mouse_y+5,mouse_x)
//draw_sprite(spr_floor_2,0,mouse_x,mouse_y)