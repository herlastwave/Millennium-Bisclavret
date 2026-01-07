// Inherit the parent event
event_inherited();

if (ChatterboxVariableGet("execDoorState") = 1) { 
    ChatterboxVariableReset("execDoorState");
   TransitionStart(floor_2, sqFadeOut, sqFadeIn);
}


is_collidable=false;
is_fightable=false;