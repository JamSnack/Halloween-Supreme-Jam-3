//Wrapper for requesting the info of a specific lobby, effectively asking to join the lobby.
function lobby_search(lobby_id)
{
	var _ds = ds_map_create();
	_ds[? "cmd"] = "lobby_info";
	_ds[? "id"] = real(lobby_id);
	send_data_raw(_ds);
}

function networking_player_update_inventory()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "inventory_update";
	_d[? "p_id"] = p_id;
	_d[? "inv"] = player_inventory;
	send_data(_d);
}

function networking_update_core_builds_at_index(_index)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "update_core_builds_at_index";
	_d[? "index"] = _index;
	_d[? "amt"] = entity_core.builds_stored[_index];
	send_data(_d);
}

function networking_update_core_candies_at_index(_index)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "update_core_candies_at_index";
	_d[? "index"] = _index;
	_d[? "amt"] = entity_core.candies_stored[_index];
	send_data(_d);
}