///@description Check if the floor above is floorless and if so then show the version of this sprite with a top

if rm.index_y > 0{
	var rm_above = ds_grid_get(rm.ship.ship,rm.index_x,rm.index_y-1)
	
	if rm_above != 0{
		
		if rm_above.object_index = obj_room_floorless{
			sprite_index = top_sprite
		}else{
			sprite_index = normal_sprite
		}
	}
}

