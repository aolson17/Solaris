width = camera_get_view_width(view_get_camera(0))
height = camera_get_view_height(view_get_camera(0))

spd_factor = .08

spd = 3 // Base speed when there is no target to follow

target = noone

zoom = 1
zoom_width = width
zoom_height = height


shake = 0
camera = camera_create_view(x,y,width,height)

view_set_camera(0,camera)