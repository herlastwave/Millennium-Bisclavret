//draw in health points
if (running_opening_sequence == true) {
    /*var _i = 0;
    repeat (player_health_total) { 
        var _increment_player_hp = function()  {
           current_player_health++;
        }
        call_later(1, time_source_units_seconds,_increment_player_hp);
    }
    */
    repeat (player_health_total) { 
       timer1+=-1;
       if (timer1 <= 0){
          current_player_health++;
          timer1 = timer_reset_value; // reset timer
       }
    }
    repeat (enemy_health_total) { 
       timer2+=-1;
       if (timer2 <= 0){
          current_enemy_health++;
          timer2 = timer_reset_value; // reset timer
       }
    }
    
    if (current_player_health>= player_health_total) {
        running_opening_sequence=false;

    }
}


if (in_dialogue==true) {
    if (ChatterboxIsStopped(chatterbox) && first_line_written==false) {
        ChatterboxJump(chatterbox, battle_dialog_node);
        current_text_index = 0;
        current_name = ChatterboxGetContentSpeaker(chatterbox, 0); 
        current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
        first_line_written=true;
    }
    else {
        if (ChatterboxIsWaiting(chatterbox)) {
            if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) { 
            ChatterboxContinue(chatterbox); 
            current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
            current_name = ChatterboxGetContentSpeaker(chatterbox, 0); 
            current_text_index = 0; 
        }
        }
        else if (ChatterboxGetOptionCount(chatterbox)>0) {
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
        else {
            current_dialogue = "This is placeholder text."
            current_name = ""
            drawing_options=false;
            in_dialogue=false;
            first_line_written=false;
        }
    }
}


if (in_dialogue=false) {
first_line_written=false;
}

//track player health
//current_player_health=player_health_total-player_hits_taken;
current_enemy_health+= keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);

