
var _cam_x = camera_get_view_x(view_camera[0]);

layer_x("Background", _cam_x*0.1);
layer_x("Assets_3", _cam_x*0.1);
layer_x("Assets_4", _cam_x*0.1);
layer_x("Assets_2", _cam_x*0.1);
layer_x("bg", _cam_x*0.1);
layer_x("wall_attached", _cam_x*0.1);
layer_x("Assets_1", _cam_x*0.05);

x += x_frac;         //Add the fraction back to your position
x_frac = x % 1;        //Get the new fraction
x_int = x - x_frac;    // Get the rounded position
x = x_int;   
