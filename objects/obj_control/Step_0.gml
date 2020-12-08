


#region Select faction

if keyboard_check_pressed(vk_right){
	selected_faction_index = clamp(selected_faction_index+1,0,ds_list_size(global.factions)-1)
}
if keyboard_check_pressed(vk_left){
	selected_faction_index = clamp(selected_faction_index-1,0,ds_list_size(global.factions)-1)
}


#endregion


