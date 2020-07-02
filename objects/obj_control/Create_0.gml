

gui_width = view_get_wport(0)
gui_height = view_get_hport(0)

build_area_height = .8 // How much of the screen can be clicked on to build things. Other area used for UI interaction

enum cat{ // Categories
	rm,
	misc,
	ext_small, // External parts that take half a room side
	ext_medium, // External parts that take an entire room side
	ext_large, // External parts that take 2 room sides
}

schematics = ds_list_create() // The object the schematic is for
schematics_cat = ds_list_create()
schematics_spr = ds_list_create()
schematics_cost = ds_list_create()
schematics_name = ds_list_create()

ds_list_add(schematics,obj_room)
ds_list_add(schematics_cat,cat.rm)
ds_list_add(schematics_spr,spr_room)
ds_list_add(schematics_cost,10)
ds_list_add(schematics_name,"Room")
ds_list_add(schematics,obj_room_floorless)
ds_list_add(schematics_cat,cat.rm)
ds_list_add(schematics_spr,spr_room_floorless)
ds_list_add(schematics_cost,5)
ds_list_add(schematics_name,"Floorless")
ds_list_add(schematics,obj_tank)
ds_list_add(schematics_cat,cat.misc)
ds_list_add(schematics_spr,spr_tank)
ds_list_add(schematics_cost,2)
ds_list_add(schematics_name,"Tank")
ds_list_add(schematics,obj_elevator)
ds_list_add(schematics_cat,cat.misc)
ds_list_add(schematics_spr,spr_elevator)
ds_list_add(schematics_cost,1)
ds_list_add(schematics_name,"Elevator")
ds_list_add(schematics,obj_wall)
ds_list_add(schematics_cat,cat.misc)
ds_list_add(schematics_spr,spr_wall)
ds_list_add(schematics_cost,1)
ds_list_add(schematics_name,"Wall")
ds_list_add(schematics,obj_door)
ds_list_add(schematics_cat,cat.misc)
ds_list_add(schematics_spr,spr_door)
ds_list_add(schematics_cost,1)
ds_list_add(schematics_name,"Door")
ds_list_add(schematics,obj_command)
ds_list_add(schematics_cat,cat.misc)
ds_list_add(schematics_spr,spr_command)
ds_list_add(schematics_cost,10)
ds_list_add(schematics_name,"Command")
ds_list_add(schematics,obj_crew_beds)
ds_list_add(schematics_cat,cat.misc)
ds_list_add(schematics_spr,spr_crew_beds)
ds_list_add(schematics_cost,3)
ds_list_add(schematics_name,"Command")
ds_list_add(schematics,obj_room_engine)
ds_list_add(schematics_cat,cat.rm)
ds_list_add(schematics_spr,spr_room_engine)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Engine Room")
ds_list_add(schematics,obj_room_ammo_loader)
ds_list_add(schematics_cat,cat.rm)
ds_list_add(schematics_spr,spr_room_ammo_loader)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Ammo Loader")
ds_list_add(schematics,obj_small_thruster)
ds_list_add(schematics_cat,cat.ext_small)
ds_list_add(schematics_spr,spr_small_thruster)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Small Thruster")
ds_list_add(schematics,obj_small_blaster)
ds_list_add(schematics_cat,cat.ext_small)
ds_list_add(schematics_spr,spr_small_blaster)
ds_list_add(schematics_cost,20)
ds_list_add(schematics_name,"Small Blaster")

square_size = gui_width * .05 // Schematic preview size

selected_cat = cat.rm
selected_schematic = 0


update_cat_surf = true
cat_surf = surface_create(gui_width,gui_height*(1-build_area_height))

enum mode{
	player,
	build,
	command
}

global.mode = mode.player


global.player_ship = noone


