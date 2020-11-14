/// The constructor for hull_chunk structs



function hull_chunk( _shape, _x, _y, _width, _height, _dir, _mat) constructor {
	//set = function( _x, _y ) { x = _x; y = _y }
	shape = _shape
	x = _x
	y = _y
	w = _width
	h = _height
	material = _mat
	if shape = shapes.triangle{
		dir = _dir
	}else{
		dir = dirs.none
	}
}


function draw_hull_chunk(_shape, _x, _y, _width, _height, _dir){
	if _shape = shapes.rectangle{
		draw_rectangle(_x,_y,_x+_width*brush_size-1,_y+_height*brush_size-1,false)
	}else{
		switch _dir{
			case dirs.up:
				var p1_x = _x-1
				var p1_y = _y+_height*brush_size-1
				var p2_x = _x+_width*brush_size-1
				var p2_y = _y+_height*brush_size-1
				var p3_x = _x+_width*brush_size-1
				var p3_y = _y-1
				break
			case dirs.down:
				var p1_x = _x-1
				var p1_y = _y-1
				var p2_x = _x+_width*brush_size-1
				var p2_y = _y-1
				var p3_x = _x-1
				var p3_y = _y+_height*brush_size-1
				break
			case dirs.left:
				var p1_x = _x-1
				var p1_y = _y-1
				var p2_x = _x+_width*brush_size-1
				var p2_y = _y-1
				var p3_x = _x+_width*brush_size-1
				var p3_y = _y+_height*brush_size-1
				break
			case dirs.right:
				var p1_x = _x-1
				var p1_y = _y-1
				var p2_x = _x-1
				var p2_y = _y+_height*brush_size-1
				var p3_x = _x+_width*brush_size-1
				var p3_y = _y+_height*brush_size-1
				break
		}
		
		draw_triangle(p1_x,p1_y,p2_x,p2_y,p3_x,p3_y,false)
	}
}
