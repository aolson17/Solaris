



mouse_index_x = clamp(round((mouse_x-x)/room_w-.5),0,max_size)
mouse_index_y = clamp(round((mouse_y-y)/room_h-.5),0,max_size)


player_index_x = round((obj_player.x-x)/room_w-.5)
player_index_y = round((obj_player.y-y)/room_h-.5)

if keyboard_check_released(ord("B")){
	if player_index_x = clamp(player_index_x,0,max_size) && player_index_y = clamp(player_index_y,0,max_size){
		player_room = ds_grid_get(ship,player_index_x,player_index_y)
		if player_room != 0{
			if global.mode = mode.build{
				global.mode = mode.player
			}else{
				global.mode = mode.build
				
				global.player_ship = id
			}
		}
	}
}

if global.mode = mode.build && global.player_ship = id{
	if obj_control.schematics_cat[|obj_control.selected_schematic] = cat.rm{
		if mouse_check_button_released(mb_left) && device_mouse_y_to_gui(0) < obj_control.build_area_height*obj_control.gui_height {
			if ds_grid_get(ship,mouse_index_x,mouse_index_y) = 0{
				if ds_grid_get_disk_max(ship,mouse_index_x,mouse_index_y,1) != 0{
				
				
				
					var new_room = instance_create_layer(x,y,"Rooms",obj_control.schematics[|obj_control.selected_schematic])
			
					new_room.index_x = mouse_index_x
					new_room.index_y = mouse_index_y
					new_room.ship = id
				
					ds_grid_set(ship,mouse_index_x,mouse_index_y,new_room)
				
					with (obj_room){
						scr_update_room_topless()
					}
					with (obj_room_floorless){
						scr_update_floorless_room_topless()
					}
					with (par_module){
						scr_update_module_top()
					}
				}
			}
		}
	}else if mouse_check_button_released(mb_left) && obj_control.schematics_cat[|obj_control.selected_schematic] = cat.ext_small{
		if ds_grid_get(ship,mouse_index_x,mouse_index_y) = 0{
			var border_room = scr_get_border_room()
			
			var dir = point_direction(x+(mouse_index_x+.5)*room_w,y+(mouse_index_y+.5)*room_h,mouse_x,mouse_y)
			var pos = 0
			var side = sides.none
			if dir <= (1/4)*360{
				if scr_find_border_room(border_room,mouse_index_x+1,mouse_index_y){
					side = sides.left
					pos = 2
				}
				if scr_find_border_room(border_room,mouse_index_x,mouse_index_y-1){
					side = sides.down
					pos = 2
				}
			}else if dir <= (2/4)*360{
				if scr_find_border_room(border_room,mouse_index_x-1,mouse_index_y){
					side = sides.right
					pos = 1
				}
				if scr_find_border_room(border_room,mouse_index_x,mouse_index_y-1){
					side = sides.down
					pos = 1
				}
			}else if dir <= (3/4)*360{
				if scr_find_border_room(border_room,mouse_index_x+1,mouse_index_y){
					side = sides.left
					pos = 4
				}
				if scr_find_border_room(border_room,mouse_index_x,mouse_index_y+1){
					side = sides.up
					pos = 4
				}
			}else if dir <= (4/4)*360{
				if scr_find_border_room(border_room,mouse_index_x-1,mouse_index_y){
					side = sides.right
					pos = 3
				}
				if scr_find_border_room(border_room,mouse_index_x,mouse_index_y+1){
					side = sides.up
					pos = 3
				}
			}
			
			if pos != 0{
				
				// Create the object to manage externals at this grid position
				var new_external = instance_create_layer(x+mouse_index_x*room_w,y+mouse_index_y*room_h,"Rooms",obj_external)
				new_external.size = sizes.small
				new_external.external = array_create(4,noone) // external parts starting in top left and going clockwise
				
				
				
				var new_external_part = instance_create_layer(x,y,"Externals",obj_control.schematics[|obj_control.selected_schematic])
				
				
				
				new_external_part.external = new_external // Set the .. for the external part
				
				
				new_external_part.side = side
				
				
				switch(pos){
					case 1: new_external.external[0] = new_external_part
						show_message("0")
						break
					case 2: new_external.external[1] = new_external_part
						show_message("1")
						break
					case 3: new_external.external[2] = new_external_part
						show_message("2")
						break
					case 4: new_external.external[3] = new_external_part
						show_message("3")
						break
				}
				
				ds_grid_set(ship,mouse_index_x,mouse_index_y,new_external)
				
				with(new_external){
					event_user(0)
				}
			}
		}
	}
}



for(i = 0; i < max_size; i++){
	for(j = 0; j < max_size; j++){
		if ds_grid_get(ship,i,j) != 0{
			var rm = ds_grid_get(ship,i,j)
			
			rm.x = x+i*room_w
			rm.y = y+j*room_h
			with(rm){
				event_user(0)
			}
		}
	}
}



