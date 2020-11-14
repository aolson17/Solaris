


function move_to(_x,_y){
	
	var dir = point_direction(x,y,_x,_y)
	
	if point_distance(x,y,_x,_y) < spd{
		x = _x
		y = _y
	}else{
		x += lengthdir_x(spd,dir)
		y += lengthdir_y(spd,dir)
	}
	
	if x < _x{
		image_xscale = 1
	}else if x > _x{
		image_xscale = -1
	}
	
}



if !ds_list_empty(orders){ // If there are orders to do
	var current_order = orders[|0]
	
	using_elevator = current_order.elevator_stage = elevator_stages.in
	
	move_to(current_order.x+current_ship.x,current_order.y+current_ship.y)
	
	if point_distance(x,y,current_order.x+current_ship.x,current_order.y+current_ship.y) < 1{ // If reached order position
		if current_order.use = noone{ // If order was just a move order
			
			ds_list_delete(orders,0)
			
		}else{ // There is some object to use now
			// TODO use object somehow
		}
	}
}else{
	using_elevator = false
}




