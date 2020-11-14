/// @description Controls




if selected_ship != noone{ // If following a ship
	
	var selected_ship_center_x = selected_ship.x+selected_ship.ship_center_x
	var selected_ship_center_y = selected_ship.y+selected_ship.ship_center_y
	
	var offset_dir = point_direction(selected_ship_center_x,selected_ship_center_y,selected_ship_center_x+ship_camera_offset_x,selected_ship_center_y+ship_camera_offset_y)
	var offset_dis = point_distance(selected_ship_center_x,selected_ship_center_y,selected_ship_center_x+ship_camera_offset_x,selected_ship_center_y+ship_camera_offset_y)
	
	ship_cam_x = selected_ship_center_x+lengthdir_x(offset_dis,offset_dir+selected_ship.angle)
	ship_cam_y = selected_ship_center_y+lengthdir_y(offset_dis,offset_dir+selected_ship.angle)
	
	
	var rotated_cam_x = selected_ship_center_x+lengthdir_x(offset_dis,offset_dir+selected_ship.angle)
	var rotated_cam_y = selected_ship_center_y+lengthdir_y(offset_dis,offset_dir+selected_ship.angle)
	
	// TODO: take the rsp into account like xsp and ysp
	var dir = point_direction(rotated_cam_x,rotated_cam_y,mouse_x+selected_ship.xsp,mouse_y+selected_ship.ysp)
	var dis = point_distance(rotated_cam_x,rotated_cam_y,mouse_x+selected_ship.xsp,mouse_y+selected_ship.ysp)
	
	global.unrotated_mouse_x = selected_ship_center_x+ship_camera_offset_x+lengthdir_x(dis,dir-selected_ship.angle)
	global.unrotated_mouse_y = selected_ship_center_y+ship_camera_offset_y+lengthdir_y(dis,dir-selected_ship.angle)
}else{ // If not following a ship
	
	global.unrotated_mouse_x = mouse_x
	global.unrotated_mouse_y = mouse_y
}








drag_key_pressed = mouse_check_button_pressed(mb_middle)// || mouse_check_button_pressed(mb_right)
drag_key = mouse_check_button(mb_middle)// || mouse_check_button(mb_right)




if selected_ship != noone{
	camera_set_view_pos(camera, (ship_cam_x-zoom_width/2), (ship_cam_y-zoom_height/2))
	camera_set_view_angle(camera,-selected_ship.angle)
}else{
	camera_set_view_pos(camera, (x-zoom_width/2), (y-zoom_height/2))
	camera_set_view_angle(camera, 0)
}



camera_set_view_size(camera,zoom_width,zoom_height)


