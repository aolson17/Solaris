


if global.mode = mode.build{
	if keyboard_check_pressed(ord("1")){
		if selected_cat != cat.rm{
			selected_cat = cat.rm
			update_cat_surf = true
		}
	}
	if keyboard_check_pressed(ord("2")){
		if selected_cat != cat.misc{
			selected_cat = cat.misc
			update_cat_surf = true
		}
	}
	if keyboard_check_pressed(ord("3")){
		if selected_cat != cat.ext_small{
			selected_cat = cat.ext_small
			update_cat_surf = true
		}
	}
	if keyboard_check_pressed(ord("4")){
		if selected_cat != cat.ext_medium{
			selected_cat = cat.ext_medium
			update_cat_surf = true
		}
	}
	if keyboard_check_pressed(ord("5")){
		if selected_cat != cat.ext_large{
			selected_cat = cat.ext_large
			update_cat_surf = true
		}
	}
}


