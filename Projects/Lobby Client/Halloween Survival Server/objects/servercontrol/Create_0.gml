/// @description Init and create lobby
randomize();


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
	scramble,
	boss_scramble,
	none
}

//Game Stage
//global.game_state = "INTERMISSION";
global.game_stage = -3;
global.game_timer = 30;
bosses_alive = 0;
boss_stage = 0;
//next_wave_spawn_horde = false;

function spawn_enemy()
{	
	if (global.game_stage >= 0)
	{
		for (var _i = 0; _i < instance_number(entity_player); _i++)
		{		
			//Hostile generic enemies
			repeat( 1 + min(6, global.game_stage div 8) )
				instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", scr_get_generic_enemy() );
		}
	
		//Keep boss count up
		if (bosses_alive < global.game_stage div 10)
		{
			instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", scr_get_boss() );
			bosses_alive += 1;
		}
		
		//golden jumpkin?
		if (irandom(45) == 5)
			instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", entity_gold_jumpkin );
			
		//Archfiends
		if (global.game_stage >= 1 && boss_stage == 0)
		{
			instance_create_layer( 450, irandom_range(630, 4500), "Instances", entity_poultrygeist );
			send_announcement("An Archfiend has appeared in the Mountains!");
			boss_stage += 1;
		}
	}
}

function on_game_start()
{
	
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
	white,
	black,
	magic,
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
	gold_jumpkin,
	troopie,
	scarecrow,
	poultrygeist,
	tender_spirit,
	skeleton_crab,
	last
}

enum STATS
{
	hp,
	movespeed,
	attack,
	attack_speed,
	last
}

//core
global.core_x = floor(CENTER_X/32)*32 + 16;
global.core_y = floor(CENTER_Y/32)*32 + 16;