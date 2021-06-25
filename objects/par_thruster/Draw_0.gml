
// Inherit the parent event
event_inherited()



if room != rm_builder{
	if surface_exists(part_surf){
		surface_set_target(part_surf);
		draw_clear_alpha(c_black,0)
		part_system_drawit(ps_thruster);
		surface_reset_target();
	}else{
		part_surf = surface_create(sprite_width*5,sprite_height*5)
	}

	// Rotate the adjusted x and y around the center of the surface and account for part_region_distance
	//var adj_x_surf = scr_x_rotated_around_point(x-surface_get_width(part_surf)/2 + lengthdir_x(part_region_distance,image_angle+90),y-surface_get_height(part_surf)/2 + lengthdir_y(part_region_distance,image_angle+90),adj_x,adj_y,my_ship.angle)
	//var adj_y_surf = scr_y_rotated_around_point(x-surface_get_width(part_surf)/2 + lengthdir_x(part_region_distance,image_angle+90),y-surface_get_height(part_surf)/2 + lengthdir_y(part_region_distance,image_angle+90),adj_x,adj_y,my_ship.angle)
	
	// Move the particles to the end of the thruster
	var adj_x = x-surface_get_width(part_surf)/2+lengthdir_x(part_region_distance,image_angle+90)
	var adj_y = y-surface_get_height(part_surf)/2+lengthdir_y(part_region_distance,image_angle+90)
	
	
	//draw_surface_ext(part_surf,adj_x_surf,adj_y_surf,1,1,my_ship.angle,c_white,1)
	draw_surface_ext(part_surf,adj_x,adj_y,1,1,0,c_white,1)
}