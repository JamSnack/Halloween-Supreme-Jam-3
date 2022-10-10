/// @description Init and create lobby

//Init variables
global.lobby_id = -1;
split_packets = ds_list_create();

//Init Imguigml
imguigml_activate();

debug_scroll = 0;

//Init debug log
debug_log = 
{
	text : "",
	clear_output : function clear_output() { text = ""; },
	append : function append(_str)
	{
		text += "[" + string(TIME) + "]: " + string(_str) + "\n"; 
		
		if (-string_height(text) < -800)
		{
			serverControl.debug_scroll -= 64;
		}
		
	}
}

//We want to create the lobby right now
debug_log.append("Trying to create lobby...");
terminal_input = "";

setting_show_incoming_packets = false;
setting_show_log = false;

createLobby(55555);

//Init targeting type
enum TARGET_TYPE
{
	normal,
}

//enemy testing
function spawn_enemy()
{
	if (instance_exists(entity_player))
		instance_create_layer(entity_player.x + 64, entity_player.y + 64, "Instances", entity_enemy);
}

global.next_enemy_id = 1;
