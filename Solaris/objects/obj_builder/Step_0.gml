

function pos_hull_chunk(_x,_y){
	// Returns array pos in hull_chunks or -1 if no chunk at position
	
	for (var i = 0; i < ds_list_size(hull_chunks); i++){
		var current_hull_chunk = hull_chunks[|i]
		
		var adj_w = current_hull_chunk.w*brush_size
		var adj_h = current_hull_chunk.h*brush_size
		
		if current_hull_chunk.shape = shapes.rectangle{
			if point_in_rectangle(_x,_y,current_hull_chunk.x,current_hull_chunk.y,current_hull_chunk.x+adj_w,current_hull_chunk.y+adj_h){
				return i
			}
		}else{
			switch current_hull_chunk.dir{
				case dirs.up:
					var p1_x = current_hull_chunk.x
					var p1_y = current_hull_chunk.y+adj_h
					var p2_x = current_hull_chunk.x+adj_w
					var p2_y = current_hull_chunk.y+adj_h
					var p3_x = current_hull_chunk.x+adj_w
					var p3_y = current_hull_chunk.y
					break
				case dirs.down:
					var p1_x = current_hull_chunk.x
					var p1_y = current_hull_chunk.y
					var p2_x = current_hull_chunk.x+adj_w
					var p2_y = current_hull_chunk.y
					var p3_x = current_hull_chunk.x
					var p3_y = current_hull_chunk.y+adj_h
					break
				case dirs.left:
					var p1_x = current_hull_chunk.x
					var p1_y = current_hull_chunk.y
					var p2_x = current_hull_chunk.x+adj_w
					var p2_y = current_hull_chunk.y
					var p3_x = current_hull_chunk.x+adj_w
					var p3_y = current_hull_chunk.y+adj_h
					break
				case dirs.right:
					var p1_x = current_hull_chunk.x
					var p1_y = current_hull_chunk.y
					var p2_x = current_hull_chunk.x
					var p2_y = current_hull_chunk.y+adj_h
					var p3_x = current_hull_chunk.x+adj_w
					var p3_y = current_hull_chunk.y+adj_h
					break
			}
		
			if point_in_triangle(_x,_y,p1_x,p1_y,p2_x,p2_y,p3_x,p3_y){
				return i
			}
		}
	}
	
	return -1
}

#region Switch category
if keyboard_check_pressed(ord("1")){
	
	if moving != noone{
		instance_destroy(moving)
		moving = noone
	}
	
	
	if selected_cat != cat.hull{
		selected_cat = cat.hull
		update_cat_surf = true
	}
}
if keyboard_check_pressed(ord("2")){
	
	if moving != noone{
		instance_destroy(moving)
		moving = noone
	}
	
	if brush_h < room_h_min{
		brush_h = room_h_min
	}
	if brush_w < room_w_min{
		brush_w = room_w_min
	}
	
	if selected_cat != cat.rooms{
		selected_cat = cat.rooms
		update_cat_surf = true
	}
	var new_room = instance_create_layer(mouse_x,mouse_y,"Floor",obj_room)
	moving = new_room
}
if keyboard_check_pressed(ord("3")){
	if moving != noone{
		instance_destroy(moving)
		moving = noone
	}
	
	if selected_cat != cat.internal{
		selected_cat = cat.internal
		update_cat_surf = true
		var schematics = obj_inventory.schematics
		var schematics_cat = obj_inventory.schematics_cat
		for(var i = 0; i < ds_list_size(schematics); i++){
			if ds_list_find_value(schematics_cat,i) = selected_cat{
				selected_schematic = i
				break
			}
		}
	}
}
if keyboard_check_pressed(ord("4")){
	if moving != noone{
		instance_destroy(moving)
		moving = noone
	}
	
	if selected_cat != cat.external{
		selected_cat = cat.external
		update_cat_surf = true
		var schematics = obj_inventory.schematics
		var schematics_cat = obj_inventory.schematics_cat
		for(var i = 0; i < ds_list_size(schematics); i++){
			if ds_list_find_value(schematics_cat,i) = selected_cat{
				selected_schematic = i
				break
			}
		}
	}
}
#endregion

#region Brush area select

if keyboard_check_pressed(vk_shift){
	brush_area_start_x = mouse_x
	brush_area_start_y = mouse_y
	brush_area_selecting = true
}
if !keyboard_check(vk_shift) && brush_area_selecting{
	brush_area_selecting = false
	if selected_cat = cat.hull{
		brush_w = max(ceil(abs(mouse_x-brush_area_start_x)/brush_size),brush_w_min)
		brush_h = max(ceil(abs(mouse_y-brush_area_start_y)/brush_size),brush_h_min)
	}else if selected_cat = cat.rooms{
		brush_w = max(ceil(abs(mouse_x-brush_area_start_x)/section_size),room_w_min)
		brush_h = max(ceil(abs(mouse_y-brush_area_start_y)/section_size)-2,room_h_min)
	}
}

#endregion

#region Control Brush

if device_mouse_y_to_gui(0) < build_area_height*gui_height {
	if selected_cat = cat.rooms{
		brush_x = round((mouse_x-section_size/2)/section_size)*section_size
		brush_y = round((mouse_y-section_size/2)/section_size)*section_size
	}else{
		brush_x = round((mouse_x-brush_size/2)/brush_size)*brush_size
		brush_y = round((mouse_y-brush_size/2)/brush_size)*brush_size
	}
}

