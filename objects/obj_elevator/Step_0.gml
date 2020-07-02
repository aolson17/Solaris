

if global.mode = mode.player{
	
	if point_distance(x+sprite_width/2,y+sprite_height,obj_player.x,obj_player.y) < 10{
		if updated = false{
			scr_update_elevator_options()
			updated = true
		}
		
		draw_set_color(c_white)
		
		for (var i = 0; i < ds_list_size(options); i++){
			draw_sprite_ext(spr_elevator_move,0,options[|i].x,options[|i].y,1,1,0,c_white,.8)
			if point_distance(options[|i].x+sprite_width/2,options[|i].y+sprite_height/2,mouse_x,mouse_y) < 25{
				if mouse_check_button_released(mb_left){
					obj_player.x = options[|i].x+sprite_width/2
					obj_player.y = options[|i].y+sprite_height+10
				}
			}
			
		}
		
		
		
		
		
		
		
	}else{
		updated = false
	}
}else{
	updated = false
}



