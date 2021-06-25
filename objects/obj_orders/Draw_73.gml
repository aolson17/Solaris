
if !ds_list_empty(selected_crew){
	if is_struct(selected_crew[|0].order_path_field){
		var cur_grid = selected_crew[|0].order_path_field.grid
		var cur_x = selected_crew[|0].order_path_field.target_grid_str.x
		var cur_y = selected_crew[|0].order_path_field.target_grid_str.y
	
		for(var i = 0; i < ds_grid_width(cur_grid);i++){
			for(var j = 0; j < ds_grid_height(cur_grid);j++){
				if cur_grid[# i,j] != -1{
					if cur_grid[# i,j].needed{
						// The grid size is half of the floor size
						var x1 = i*floor_size/2+cur_x+selected_ship.x
						var y1 = j*floor_size/2+cur_y+selected_ship.y
			
						//draw_set_color(c_white)
						//draw_text(x1,y1,cur_grid[# i,j].dis)
					
					
						x1 += .5*floor_size/2
						y1 += .5*floor_size/2
					
						draw_line_color(x1,y1,x1+cur_grid[# i,j].vec_x*5,y1+cur_grid[# i,j].vec_y*5,c_blue,c_black)
					}
				}
			}
		}
	}
}

draw_set_color(c_green)
for (var i = 0; i < ds_list_size(path_fields); i++){
	var x1 = path_fields[|i].goal_x+selected_ship.x
	var y1 = path_fields[|i].goal_y+selected_ship.y
	
	draw_circle(x1,y1,3,false)
}
