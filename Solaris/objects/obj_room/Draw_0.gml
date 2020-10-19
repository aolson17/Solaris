





for(var i = 0; i < sections_wide; i++){
	for(var j = 0; j < sections_tall; j++){
		if (j+(y/section_size))%2 != 0{//j%2 != 0 && sections_tall%2 = 0 || j%2 = 0 && sections_tall%2 != 0{
			draw_sprite(spr_room_wall_lower,0,x+i*section_size,y+j*section_size)
		}else{
			draw_sprite(spr_room_wall_upper,0,x+i*section_size,y+j*section_size)
		}
	}
	draw_sprite(spr_room_floor,0,x+i*section_size,y+sections_tall*section_size)
}

for(var i = 0; i < sections_wide; i++){
	draw_sprite(spr_room_ceiling,0,x+i*section_size,y)
}

if ds_list_size(paths_elevator_l) > 0{
	// Has a left floor elevator
	draw_sprite(spr_room_elevator,0,x,y+sections_tall*section_size)
}
if ds_list_size(paths_elevator_r) > 0{
	// Has a right floor elevator
	draw_sprite(spr_room_elevator,0,x+(sections_wide-1)*section_size,y+sections_tall*section_size)
}

if room = rm_builder{
	// Draw collision box
	if collision_hull_chunk(x,y,sections_wide*section_size,(sections_tall+2)*section_size){
		draw_set_color(c_red)
		draw_set_alpha(.2)
		draw_rectangle(x,y,x+sections_wide*section_size,y+(sections_tall+2)*section_size,false)
		draw_set_alpha(1)
	}
}


