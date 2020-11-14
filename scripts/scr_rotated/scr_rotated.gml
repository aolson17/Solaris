


///@param _x1 Position that gets rotated
///@param _y1
///@param _x2 Position to rotate around
///@param _y2
///@param _r How many degrees to rotate
function scr_x_rotated_around_point(_x1,_y1,_x2,_y2,_r){
	var dir = point_direction(_x1,_y1,_x2,_y2)
	var dis = -point_distance(_x1,_y1,_x2,_y2)
	
	var adj_x = _x2+lengthdir_x(dis,dir+_r)
	
	return adj_x
}


function scr_y_rotated_around_point(_x1,_y1,_x2,_y2,_r){
	var dir = point_direction(_x1,_y1,_x2,_y2)
	var dis = -point_distance(_x1,_y1,_x2,_y2)
	
	var adj_y = _y2+lengthdir_y(dis,dir+_r)
	
	return adj_y
}