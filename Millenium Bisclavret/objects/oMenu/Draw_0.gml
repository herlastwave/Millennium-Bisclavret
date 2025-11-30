
draw_set_alpha(1);

draw_set_colour(c_white);
draw_set_colour(c_black);
draw_set_font(typeyRegLarge);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

var _desc = (description != -1);
var _scrollPush=max(0, hover - (visibleOptionsMax-1));

for (l=0; 1< (visibleOptionsMax+_desc); l++) {
    if (l >= array_length(options)) {
        break;
    }
    draw_set_colour(c_grey);
    if (l==0) && (_desc) {
        draw_text(x+xmargin, y+ymargin, description);
    }
    else {
        var _optionToShow = l - _desc+_scrollPush;
        var _str = options[_optionToShow][0];

        if (hover == _optionToShow - _desc) {
            //replace with dagger soon
            draw_set_color(c_black);
        }
        if (options[_optionToShow][3]==false) {
            draw_set_colour(c_red);
        }
        draw_text(x+xmargin,y+ymargin+l*heightLine, _str);
        
    }

}

//draw_sprite_ext(dagger,0,x+xmargin-95, y+ymargin + ((hover)*heightLine)+7, );
if (!oBattle.cursor.active) {
    draw_sprite_ext(dagger, -1, x+xmargin-300, y+ymargin + ((hover)*heightLine)+7, 0.38, 0.38, 0, c_black, 1);
}



/*
menu_options = ["Taunt","Block","Strike","Flee"];
var menu_length = array_length(menu_options);

var _i=0;
draw_set_halign(fa_right)

var _unit = unitTurnOrder[turn];

if (_unit.object_index==oBattleUnitPlayer) {
    // wait for player to choose options using space
    
    if (menu_hover > menu_length-1) {
        menu_hover = 0;
    }
    else if (menu_hover < 0) {
        menu_hover = menu_length-1;
    }
    
    menu_hover+= keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
    
    //push menu choice
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) {
        menu_push=menu_options[menu_hover];
    } 
    
    repeat (menu_length) {
        var menu_item = menu_options[_i];
        
        if(menu_hover==_i) {
            draw_sprite_ext(dagger, -1, menu_x-95-string_length(menu_item)*24, menu_y+8, 0.38, 0.38, 0, c_black, 1)
            choice_alpha=1;
        }
        else {
            choice_alpha=0.5;
        }
        
        draw_text_colour(menu_x, menu_y, menu_item, c_black, c_black, c_black, c_black, choice_alpha);
        
        menu_y+=menu_spacing;
        _i++;
    }
}
else {
    repeat (menu_length) {
        var menu_item = menu_options[_i];
        
        draw_text_colour(menu_x, menu_y, menu_item, c_black, c_black, c_black, c_black, choice_alpha);
        
        menu_y+=menu_spacing;
        _i++;
    }
}
*/