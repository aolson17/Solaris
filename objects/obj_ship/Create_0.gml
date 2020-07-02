

room_w = sprite_get_width(spr_room)
room_h = sprite_get_height(spr_room)


max_size = 20 // Maximum number of room colomns and rows

center = round(max_size/2)

ship = ds_grid_create(max_size,max_size) // Holds ids of room objects or external objects

var starting_room = instance_create_layer(x,y,"Rooms",obj_room)

starting_room.index_x = center
starting_room.index_y = center
starting_room.ship = id
		
		
ds_grid_set(ship,center,center,starting_room)

