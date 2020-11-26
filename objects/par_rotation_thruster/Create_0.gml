
// Inherit the parent event
event_inherited();


// Initialize thrust
thrust = 1


active = 0 // How much this thruster is being used, from -1 to 0 to 1 where 0 is not being used

can_rotate = false // This part should not be rotated when building the ship

// Change these in each thruster object
part_scale = 1 // How big of a thruster effect
part_region_distance = 28 // How far away from the origin to create the particles


#region Thruster particle setup

part_surf = surface_create(sprite_width*5,sprite_height*5)

//NewEffect Particle System
ps_thruster = part_system_create();
part_system_depth(ps_thruster, -1);

part_system_automatic_draw(ps_thruster, false);

//NewEffect Particle Types
//Effect1
pt_Effect1 = part_type_create();
part_type_shape(pt_Effect1, pt_shape_spark);
part_type_size(pt_Effect1, 0.10, 0.50, 0, 0.05);
part_type_scale(pt_Effect1, part_scale, part_scale);
part_type_orientation(pt_Effect1, 0, 0, 0, 0, 0);
part_type_color3(pt_Effect1, 16777088, 16777215, 16777088);
part_type_alpha3(pt_Effect1, 1, 1, 0);
part_type_blend(pt_Effect1, 0);
part_type_life(pt_Effect1, 10, 15);
part_type_speed(pt_Effect1, 5, 5, 0, 0);
part_type_direction(pt_Effect1, 88, 100, 0, 0);
part_type_gravity(pt_Effect1, 0, 0);

//NewEffect Emitters
pe_Effect1 = part_emitter_create(ps_thruster);

#endregion

