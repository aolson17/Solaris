/// @description Grab Controls

if device_mouse_y_to_gui(0) >= build_area_height*gui_height {
	gui_lmb = mouse_check_button_released(mb_left)
	gui_rmb = mouse_check_button_released(mb_right)
	lmb = false
	lmb_down = false
	rmb_down = false
	rmb = false
}else{
	gui_lmb = false
	gui_rmb = false
	lmb = mouse_check_button_released(mb_left)
	lmb_down = mouse_check_button(mb_left)
	rmb_down = mouse_check_button(mb_right)
	rmb = mouse_check_button_released(mb_right)
}
