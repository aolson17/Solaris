




for (var i = 0; i < 4; i++){
	if external[i] != noone{
		switch (i){
			case 0:
				external[i].x = x
				external[i].y = y
				break
			case 1:
				external[i].x = x+sprite_width/2
				external[i].y = y
				break
			case 2:
				external[i].x = x+sprite_width/2
				external[i].y = y+sprite_height/2
				break
			case 3:
				external[i].x = x
				external[i].y = y+sprite_height/2
				break
		}
	}
}




