

my_ship = noone // Set when created by obj_ship

prev_moving = false // Used to detect when room is placed

can_rotate = true // If this part can be rotated when building the ship

anchor_chunk = -1 // Which hull chunk this external object is anchored to

if sprite_index != -1{
	surf = surface_create(sprite_width*3,sprite_height*3)
}

mass = 10



