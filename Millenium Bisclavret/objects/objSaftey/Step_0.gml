// Inherit the parent event
event_inherited();

if (ChatterboxVariableGet("safetyIsCollidable") = 0) {
    if (move_progress < move_target) {
        move_progress++;
        var _progress_factor = move_progress / move_target;
        y = round(lerp(start_y, end_y, _progress_factor));
    }
    else {
        is_collidable = false;
    }
}
else {
	is_collidable = true;
}

if (x-objPlayer.x < 0) {
    image_xscale = -abs(image_xscale);
}
else {
    image_xscale = abs(image_xscale);
}