if !keyboard_check(vk_control){
	if keyboard_check_pressed(vk_down){
		brush_h = brush_h+1
		brush_changed = true
	}
	if keyboard_check_pressed(vk_up){
		if selected_cat = cat.rooms{
			brush_h = max(room_h_min,brush_h-1)
		}else{
			brush_h = max(brush_h_min,brush_h-1)
		}
		brush_changed = true
	}
	if keyboard_check_pressed(vk_right){
		brush_w = brush_w+1
		brush_changed = true
	}
	if keyboard_check_pressed(vk_left){
		if selected_cat = cat.rooms{
			brush_w = max(room_w_min,brush_w-1)
		}else{
			brush_w = max(brush_w_min,brush_w-1)
		}
		brush_changed = true
	}
}else{
	// Rotation
	if selected_cat = cat.external{
		if keyboard_check(vk_left){
			moving.image_angle += 2
		}
		if keyboard_check(vk_right){
			moving.image_angle -= 2
		}
	}else{
		if keyboard_check_pressed(vk_down){
			brush_dir = dirs.down
		}
		if keyboard_check_pressed(vk_up){
			brush_dir = dirs.up
		}
		if keyboard_check_pressed(vk_left){
			brush_dir = dirs.left
		}
		if keyboard_check_pressed(vk_right){
			brush_dir = dirs.right
		}
	}
}

if keyboard_check_pressed(ord("T")){
	if brush_shape = shapes.rectangle{
		brush_shape = shapes.triangle
	}else if brush_shape = shapes.triangle{
		brush_shape = shapes.rectangle
	}
}

#endregion

#region Move object to brush and place it

if selected_cat = cat.rooms || selected_cat = cat.external{
	if moving != noone{
		// Move object along with brush
		moving.x = brush_x
		moving.y = brush_y
		
		moving.sections_tall = brush_h
		moving.sections_wide = brush_w
		
		if selected_cat != cat.external{
			if lmb{
				if !brush_col{
					moving = noone
				}
			}
		}else{
			var external_anchor_chunk = pos_hull_chunk(moving.x,moving.y) // Which hull chunk is the anchor for the new external object
			moving.anchor_chunk = external_anchor_chunk
			if external_anchor_chunk != -1 && !brush_col{
				if lmb{
					moving.anchor_chunk = external_anchor_chunk
					moving = noone
				}
			}
		}
	}
}

#endregion

#region Check if brush is colliding with placed stuff
if prev_brush_x != brush_x || prev_brush_y != brush_y || brush_changed{
	brush_changed = false
	show_debug_message("Brush Changed   "+string(random(10)))
	if selected_cat = cat.hull{
		brush_col = collision_hull_chunk(brush_x,brush_y,brush_w*brush_size,brush_h*brush_size)
	}else if selected_cat = cat.rooms{
		if moving != noone{
			brush_col = collision_hull_chunk(brush_x,brush_y,brush_w*section_size,(brush_h+2)*section_size)
		}
	}else if selected_cat = cat.external{
		if moving != noone{
			brush_col = false
			with(moving){
				if place_meeting(x,y,par_external){
					other.brush_col = true
					break
				}
			}
			if collision_rooms(moving.bbox_left,moving.bbox_top,moving.bbox_right-moving.bbox_left,moving.bbox_bottom-moving.bbox_top){
				brush_col = true
			}
		}
	}
}
prev_brush_x = brush_x
prev_brush_y = brush_y
#endregion

#region Placing or picking up chunks
if selected_cat = cat.hull{
	if selecting = -1{
		if lmb && !brush_col{ // Building Chunk
			update_surf = true
			brush_changed = true
			// Create new chunk according to brush info
			var new_hull_chunk = new hull_chunk(brush_shape, brush_x, brush_y, brush_w, brush_h, brush_dir,brush_mat)
			ds_list_add(hull_chunks,new_hull_chunk)
		}
	}else{ // Hovering over an existing chunk
		if lmb{
			update_surf = true
			var chunk = ds_list_find_value(hull_chunks,selecting)
			brush_shape = chunk.shape
			brush_mat = chunk.material
			brush_w = chunk.w
			brush_h = chunk.h
			
			if chunk.shape = shapes.triangle{
				brush_dir = chunk.dir
			}else{
				brush_dir = dirs.up
			}
			
			brush_changed = true
			
			// Check for anchoring externals
			with(par_external){
				if anchor_chunk = other.selecting{
					instance_destroy()
				}
			}
			
			ds_list_delete(hull_chunks,selecting)
		}
	}
}
#endregion

#region Pick up object

// Ready to pick up an object
if selected_cat = cat.rooms || selected_cat = cat.external{
	if selecting != -1{
		if lmb{
			brush_changed = true
			if moving != noone{
				instance_destroy(moving)
			}
			moving = selecting
			if selected_cat = cat.rooms{
				brush_w = moving.sections_wide
				brush_h = moving.sections_tall
				// Set off the other rooms for updating
				with(obj_room){
					if id != other.moving{
						update_paths = true
					}
				}
				moving.update_paths = true
			}
		}
	}
}
#endregion

#region Select part to move

selecting = -1
if device_mouse_y_to_gui(0) < build_area_height*gui_height{
	
	switch selected_cat{
		case cat.hull:
			selecting = pos_hull_chunk(mouse_x,mouse_y)
			break
		case cat.rooms:
			with obj_room{
				if other.moving != id{ // Don't select what is already being moved
					if point_in_rectangle(mouse_x,mouse_y,x,y,x+sections_wide*section_size,y+(sections_tall+2)*section_size){
						other.selecting = id
						break
					}
				}
			}
			break
		case cat.external:
			with par_external{
				if other.moving != id{ // Don't select what is already being moved
					if instance_position(mouse_x,mouse_y,id){
						other.selecting = id
						break
					}
				}
			}
			break
		case cat.internal:
			break
	}
}

#endregion

