draw_set_font(typey);

var x1= 0;
var y1= window_get_height() - 160;
var x2 = window_get_width();
var y2 = window_get_height();

draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, false);

if (currently_talking != noone) {
    
    var name_x = x1 + 32;
    var name_y = y1 + 32;
    
    var text_x = x1 + 200;
    var text_y = y1 + 32;
    
    draw_set_color(c_black);
    
    if (in_dialogue=true) {
        draw_text(name_x, name_y, current_name);
        draw_text(text_x, text_y, string_copy("\""+current_dialogue+"\"", 1, current_text_index));
        current_text_index++;
    }
    else {
        draw_text(name_x, name_y, "Melion");
        draw_text(text_x, text_y, current_observation);
    }
}