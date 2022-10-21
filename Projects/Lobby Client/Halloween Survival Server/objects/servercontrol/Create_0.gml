/// @description Init and create lobby

//Init variables
global.lobby_id = -1;
global.inventory_size = 8;
//split_packets = ds_list_create();

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

alarm[0] = 10;

//Init targeting type
enum TARGET_TYPE
{
	normal,
	none
}

//Game Stage
//global.game_state = "INTERMISSION";
global.game_stage = 1;
global.game_timer = 30;
bosses_alive = 0;

function spawn_enemy()
{
	for (var _i = 0; _i < instance_number(entity_player); _i++)
	{
		//Hostile generic enemies
		repeat( irandom(2) + min(6, global.game_stage div 5) )
			instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", scr_get_generic_enemy() );
	}
	
	
	
	//Keep boss count up
	if (bosses_alive < global.game_stage div 10)
	{
		instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", scr_get_boss() );
		bosses_alive += 1;	
	}

}

global.next_id = 1;

//Game stuff
enum BUILD
{
	block,
	door,
	glass,
	false_block,
	last	
}

enum CANDY
{
	yellow,
	magenta,
	teal,
	red,
	green,
	blue,
	last
}

enum ENEMY
{
	generic_enemy,
	greenthin,
	jumpkin,
	golden_jumpkin,
	zombie,
	pigyamo,
	pumpkin,
	weed,
	last
}