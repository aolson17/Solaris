
mask_index = spr_soldier_mask

xspd = 2
yspd = 1

spd = 2

my_room = noone

moving = false
target_room = noone
target_x = x
target_y = y

sprite_details = spr_soldier_details_idle
sprite_gun = spr_soldier_gun_idle


room_path = ds_list_create() // A list of rooms to follow to reach the target room


next_path_x = x
next_path_y = y

next_path_elevator_x = x
next_path_elevator_y = y
used_elevator = false
using_elevator = false
needs_elevator = false
elevator_start_room = noone

elevator_side = "none" // "none" "left" or "right"


// When crew is close to each other their images should be offset
offset_range = 15 // How close must others be to start offseting
offset_direction = irandom_range(0,360)
offset_magnitude_random_factor = random_range(0,1)
offset_magnitude_factor = 2.5 // Multiplied by number of others near
offset_target_magnitude = 0 // Target magnitude
offset_magnitude = 0 // Current magnitude
offset_speed_factor = .05 // How fast offset is changed



