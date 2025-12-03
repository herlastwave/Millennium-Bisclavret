//momentum
hsp=0
accel =0.5;
decel = 0.5;

global.reneeFought=false;

// max horz speed
max_hsp= 9;

show_icon=false;

moving=true;

facingForward = true;

npc_x=0;

x_frac = 0;

current_dialogue = "";
current_name = "";
current_text_index = 0;
current_text_line_number = 0;

currently_talking = noone;

in_dialogue = false;
in_cutscene = false;

ChatterboxLoadFromFile("dialog.yarn");

chatterbox = ChatterboxCreate("dialog.yarn");

ChatterboxVariableDefault("gotBooklet", 0)
ChatterboxVariableDefault("reneeVisited", -1)
ChatterboxVariableDefault("battleStart", 0);

is_colliding=false;

drawing_options = false;

choice_select=0;
choice_alpha=1;

first_line_written=false;



