
draw_text(x,y,"x: "+string(x))
draw_text(x,y+15,"y: "+string(y))

if room != rm_builder{
	draw_text(x,y-15,"Faction: "+global.factions[|faction_index].name)
}

if sprite_exists(sprite_index){
	
	
	ship_center_x = sprite_width/2
	ship_center_y = sprite_height/2
	
	
	if room != rm_builder{
		var adj_x = scr_x_rotated_around_point(x,y,x+ship_center_x,y+ship_center_y,angle)
		var adj_y = scr_y_rotated_around_point(x,y,x+ship_center_x,y+ship_center_y,angle)
	}else{
		var adj_x = x
		var adj_y = y
	}
	
	draw_sprite_ext(sprite_index,0,adj_x,adj_y,1,1,angle,c_white,1)
}

