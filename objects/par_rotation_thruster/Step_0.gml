
// Inherit the parent event
event_inherited();

if active != 0{
	
	
	
	part_type_scale(pt_Effect1, part_scale, part_scale);
	part_type_direction(pt_Effect1, 88+image_angle, 100+image_angle, 0, 0);
	var xp, yp;
	xp = surface_get_width(part_surf)/2
	yp = surface_get_height(part_surf)/2
	part_emitter_region(ps_thruster, pe_Effect1, xp-12*part_scale, xp+12*part_scale, yp-12*part_scale, yp+12*part_scale, ps_shape_diamond, ps_distr_invgaussian);
	//NewEffect emitter positions. Streaming or Bursting Particles.
	part_emitter_stream(ps_thruster, pe_Effect1, pt_Effect1, 6);
	
	
	
}else{
	part_emitter_stream(ps_thruster, pe_Effect1, pt_Effect1, 0);
}





