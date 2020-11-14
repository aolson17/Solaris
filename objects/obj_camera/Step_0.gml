
if room = rm_builder{
	move_x = keyboard_check(ord("D"))-keyboard_check(ord("A"))
	move_y = keyboard_check(ord("S"))-keyboard_check(ord("W"))
	
	dir = point_direction(0,0,move_x,move_y)
	if move_x != 0 || move_y != 0{
		target_x += lengthdir_x(spd*zoom,dir)
		target_y += lengthdir_y(spd*zoom,dir)
	}
}else{
	
	// Select a ship
	//if mouse_check_button_pressed(mb_middle){
	if keyboard_check_pressed(vk_space){
		if selected_ship != instance_nearest(x,y,obj_ship){
			selected_ship = instance_nearest(x,y,obj_ship)
			ship_camera_offset_x = x-(selected_ship.x+selected_ship.ship_center_x)
			ship_camera_offset_y = y-(selected_ship.y+selected_ship.ship_center_y)
		}
		
		
	}
}


if selected_ship != noone{
	if drag_key_pressed{
		//var selected_ship_center_x = 0//selected_ship.x+selected_ship.ship_center_x
		//var selected_ship_center_y = 0//selected_ship.y+selected_ship.ship_center_y
		//
		//drag_origin_x = selected_ship_center_x+ship_camera_offset_x
		//drag_origin_y = selected_ship_center_y+ship_camera_offset_y
		//drag_origin_mouse_x = device_mouse_x_to_gui(0) //global.unrotated_mouse_x
		//drag_origin_mouse_y = device_mouse_y_to_gui(0) //global.unrotated_mouse_y
	}
	if drag_key{
		var selected_ship_center_x = 0//selected_ship.x+selected_ship.ship_center_x
		var selected_ship_center_y = 0//selected_ship.y+selected_ship.ship_center_y
		
		//target_x = drag_origin_mouse_x+drag_origin_x-(device_mouse_x_to_gui(0)-(selected_ship_center_x+ship_camera_offset_x-drag_origin_x))
		//target_y = drag_origin_mouse_y+drag_origin_y-(device_mouse_y_to_gui(0)-(selected_ship_center_y+ship_camera_offset_y-drag_origin_y))
		//ship_camera_offset_x += (target_x-ship_camera_offset_x)*drag_spd_factor
		//ship_camera_offset_y += (target_y-ship_camera_offset_y)*drag_spd_factor
		ship_camera_offset_x -= (device_mouse_x_to_gui(0)-prev_mouse_gui_x)*(zoom_width/view_wport[0])
		ship_camera_offset_y -= (device_mouse_y_to_gui(0)-prev_mouse_gui_y)*(zoom_height/view_hport[0])
	}
}else{
	if drag_key_pressed{
		drag_origin_x = x
		drag_origin_y = y
		drag_origin_mouse_x = global.unrotated_mouse_x
		drag_origin_mouse_y = global.unrotated_mouse_y
	}
	if drag_key{
		target_x = drag_origin_mouse_x+drag_origin_x-(global.unrotated_mouse_x-(x-drag_origin_x))
		target_y = drag_origin_mouse_y+drag_origin_y-(global.unrotated_mouse_y-(y-drag_origin_y))
		x += (target_x-x)*drag_spd_factor
		y += (target_y-y)*drag_spd_factor
	}else{
		x += (target_x-x)*spd_factor
		y += (target_y-y)*spd_factor
	}
}
prev_mouse_gui_x = device_mouse_x_to_gui(0)
prev_mouse_gui_y = device_mouse_y_to_gui(0)

if mouse_wheel_down(){
	zoom_target *= 1.1
    var cx = (global.unrotated_mouse_x - x) / zoom // Keep mouse in the same position relative to the screen
    var cy = (global.unrotated_mouse_y - y) / zoom
    target_x = global.unrotated_mouse_x - cx * zoom_target
    target_y = global.unrotated_mouse_y - cy * zoom_target
}
if mouse_wheel_up(){
	zoom_target *= .9
    var cx = (global.unrotated_mouse_x - x) / zoom // Keep mouse in the same position relative to the screen
    var cy = (global.unrotated_mouse_y - y) / zoom
    target_x = global.unrotated_mouse_x - cx * zoom_target
    target_y = global.unrotated_mouse_y - cy * zoom_target
}
zoom += (zoom_target-zoom)*zoom_spd_factor
zoom_width = width * zoom
zoom_height = height * zoom


if shake > 0{
	shake_offset_x = choose(-1,1)*((irandom(shake)+1)*4)
	shake_offset_y = choose(-1,1)*((irandom(shake)+1)*4)
	shake--
}else{
	shake_offset_x = 0
	shake_offset_y = 0
}



if keyboard_check(ord("M")){
	angle+=.5
}
if keyboard_check(ord("N")){
	angle-=.5
}

/*
if selected_ship != noone{
	camera_set_view_pos(camera, (rotated_x-zoom_width/2), (rotated_y-zoom_height/2))
	camera_set_view_angle(camera, -selected_ship.angle)
}else{
	camera_set_view_pos(camera, (x-zoom_width/2), (y-zoom_height/2))
	camera_set_view_angle(camera, 0)
}



camera_set_view_size(camera,zoom_width,zoom_height)

