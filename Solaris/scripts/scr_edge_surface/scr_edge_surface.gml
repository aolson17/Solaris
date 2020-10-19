/// @function scr_edge(surface,back sprite, edge sprite, edge width, unique side or false, unique side sprite, unique side width)
/// @description Creates the textured surface
/// @param {Surface} old_surface
/// @param {Sprite} back_sprite
/// @param {Sprite} edge_sprite
/// @param {int} edge_width
/// @return {Surface} Surface
function scr_edge_surface(argument0, argument1, argument2, argument3) {
	var old_surface = argument0
	var surface = surface_create(surface_get_width(old_surface),surface_get_height(old_surface))
	surface_set_target(surface)
	draw_clear_alpha(c_black,0)
	draw_surface_ext(old_surface,0,0,1,1,0,c_white,1)
	surface_reset_target()
	var back_sprite = argument1
	var edge_sprite = argument2
	var edge_width = argument3
	//var edge_corner_factor = .5// Less than 1 for curved edges
	//edge_1 = surface_create(surface_get_width(surface),surface_get_height(surface))
	//edge_2 = surface_create(surface_get_width(surface),surface_get_height(surface))

	var edge_surface = surface_create(surface_get_width(surface),surface_get_height(surface))
	surface_set_target(edge_surface)
	draw_clear(c_black)
	gpu_set_blendmode(bm_subtract);
	draw_surface(old_surface,0,0)
	gpu_set_blendmode(bm_normal);
	surface_reset_target()

	var edge_surface_2 = surface_create(surface_get_width(surface),surface_get_height(surface))
	surface_set_target(edge_surface_2)
	draw_clear_alpha(c_black,0)
	for (var i = 0;i < 360;i++){
		draw_surface_ext(edge_surface,lengthdir_x(edge_width,i*1),lengthdir_y(edge_width,i*1),1,1,0,c_white,1)
	}

	gpu_set_blendmode_ext(bm_dest_alpha, bm_one);
	draw_sprite_tiled(edge_sprite,0,0,0)
	gpu_set_blendmode(bm_normal);
	surface_reset_target()
	//gpu_set_blendmode_ext(bm_dest_alpha, bm_normal);

	//var noise_surface = scr_perlinNoise(surface_get_width(surface),surface_get_height(surface), global.int_cellWidth, global.int_cellWidth, 0, 0, 128, 40, 0, 0, 252, 0, -4, 0);

	surface_set_target(surface)
	//gpu_set_blendmode_ext(bm_dest_alpha, bm_one);
	gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_src_colour);
	//draw_surface(noise_surface,0,0)
	//draw_set_alpha(.5)
	draw_sprite_tiled(back_sprite,0,0,0)
	//draw_set_alpha(1)
	draw_surface(edge_surface_2,0,0)

	surface_reset_target()
	gpu_set_blendmode(bm_normal);

	surface_free(edge_surface)
	surface_free(old_surface)

	return surface



}
