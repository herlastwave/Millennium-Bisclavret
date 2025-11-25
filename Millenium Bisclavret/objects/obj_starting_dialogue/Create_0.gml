ChatterboxLoadFromFile("dialog.yarn");

chatterbox = ChatterboxCreate("dialog.yarn");

current_dialogue = "";
current_text_index = 0;

ChatterboxJump(chatterbox, "Prologue");

current_dialogue        = ChatterboxGetContent(chatterbox,0);
nodeTitle   = ChatterboxGetCurrent(chatterbox);
current_name = ""