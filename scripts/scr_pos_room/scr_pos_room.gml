///@description Returns the room at a position or noone if there is none at the position
function pos_room(_x,_y){
	with(obj_room){
		if point_in_rectangle(_x,_y,x,y,x+sections_wide*section_size,y+(sections_tall+2)*section_size){
			return id
		}
	}
	return noone
}