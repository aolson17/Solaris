



ds_list_destroy(ship_rooms)
ds_list_destroy(ship_externals)
ds_list_destroy(ship_internals)
ds_list_destroy(ship_props)
ds_list_destroy(hull_chunks)

if ds_exists(floor_grids,ds_type_list){
	for (var i = 0; i < ds_list_size(floor_grids); i++){
		ds_grid_destroy(floor_grids[|i].grid)
	}
	ds_list_destroy(floor_grids)
}