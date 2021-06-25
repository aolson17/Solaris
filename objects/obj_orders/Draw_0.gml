
if !instance_exists(selected_ship){
	selected_ship = noone
}


// Draw selection area if hold clicking
if mouse_check_button(mb_left) && point_distance(mouse_x,mouse_y,selected_area_x,selected_area_y) > selected_area_min{
	draw_set_color(c_red)
	
	draw_rectangle(mouse_x,mouse_y,selected_area_x,selected_area_y,true)
}

for (var i = 0; i < ds_list_size(selected_crew); i++){
	with (selected_crew[|i]){
		draw_sprite_ext(spr_crew_selected,0,x,y,1,1,0,c_white,1)
	}
}

// Show selected ship
with(selected_ship){
	draw_set_color(c_white)
	draw_circle(x,y,10,true)
	draw_circle(x,y,9,true)
	draw_circle(x,y,8,true)
}