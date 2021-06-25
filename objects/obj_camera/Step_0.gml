
if room = rm_builder{
	move_x = keyboard_check(ord("D"))-keyboard_check(ord("A"))
	move_y = keyboard_check(ord("S"))-keyboard_check(ord("W"))
	
	dir = point_direction(0,0,move_x,move_y)
	if move_x != 0 || move_y != 0{
		target_x += lengthdir_x(spd*zoom,dir)
		target_y += lengthdir_y(spd*zoom,dir)
	}
}else{
	
	// Select a ship or deselect current ship
	if keyboard_check_pressed(vk_space){
		if selected_ship = noone{
			if selected_ship != instance_nearest(mouse_x,mouse_y,obj_ship){
				selected_ship = instance_nearest(mouse_x,mouse_y,obj_ship)
				ship_camera_offset_x = x-selected_ship.x
				ship_camera_offset_y = y-selected_ship.y
			}
		}else{
			selected_ship = noone
			target_x = x
			target_y = y
		}
	}
}


if selected_ship != noone{
	if drag_key{
		ship_camera_offset_x -= (device_mouse_x_to_gui(0)-prev_mouse_gui_x)*(zoom_width/view_wport[0])
		ship_camera_offset_y -= (device_mouse_y_to_gui(0)-prev_mouse_gui_y)*(zoom_height/view_hport[0])
	}
	x = selected_ship.x+ship_camera_offset_x
	y = selected_ship.y+ship_camera_offset_y
}else{
	if drag_key_pressed{
		drag_origin_x = x
		drag_origin_y = y
		drag_origin_mouse_x = mouse_x
		drag_origin_mouse_y = mouse_y
	}
	if drag_key{
		target_x = drag_origin_mouse_x+drag_origin_x-(mouse_x-(x-drag_origin_x))
		target_y = drag_origin_mouse_y+drag_origin_y-(mouse_y-(y-drag_origin_y))
		x += (target_x-x)*drag_spd_factor
		y += (target_y-y)*drag_spd_factor
	}else{
		x += (target_x-x)*spd_factor
		y += (target_y-y)*spd_factor
	}
}
prev_mouse_gui_x = device_mouse_x_to_gui(0)
prev_mouse_gui_y = device_mouse_y_to_gui(0)

#region Zoom

if mouse_wheel_down(){
	zoom_target *= 1.1
    var cx = (mouse_x - x) / zoom // Keep mouse in the same position relative to the screen
    var cy = (mouse_y - y) / zoom
	// Zoom away from mouse location
    //target_x = global.unrotated_mouse_x - cx * zoom_target
    //target_y = global.unrotated_mouse_y - cy * zoom_target
}
if mouse_wheel_up(){
	zoom_target *= .9
    var cx = (mouse_x - x) / zoom // Keep mouse in the same position relative to the screen
    var cy = (mouse_y - y) / zoom
	// Zoom into mouse location
    //target_x = global.unrotated_mouse_x - cx * zoom_target
    //target_y = global.unrotated_mouse_y - cy * zoom_target
}
zoom += (zoom_target-zoom)*zoom_spd_factor
zoom_width = width * zoom
zoom_height = height * zoom

#endregion

#region Camera shake

if shake > 0{
	shake_offset_x = choose(-1,1)*((irandom(shake)+1)*4)
	shake_offset_y = choose(-1,1)*((irandom(shake)+1)*4)
	shake--
}else{
	shake_offset_x = 0
	shake_offset_y = 0
}

#endregion

#region Update camera position

camera_set_view_pos(camera, (x-zoom_width/2), (y-zoom_height/2))
camera_set_view_size(camera,zoom_width,zoom_height)

#endregion

