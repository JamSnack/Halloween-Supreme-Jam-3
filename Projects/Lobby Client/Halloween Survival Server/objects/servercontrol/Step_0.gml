/// @description Insert description here
// You can write your code in this editor
if (imguigml_ready())
{
	
	//OUTPUT WINDOW
	imguigml_begin("Output");
	if (imguigml_button("Clear Output"))
		debug_log.clear_output();
		
	if (imguigml_button("Restart Lobby"))
		game_restart();
		
	imguigml_text(debug_log.text);
	imguigml_end();
	
	
	//LOBBY INFORMATION WINDOW
	if (global.lobby_id != -1)
	{
		imguigml_begin("Lobby Information");
		imguigml_text("Lobby ID: " + string(global.lobby_id));
	}
	
	imguigml_end();
}

//HEARTBEAT

if (TIME % 3 == 0)
{
	with (entity_player)
	{
		if (moved)
		{
			var _d = ds_map_create();
			_d[? "cmd"] = "player_pos";
			_d[? "p_id"] = p_id;
			_d[? "x"] = x;
			_d[? "y"] = y;
			send_data(_d);
			
			moved = false;
		}
	}
}