/// @description Update Module Position


for (var i = 0; i < 4; i++){
	if module[i] != noone{
		module[i].x = 1+x+i*sprite_width/4
		module[i].y = y+7
	}
	
	
}

if light != noone{
	light.x = x
	light.y = y
}
