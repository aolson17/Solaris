


gui_width = view_get_wport(0)
gui_height = view_get_hport(0)

build_area_height = .8 // How much of the screen can be clicked on to build things. Other area used for UI interaction


square_size = gui_width * .05 // Schematic preview size

selected_cat = cat.hull
selected_schematic = 0


update_cat_surf = true
cat_surf = surface_create(gui_width,gui_height*(1-build_area_height))


alarm[1] = 1

brush_shape = shapes.rectangle // Rectangle or triangle, goes with the shapes enum
brush_dir = dirs.up // Used currently just for direction of triangle shaped brush
brush_x = 0
brush_y = 0
prev_brush_x = 0 // Used for making fewer collision checks. Only checks when moving
prev_brush_y = 0
brush_w = 1
brush_h = 1
brush_w_min = 1
brush_h_min = 1

last_brush_cat = cat.hull // Which cat with a brush was used last, cat.hull or cat.rooms

brush_mat = 0 // The index of the selected material in global.materials

brush_changed = false // If brush col should be updated
brush_col = false // If the brush is colliding

room_h_min = 2
room_w_min = 2


moving = noone // Which object is being moved or -1 if none
selecting = -1 // Which object is hovered over or -1 if none

hull_chunks = obj_ship.hull_chunks // The list of all of the hull chunks. References same list as obj_ship's hull_chunks does

hull_surf = surface_create(1,1) // The surface for all of the hull across the ship. Size is changed to size of ship when filled
hull_mat_surf = surface_create(1,1) // A helper surface used for each material when making hull_surf
hull_mat_edges_surf = surface_create(1,1) // Holds the edge texture. This second helper is necessary because a surface can not be drawn on itself

hull_mats_found = ds_list_create() // A list of the material types that are being used in the hull

ship_x = 0 // Dimensions of the ship to use for the hull surface
ship_y = 0
ship_x2 = 0
ship_y2 = 0
hull_surf_edge_space = 10 // Extra space around the helper surfaces to make room for edges

glass_alpha = .6 // How opaque glass is

update_surf = true

made_spr_ship_hull = false // Whether or not the spr_ship_hull must be deleted before making a new one

external_col_list = ds_list_create() // List of collisions of external objects with brush, used for determining brush collisions in scr_collision_hull


#region Brush area selection

brush_area_start_x = 0
brush_area_start_y = 0
brush_area_selecting = false

#endregion
