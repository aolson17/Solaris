/// @description Set up thrust



thrust_up = max(lengthdir_y(thrust,image_angle+90),0)
thrust_down = max(lengthdir_y(thrust,image_angle-90),0)
thrust_left = max(lengthdir_x(thrust,image_angle+90),0)
thrust_right = max(lengthdir_x(thrust,image_angle-90),0)



