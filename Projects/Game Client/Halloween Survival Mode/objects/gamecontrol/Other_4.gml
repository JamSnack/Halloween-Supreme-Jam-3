/// @description Insert description here
// You can write your code in this editor
global.use_effects = false;

if (room == rm_world)
{
	var _p = instance_create_layer(SPAWN_X, SPAWN_Y, "Instances", obj_player);
	_p.p_id = global.player_id;
	
	global.use_effects = true;
	
	//request world update
	var _d = ds_map_create();
	_d[? "cmd"] = "request_world_update";
	_d[? "p_id"] = global.player_id;
	send_data(_d);
	
	//request player colors
	var _d = ds_map_create();
	_d[? "cmd"] = "request_player_colors";
	send_data(_d);
}