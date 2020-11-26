






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
	
	draw_set_color(c_lime)
	draw_circle(ship_cam_x,ship_cam_y,10,false)
}



// Show selected ship
with(selected_ship){
	draw_set_color(c_blue)
	draw_circle(x,y,20,true)
	draw_circle(x,y,19,true)
	draw_circle(x,y,18,true)
}

