draw_sprite(battleBackground, 0, x, y);

//draw units in depth order
unitWithCurrentTurn=unitTurnOrder[turn].id;
for (var i=0; i<array_length(unitRenderOrder); i++) {
    with(unitRenderOrder[i]) {
        draw_self();
    }
}

//draw cursor
if (cursor.active) {
    with (cursor) {
        if (activeTarget != noone) {
            if (!is_array(activeTarget)) {
                
                draw_sprite_ext(dagger,0,activeTarget.x-250+10*sin(get_timer()/100000),activeTarget.y-250,0.5,0.5,0,c_white,1);
                
            }
            else {
                draw_set_alpha(sin(get_timer()/50000)+1);
                for (var i=0; i< array_length(activeTarget); i++) {
                    draw_sprite(dagger,0,activeTarget[i].x,activeTarget[i].y);
                }
                draw_set_alpha(1.0);
            }
        }
    }
}