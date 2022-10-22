/// @description Insert description here
// You can write your code in this editor
if (imguigml_ready())
{
	if (room == rm_zero)
	{
		var _s = 300;
		imguigml_set_next_window_pos(global.display_width/2 - _s/2, 80);
		imguigml_set_next_window_size(_s, 300);
		imguigml_begin("Multiplayer");
		
		imguigml_text("Enter Username:");
		global.player_name = imguigml_input_text(" ", global.player_name, 12)[1];
		
		if (global.player_name == "")
			global.player_name = ">:)";
		
		imguigml_text("Enter Lobby ID:");
		stored_lobby_id = imguigml_input_text("", stored_lobby_id, 5)[1]; //returns imguigml_input_text at [1], which is the text feild portion of the array.
		var join_lobby = imguigml_button("Join Lobby");
	
		if (join_lobby)
			joinLobby(stored_lobby_id);
		
		//Draw stuff
		var l_text = (global.lobby_id == -1) ? "No lobby entered." : string(global.lobby_id);
		
		imguigml_text("Lobby ID: " + l_text);
		imguigml_end();
	}
}

//Have we successfully found a lobby?
if (global.lobby_id != -1 && room == rm_zero)
{
	room_goto(rm_world);
	chat_overlay.append("Welcome to Treat Squad, " + string(global.player_name) + "!\nWorld: "+string(global.lobby_id));
}

//Chatting
var chat_key = keyboard_check_released(vk_enter);
	
//show_debug_message(string(global.chatting));	

if (global.chatting)
{
	if (chat_key)
	{
		chat_overlay.send_chat();
		global.chatting = false;
		keyboard_string = "";
	}
	else
	{
		if (string_length(keyboard_string) < 42)
			chat_overlay.chat_text = keyboard_string;
		else keyboard_string = chat_overlay.chat_text;
	}
}
else if (chat_key)
{
	global.chatting = true;
	keyboard_string = "";
}

global.chat_alpha = approach(global.chat_alpha, global.chatting, 0.0025 + 0.09*global.chatting);

//XP
xp_draw = lerp(xp_draw, xp, 0.1);

//Character Sheet
if (keyboard_check_released(ord("G")))
	draw_character_sheet_target = !draw_character_sheet_target;
	
draw_character_sheet = approach(draw_character_sheet, draw_character_sheet_target, 0.1);