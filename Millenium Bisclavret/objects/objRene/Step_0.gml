event_inherited();

if (defeated=true) {
    is_collidable=false;
}
/*
if (ChatterboxVariableGet("$reneeVisited")>0) {
    is_fightable=false;
}
 */


if (ChatterboxVariableGet("reneeVisited") = 1) { 
   is_fightable=false;
}

if (x-objPlayer.x < 0) {
    image_xscale = -abs(image_xscale);
}
else {
    image_xscale = abs(image_xscale);
}