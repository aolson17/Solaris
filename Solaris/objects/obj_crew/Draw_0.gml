

var number_of_others = 0

with(obj_crew){
	if id != other.id{
		if point_distance(x,y,other.x,other.y) < other.offset_range{
			number_of_others++
		}
	}
}
number_of_others = power(number_of_others,.75)
offset_target_magnitude = (number_of_others*offset_magnitude_factor)*power(offset_magnitude_random_factor,.8)

if using_elevator{
	offset_target_magnitude *= .5
}
if !moving{
	offset_target_magnitude *= 1.2
}

offset_magnitude += (offset_target_magnitude-offset_magnitude)*offset_speed_factor

crowd_adj_x = x + lengthdir_x(offset_magnitude,offset_direction)
crowd_adj_y = y + lengthdir_y(offset_magnitude,offset_direction)

// Rotate x and y around the center of the ship
var adj_x = scr_x_rotated_around_point(crowd_adj_x,crowd_adj_y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)
var adj_y = scr_y_rotated_around_point(crowd_adj_x,crowd_adj_y,my_ship.x+my_ship.ship_center_x,my_ship.y+my_ship.ship_center_y,my_ship.angle)


draw_sprite_ext(sprite_index,image_index,adj_x,adj_y,image_xscale,image_yscale,my_ship.angle,c_white,image_alpha)
draw_sprite_ext(sprite_gun,image_index,adj_x,adj_y,image_xscale,image_yscale,my_ship.angle,c_white,image_alpha)
draw_sprite_ext(sprite_details,image_index,adj_x,adj_y,image_xscale,image_yscale,my_ship.angle,c_white,image_alpha)



if using_elevator{
	draw_sprite_ext(spr_using_elevator,0,adj_x,adj_y,1,1,my_ship.angle,c_white,1)
}