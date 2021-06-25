

if sprite_exists(sprite_index){
	// Draw the floor grid
	
	for(var k = 0; k < ds_list_size(floor_grids); k++){
		var cur_struct = floor_grids[|k]
		var cur_grid = cur_struct.grid
		var cur_x = cur_struct.x
		var cur_y = cur_struct.y
		
		if point_in_rectangle(mouse_x-x,mouse_y-y,cur_x,cur_y,cur_x+ds_grid_width(cur_grid)*floor_size,cur_y+ds_grid_height(cur_grid)*floor_size){
			for(var i = 0; i < ds_grid_width(cur_grid);i++){
				for(var j = 0; j < ds_grid_height(cur_grid);j++){
			
					//var tl_x = scr_x_rotated_around_point(x+ship_center_x,y+ship_center_y,angle)
			
			
					var x1 = i*floor_size+cur_x+x
					var y1 = j*floor_size+cur_y+y
					//var x2 = (i+1)*ship_floor_size+ship_floor_x1+x
					//var y2 = (j+1)*ship_floor_size+ship_floor_y1+y
			
					switch(cur_grid[# i,j]){
						case floor_types.empty: //draw_set_color(c_lime)
							var spr = spr_grid_green
							//draw_sprite(spr,0,x1,y1)
							break
						case floor_types.wall: //draw_set_color(c_red)
							var spr = spr_grid_red
							break
					}
			
					//draw_rectangle(x1,y1,x2-1,y2-1,true)
					draw_sprite(spr,0,x1,y1)
				}
			}
			
			// Draw elevator destinations
			for(var i = 0; i < cur_struct.elev_dests_count;i++){
				var this_elev = cur_struct.elev_dests[i].elev
				
				var dest_y = cur_struct.elev_dests[i].dest.y+y
				
				draw_circle(this_elev.x,dest_y,3,false)
			}
		}
	}
}

