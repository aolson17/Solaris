///@description Return what the selected schematic must border
function scr_get_border_room() {




	var border_room = noone
	if object_is_ancestor(obj_control.schematics[|obj_control.selected_schematic],obj_small_thruster) || obj_control.schematics[|obj_control.selected_schematic] = obj_small_thruster{
		// If this is a thruster it must border at least one engine room
		border_room = obj_room_engine
	}
	if object_is_ancestor(obj_control.schematics[|obj_control.selected_schematic],obj_small_blaster) || obj_control.schematics[|obj_control.selected_schematic] = obj_small_blaster{
		border_room = obj_room_ammo_loader
	}

	return border_room


}
