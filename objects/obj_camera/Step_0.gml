

var look_dir = point_direction(target.x,target.y,mouse_x,mouse_y)
var look_power = point_distance(target.x,target.y,mouse_x,mouse_y)/60

target_x = (target.x)+lengthdir_x(look_power,look_dir)
target_y = (target.y)+lengthdir_y(look_power,look_dir)


if mouse_wheel_down(){
	zoom *= 1.2
}
if mouse_wheel_up(){
	zoom *= .9
}
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

x += spd_factor*(target_x-x+shake_offset_x)
y += spd_factor*(target_y-y+shake_offset_y)

camera_set_view_pos(camera, (x-zoom_width/2), (y-zoom_height/2))
camera_set_view_size(camera,zoom_width,zoom_height)