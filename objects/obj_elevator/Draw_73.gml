
if global.mode = mode.player{
	
	if point_distance(x+sprite_width/2,y+sprite_height,obj_player.x,obj_player.y) < 10{
		
		draw_set_color(c_white)
		
		for (var i = 0; i < ds_list_size(options); i++){
			draw_sprite_ext(spr_elevator_move,0,options[|i].x,options[|i].y,1,1,0,c_white,.8)
		}
		
		
		
		
		
		
		
	}
}

