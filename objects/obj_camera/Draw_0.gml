






if selected_ship != noone{
	var selected_ship_center_x = selected_ship.x+selected_ship.ship_center_x
	var selected_ship_center_y = selected_ship.y+selected_ship.ship_center_y
	
	draw_set_color(c_white)
	
	draw_circle(selected_ship_center_x+ship_camera_offset_x,selected_ship_center_y+ship_camera_offset_y,10,false)
	
	draw_set_color(c_blue)
	draw_circle(global.unrotated_mouse_x,global.unrotated_mouse_y,10,false)
	
	draw_set_color(c_green)
	draw_circle(mouse_x,mouse_y,5,false)
	
	
	draw_set_color(c_maroon)
	draw_circle(selected_ship.x+selected_ship.ship_center_x,selected_ship.y+selected_ship.ship_center_y,5,false)
	
	
	var offset_dir = point_direction(selected_ship_center_x,selected_ship_center_y,selected_ship_center_x+ship_camera_offset_x,selected_ship_center_y+ship_camera_offset_y)
	var offset_dis = point_distance(selected_ship_center_x,selected_ship_center_y,selected_ship_center_x+ship_camera_offset_x,selected_ship_center_y+ship_camera_offset_y)
	
	draw_set_color(c_lime)
	draw_circle(selected_ship_center_x+lengthdir_x(offset_dis,offset_dir+selected_ship.angle),selected_ship_center_y+lengthdir_y(offset_dis,offset_dir+selected_ship.angle),10,false)
}





