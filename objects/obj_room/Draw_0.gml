
draw_self()

if global.mode = mode.build && global.player_ship = ship && obj_control.schematics_cat[|obj_control.selected_schematic] = cat.misc{
	
	for (var i = 0; i < 4; i++){
		
		if module[i] = noone{
			
			draw_sprite_ext(spr_new_module,0,1+x+i*sprite_width/4,y+7,1,1,0,c_white,1)
				
		}
		
		
	}
}

