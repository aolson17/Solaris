

///@description Draws a room with the specified parameters
///@param _x Top left position
///@param _y
///@param _y_wall The wall height to use to line up walls across rooms
///@param _sections_wide How many sections wide the room is
///@param _sections_tall How many sections tall the wall of the room is, then more is added for the floor
function draw_room(_x,_y,_y_wall,_sections_wide,_sections_tall){
	
	for(var i = 0; i < _sections_wide; i++){
		for(var j = 0; j < _sections_tall; j++){
			if (j+(_y_wall/section_size))%2 != 0{
				draw_sprite(spr_room_wall_lower,0,_x+i*section_size,_y+j*section_size)
			}else{
				draw_sprite(spr_room_wall_upper,0,_x+i*section_size,_y+j*section_size)
			}
		}
		draw_sprite(spr_room_floor,0,_x+i*section_size,_y+_sections_tall*section_size)
	}

	for(var i = 0; i < _sections_wide; i++){
		draw_sprite(spr_room_ceiling,0,_x+i*section_size,_y)
	}
}


if room = rm_builder{
	draw_room(x,y,y,sections_wide,sections_tall)
	
	// Draw collision box
	if collision_hull_chunk(x,y,sections_wide*section_size,(sections_tall+2)*section_size){
		draw_set_color(c_red)
		draw_set_alpha(.2)
		draw_rectangle(x,y,x+sections_wide*section_size,y+(sections_tall+2)*section_size,false)
		draw_set_alpha(1)
	}
}else{ // Not in the builder
	
	
	// Create a sprite for this room when not in the builder
	if sprite_index = -1{ // If this room needs a sprite still
		// Recreate the surface if it was lost
		var surf = surface_create(sections_wide*section_size,(sections_tall+2)*section_size)
		surface_set_target(surf)
		draw_clear_alpha(c_black, 0)
		draw_room(0,0,y,sections_wide,sections_tall)
		surface_reset_target()
		sprite_index = sprite_create_from_surface(surf,0,0,surface_get_width(surf),surface_get_height(surf),false,false,0,0)
		surface_free(surf)
	}else{
		
		draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,1)
	}
}


// Show which internals are installed
for(var i = 0; i < ds_list_size(internals);i++){
	//draw_text(x+(i+1)*section_size,y,internals[|i])
}
