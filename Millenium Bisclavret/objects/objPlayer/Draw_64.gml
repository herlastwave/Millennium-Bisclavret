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
if (currently_talking != noone) {
    draw_set_color(c_black);
    
    if (in_dialogue=true) {
        if (current_name="") {
            draw_set_halign(fa_left)
            draw_text_ext(text_x, text_y, string_copy(current_dialogue, 1, current_text_index), -1, window_get_width()-250);
            current_text_index++;
        }
        else {
            draw_set_halign(fa_right)
            draw_text_ext(name_x, name_y, current_name, -1, 200);
            draw_set_halign(fa_left)
            draw_text_ext(text_x, text_y, string_copy("\""+current_dialogue+"\"", 1, current_text_index), -1, window_get_width()-350);
            current_text_index++;
        }
    }
}

