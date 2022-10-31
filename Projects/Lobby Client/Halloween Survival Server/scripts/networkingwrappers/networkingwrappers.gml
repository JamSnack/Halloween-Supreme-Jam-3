//Wrapper for requesting the info of a specific lobby, effectively asking to join the lobby.
function lobby_search(lobby_id)
{
	var _ds = ds_map_create();
	_ds[? "cmd"] = "lobby_info";
	_ds[? "id"] = real(lobby_id);
	send_data_raw(_ds);
}

/*function networking_player_update_inventory()
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
}*/

function networking_update_core_candies_at_index(_index)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "update_core_candies_at_index";
	_d[? "index"] = _index;
	_d[? "amt"] = entity_core.candies_stored[_index];
	send_data(_d);
}

function send_chat(text)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "chat";
	_d[? "t"] = text;
	_d[? "n"] = "";
	send_data(_d);
}

function send_announcement(text)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "announcement";
	_d[? "t"] = text;
	send_data(_d);
}

function send_damage(x, y, amount)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "damage";
	_d[? "d"] = amount;
	_d[? "x"] = x;
	_d[? "y"] = y;
	send_data(_d);
}

function networking_send_new_projectile(x, y, direction, speed, image_data, id, friction)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "projectile_shoot";
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "d"] = direction;
	_d[? "s"] = speed;
	_d[? "indx"] = image_data;
	_d[? "id"] = id;
	_d[? "f"] = friction;
	send_data(_d);
}

function send_core_revives()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "core_revives";
	_d[? "r"] = entity_core.player_revives;
	send_data(_d);	
}

function send_player_hp()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_hp";
	_d[? "hp"] = hp;
	_d[? "mhp"] = max_hp;
	_d[? "p_id"] = p_id;
	send_data(_d);	
}