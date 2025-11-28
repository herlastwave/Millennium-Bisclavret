draw_set_font(typeyReg);

var x1= 0;
var y1= window_get_height() - 200;
var x2 = window_get_width();
var y2 = window_get_height();

draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, false);

var name_x = x1 + 290;
var name_y = y1 + 50;
    
var text_x = x1 + 340;
var text_y = y1 + 50;

draw_set_color(c_black);


if (current_name="") {
    draw_set_halign(fa_left)
    draw_set_font(typeyReg);
    draw_text_ext_colour(text_x, text_y, string_copy(current_dialogue, 1, current_text_index), -1, window_get_width()-450, c_black, c_black, c_black, c_black, 1);
    current_text_index++;
}
else {
    draw_set_halign(fa_right)
    draw_set_font(typeyItalic);
    draw_text_ext_colour(name_x, name_y, current_name, -1, 250, c_black, c_black, c_black, c_black, 1);
    draw_text_ext_colour(name_x+35, name_y, "–", -1, 200, c_black, c_black, c_black, c_black, 1);
    draw_set_font(typeyReg);
    draw_set_halign(fa_left)
    draw_text_ext_colour(text_x, text_y, string_copy("\""+current_dialogue+"\"", 1, current_text_index), -1, window_get_width()-450, c_black, c_black, c_black, c_black, 1);
    current_text_index++;
}


if (drawing_options=true) {
    var _option_count = ChatterboxGetOptionCount(chatterbox);
    var _i=0;
    
    draw_set_halign(fa_left)
    var choice_x = x1 + 350;
    var choice_y= y1 + 130;
    choice_alpha=1;
    
    repeat (_option_count) {
        var _choice_option = ChatterboxGetOption(chatterbox, _i);
        
        if(choice_select==_i) {
            draw_sprite_ext(dagger, -1, choice_x-75, choice_y, 0.25, 0.25, 0, c_black, 1)
            choice_alpha=1;
        }
        else {
            choice_alpha=0.5;
        }
        
        
        draw_text_colour(choice_x, choice_y, _choice_option, c_black, c_black, c_black, c_black, choice_alpha);
        
        choice_x+=string_length(_choice_option)*12+250;
        _i++;
    }
}

//draw menus
var menu_x = 250;
var menu_y = 500;
var menu_spacing=50;

draw_set_colour(c_black);
draw_set_font(typeyRegLarge);

menu_options = ["Taunt","Block","Strike","Flee"];
var menu_option_count = array_length(menu_options);

var _i=0;
draw_set_halign(fa_right)

if (in_dialogue=false) {
    // wait for player to choose options using space
    
    if (menu_choice_select > menu_option_count-1) {
        menu_choice_select = 0;
    }
    else if (menu_choice_select < 0) {
        menu_choice_select = menu_option_count-1;
    }
    
    menu_choice_select+= keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

    repeat (menu_option_count) {
        var menu_choice_option = menu_options[_i];
        
        if(menu_choice_select==_i) {
            draw_sprite_ext(dagger, -1, menu_x-95-string_length(menu_choice_option)*24, menu_y+8, 0.38, 0.38, 0, c_black, 1)
            choice_alpha=1;
        }
        else {
            choice_alpha=0.5;
        }
        
        draw_text_colour(menu_x, menu_y, menu_choice_option, c_black, c_black, c_black, c_black, choice_alpha);
        
        menu_y+=menu_spacing;
        _i++;
    }
}
else {
    repeat (menu_option_count) {
        var menu_choice_option = menu_options[_i];
        
        draw_text_colour(menu_x, menu_y, menu_choice_option, c_black, c_black, c_black, c_black, choice_alpha);
        
        menu_y+=menu_spacing;
        _i++;
    }
}

//draw hitpoints
//player
var player_health_x = 65;
var player_health_y = 150;
var health_spr_scale=0.20;
var health_spr_spacing=75;

var _j=0

var full_health_points=current_player_health;
var empty_health_points=player_health_total-current_player_health;

draw_sprite_ext(health_karat,-1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,0,c_white,1);
player_health_y += health_spr_spacing;

if running_opening_sequence == false {
   repeat (empty_health_points) {   
       
       draw_sprite_ext(hit_point_empty, -1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,0,c_white,1)
       
       player_health_y+=health_spr_spacing;
   }
}
repeat (full_health_points) {   
    
    draw_sprite_ext(hit_point_full, -1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,0,c_white,1)
    
    player_health_y+=health_spr_spacing;
}
draw_sprite_ext(health_karat,-1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,180,c_white,1);


//enemy
var enemy_health_x = window_get_width()-50;
var enemy_health_y = 100;
var enemy_health_spr_scale=0.15;
var enemy_health_spr_spacing=55;

var _j=0

var full_health_points=current_enemy_health;
var empty_health_points=enemy_health_total-current_enemy_health;

draw_sprite_ext(health_karat,-1,enemy_health_x,enemy_health_y,enemy_health_spr_scale,enemy_health_spr_scale,0,c_white,1);
enemy_health_y += enemy_health_spr_spacing;

if running_opening_sequence == false {
    repeat (empty_health_points) {   
    
       draw_sprite_ext(hit_point_empty, -1,enemy_health_x,enemy_health_y,enemy_health_spr_scale,enemy_health_spr_scale,0,c_white,1)
       
       enemy_health_y+=enemy_health_spr_spacing;
    }
}

repeat (full_health_points) {   
    
    draw_sprite_ext(hit_point_full, -1,enemy_health_x,enemy_health_y,enemy_health_spr_scale,enemy_health_spr_scale,0,c_white,1)
    
    enemy_health_y+=enemy_health_spr_spacing;
}
draw_sprite_ext(health_karat,-1,enemy_health_x,enemy_health_y,enemy_health_spr_scale,enemy_health_spr_scale,180,c_white,1);

