

end_scene = ChatterboxVariableGet("sceneEnd");


if (ChatterboxIsStopped(chatterbox)) {
    
    current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
    current_text_index = 0;
} 

if (ChatterboxIsWaiting(chatterbox)) {
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) { 
    
       ChatterboxContinue(chatterbox); 
       current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
       current_name = ChatterboxGetContentSpeaker(chatterbox, 0); 
       current_text_index = 0;
    }
}
else {
    drawing_options=true;
    // wait for player to choose options using space
    choice_select+= keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
    if (choice_select > ChatterboxGetOptionCount(chatterbox)-1) {
        choice_select = 0;
    }
    else if (choice_select < 0) {
        choice_select = ChatterboxGetOptionCount(chatterbox)-1;
    }
    //check for whether the player confirms a choice
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) {
        ChatterboxSelect(chatterbox, choice_select);
        current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
        current_name = ChatterboxGetContentSpeaker(chatterbox, 0); 
        current_text_index = 0;
    }
}

if (end_scene=1) {
    ChatterboxStop(chatterbox);
    var target = floor_1;
    TransitionStart(target,sqNoOut, sqFadeIn);
}