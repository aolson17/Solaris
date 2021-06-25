width = camera_get_view_width(view_get_camera(0))
height = camera_get_view_height(view_get_camera(0))


spd = 3.5 // Base speed when there is no target to follow

selected_ship = noone

zoom = 1
zoom_width = width
zoom_height = height

zoom_target = zoom
zoom_spd_factor = .3
target_x = x
target_y = y
spd_factor = .2


// Dragging camera movement
drag_origin_mouse_x = 0
drag_origin_mouse_y = 0
drag_origin_x = 0
drag_origin_y = 0

drag_spd_factor = .4

drag_key = false
drag_key_pressed = false

ship_camera_offset_x = 0
ship_camera_offset_y = 0

prev_mouse_gui_x = 0
prev_mouse_gui_y = 0

shake = 0
camera = camera_create_view(x,y,width,height)

view_set_camera(0,camera)