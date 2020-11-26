
// Inherit the parent event
event_inherited()

if room != rm_builder && active != 0{
	if surface_exists(part_surf){
		surface_set_target(part_surf);
		draw_clear_alpha(c_black,0)
		part_system_drawit(ps_thruster);
		//draw_rectangle(0,0,sprite_width*5,sprite_height*5,false)
		surface_reset_target();
	}else{
		part_surf = surface_create(sprite_width*5,sprite_height*5)
	}
	
	var my_ship_center_x = my_ship.x+my_ship.ship_center_x
	var my_ship_center_y = my_ship.y+my_ship.ship_center_y
	
	var angle_offset = 90+point_direction(x,y,my_ship_center_x,my_ship_center_y)-active*90 // The offset for the angle of the surface so the particles go in the correct direction
	
	
	// Rotate x and y around the center of the ship
	var adj_x = scr_x_rotated_around_point(x,y,my_ship_center_x,my_ship_center_y,my_ship.angle)
	var adj_y = scr_y_rotated_around_point(x,y,my_ship_center_x,my_ship_center_y,my_ship.angle)
	
	// Adjust for the the distance away the particles must come from
	var adj_x = adj_x+lengthdir_x(part_region_distance,90*active+point_direction(adj_x,adj_y,my_ship_center_x,my_ship_center_y))
	var adj_y = adj_y+lengthdir_y(part_region_distance,90*active+point_direction(adj_x,adj_y,my_ship_center_x,my_ship_center_y))

	// Rotate the adjusted x and y around the center of the surface to keep the surface in the correct place while rotating the surface about its top left point
	var adj_x_surf = scr_x_rotated_around_point(adj_x-surface_get_width(part_surf)/2,adj_y-surface_get_height(part_surf)/2,adj_x,adj_y,my_ship.angle+angle_offset)
	var adj_y_surf = scr_y_rotated_around_point(adj_x-surface_get_width(part_surf)/2,adj_y-surface_get_height(part_surf)/2,adj_x,adj_y,my_ship.angle+angle_offset)
	
	draw_surface_ext(part_surf,adj_x_surf,adj_y_surf,1,1,my_ship.angle+angle_offset,c_white,1)
}