battle_dialog_node="ReneeBattle"

ChatterboxLoadFromFile("dialog.yarn");

chatterbox = ChatterboxCreate("dialog.yarn");

current_dialogue = "";
current_text_index = 0;

ChatterboxJump(chatterbox, battle_dialog_node);
current_dialogue        = ChatterboxGetContent(chatterbox,0);
current_name = "";

ChatterboxVariableDefault("sceneEnd", 0);

drawing_options = false;

choice_select=0;
choice_alpha=1;

first_line_written=true;

in_dialogue = true;
menu_choice_select = 0;

player_health_total=3;
enemy_health_total=5;

player_hits_taken =0;
enemy_hits_taken=0;

current_player_health=0;
current_enemy_health=0;

running_opening_sequence=true;
//time_source_create(time_source_game, 5, time_source_units_frames, )

timer_reset_value = 1.5*room_speed;
timer1 = timer_reset_value;
timer2 = timer_reset_value;
