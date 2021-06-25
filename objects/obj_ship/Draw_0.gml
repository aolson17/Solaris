
draw_text(x,y,"x: "+string(x))
draw_text(x,y+15,"y: "+string(y))

if room != rm_builder{
	draw_text(x,y-15,"Faction: "+global.factions[|faction_index].name)
}

if sprite_exists(sprite_index){
	
	draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,1)
}

