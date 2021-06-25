



//draw_text(x,y,id)

if room = rm_builder{
	draw_self()
	
	// Show if selecting
	if id = obj_builder.selecting{
		draw_set_alpha(.2)
		draw_set_color(c_blue)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		draw_set_alpha(1)
	}
	// Show collision indicator for rooms and other externals
	if id = obj_builder.moving && obj_builder.brush_col{
		draw_set_alpha(.2)
		draw_set_color(c_red)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		draw_set_alpha(1)
	}
	
	if id = obj_builder.moving && anchor_room != noone{
		with(anchor_room){
			draw_set_color(c_green)
			draw_set_alpha(.2)
			draw_rectangle(x,y,x+sections_wide*section_size,y+(sections_tall+2)*section_size,false)
			draw_set_alpha(1)
		}
	}
}else{ // Not in the build room
	
	if sprite_index != -1{
		draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,image_alpha)
	}
}

