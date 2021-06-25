
sprite_index = choose(spr_character, spr_character_2)

mask_index = spr_soldier_mask

spd = 2

// Which ship this unit is assigned to
my_ship = instance_nearest(x,y,obj_ship)
// Which ship this unit is currently on
current_ship = my_ship

moving = false
target_x = x-current_ship.x
target_y = y-current_ship.y



orders = ds_list_create() // List of all of the queued orders for this crew member



vec_x = 0
vec_y = 0
