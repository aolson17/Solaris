
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


