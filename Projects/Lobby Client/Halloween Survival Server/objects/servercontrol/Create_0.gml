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
			serverControl.debug_scroll -= 64;
			
		//draw_enable_drawevent(true);
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
	charge,
	none
}

//Game Stage
//global.game_state = "INTERMISSION";
global.game_stage = 500;
global.game_timer = 30;
bosses_alive = 0;
boss_stage = 4;

function spawn_enemy()
{	
	if (global.game_stage >= 0)
	{
		for (var _i = 0; _i < instance_number(entity_player); _i++)
		{		
			//Hostile generic enemies
			repeat( 1 + min(6, global.game_stage div 30) )
				instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", scr_get_generic_enemy() );
		}
	
		//Keep boss count up
		if (bosses_alive < global.game_stage div 10)
		{
			instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", scr_get_boss() );
			bosses_alive += 1;
		}
		
		//golden jumpkin?
		if (irandom(40) == 5)
			instance_create_layer( choose(-32, WORLD_WIDTH+32), choose(-32, WORLD_HEIGHT+32), "Instances", entity_gold_jumpkin );
			
		//Archfiends
		if (global.game_stage >= 1 && boss_stage == 0)
		{
			instance_create_layer( 450, irandom_range(630, 4500), "Instances", entity_poultrygeist );
			send_announcement("An Archfiend has appeared in the Mountains!");
			boss_stage += 1;
		}
		else if (global.game_stage >= 35 && boss_stage == 1)
		{
			instance_create_layer( 610, 7420, "Instances", entity_skeleton_crab );
			send_announcement("An Archfiend has appeared near the Ocean!");
			boss_stage += 1;
		}
		else if (global.game_stage >= 70 && boss_stage == 2)
		{
			instance_create_layer( 7000, 7159, "Instances", entity_halloween_ham );
			send_announcement("An Archfiend has appeared in the Marsh!");
			boss_stage += 1;
		}
		else if (global.game_stage >= 100 && boss_stage == 3)
		{
			send_announcement("[Grevil the Galling]: You Trick or Treaters will NEVER have your treats back!");
			spawn_scarecrows(30);
			bosses_alive = 0;
			boss_stage += 1;
		}
		else if (global.game_stage >= 101 && boss_stage == 4)
		{
			send_announcement("[Grevil the Galling]: My treat champions will defeat you!");
			instance_create_layer( CENTER_X,  CENTER_Y - 350, "Instances", entity_poultrygeist );
			instance_create_layer( CENTER_X - 450, CENTER_Y + 450, "Instances", entity_skeleton_crab );
			instance_create_layer( CENTER_X + 450, CENTER_Y + 450, "Instances", entity_halloween_ham );
			boss_stage += 1;
		}
		else if (global.game_stage >= 102 && boss_stage == 5)
		{
			send_announcement("[Grevil the Galling]: FACE MY WRATH!");
			boss_stage += 1;
		}
		else if (global.game_stage >= 103 && boss_stage == 6)
		{
			boss_stage += 1;
		}
	}
}

function spawn_scarecrows(amt)
{
	var _deg = 0;
	repeat(amt)
	{
		_deg += 1/amt;
		instance_create_layer(CENTER_X + lengthdir_x(1300, _deg*360), CENTER_Y + lengthdir_y(1300, _deg*360), "Instances", entity_scarecrow);
	}
}

function on_game_start()
{
	spawn_scarecrows(25);
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
	skeleton_crab_minion,
	halloween_ham,
	ham_jumpkin,
	ocean_node,
	rock,
	star,
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

enum PROJECTILE
{
	normal,
	egg,
	wave,
	wind,
	last	
}

//core
global.core_x = floor(CENTER_X/32)*32 + 16;
global.core_y = floor(CENTER_Y/32)*32 + 16;