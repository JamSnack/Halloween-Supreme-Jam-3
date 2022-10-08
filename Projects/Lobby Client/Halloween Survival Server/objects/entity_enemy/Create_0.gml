/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function send_enemy_to_client()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "create_enemy";
	_d[? "e_id"] = enemy_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "mhp"] = max_hp;
	_d[? "hp"] = hp;
	_d[? "o_i"] = "obj_enemy_entity"; //what to create on the player's side
	send_data(_d);
}

move_delay = 10;
