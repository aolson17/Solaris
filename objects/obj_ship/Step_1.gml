

if room != rm_builder && mass != 0{
	if id = obj_orders.selected_ship{ // If ship is controlled by the player
		
		#region Activate thrusters
		for(var i = 0; i < ds_list_size(ship_externals); i++){
			with (ship_externals[|i]){
				if object_is_ancestor(object_index,par_thruster){
					active = false
					if keyboard_check(ord("D")){
						if thrust_right > 0{
							active = thrust_right/thrust
						}
					}
					if keyboard_check(ord("A")){
						if thrust_left > 0{
							active = thrust_left/thrust
						}
					}
					if keyboard_check(ord("W")){
						if thrust_up > 0{
							active = thrust_up/thrust
						}
					}
					if keyboard_check(ord("S")){
						if thrust_down > 0{
							active = thrust_down/thrust
						}
					}
				}
				if object_is_ancestor(object_index,par_rotation_thruster){
					active = false
					if keyboard_check(ord("Q")){
						active = 1
					}
					if keyboard_check(ord("E")){
						active = -1
					}
				}
			}
		}
		#endregion
	
		#region Control lateral movement
	
		move_x = (keyboard_check(ord("D"))*thrust_right-keyboard_check(ord("A"))*thrust_left)/(mass/26)
		move_y = (keyboard_check(ord("S"))*thrust_down-keyboard_check(ord("W"))*thrust_up)/(mass/26)
	
		var move_dir = point_direction(0,0,move_x,move_y)
		var move_dis = point_distance(0,0,move_x,move_y)
	
		xsp += lengthdir_x(move_dis,move_dir+angle)
		ysp += lengthdir_y(move_dis,move_dir+angle)
	
		#endregion
	
		#region Control rotation
	
		move_r = thrust_r*(keyboard_check(ord("E"))-keyboard_check(ord("Q")))/35
	
		rsp += move_r
		
		#endregion
	
		if keyboard_check_pressed(ord("X")){
			xsp = 0
			rsp = 0
			ysp = 0
		}
		if keyboard_check_pressed(ord("Z")){
			angle = 0
		}
	
	}
	
	#region Execute lateral movement
	if xsp != 0 || ysp != 0{
		x += xsp
		y += ysp
		
		if obj_camera.selected_ship = id{
			obj_camera.x += xsp
			obj_camera.y += ysp
			obj_camera.target_x += xsp
			obj_camera.target_y += ysp
			obj_camera.drag_origin_x += xsp
			obj_camera.drag_origin_y += ysp
			obj_camera.drag_origin_mouse_x += xsp
			obj_camera.drag_origin_mouse_y += ysp
		}
		
		if obj_orders.selected_ship = id{
			obj_orders.selected_area_x += xsp
			obj_orders.selected_area_y += ysp
		}
		
		for(var i = 0; i < ds_list_size(ship_externals); i++){
			var current = ship_externals[|i]
			current.x += xsp
			current.y += ysp
		}
		for(var i = 0; i < ds_list_size(ship_rooms); i++){
			var current = ship_rooms[|i]
			current.x += xsp
			current.y += ysp
		}
		for(var i = 0; i < ds_list_size(ship_internals); i++){
			var current = ship_internals[|i]
			current.x += xsp
			current.y += ysp
		}
		for(var i = 0; i < ds_list_size(ship_props); i++){
			var current = ship_props[|i]
			current.x += xsp
			current.y += ysp
		}
		for(var i = 0; i < ds_list_size(ship_crew); i++){
			var current = ship_crew[|i]
			current.x += xsp
			current.y += ysp
		}
	}
	#endregion
	
	#region Execute rotation
	
	angle -= rsp
	
	#endregion
}
