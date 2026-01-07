// Inherit the parent event
event_inherited();

if (ChatterboxVariableGet("execDoorState") = 1) { 
    ChatterboxVariableReset("execDoorState");
   TransitionStart(exec, sqFadeOut, sqFadeIn);
    global.playerPosX=objPlayer.x;
}


is_collidable=false;
is_fightable=false;