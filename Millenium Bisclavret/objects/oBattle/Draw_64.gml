

var x1= 0;
var y1= window_get_height() - 200;
var x2 = window_get_width();
var y2 = window_get_height();

draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, false);

//temporary UI to be replaced with mine
//positions
#macro COLUMN_ENEMY 20
#macro COLUMN_NAME 490
#macro COLUMN_HP 890

//draw headings
draw_set_font(typeyReg);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);

draw_text(COLUMN_ENEMY, y1+20, "ENEMY");
draw_text(COLUMN_NAME, y1+20, "NAME");
draw_text(COLUMN_HP, y1+20, "HP");

//draw enemy names
draw_set_font(typeyItalic);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
var _drawLimit=2;
var _drawn=0;
for (var i=0; (i<array_length(enemyUnits)) && (_drawn < _drawLimit); i++) {
    var _char=enemyUnits[i];
    if (_char.hp>0)
    {
        _drawn++;
        if (_char.id==unitWithCurrentTurn) {
            draw_set_color(c_blue);
        }
        draw_text(COLUMN_ENEMY,y1+50+(i*50),_char.name);
    }
}

//draw party info
for (var i=0; i<array_length(playerUnits); i++) {
    //player names
    draw_set_halign(fa_left);
    draw_set_color(c_black);
    var _char=playerUnits[i];
    if (_char.id==unitWithCurrentTurn) {
        draw_set_colour(c_blue);
    }
    if (_char.hp <= 0) {
        draw_set_colour(c_red);
    }
    draw_text(COLUMN_NAME, y1+50+(i*50),_char.name);
    draw_set_halign(fa_right);
    
    //hp
    draw_set_colour(c_black);
    if (_char.hp < (_char.hp_max*0.5)) {
        draw_set_color(c_orange);
    }
    if (_char.hp < 0) {
        draw_set_color(c_red);
    }
    draw_text(COLUMN_HP, y1+50+(i*50),string(_char.hp)+"/"+string(_char.hp_max));
}

//draw hp bubbles
var player_health_x = 165;
var player_health_y = 150;
var health_spr_scale=0.25;
var health_spr_spacing=90;

var enemy_health_x = window_get_width()-150;
var enemy_health_y = 50;
var enemy_health_spr_scale=0.15;
var enemy_health_spr_spacing=55;
var enemy_health_rect_halfwidth=30;

//draw player hp bubbles
for (var i=0; i<array_length(playerUnits); i++) {
    var _char=playerUnits[i];
    var full_health_points=_char.hp;
    var empty_health_points=_char.hp_max-_char.hp;
    
    draw_sprite_ext(health_karat,-1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,0,c_white,1);
    player_health_y += health_spr_spacing;
    
    repeat (empty_health_points) {   
        draw_sprite_ext(hit_point_empty, -1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,0,c_white,1)
        player_health_y+=health_spr_spacing;
    }
    
    repeat (full_health_points) {   
        draw_sprite_ext(hit_point_full, -1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,0,c_white,1)
        player_health_y+=health_spr_spacing;
    }
    draw_sprite_ext(health_karat,-1,player_health_x,player_health_y,health_spr_scale,health_spr_scale,180,c_white,1);
}

//draw enemy hp bubbles

for (var i=0; i<array_length(enemyUnits); i++) {
    var _char=enemyUnits[i];
    var full_health_points=_char.hp;
    var empty_health_points=_char.hp_max-_char.hp;
    
    draw_set_colour(c_white) {
        draw_rectangle(enemy_health_x-enemy_health_rect_halfwidth,enemy_health_y-50,enemy_health_x+enemy_health_rect_halfwidth,enemy_health_y+250, false);
    }
    
    repeat (empty_health_points) {   
        draw_sprite_ext(hit_point_empty, -1,enemy_health_x,enemy_health_y,enemy_health_spr_scale,enemy_health_spr_scale,0,c_white,1)
        enemy_health_y+=enemy_health_spr_spacing;
    }
    
    repeat (full_health_points) {   
        draw_sprite_ext(hit_point_full, -1,enemy_health_x,enemy_health_y,enemy_health_spr_scale,enemy_health_spr_scale,0,c_white,1)
        enemy_health_y+=enemy_health_spr_spacing;
    }
    draw_sprite_ext(health_karat,-1,enemy_health_x,enemy_health_y,enemy_health_spr_scale,enemy_health_spr_scale,180,c_white,1);
}




//enemy

