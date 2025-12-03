
x += x_frac;         //Add the fraction back to your position
x_frac = x % 1;        //Get the new fraction
x_int = x - x_frac;    // Get the rounded position
x = x_int;   


if (ChatterboxIsStopped() && keyboard_check_pressed(vk_escape)) {
    in_dialogue=false;
}

// get inputs
var _key_left = keyboard_check(vk_left);
var _key_right = keyboard_check(vk_right);

// get move direction
if (currently_talking = noone) { 
    _dir = _key_right - _key_left;
}
else {
    _dir = 0;
}

// slow down char if no dir is pressed

if (_dir==0) {
    
    //going left
    if (hsp < 0) { 
        // takes ma 
        hsp = min(hsp + decel,0);
        
    }
    else {
        hsp = max(hsp - decel,0);
    }
}

//clamp speed to max speed
hsp = clamp(hsp, -max_hsp,max_hsp);

// horizontal collision for barriers
if (place_meeting(x+hsp,y,barriers)) {
    repeat (abs(hsp) + 1) {
            if (place_meeting(x + sign(hsp), y, barriers))
               break;
            x += hsp;
         }
         
        if facingForward {
            hsp=-accel;
        }
        
        if !facingForward {
            hsp=accel;
        }

    
}



// collide with solid npcs



if (place_meeting(x+hsp,y,npc_container)) {
    var who_is_here = instance_place(x,y, npc_container);

    
    if (who_is_here != noone && who_is_here.is_collidable == true) {
        /*
        var _x = round(x);
        var _pixel = sign(hsp);
        while (!place_meeting(_x+_pixel,y,npc_container)) {
            _x += _pixel;
            
        }
        x=_x;
        hsp = 0;
         * */
        
        repeat (abs(hsp) + 1) {
            if (place_meeting(x + sign(hsp), y, npc_container))
               break;
            x += hsp;
         }
         
        if _dir > 0{
            hsp=-accel;
        }

        else {
            hsp = 0;
        }


    }
    
    if (who_is_here != noone && who_is_here.is_fightable == true) {
        //initialize challange dialogue
        
       if (ChatterboxIsStopped(chatterbox)) {
           in_dialogue = true;
            
           
            ChatterboxJump(chatterbox, who_is_here.node_name);
           
           
           currently_talking = who_is_here;
           current_name = ChatterboxGetContentSpeaker(chatterbox, 0);
            current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
       } 
       
    }
    
    //check if npc is fightable
    /*if (who_is_here != noone && who_is_here.is_fightable == true) {
        //initialize challange dialogue
        in_cutscene = true;
        in_dialogue = true;
        
        current_dialogue = who_is_here.text[0];
        current_name = who_is_here.char_name;
        
        currently_talking = who_is_here;
        current_text_index = 0;
        current_text_line_number = 0;
        
        
        if (current_text_line_number < array_length(currently_talking.text) - 1) {

            current_text_line_number++;

            current_dialogue = currently_talking.text[current_text_line_number];
            current_text_index = 0;
        } 
        else {
            currently_talking = noone;
            if (instance_exists(obj_battle_switcher) != true) {
               var _switcher=instance_create_depth(0,0,0, obj_battle_switcher)
               _switcher.player_data = self;
               _switcher.enemy_data = other;
               _switcher.original_room = room;
               
               room_goto(battle_screen);
            }
        }
        //check if the battle switcher has already activated. if not, activate it.
        */
    
}


hsp += _dir*accel;
//commit to movement
x+=hsp;





// get horz. speed (pos right, neg left)

// get horz. speed (pos right, neg left)


//change sprites accordingly

if (hsp > 0) {
    sprite_index = player_run_cycle;
    image_xscale = abs(image_xscale);
    facingForward = true;
    moving=true;
}
else if (hsp < 0) {
    sprite_index = player_run_cycle;
    image_xscale = -abs(image_xscale);
    facingForward = false;
    moving=true;
    
}
else {
    sprite_index = player_idle;
    moving=false;
}




/*
if(keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) {
    if (ChatterboxIsStopped(chatterbox)) {
        var who_is_here = instance_place(x,y, npc_container);
        
        if (who_is_here != noone) {
            in_dialogue = true;
            
            ChatterboxJump(chatterbox, who_is_here.node_name);
            
            currently_talking = who_is_here;
            current_name = ChatterboxGetContentSpeaker(chatterbox, 0);
        }
    } 
    else if (ChatterboxIsWaiting(chatterbox)) {
        ChatterboxContinue(chatterbox); 
    }
    
    if (not ChatterboxIsStopped(chatterbox)) {
        current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
        current_text_index = 0;
        current_name = ChatterboxGetContentSpeaker(chatterbox, 0);
        
        if (ChatterboxGetOptionCount(chatterbox)>0) {
            drawing_options=true;
        }
        else {
            drawing_options=false;
        }
    }
    else {
        current_dialogue = "";
        currently_talking = noone;
        current_name = "";
        in_dialogue=false;
    }
}
*/

if (place_meeting(x+hsp,y,npc_container)) {

    var who_is_here = instance_place(x,y, npc_container);
    
    if(keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) {
        in_dialogue = true;
        
    }
    if (in_dialogue=true) {
        
        if (ChatterboxIsStopped(chatterbox) && first_line_written==false) {
            ChatterboxJump(chatterbox, who_is_here.node_name);
            current_text_index = 0;
            currently_talking = who_is_here;
            current_name = ChatterboxGetContentSpeaker(chatterbox, 0); 
            current_dialogue = ChatterboxGetContentSpeech(chatterbox, 0);
            first_line_written=true;
        }
        else {
            if ChatterboxIsWaiting(chatterbox) {
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
                    choice_select=0;
                } 
            }
            else {
                drawing_options = false;
                current_dialogue = "";
                currently_talking = noone;
                current_name = "";
                in_dialogue=false;
            }
        }
    }
}

if (in_dialogue=false) {
  first_line_written=false;
}


if (ChatterboxVariableGet("battleStart")>0) {
    ChatterboxVariableReset("battleStart");
    global.reneeFought=true;
    

/*    var target = battle_screen;
    TransitionStart(target,sqNoOut, sqFadeIn);
    */

    NewEncounter([global.enemies.renee],battle_background);
    
}
