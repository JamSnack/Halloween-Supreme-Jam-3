/// @description Insert description here
// You can write your code in this editor
imguigml_activate();

show_debug_overlay(true);

//vars
stored_lobby_id = "";

//Initialize Multiplayer stuff
global.port = 55555;
global.socket = noone;
global.is_host = false; //Whether or not this client is hosting a multiplayer game.
global.player_id = -1; //Will be granted on lobby-join. Keeps track of who's who


//Keep track of multiplayer state:
global.lobby_id = -1;

//Chat
chat_overlay = {
	text : "",
	append : function append(new_text) { text = (new_text + "\n" + text) },
	clear_text : function clear_text() { text = "" }
}