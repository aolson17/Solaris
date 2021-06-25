

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
	
	// Adjust brush size from room size
	if last_brush_cat = cat.rooms{
		brush_w *= section_size/brush_size
		brush_h = (brush_h+2)*(section_size/brush_size) // The +2 is to account for the extra floor space in a room
	}
	last_brush_cat = cat.hull
}
if keyboard_check_pressed(ord("2")){
	
	// Adjust brush size from room size
	if last_brush_cat = cat.hull{
		brush_w = max(ceil(brush_w/(section_size/brush_size)),room_w_min)
		brush_h = max(ceil(brush_h/(section_size/brush_size))-2,room_h_min)
	}
	last_brush_cat = cat.rooms
	
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
if keyboard_check_pressed(ord("5")){
	if moving != noone{
		instance_destroy(moving)
		moving = noone
	}
	
	if selected_cat != cat.prop{
		selected_cat = cat.prop
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

if keyboard_check_released(vk_shift){
	brush_changed = true
}

#endregion

#region Control Brush and object rotation

if device_mouse_y_to_gui(0) < build_area_height*gui_height {
	if selected_cat = cat.rooms{
		brush_x = round((mouse_x-section_size/2)/section_size)*section_size
		brush_y = round((mouse_y-section_size/2)/section_size)*section_size
	}else if selected_cat = cat.prop{
		brush_x = round(mouse_x)
		brush_y = round(mouse_y)
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
		if instance_exists(moving){
			if moving.can_rotate{
				if keyboard_check_pressed(vk_left){
					moving.image_angle += 22.5
					brush_changed = true
				}
				if keyboard_check_pressed(vk_right){
					moving.image_angle -= 22.5
					brush_changed = true
				}
			}
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

// Switch shape
if keyboard_check_pressed(ord("T")){
	if brush_shape = shapes.rectangle{
		brush_shape = shapes.triangle
	}else if brush_shape = shapes.triangle{
		brush_shape = shapes.rectangle
	}
}

#endregion

#region Move object to brush and place it

if selected_cat != cat.hull{
	if moving != noone{
		// Move object along with brush
		moving.x = brush_x
		moving.y = brush_y
		
		if selected_cat = cat.rooms{
			moving.sections_tall = brush_h
			moving.sections_wide = brush_w
		}
		
		if selected_cat = cat.rooms{
			if lmb{
				if !brush_col{
					moving = noone
				}
			}
		}else if selected_cat = cat.internal{
			var brush_room = collision_rooms(mouse_x,mouse_y,1,1,true) // Room the brush is in
			brush_col = true
			anchor_room = noone
			if brush_room != false{
				moving.anchor_room = brush_room
				var brush_index = -1
				// Go through each place an internal can be placed in this room and see if it would work
				for (var i = 0; i < brush_room.sections_wide;i++){
					if mouse_x = clamp(mouse_x,brush_room.x+(i)*section_size,brush_room.x+(i+1)*section_size){
						// If mouse is selecting here
						if brush_room.internals[|i] = noone{ // Room position is free
							//TODO if using an allow_props system then finish preventing internal from being placed with props around
							//if !moving.allow_props{ // If this internal does not allow for props in its area then check for props
							//	for (var j = 0; j < ds_list_size(brush_room.props))
							//	
							//}
							if brush_room.sections_tall > moving.sections_tall{
								if moving.sections_wide = 1{
									brush_col = false
									brush_index = i
								}else{
									var empty_places = 1 // How many adjacent empty internal places have been found so far
									// Look through the next internal positions in the room to see if there are enough empty spaces
									for (var j = i+1; j < min(brush_room.sections_wide,i+moving.sections_wide);j++){
										if brush_room.internals[|j] = noone{
											empty_places++
										}
									}
									if empty_places = moving.sections_wide{
										// If there is enough space
										brush_col = false
										brush_index = i
									}
								}
							}
						}
						break // Can stop once found right place. TODO: replace for loop with a more direct option
					}
				}
				if !brush_col{
					brush_x = brush_room.x+(brush_index)*section_size
					brush_y = brush_room.y+(brush_room.sections_tall)*section_size
					moving.x = brush_x
					moving.y = brush_y
					if lmb{
						if moving.sections_wide > 1{
							// Set every necessary position to the new object
							for (var i = 0; i < moving.sections_wide;i++){
								brush_room.internals[|brush_index+i] = moving
							}
						}else{
							brush_room.internals[|brush_index] = moving
						}
						moving = noone
					}
				}
			}
		}else if selected_cat = cat.prop{
			var brush_room = collision_rooms(mouse_x,mouse_y,1,1,true)
			brush_col = true
			anchor_room = noone
			if brush_room != false{
				// Find the height of a possibly selected floor
				with(brush_room){
					other.floor_mouse_y = clamp(mouse_y,y+(sections_tall)*section_size,y+(sections_tall+2)*section_size)
				}
				if floor_mouse_y = mouse_y{ // if the mouse is targeting a floor
					moving.anchor_room = brush_room
					var brush_index = -1
					// Go through each place a prop can be placed in this room and see if it would work
					for (var i = 0; i < brush_room.sections_wide-2;i++){
						if mouse_x = clamp(mouse_x,brush_room.x+(i+1)*section_size,brush_room.x+(i+2)*section_size){
							// If mouse is selecting here
							if brush_room.internals[|i] = noone || brush_room.internals[|i].allow_props{ // Room position is free or allows props
								brush_col = false
								brush_index = i
							}
							break // Can stop once found right place. TODO: replace for loop with a more direct option
						}
					}
					if !brush_col{
						if lmb{
							ds_list_add(brush_room.props, moving)
							moving = noone
						}
					}
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
			if collision_rooms(moving.bbox_left,moving.bbox_top,moving.bbox_right-moving.bbox_left,moving.bbox_bottom-moving.bbox_top,true) != false{
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
if selected_cat = cat.rooms || selected_cat = cat.external || selected_cat = cat.prop || selected_cat = cat.internal{
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
			}else if selected_cat = cat.prop{
				// Remove selected prop from anchor room's prop list
				ds_list_delete(selecting.anchor_room.props,ds_list_find_index(selecting.anchor_room.props,selecting))
			}else if selected_cat = cat.internal{
				// Remove selected internal from anchor room's internals list
				
				var anchor_room = selecting.anchor_room
				
				for(var i = 0; i < anchor_room.sections_wide; i++){
					// Reset any array indices this internal used to be filling to noone
					if anchor_room.internals[|i] = selecting{
						anchor_room.internals[|i] = noone
					}
				}
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
			with (par_internal){
				if other.moving != id{ // Don't select what is already being moved
					if instance_position(mouse_x,mouse_y,id){
						other.selecting = id
						break
					}
				}
			}
			break
		case cat.prop:
			with (par_prop){
				if other.moving != id{ // Don't select what is already being moved
					if instance_position(mouse_x,mouse_y,id){
						other.selecting = id
						break
					}
				}
			}
			break
	}
}

#endregion

