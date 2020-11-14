



if sprite_exists(sprite_index){
	
	
	ship_center_x = sprite_width/2
	ship_center_y = sprite_height/2
	
	
	
	
	//var dir = point_direction(x,y,x+ship_center_x,y+ship_center_y)
	//var dis = -point_distance(x,y,x+ship_center_x,y+ship_center_y)
	//
	//var adj_x = x+ship_center_x+lengthdir_x(dis,dir-angle)
	//var adj_y = y+ship_center_y+lengthdir_y(dis,dir-angle)
	
	var adj_x = scr_x_rotated_around_point(x,y,x+ship_center_x,y+ship_center_y,angle)
	var adj_y = scr_y_rotated_around_point(x,y,x+ship_center_x,y+ship_center_y,angle)
	
	draw_sprite_ext(sprite_index,0,adj_x,adj_y,1,1,angle,c_white,1)
	
	//draw_self()
}

