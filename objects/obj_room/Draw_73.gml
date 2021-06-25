



if room = rm_builder{
	// Show if selecting
	if id = obj_builder.selecting{
		draw_set_alpha(.2)
		draw_set_color(c_blue)
		draw_rectangle(x,y,x+sections_wide*section_size-1,y+(sections_tall+2)*section_size,false)
		draw_set_alpha(1)
	}
}

