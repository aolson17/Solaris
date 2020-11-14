/// The constructor for hull_chunk structs

// The stages of using an elevator, or not using it. Not using it is equal to false because both are 0
enum elevator_stages{
	none,
	enter, // Moving to the elevator
	in, // Moving from enter to the exit position
	leave // Moving out of the elevator
}

///@description A given order, to go in each crew members list of queued orders
///@param _x Where the order is located so where the crew member must go
///@param _y 
///@param _use {Object ID or noone} The object id of what should be used if using an object, or noone if just movement
///@param _elevator_stage {elevator_stages} Which elevator stage or if no elevator is involved then none or false
function order( _x, _y, _use, _elevator_stage) constructor {
	//set = function( _x, _y ) { x = _x; y = _y }
	x = _x
	y = _y
	use = _use
	elevator_stage = _elevator_stage
}





