/// @description Insert description here
// You can write your code in this editor
imguigml_activate();

//show_debug_overlay(true);
network_set_config(network_config_connect_timeout, 2000);

//vars
stored_lobby_id = "";
direct_connect = "165.22.184.25";

//Initialize Multiplayer stuff
global.port = 55555;
global.socket = noone;
global.player_id = -1; //Will be granted on lobby-join. Keeps track of who's who
global.player_name = "Player";
global.use_effects = false;
ping = 0;
ping_draw = 0;

//Keep track of multiplayer state:
global.lobby_id = -1;

//Chat
global.chat_alpha = 0;

chat_overlay = {
	text : "",
	append : function append(new_text) 
	{
		text = text + "\n" + new_text;
		
		if (string_height(text) > 160)
		{
			var _c = string_pos("\n", text);
			text = string_delete(text, 1, _c);
		}
		
		global.chat_alpha = 2.0;
	},
	clear_text : function clear_text() { text = "" },
	chat_text : "",
	send_chat : function send_chat() 
	{ 
		if (chat_text != "")
		{
			var _d = ds_map_create();
			_d[? "cmd"] = "chat"
			_d[? "n"] = string(global.player_name);
			_d[? "t"] = chat_text;
			send_data(_d);
		
			chat_text = "";
		}
	},
}

global.chatting = false;

//Initialize boring stuff
global.display_width = display_get_gui_width();
global.display_height = display_get_gui_height();

//Font
draw_set_font(fnt_default);

//Initialize player stuff
/*global.inventory_size = 0;
inventory_slot_selected = 0; //index of the currently selected slot
inventory_is_open = false;
inventory_anim_value = 0;

//The physical inventory this client has access to.
client_inventory = 
{
	inven : array_create(global.inventory_size, 0),
	add : function(item_id)
	{
		for (var i = 0; i < global.inventory_size; i++)
			if (inven[i] == 0)
			{
				inven[i] = item_id;
				return true;
			}
					
		return false;
	},
	remove : function(item_id)
	{
		if (item_id == undefined)
			array_pop(inven);
		else
		{
			for (var i = 0; i < global.inventory_size; i++)
				if (inven[i] == item_id)
				{
					array_delete(inven, i, 1);
					break;
				}
		}
	},
	
	is_empty : function()
	{
		for (var i = 0; i < global.inventory_size; i++)
				if (inven[i] != 0)
					return false;
					
		return true;
	},
	
	is_full : function()
	{
		for (var i = 0; i < global.inventory_size; i++)
			if (inven[i] == 0)
				return false;
					
		return true;
	},
	
	inventory_to_string : function()
	{
		for (var i = 0; i < global.inventory_size; i++)
			show_debug_message("invetory[" + string(i) + "]: " + string(inven[i]));
	}
}
*/
//Game state
global.game_timer = 0;
global.revives_remaining = 20;

//animation cuvres
global.pop_curve = animcurve_get_channel(ac_pop, 0);
global.fade_curve = animcurve_get_channel(ac_pop, 1);

//enums
//cloned from server counterparts
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
	black,
	white,
	magic,
	last
}

global.held_candy = array_create(CANDY.last, 0);

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
	ghost,
	gravestone,
	imp,
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

//CLIENT PLAYER STATS
enum STATS
{
	hp,
	movespeed,
	attack,
	attack_speed,
	last
}

player_stats = array_create(STATS.last, 0);

xp = 0;
xp_needed = 25;
level = 0;
xp_draw = 0;
skillpoints = 0;

draw_character_sheet = 0;
draw_character_sheet_target = 0;

cursor_text = "";


//keep things real with the server
enemy_update_index = 0;
update_enemy_delay = 0;
block_update_index = 0;
update_block_delay = 0;

//view stuff
x_view = 560;
y_view = 560;
target_x_view = 0;
target_y_view = 0;
x_accel = 0;
y_accel = 0;

bkg_sprite = layer_sprite_create("Assets_1", 0, 0, spr_menu_bkg);
layer_sprite_xscale(bkg_sprite, 5);
layer_sprite_yscale(bkg_sprite, 5);

//global listener
audio_listener_orientation(0, 0, 1, 0, -1, 0);
audio_falloff_set_model(audio_falloff_linear_distance);
//server_inventory = array_create(inventory_size, 0); //A representation of the server's inventory for this client.