

// get inputs
var _key_left = keyboard_check(vk_left);
var _key_right = keyboard_check(vk_right);

// get move direction
if (currently_talking = noone) { 
    var _dir = _key_right - _key_left;
}
else {
    var _dir = 0;
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
    var _x = round(x);
    var _pixel = sign(hsp);
    while (!place_meeting(_x+_pixel,y,barriers)) {
        _x += _pixel;
        
    }
    x=_x;
    hsp = 0;
}

if (place_meeting(x+hsp,y,npc_container)) {
    var who_is_here = instance_place(x,y, npc_container);
    
    if (who_is_here != noone && who_is_here.is_collidable == true) {
        var _x = round(x);
        var _pixel = sign(hsp);
        while (!place_meeting(_x+_pixel,y,npc_container)) {
            _x += _pixel;
            
        }
        x=_x;
        hsp = 0;
    }
}






x += x_frac;         //Add the fraction back to your position
x_frac = x % 1;        //Get the new fraction
x_int = x - x_frac;    // Get the rounded position
x = x_int;   

// get horz. speed (pos right, neg left)
hsp += _dir*accel;

//commit to movement
x+=hsp;

//change sprites accordingly

if (hsp > 0) {
    sprite_index = player_run_cycle;
    image_xscale = abs(image_xscale);
    facingForward = true;
}
else if (hsp < 0) {
    sprite_index = player_run_cycle;
    image_xscale = -abs(image_xscale);
    facingForward = false;
}
else {
    sprite_index = player_idle;
}

// dialogue check

if(keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)){
    if (currently_talking == noone) {
        var who_is_here = instance_place(x,y, npc_container);
        var what_is_here = instance_place(x,y, interactable_container);
        
        if (who_is_here != noone) {
            current_dialogue = who_is_here.text[0];
            current_name = who_is_here.char_name;
            
            in_dialogue = true;
            
            currently_talking = who_is_here;
            current_text_index = 0;
            current_text_line_number = 0;
            

        }
        else if (what_is_here != noone) {
            current_observation = what_is_here.text;
            in_dialogue = false;
            currently_talking = true;
        }
    }
    else {
        if (current_text_line_number < array_length(currently_talking.text) - 1) {

            current_text_line_number++;

            current_dialogue = currently_talking.text[current_text_line_number];
            current_text_index = 0;
        } else {
            currently_talking = noone;
        }
    }
}