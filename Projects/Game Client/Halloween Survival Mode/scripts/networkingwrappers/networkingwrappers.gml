// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Wrapper for requesting the info of a specific lobby, effectively asking to join the lobby.
function lobby_search(lobby_id)
{
	var id_as_real_number = -1;
	
	try { id_as_real_number = real(lobby_id); } 
	catch(e) { show_debug_message("id is not a real number" + string(e)); } 
	
	var _ds = ds_map_create();
	_ds[? "cmd"] = "lobby_info";
	_ds[? "id"] = id_as_real_number;
	_ds[? "p_n"] = global.player_name;
	send_data_raw(_ds);
}