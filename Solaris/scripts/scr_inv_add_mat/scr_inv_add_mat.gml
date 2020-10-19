/// @description Creates the textured surface
/// @param Material_Enum_Value
function scr_inv_add_mat(argument0) {

	var new_mat = argument0

	show_debug_message(materials)

	var new_wall_data = array_create(wall_data.val+1)
	new_wall_data[wall_data.hp] = materials[new_mat, mat_data.max_hp-1]
	new_wall_data[wall_data.val] = new_mat
	show_debug_message("wall "+string(new_wall_data))
	ds_list_add(schematics,new_wall_data)
	ds_list_add(schematics_cat,cat.hull)
	ds_list_add(schematics_spr,spr_metal)
	ds_list_add(schematics_cost,materials[new_mat, mat_data.cost])
	ds_list_add(schematics_name,materials[new_mat, mat_data.name])






}
