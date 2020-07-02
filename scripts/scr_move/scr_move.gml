/// @function scr_move_collide(xspd,yspd)
/// @description Attempts to move the character while checking for collisions
/// @param {Int} xspd
/// @param {Int} yspd
/// @return {Boolean} Success

var xspd_ = argument0
var yspd_ = argument1

var sprite_width_offset = 6


x+=xspd_
var x_moved = true
if collision_point(x-sprite_width_offset,y,par_solid,true,true) || collision_point(x+sprite_width_offset,y,par_solid,true,true) || !collision_rectangle(x+sprite_width_offset,y,x+sprite_width_offset-1,y-1,par_room,true,true) || !collision_rectangle(x-sprite_width_offset,y,x-sprite_width_offset+1,y-1,par_room,true,true){
	x-=xspd_
	x_moved = false
}

y+=yspd_
var y_moved = true
if collision_point(x-sprite_width_offset,y,par_solid,true,true) || collision_point(x+sprite_width_offset,y,par_solid,true,true) || !collision_point(x+sprite_width_offset-1,y,par_room,true,true) || !collision_point(x-sprite_width_offset+1,y,par_room,true,true){
	y-=yspd_
	y_moved = false
}


if y_moved || x_moved{
	return true
}


/*if xspd_ != 0{
	if !collision_point(x+xspd_+sprite_width_offset,y,par_room,true,true){
		while(collision_point(x+sprite_width_offset+sign(xspd_),y,par_room,true,true)){
			x+=sign(xspd_)
		}
		x = round(x)
	}else{
		can_move = true
		x+=xspd_
	}
}

if yspd_ != 0{
	if !collision_point(x,y+yspd_,par_room,true,true){
		while(collision_point(x,y+sign(yspd_),par_room,true,true)){
			y+=sign(yspd_)
		}
		y = round(y)
	}else{
		can_move = true
		y+=yspd_
	}
}*/
