
// Inherit the parent event
event_inherited()





if surface_exists(part_surf){
	surface_set_target(part_surf);
	draw_clear_alpha(c_black,0)
	part_system_drawit(ps_thruster);
	surface_reset_target();
}else{
	part_surf = surface_create(sprite_width*5,sprite_height*5)
}

// Rotate x and y around the center of the ship
var adj_x = scr_x_rotated_around_point(x,y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
var adj_y = scr_y_rotated_around_point(x,y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)

// Rotate the adjusted x and y around the center of the surface and account for part_region_distance
var adj_x_surf = scr_x_rotated_around_point(adj_x-surface_get_width(part_surf)/2 + lengthdir_x(part_region_distance,image_angle+90),adj_y-surface_get_height(part_surf)/2 + lengthdir_y(part_region_distance,image_angle+90),adj_x,adj_y,my_ship.angle)
var adj_y_surf = scr_y_rotated_around_point(adj_x-surface_get_width(part_surf)/2 + lengthdir_x(part_region_distance,image_angle+90),adj_y-surface_get_height(part_surf)/2 + lengthdir_y(part_region_distance,image_angle+90),adj_x,adj_y,my_ship.angle)

draw_surface_ext(part_surf,adj_x_surf,adj_y_surf,1,1,my_ship.angle,c_white,1)

if point_distance(x,y,mouse_x,mouse_y) < 30{
	show_debug_message("Up "+string(thrust_up))
	show_debug_message("Down "+string(thrust_down))
	show_debug_message("Left "+string(thrust_left))
	show_debug_message("Right "+string(thrust_right))
	show_debug_message("Thrust "+string(thrust))
	show_debug_message("Angle "+string(image_angle))
}
