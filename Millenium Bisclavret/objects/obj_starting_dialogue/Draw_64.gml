draw_set_font(typeyReg);

var x1= 0;
var y1= window_get_height() - 200;
var x2 = window_get_width();
var y2 = window_get_height();

draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, false);

var name_x = x1 + 300;
var name_y = y1 + 50;
    
var text_x = x1 + 350;
var text_y = y1 + 50;


draw_set_halign(fa_right)
draw_set_font(typeyItalic);
draw_text_ext_colour(name_x, name_y, current_name, -1, 250, c_black, c_black, c_black, c_black, 1);
draw_set_font(typeyReg);
draw_set_halign(fa_left)
if (current_name != "") {
    draw_text_ext_colour(name_x+20, name_y, "–", -1, 200, c_black, c_black, c_black, c_black, 1);
}
draw_text_ext_colour(text_x, text_y, string_copy(current_dialogue, 1, current_text_index), -1, window_get_width()-450, c_black, c_black, c_black, c_black, 1);
current_text_index++;

if (drawing_options=true) {
    var _option_count = ChatterboxGetOptionCount(chatterbox);
    var _i=0;
    
    draw_set_halign(fa_left)
    var choice_x = x1 + 350;
    var choice_y= y1 + 100;
    
    repeat (_option_count) {
        var _choice_option = ChatterboxGetOption(chatterbox, _i);
        draw_text_colour(choice_x, choice_y, _choice_option, c_black, c_black, c_black, c_black, 1);
        
        choice_x+=250;
        _i++;
    }
}

