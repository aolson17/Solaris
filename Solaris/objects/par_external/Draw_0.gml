
/*
if side = sides.none{
	draw_self()
}else{
	switch side{
		case sides.up: draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,image_alpha)
			break
		case sides.down: draw_sprite_ext(sprite_index,image_index,x+sprite_width,y+sprite_height,image_xscale,image_yscale,180,c_white,image_alpha)
			break
		case sides.left: draw_sprite_ext(sprite_index,image_index,x,y+sprite_height,image_xscale,image_yscale,90,c_white,image_alpha)
			break
		case sides.right: draw_sprite_ext(sprite_index,image_index,x+sprite_width,y,image_xscale,image_yscale,270,c_white,image_alpha)
			break
		
	}
	
}
*/
draw_self()
if room = rm_builder{
	// Show if selecting
	if id = obj_builder.selecting{
		draw_set_alpha(.2)
		draw_set_color(c_blue)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		draw_set_alpha(1)
	}
	// Show anchor indicator
	if id = obj_builder.moving && anchor_chunk = -1{
		draw_set_alpha(.2)
		draw_set_color(c_green)//c_maroon)
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
}
