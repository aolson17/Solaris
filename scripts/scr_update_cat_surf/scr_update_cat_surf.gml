

surface_set_target(cat_surf)
draw_clear_alpha(c_black,0)

if selected_cat = cat.rm{
	var spr_scale = 1
}else{
	var spr_scale = 3
}

var pos = 0

for(var i = 0; i < ds_list_size(schematics); i++){
	
	if ds_list_find_value(schematics_cat,i) = selected_cat{
		
		
		
		var spr = ds_list_find_value(schematics_spr,i)
		var cost = ds_list_find_value(schematics_cost,i)
		var obj = ds_list_find_value(schematics,i)
		var name = ds_list_find_value(schematics_name,i)
		
		
		
		draw_sprite_ext(spr,0,square_size * pos,20,spr_scale,spr_scale,0,c_white,1)
		
		if i = selected_schematic{
			draw_set_color(c_blue)
			draw_set_alpha(.6)
			draw_rectangle(square_size * pos,0,square_size * (pos+1),surface_get_height(cat_surf),false)
			draw_set_alpha(1)
		}
		
		draw_set_color(c_white)
		
		draw_text(square_size * pos,0,name)
		
		draw_set_halign(fa_right)
		draw_text(square_size * (pos+1),surface_get_height(cat_surf)-30,"$"+string(cost))
		draw_set_halign(fa_left)
		
		
		
		pos++
	}
	
}




surface_reset_target()
