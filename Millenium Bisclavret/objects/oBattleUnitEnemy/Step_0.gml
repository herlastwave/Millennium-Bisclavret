event_inherited();
if (hp <=0) {
    image_blend=c_red;
    image_alpha-=0.01;
}
else {
    image_blend=c_white;
    image_alpha=1.0;
}