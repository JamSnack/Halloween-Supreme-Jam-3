/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Request the server for playername if it doesn't exist

if (p_n == "" && TIME % 2 == 0)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_name_request";
	_d[? "p_id"] = p_id;
	send_data(_d);
}

