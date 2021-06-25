
//draw_sprite_ext(sprite_index,image_index,adj_x,adj_y,image_xscale,image_yscale,my_ship.angle,c_white,image_alpha)
//draw_sprite_ext(sprite_gun,image_index,adj_x,adj_y,image_xscale,image_yscale,my_ship.angle,c_white,image_alpha)
//draw_sprite_ext(sprite_details,image_index,adj_x,adj_y,image_xscale,image_yscale,my_ship.angle,c_white,image_alpha)

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,image_alpha)

draw_set_color(c_white)
draw_circle(target_x+current_ship.x,target_y+current_ship.y,5,false)

