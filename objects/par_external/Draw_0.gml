





if room = rm_builder{
	//draw_self()
	
	// Show if selecting
	if id = obj_builder.selecting{
		draw_set_alpha(.2)
		draw_set_color(c_blue)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		draw_set_alpha(1)
	}
	// Show anchor indicator
	if id = obj_builder.moving && anchor_chunk = -1{
		draw_set_alpha(.2)
		draw_set_color(c_yellow)//c_maroon)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		draw_set_alpha(1)
	}
	// Show collision indicator for rooms and other externals
	if id = obj_builder.moving && obj_builder.brush_col{
		draw_set_alpha(.2)
		draw_set_color(c_red)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		draw_set_alpha(1)
	}
}else{ // Not in the builder
}


if sprite_index != -1{
	if !surface_exists(surf){
		surf = surface_create(sprite_width*3,sprite_height*3)
	}
	
	
	surface_set_target(surf)
	draw_clear_alpha(c_black,0)
		
	draw_sprite_ext(sprite_index,image_index,surface_get_width(surf)/2,surface_get_height(surf)/2,1,1,image_angle,c_white,1)
		
	surface_reset_target()
	
	if room != rm_builder{
	// Rotate x and y around the center of the ship
		var adj_x = scr_x_rotated_around_point(x,y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
		var adj_y = scr_y_rotated_around_point(x,y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
		var angle = my_ship.angle
	}else{
		var adj_x = x
		var adj_y = y
		var angle = 0//image_index
	}
	
	// Rotate the adjusted x and y around the center of the surface
	var adj_x_surf = scr_x_rotated_around_point(adj_x-surface_get_width(surf)/2,adj_y-surface_get_height(surf)/2,adj_x,adj_y,angle)
	var adj_y_surf = scr_y_rotated_around_point(adj_x-surface_get_width(surf)/2,adj_y-surface_get_height(surf)/2,adj_x,adj_y,angle)
		
	draw_surface_ext(surf,adj_x_surf,adj_y_surf,1,1,angle,c_white,1)
}