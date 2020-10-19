



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

if needs_elevator{
	offset_target_magnitude *= .5
}
if using_elevator{
	offset_target_magnitude *= .5
}
if !moving{
	offset_target_magnitude *= 1.2
}

offset_magnitude += (offset_target_magnitude-offset_magnitude)*offset_speed_factor

var adj_x = x + lengthdir_x(offset_magnitude,offset_direction)
var adj_y = y + lengthdir_y(offset_magnitude,offset_direction)

draw_sprite_ext(sprite_index,image_index,adj_x,adj_y,image_xscale,image_yscale,image_angle,c_white,image_alpha)
draw_sprite_ext(sprite_gun,image_index,adj_x,adj_y,image_xscale,image_yscale,image_angle,c_white,image_alpha)
draw_sprite_ext(sprite_details,image_index,adj_x,adj_y,image_xscale,image_yscale,image_angle,c_white,image_alpha)


if using_elevator{
	draw_sprite(spr_using_elevator,0,x,y)
}