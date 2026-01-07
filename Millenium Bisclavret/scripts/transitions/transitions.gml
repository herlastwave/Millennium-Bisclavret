global.midTransition = false;
global.roomTarget = -1;

// puts sequence in room
function TransitionPlaceSequence(_type){
    if (layer_exists("transition")) {
        layer_destroy("transition");
    }
        
    var _lay = layer_create(-9999,"transition");
    //layer_sequence_create(_lay,camera_get_view_x(view_camera[0])-50,camera_get_view_y(view_camera[0])-50,_type);
    layer_sequence_create(_lay,camera_get_view_x(view_camera[0])-50,camera_get_view_y(view_camera[0])-50,_type);
    //layer_sequence_create(_lay,objPlayer.x,objPlayer.y,_type);

}

//called when you want to go from one room to another w/ any combination of in or out sequences

function TransitionStart(_roomTarget, _typeOut, _typeIn) {
    if (!global.midTransition) {
        global.midTransition = true;
        global.roomTarget = _roomTarget;
        TransitionPlaceSequence(_typeOut);
        layer_set_target_room(_roomTarget);
        TransitionPlaceSequence(_typeIn);
        layer_reset_target_room();
        return true;
    }
    else return false;
        
}

//called as a moment at the end of an "out" transition seq.

function TransitionChangeRoom() {
    room_goto(global.roomTarget);
    
}

// called at the moment at the end of an "in" transition seq.
function TransitionFinished() {
    layer_sequence_destroy(self.elementID);
    global.midTransition = false;
}