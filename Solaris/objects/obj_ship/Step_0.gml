




move_x = keyboard_check(vk_right)-keyboard_check(vk_left)
move_y = keyboard_check(vk_down)-keyboard_check(vk_up)
dir = point_direction(0,0,move_x,move_y)
if move_x != 0 || move_y != 0{
	var change_x = lengthdir_x(spd,dir)
	var change_y = lengthdir_y(spd,dir)
	x += change_x
	y += change_y
	for(var i = 0; i < ds_list_size(ship_externals); i++){
		var current = ship_externals[|i]
		current.x += change_x
		current.y += change_y
	}
	for(var i = 0; i < ds_list_size(ship_rooms); i++){
		var current = ship_rooms[|i]
		current.x += change_x
		current.y += change_y
	}
}



