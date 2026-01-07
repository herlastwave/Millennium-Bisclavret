event_inherited()

if (ChatterboxVariableGet("lethequeLeave") = 1) { 
    TransitionStart(floor_2, sqFadeOut, sqFadeIn);
    room_goto(floor_2);
}

if (defeated=true) {

    is_fightable=true;
}

if (ChatterboxVariableGet("lethequeLeave") = 0) { 
   is_fightable=false;
    is_collidable=false;
}


var lethequeleave=ChatterboxVariableGet("lethequeLeave");