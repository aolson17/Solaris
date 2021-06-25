


draw_set_color(c_red)
if !ds_list_empty(orders){ // If there are orders to do
	var current_order = orders[|0]
	
	// Default to moving to the goal of the order
	var order_x = current_order.x
	var order_y = current_order.y
	var move_type = move_types.walk
	draw_circle(order_x+current_ship.x,order_y+current_ship.y,3,false)
	
	// Check if there are multiple steps to the order
	for (var i = 0; i < current_order.steps_count; i++){
		var current_step = current_order.current_step
		// Go to this step of the order
		if is_struct(current_order.steps[current_step]){
			order_x = current_order.steps[current_step].x
			order_y = current_order.steps[current_step].y
			move_type = current_order.steps[current_step].type
			draw_circle(order_x+current_ship.x,order_y+current_ship.y,2,false)
		}
	}
	
	
	draw_set_color(c_blue)
	draw_circle(order_x+current_ship.x,order_y+current_ship.y,2,false)
	
	draw_set_color(c_white)
	draw_text(x,y-50,current_order.current_step)
}else{
	draw_circle(x,y,2,false)
}

/*for(var i = 0; i < ds_list_size(orders)-1; i++){
	var current_order = orders[|i]
	var next_order = orders[|i+1]
	draw_set_color(c_red)
	
	// Rotate order positions around the center of the ship
	var adj_x_current = scr_x_rotated_around_point(current_order.x+current_ship.x,current_order.y+current_ship.y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	var adj_y_current = scr_y_rotated_around_point(current_order.x+current_ship.x,current_order.y+current_ship.y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	
	var adj_x_next = scr_x_rotated_around_point(next_order.x+current_ship.x,next_order.y+current_ship.y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	var adj_y_next = scr_y_rotated_around_point(next_order.x+current_ship.x,next_order.y+current_ship.y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	
	var adj_x_current = current_order.x+current_ship.x
	var adj_y_current = current_order.y+current_ship.y
	var adj_x_next = next_order.x+current_ship.x
	var adj_y_next = next_order.y+current_ship.y
	
	draw_line(adj_x_current,adj_y_current,adj_x_next,adj_y_next)
	//draw_line(current_order.x+current_ship.x,current_order.y+current_ship.y,next_order.x+current_ship.x,next_order.y+current_ship.y)
	//draw_text(current_order.x+current_ship.x,current_order.y+current_ship.y,string(i))
}

if !ds_list_empty(orders){
	var current_order = orders[|0]
	
	var adj_x_current = scr_x_rotated_around_point(current_order.x+current_ship.x,current_order.y+current_ship.y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	var adj_y_current = scr_y_rotated_around_point(current_order.x+current_ship.x,current_order.y+current_ship.y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	
	// Rotate x and y around the center of the ship
	var adj_x = scr_x_rotated_around_point(x,y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	var adj_y = scr_y_rotated_around_point(x,y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
	
	var adj_x = adj_x_current
	var adj_y = adj_y_current
	
	draw_set_color(c_red)
	draw_line(adj_x_current,adj_y_current,adj_x,adj_y)
}
