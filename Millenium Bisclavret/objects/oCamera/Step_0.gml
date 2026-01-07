x += x_frac;         //Add the fraction back to your position
x_frac = x % 1;        //Get the new fraction
x_int = x - x_frac;    // Get the rounded position
x = x_int;      

      //Use that rounded position to place your object


if (follow != noone)
{
    if (objPlayer.facingForward==true) {
        xTo = follow.x;
    }
    else if (objPlayer.facingForward==false) {
        xTo = follow.x;
    }
    yTo = follow.y;
}

x+=(xTo - x)/5;
x+=(yTo-y)/5;

camera_set_view_pos(view_camera[0],x-(camWidth*0.5),y-(camHeight*0.5));
global.cameraPosX=camera_get_view_x(view_camera[0])-50;
global.cameraPosY=camera_get_view_y(view_camera[0])-50;

