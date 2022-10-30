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

function networking_send_player_colors()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_colors";
	_d[? "p_id"] = global.player_id;
	
	//grab colors, construct packet
	for (var _i = 0; _i < 6*3; _i++)
	{
		var _c = "c"+string(_i);
		var _index = _i mod 3;
							
		switch (_i)
		{
			case 0: 
			case 1:
			case 2: { _d[? _c] = REPLACE_SKIN_LIGHT_ID[_index]; } break;
								
			case 3: 
			case 4:
			case 5: { _d[? _c] = REPLACE_SKIN_DARK_ID[_index]; } break;
								
			case 6: 
			case 7:
			case 8: { _d[? _c] = REPLACE_SHIRT_LIGHT_ID[_index]; } break;
								
			case 9: 
			case 10:
			case 11: { _d[? _c] = REPLACE_SHIRT_DARK_ID[_index]; } break;
								
			case 12: 
			case 13:
			case 14: { _d[? _c] = REPLACE_PANTS_LIGHT_ID[_index]; } break;
								
			case 15: 
			case 16:
			case 17: { _d[? _c] = REPLACE_PANTS_DARK_ID[_index]; } break;
		}
	}
	
	send_data(_d);
}

function request_enemy(enemy_id)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "request_enemy_entity";
	_d[? "e_id"] = enemy_id;
	send_data(_d);
	
	show_debug_message("Request Enemy");
}

function request_tile_update(tile_id)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "request_tile_update";
	_d[? "t_id"] = tile_id;
	send_data(_d);
}