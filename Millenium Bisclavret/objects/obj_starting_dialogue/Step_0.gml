
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
    var target = floor_1;
    TransitionStart(target,sqNoOut, sqFadeIn);
}