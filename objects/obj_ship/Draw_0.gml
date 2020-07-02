




if global.mode = mode.build && global.player_ship = id{
	if obj_control.schematics_cat[|obj_control.selected_schematic] = cat.rm{
		for(i = 1; i < max_size-1; i++){
			for(j = 1; j < max_size-1; j++){
				if ds_grid_get(ship,i,j) != 0{
				
					if ds_grid_get(ship,i-1,j) = 0{
						draw_sprite_ext(spr_new_room,0,x+(i-1)*room_w,y+j*room_h,1,1,0,c_white,1)
					}
					if ds_grid_get(ship,i+1,j) = 0{
						draw_sprite_ext(spr_new_room,0,x+(i+1)*room_w,y+j*room_h,1,1,0,c_white,1)
					}
					if ds_grid_get(ship,i,j-1) = 0{
						draw_sprite_ext(spr_new_room,0,x+i*room_w,y+(j-1)*room_h,1,1,0,c_white,1)
					}
					if ds_grid_get(ship,i,j+1) = 0{
						draw_sprite_ext(spr_new_room,0,x+i*room_w,y+(j+1)*room_h,1,1,0,c_white,1)
					}
				}
			}
		}
	}else if obj_control.schematics_cat[|obj_control.selected_schematic] = cat.ext_small{
		var border_room = scr_get_border_room()
		for(i = 1; i < max_size-1; i++){
			for(j = 1; j < max_size-1; j++){
				
				
				
				if ds_grid_get(ship,i,j) != 0{
					if ds_grid_get(ship,i,j).object_index = border_room{
						if ds_grid_get(ship,i-1,j) = 0{ // If left is completely empty
							draw_sprite_ext(spr_new_external_small,0,x+(i-.5)*room_w,y+(j)*room_h,1,1,0,c_white,1)
							draw_sprite_ext(spr_new_external_small,0,x+(i-.5)*room_w,y+(j+.5)*room_h,1,1,0,c_white,1)
						}
						if ds_grid_get(ship,i+1,j) = 0{ // If right is completely empty
							draw_sprite_ext(spr_new_external_small,0,x+(i+1)*room_w,y+(j)*room_h,1,1,0,c_white,1)
							draw_sprite_ext(spr_new_external_small,0,x+(i+1)*room_w,y+(j+.5)*room_h,1,1,0,c_white,1)
						}
						if ds_grid_get(ship,i,j-1) = 0{ // If up is completely empty
							draw_sprite_ext(spr_new_external_small,0,x+(i)*room_w,y+(j-.5)*room_h,1,1,0,c_white,1)
							draw_sprite_ext(spr_new_external_small,0,x+(i+.5)*room_w,y+(j-.5)*room_h,1,1,0,c_white,1)
						}
						if ds_grid_get(ship,i,j+1) = 0{ // If down is completely empty
							draw_sprite_ext(spr_new_external_small,0,x+(i)*room_w,y+(j+1)*room_h,1,1,0,c_white,1)
							draw_sprite_ext(spr_new_external_small,0,x+(i+.5)*room_w,y+(j+1)*room_h,1,1,0,c_white,1)
						}
					}
				}
			}
		}
	}
}

