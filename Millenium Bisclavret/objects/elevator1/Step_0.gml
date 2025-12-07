// Inherit the parent event
event_inherited();

if (ChatterboxVariableGet("elevatorState") = 1) {
   TransitionStart(elevator, sqFadeOut, sqFadeIn);
}

is_collidable=false;
is_fightable=false;