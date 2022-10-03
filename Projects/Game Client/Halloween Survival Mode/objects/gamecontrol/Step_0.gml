/// @description Insert description here
// You can write your code in this editor
if (imguigml_ready())
{
	if (room == rm_zero)
	{
		imguigml_begin("Multiplayer");
		stored_lobby_id = imguigml_input_text("Lobby ID", stored_lobby_id, 8)[1]; //returns imguigml_input_text at [1], which is the text feild portion of the array.
		var join_lobby = imguigml_button("Join Lobby");
	
		if (join_lobby)
			joinLobby(stored_lobby_id);
		
		//Draw stuff
		imguigml_text("Lobby ID: " + string(global.lobby_id));
		imguigml_end();
	}
	else
	{
		imguigml_set_next_window_pos(0, room_height - 200);
		imguigml_begin("Chat");
		imguigml_text(chat_overlay.text);
		imguigml_end();
	}
}

//Have we successfully found a lobby?
if (global.lobby_id != -1 && room == rm_zero)
{
	room_goto(rm_world);
	chat_overlay.append("Welcome to Treat Squad, player " + string(global.player_id) + "!\nWorld: "+string(global.lobby_id));
}