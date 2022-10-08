/// @description Insert description here
// You can write your code in this editor
if (imguigml_ready())
{
	
	//OUTPUT WINDOW
	imguigml_set_next_window_size(600, 100);
	imguigml_set_next_window_pos(0, 0);
	imguigml_begin("Output");
	if (imguigml_button("Clear Output"))
		debug_log.clear_output();
		
	if (imguigml_button("Restart Lobby"))
		game_restart();
	
	debug_scroll = clamp(debug_scroll, -string_height(debug_log.text) + 600, 0);
	
	//TERMINAL INPUT
	terminal_input = imguigml_input_text("Terminal Input", terminal_input, 128)[1];
	
	//Interpret terminal input
	if (keyboard_check_pressed(vk_enter) && terminal_input != "")
	{
		switch (terminal_input)
		{
			case "/help": { debug_log.append("\n/help - List these commands\n/receive - Toggle view of incoming packets"); } break;
			case "/receive": { debug_log.append("Toggled incoming packets."); setting_show_incoming_packets = !setting_show_incoming_packets} break;
			case "/show log": { setting_show_log = !setting_show_log; } break;
			default: { debug_log.append("Unknown command. Try /help for more info.") } break;
		}
		
		terminal_input = "";
	}
	
	imguigml_end();
	
	//LOBBY INFORMATION WINDOW
	if (global.lobby_id != -1)
	{
		imguigml_set_next_window_size(300, 300);
		imguigml_set_next_window_pos(600, 0);
		
		imguigml_begin("Lobby Information");
		
		imguigml_text("Lobby ID: " + string(global.lobby_id));
		
		imguigml_end();
	}
}

//HEARTBEAT
with (entity_player)
{
	if (moved)
	{
		var _d = ds_map_create();
		_d[? "cmd"] = "player_pos";
		_d[? "p_id"] = p_id;
		_d[? "x"] = x;
		_d[? "y"] = y;
		_d[? "xscale"] = image_xscale;
		send_data(_d);
			
		moved = false;
	}
}


//DEBUG SCROLLING (Fuck)
if (mouse_wheel_up())
	debug_scroll -= 24;
else if (mouse_wheel_down())
	debug_scroll += 24;