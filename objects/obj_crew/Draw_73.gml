




for(var i = 0; i < ds_list_size(orders)-1; i++){
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
