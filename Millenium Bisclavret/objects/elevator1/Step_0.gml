// Inherit the parent event
event_inherited();

if (ChatterboxVariableGet("elevatorState") = 1) {
   TransitionStart(floor_elevator, sqFadeOut, sqFadeIn);
    room_goto(floor_elevator);
}

var _elevator = ChatterboxVariableGet("elevatorState");

is_collidable=false;
is_fightable=false;