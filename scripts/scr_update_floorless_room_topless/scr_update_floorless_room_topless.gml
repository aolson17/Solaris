

if index_y > 0{
	
	var rm_above = ds_grid_get(ship.ship,index_x,index_y-1)
	
	
	if rm_above != 0{
		
		if rm_above.object_index = obj_room_floorless{
			sprite_index = spr_room_floorless_topless
			instance_destroy(light)
			light = noone
		}else{
			sprite_index = spr_room_floorless
			light = instance_create_layer(x,y,"Lights",obj_ceiling_light)
		}
		
	}
	
	
	
}

