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
    
    if (current_enemy_health >= enemy_health_total) {
        running_opening_sequence=false;
    }
}
else {
    current_player_health=player_health_total-player_hits_taken;
    current_enemy_health=enemy_health_total-enemy_hits_taken;

}

//pick active or passive enemy behavior and dialogue

if (picking_random_desc=true) {
    var _current_desc_index = 0;
    var _active_passive_select = 0;
    
    _active_passive_select=irandom_range(0,1)
    if (_active_passive_select == 0) {
        enemy_active=false;
    }
    else {
        enemy_active=true;
    }
    
    _current_desc_index=irandom_range(0,array_length(enemy_lines_passive)-1);
    
    if (_active_passive_select==0) {
       current_enemy_desc=enemy_lines_passive[_current_desc_index];
    }
    else {
       current_enemy_desc=enemy_lines_active[_current_desc_index];
    }
    
    picking_random_desc=false;
}


//passive index comes first, then active
//check whether the number falls within the passive range


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
            // implement some way to keep track of active/passive text
            current_dialogue = current_enemy_desc;
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

//go through menu
if (selecting_menu_option==true && check_menu_option_selected==false) {
        
    if (menu_option_confirm=="Taunt") {
        show_debug_message("taunting");
        check_menu_option_selected=true;
    }
    else if (menu_option_confirm=="Block"){
        show_debug_message("blocking");
        check_menu_option_selected=true;
    }
    else if (menu_option_confirm=="Strike"){
        show_debug_message("striking");
        
        if (enemy_active==false) {
            show_debug_message("successful strike");
            enemy_hits_taken++;
            check_menu_option_selected=true;
        }
        else {
            show_debug_message("failed strike");
            check_menu_option_selected=true;
        }
    }
    else if (menu_option_confirm=="Flee"){
        show_debug_message("fleeing");
        check_menu_option_selected=true;
    }
}



