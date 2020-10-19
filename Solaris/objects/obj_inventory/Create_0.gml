



enum cat{ // Categories
	hull,
	internal,
	external,
	rooms,
}

schematics = ds_list_create() // The object the schematic is for
schematics_cat = ds_list_create() // Which tab this schematic falls under in the builder
schematics_spr = ds_list_create() // The sprite for it in the build menu
schematics_cost = ds_list_create()
schematics_name = ds_list_create()


enum wall_data{ // Data held by the ship's wall grid
	hp,
	val // The enum value for this wall to access more mat_data info
}

enum mat_data{
	texture,
	edge,
	edge_size,
	edge_corner_size,
	max_hp,
	armor,
	mass,
	cost,
	color,
	name,
}

global.materials = []// materials is an array of arrays of mat_data
#region Set up material data
var mat_val = array_length(global.materials)
global.materials[mat_val][mat_data.name] = "Aluminum"
global.materials[mat_val][mat_data.texture] = spr_metal
global.materials[mat_val][mat_data.edge] = spr_metal
global.materials[mat_val][mat_data.edge_size] = 4
global.materials[mat_val][mat_data.edge_corner_size] = 3
global.materials[mat_val][mat_data.max_hp] = 5
global.materials[mat_val][mat_data.armor] = 2
global.materials[mat_val][mat_data.mass] = 1
global.materials[mat_val][mat_data.color] = make_color_rgb(230,230,230)

var mat_val = array_length(global.materials)
global.materials[mat_val][mat_data.name] = "Steel"
global.materials[mat_val][mat_data.texture] = spr_metal
global.materials[mat_val][mat_data.edge] = spr_rough_edge
global.materials[mat_val][mat_data.edge_size] = 4
global.materials[mat_val][mat_data.edge_corner_size] = 3
global.materials[mat_val][mat_data.max_hp] = 5
global.materials[mat_val][mat_data.armor] = 2
global.materials[mat_val][mat_data.mass] = 1
global.materials[mat_val][mat_data.cost] = 1
global.materials[mat_val][mat_data.color] = make_color_rgb(30,30,30)

var mat_val = array_length(global.materials)
global.materials[mat_val][mat_data.name] = "Gold"
global.materials[mat_val][mat_data.texture] = spr_metal
global.materials[mat_val][mat_data.edge] = spr_rough_edge
global.materials[mat_val][mat_data.edge_size] = 4
global.materials[mat_val][mat_data.edge_corner_size] = 3
global.materials[mat_val][mat_data.max_hp] = 5
global.materials[mat_val][mat_data.armor] = 2
global.materials[mat_val][mat_data.mass] = 1
global.materials[mat_val][mat_data.cost] = 1
global.materials[mat_val][mat_data.color] = make_color_rgb(212,175,55)

var mat_val = array_length(global.materials)
global.materials[mat_val][mat_data.name] = "Glass"
global.materials[mat_val][mat_data.texture] = spr_glass
global.materials[mat_val][mat_data.edge] = spr_smooth_edge
global.materials[mat_val][mat_data.edge_size] = 4
global.materials[mat_val][mat_data.edge_corner_size] = 3
global.materials[mat_val][mat_data.max_hp] = 5
global.materials[mat_val][mat_data.armor] = 2
global.materials[mat_val][mat_data.mass] = 1
global.materials[mat_val][mat_data.cost] = 1
global.materials[mat_val][mat_data.color] = make_color_rgb(200,200,200)
#endregion

#region Fill schematics inventory

#region Starting materials

//scr_inv_add_mat(mat.aluminum)
//scr_inv_add_mat(mat.steel)
//scr_inv_add_mat(mat.gold)
//scr_inv_add_mat(mat.glass)

#endregion

ds_list_add(schematics,obj_room)
ds_list_add(schematics_cat,cat.rooms)
ds_list_add(schematics_spr,spr_room)
ds_list_add(schematics_cost,2)
ds_list_add(schematics_name,"Room")

ds_list_add(schematics,obj_tank)
ds_list_add(schematics_cat,cat.internal)
ds_list_add(schematics_spr,spr_tank)
ds_list_add(schematics_cost,2)
ds_list_add(schematics_name,"Tank")
ds_list_add(schematics,obj_elevator)
ds_list_add(schematics_cat,cat.internal)
ds_list_add(schematics_spr,spr_elevator)
ds_list_add(schematics_cost,1)
ds_list_add(schematics_name,"Elevator")
ds_list_add(schematics,obj_wall)
ds_list_add(schematics_cat,cat.internal)
ds_list_add(schematics_spr,spr_wall)
ds_list_add(schematics_cost,1)
ds_list_add(schematics_name,"Wall")
ds_list_add(schematics,obj_door)
ds_list_add(schematics_cat,cat.internal)
ds_list_add(schematics_spr,spr_door)
ds_list_add(schematics_cost,1)
ds_list_add(schematics_name,"Door")
ds_list_add(schematics,obj_command)
ds_list_add(schematics_cat,cat.internal)
ds_list_add(schematics_spr,spr_command)
ds_list_add(schematics_cost,10)
ds_list_add(schematics_name,"Command")
ds_list_add(schematics,obj_crew_beds)
ds_list_add(schematics_cat,cat.internal)
ds_list_add(schematics_spr,spr_crew_beds)
ds_list_add(schematics_cost,3)
ds_list_add(schematics_name,"Command")
ds_list_add(schematics,obj_small_thruster)
ds_list_add(schematics_cat,cat.external)
ds_list_add(schematics_spr,spr_small_thruster)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Small Thruster")
ds_list_add(schematics,obj_small_blaster)
ds_list_add(schematics_cat,cat.external)
ds_list_add(schematics_spr,spr_small_blaster)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Small Blaster")
ds_list_add(schematics,obj_medium_blaster)
ds_list_add(schematics_cat,cat.external)
ds_list_add(schematics_spr,spr_medium_blaster)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Medium Blaster")
ds_list_add(schematics,obj_medium_thruster)
ds_list_add(schematics_cat,cat.external)
ds_list_add(schematics_spr,spr_medium_thruster)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Medium Thruster")


#endregion
