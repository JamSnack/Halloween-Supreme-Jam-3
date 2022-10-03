// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function joinLobby(lobby_id)
{
	//server_status = "Connecting to server...";
	global.socket = network_create_socket(network_socket_tcp);
	
	//Try to connect to the main server.
	var _s = network_connect_raw_async(global.socket, "127.0.0.1", 55555);
	
	if (_s >= 0)
	{
		//after we've connected to the main server, attempt to join the desired lobby:
		lobby_search(lobby_id);
	}	
}

function send_data(data_map)
{
	var json_map = json_encode(data_map);
	var buff = buffer_create(128, buffer_grow, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	var _b = buffer_write(buff, buffer_string, json_map);
	
	if (_b == -1) then show_debug_message("buffer_write failed.");
	
	//show_debug_message(json_map);
	var packet_sent = network_send_raw(global.socket, buff, buffer_tell(buff)); //final argument is optional here
		
	if (packet_sent == 0)
	{
		//the send has failed. We need to try again later.
		show_debug_message("FAILED TO SEND: PACKET IS " +string(data_map[? "cmd"]));
	}// else global.packets_sent++;
	
	//cleanup
	buffer_delete(buff);
	ds_map_destroy(data_map);
}

function handle_data(data)
{	
	var parsed_data = json_decode(data);
	show_debug_message("Handling data: "+string(data));
	
	if (parsed_data != -1)
	{
		switch parsed_data[? "cmd"]
		{	
			case "lobby_connect_success": global.lobby_id = parsed_data[? "l_id"]; global.player_id = parsed_data[? "plr_id"]; break;
			case "player_pos":
			{
				var pl_id =  parsed_data[? "p_id"];
				var _x = parsed_data[? "x"];
				var _y = parsed_data[? "y"];
				
				//update current client's position
				if (global.player_id == pl_id)
				{
					obj_player.x = _x;
					obj_player.y = _y;
				}
				else
				{
					var instance_updated = false;
					
					//update another player's position
					with (obj_player_entity)
					{
						if (pl_id == p_id)
						{
							x = _x;
							y = _y;
							
							instance_updated = true;
							break;
						}
					}
					
					//Create a dummy for a new player
					if (!instance_updated)
					{
						var _p = instance_create_layer(_x, _y, "Instances", obj_player_entity);
						_p.p_id = pl_id;
					}
				}
			}
			break;
		}
	}
}