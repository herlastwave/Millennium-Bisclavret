draw_set_font(typey);

var x1= 0;
var y1= window_get_height() - 200;
var x2 = window_get_width();
var y2 = window_get_height();

draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, false);

var name_x = x1 + 220;
var name_y = y1 + 50;
    
var text_x = x1 + 250;
var text_y = y1 + 50;

draw_set_halign(fa_right)
draw_text_ext_colour(name_x, name_y, current_name, -1, 200, c_black, c_black, c_black, c_black, 1);
draw_set_halign(fa_left)
draw_text_ext_colour(text_x, text_y, string_copy(current_dialogue, 1, current_text_index), -1, window_get_width()-350, c_black, c_black, c_black, c_black, 1);
current_text_index++;
