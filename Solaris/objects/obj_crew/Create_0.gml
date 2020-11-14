
mask_index = spr_soldier_mask

spd = 2

// Which ship this unit is assigned to
my_ship = instance_nearest(x,y,obj_ship)
// Which ship this unit is currently on
current_ship = my_ship

//my_room = noone delete me? can just use pos_room

moving = false
target_room = noone
target_x = x
target_y = y

sprite_details = spr_soldier_details_idle
sprite_gun = spr_soldier_gun_idle


room_path = ds_list_create() // A list of rooms to follow to reach the target room


using_elevator = false


orders = ds_list_create() // List of all of the queued orders for this crew member

// When crew is close to each other their images should be offset
offset_range = 15 // How close must others be to start offseting
offset_direction = irandom_range(0,360)
offset_magnitude_random_factor = random_range(0,1)
offset_magnitude_factor = 2.5 // Multiplied by number of others near
offset_target_magnitude = 0 // Target magnitude
offset_magnitude = 0 // Current magnitude
offset_speed_factor = .05 // How fast offset is changed

crowd_adj_x = x
crowd_adj_y = y
