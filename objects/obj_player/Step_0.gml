

if global.mode = mode.player{
	move_x = keyboard_check(ord("D"))-keyboard_check(ord("A"))
	move_y = keyboard_check(ord("S"))-keyboard_check(ord("W"))
}else{
	move_x = 0
	move_y = 0
}

var moving = false
if move_x != 0 || move_y != 0{
	moving = true
	dir = point_direction(0,0,move_x,move_y)
	xspd = lengthdir_x(speed_x,dir)
	yspd = lengthdir_y(speed_y,dir)
	move_success = scr_move(xspd,yspd)
	if !move_success{
		moving = false
	}
}



//show_debug_message("player x " + string(x))
//show_debug_message("player y " + string(y))


