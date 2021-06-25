/// The constructor for order structs

enum move_types{
	walk,
	elevator
}

///@description A given order, to go in each crew members list of queued orders
///@param _x Where the order is located so where the crew member must go
///@param _y 
///@param _use {Object ID or noone} The object id of what should be used if using an object, or noone if just movement
function order( _x, _y, _use) constructor {
	x = _x
	y = _y
	use = _use
	steps = [] // Array of structs with info about positions to move to
	steps_count = 0
	
	current_step = 0 // Which step the crew with this order is on
	
	static add_step = function(_x,_y,_type){
		steps[steps_count] = {
			x : _x,
			y : _y,
			type : _type
		}
		steps_count++
	}
}





