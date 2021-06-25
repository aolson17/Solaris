// The enums used throughout the game



enum cat{ // Categories
	hull,
	internal,
	external,
	rooms,
	prop,
}

enum floor_types{
	empty, // Walkable cells
	wall, // Impassable cells
	elevator,
}


#region Hull chunk enums

enum shapes{
	triangle,
	rectangle,
}

enum dirs{
	left,
	right,
	up,
	down,
	none
}

#endregion
