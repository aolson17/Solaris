

if selected_ship != noone{

	// Rotate x and y around the center of the ship
	var adj_x = scr_x_rotated_around_point(floor_mouse_x,floor_mouse_y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)
	var adj_y = scr_y_rotated_around_point(floor_mouse_x,floor_mouse_y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)

	draw_circle_color(adj_x,adj_y,5,c_red,c_black,false)
}


draw_circle_color(global.unrotated_mouse_x,global.unrotated_mouse_y,10,c_blue,c_black,false)
draw_circle_color(floor_mouse_x,floor_mouse_y,10,c_green,c_black,false)

draw_set_color(c_blue)
draw_circle(global.unrotated_mouse_x,global.unrotated_mouse_y,10,false)


// If hold clicking
if mouse_check_button(mb_left) && point_distance(mouse_x,mouse_y,selected_area_x,selected_area_y) > selected_area_min{
	draw_set_color(c_red)
	
	// Rotate x and y around the center of the ship
	var rotated_select_x = scr_x_rotated_around_point(selected_area_x,selected_area_y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)
	var rotated_select_y = scr_y_rotated_around_point(selected_area_x,selected_area_y,selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,selected_ship.angle)
	
	// The scalar projection of b onto a is |b|cos(theta)
	var hypotenuse_dis = point_distance(rotated_select_x,rotated_select_y,mouse_x,mouse_y)
	var hyp_ship_theta = angle_difference(point_direction(rotated_select_x,rotated_select_y,mouse_x,mouse_y),selected_ship.angle)
	var distance_to_other_points = hypotenuse_dis*cos(degtorad(hyp_ship_theta))
	
	var x1 = rotated_select_x
	var y1 = rotated_select_y
	var x2 = rotated_select_x+lengthdir_x(distance_to_other_points,selected_ship.angle)
	var y2 = rotated_select_y+lengthdir_y(distance_to_other_points,selected_ship.angle)
	var x3 = mouse_x
	var y3 = mouse_y
	var x4 = mouse_x-lengthdir_x(distance_to_other_points,selected_ship.angle)
	var y4 = mouse_y-lengthdir_y(distance_to_other_points,selected_ship.angle)
	
	// Draw the selection area
	draw_primitive_begin(pr_linestrip)
	draw_vertex(x1,y1) // Top left
	draw_vertex(x2,y2) // Top right
	draw_vertex(x3, y3) // Bottom right
	draw_vertex(x4,y4) // Bottom left
	draw_vertex(x1, y1) // Top left
	draw_primitive_end()
	
}

draw_set_color(c_green)
for (var i = 0; i < ds_list_size(selected_crew); i++){
	with (selected_crew[|i]){
		
		// Rotate x and y around the center of the ship
		var adj_x = scr_x_rotated_around_point(crowd_adj_x,crowd_adj_y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
		var	adj_y = scr_y_rotated_around_point(crowd_adj_x,crowd_adj_y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
		
		//draw_rectangle(adj_bbox_left,adj_bbox_top,adj_bbox_right,adj_bbox_bottom,false)
		draw_sprite_ext(spr_crew_selected,0,adj_x,adj_y,1,1,my_ship.angle,c_white,1)
	}
}

// Show selected ship
with(selected_ship){
	draw_set_color(c_white)
	draw_circle(x,y,10,true)
	draw_circle(x,y,9,true)
	draw_circle(x,y,8,true)
}