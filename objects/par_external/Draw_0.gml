





if room = rm_builder{
	//draw_self()
	
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
		draw_set_color(c_yellow)//c_maroon)
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
}else{ // Not in the builder
}


if sprite_index != -1{
	if !surface_exists(surf){
		surf = surface_create(sprite_width*3,sprite_height*3)
	}
	surface_set_target(surf)
	draw_clear_alpha(c_black,0)
	
	draw_sprite_ext(sprite_index,image_index,surface_get_width(surf)/2,surface_get_height(surf)/2,1,1,image_angle,c_white,1)
	
	surface_reset_target()
	
	
	draw_surface_ext(surf,x-surface_get_width(surf)/2,y-surface_get_height(surf)/2,1,1,0,c_white,1)
}