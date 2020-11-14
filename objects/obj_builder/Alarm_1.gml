/// @description Make selected schematic one of selected cat

var schematics = obj_inventory.schematics
var schematics_cat = obj_inventory.schematics_cat
for(var i = 0; i < ds_list_size(schematics); i++){
	if ds_list_find_value(schematics_cat,i) = selected_cat{
		selected_schematic = i
		break
	}
}