/// @description Init and create lobby

//Init variables
global.lobby_id = -1;

//Init Imguigml
imguigml_activate();

//Init debug log
debug_log = 
{
	text : "",
	clear_output : function clear_output() { text = ""; },
	append : function append(_str) { text += "[" + string(TIME) + "]: " + string(_str) + "\n" }
}

//We want to create the lobby right now
debug_log.append("Trying to create lobby...");
terminal_input = "";

setting_show_incoming_packets = false;
time_last = 0;

createLobby(55555);