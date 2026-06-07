if (place_meeting(x, y, objPlayer)) {
    draw_sprite_ext(dagger,-1, x+23, y-250-5*sin(get_timer()/200000), 0.4, 0.4, 360-90, c_white, 1);
    draw_sprite_ext(dagger,-1, x+27, y-250-5*sin(get_timer()/200000), 0.4, 0.4, 360-90, c_white, 1);
    draw_sprite_ext(dagger_white,-1, x+24, y-250-5*sin(get_timer()/200000), 0.4, 0.4, 360-90, c_white, 1);
}


