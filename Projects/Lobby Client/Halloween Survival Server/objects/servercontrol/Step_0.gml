/// @description Insert description here
// You can write your code in this editor
if (imguigml_ready())
{
	
	//OUTPUT WINDOW
	imguigml_set_next_window_size(600, 120);
	imguigml_set_next_window_pos(0, 0);
	imguigml_begin("Output");
	if (imguigml_button("Clear Output"))
		debug_log.clear_output();
		
	if (imguigml_button("Restart Lobby"))
		game_restart();
		
	if (imguigml_button("Spawn Enemy"))
		spawn_enemy();
	
	if (imguigml_button("Toggle Headless (Optimal)"))
	{
		headless_mode = !headless_mode;
		draw_enable_drawevent(!headless_mode);
	}
	
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


//DEBUG SCROLLING (Fuck)
if (mouse_wheel_up())
	debug_scroll -= 24;
else if (mouse_wheel_down())
	debug_scroll += 24;
	
//Game Control
if (global.game_timer <= 0)
{
	//Intermission is over!
	global.game_timer = room_speed*(30+irandom(20));
	
	//respawn players
	if (instance_exists(entity_player))
	{
		with (entity_player)	
		{
			//decrease game_stage for each player death.
			if (dead)
				if (global.game_stage > 0)
					global.game_stage -= 1;
			
			dead = false;
		}
	}
			
	//respawn core
	if (!instance_exists(entity_core))
	{
		instance_create_layer(global.core_x, global.core_y, "Instances", entity_core);
		global.game_stage = floor((global.game_stage)/2); //if the players got cored, drastically decrease game_stage
		
		on_game_start();
	}
	else
	{
		//spawn mobs
		spawn_enemy();
	
		//Fill the world with nodes
		repeat (35 - (instance_number(entity_pumpkin) + instance_number(entity_weed)) )
		{
			var _x = irandom_range(3032, 5000-32);
			var _y = irandom_range(3032, 5000-32)
			
			if (collision_point(_x, _y, entity_block, false, true) == noone)
				instance_create_layer(_x, _y, "Instances", choose(entity_weed, entity_pumpkin, entity_pumpkin) );	
		}
	
		repeat (20 - instance_number(entity_ocean_node) )
		{
			var _x = irandom_range(32, 2700);
			var _y = irandom_range(6200, 8000-32)
			
			if (collision_point(_x, _y, entity_block, false, true) == noone)
				instance_create_layer(_x, _y, "Instances", entity_ocean_node);	
		}
	
		repeat (30 - instance_number(entity_rock) )
		{
			var _x = irandom_range(32, 1580);
			var _y = irandom_range(32, 5740);
			
			if (collision_point(_x, _y, entity_block, false, true) == noone)
				instance_create_layer(_x, _y, "Instances", entity_rock);	
		}
	
		repeat (3 - instance_number(entity_star))
		{
			var _x = irandom_range(500, 7500);
			var _y = irandom_range(500, 7500)
			
			if (collision_point(_x, _y, entity_block, false, true) == noone)
				instance_create_layer(_x, _y, "Instances", entity_star);	
		}
	
		//passively increase game_stage
		global.game_stage += 1;
	}
}
else
{	
	if (instance_number(entity_player) > 0)
	{
		//Waiting to increase game_stage...
		global.game_timer--;
	}
}