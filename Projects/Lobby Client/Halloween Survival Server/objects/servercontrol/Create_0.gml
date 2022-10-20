/// @description Init and create lobby

//Init variables
global.lobby_id = -1;
global.inventory_size = 8;
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

//Game Stage
//global.game_state = "INTERMISSION";
global.game_stage = 5;
global.game_timer = 30;

function spawn_enemy()
{
	repeat(global.game_stage + instance_number(entity_player))
	{
		var _x = irandom(1000);
		
		var _e = instance_create_layer(_x, -100, "Instances", choose(entity_enemy, entity_fast_enemy));
	}
}

global.next_id = 1;

//Game stuff
enum BUILD
{
	block,
	door,
	glass,
	last	
}

enum CANDY
{
	yellow,
	magenta,
	teal,
	last
}