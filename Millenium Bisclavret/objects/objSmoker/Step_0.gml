// Inherit the parent event
event_inherited();

if (x-objPlayer.x < 0) {
    image_xscale = abs(image_xscale);
}
else {
    image_xscale = -abs(image_xscale);
}