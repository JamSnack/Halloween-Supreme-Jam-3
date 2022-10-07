// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createLobby(port)
{
	//Creates a lobby on the relay server
	global.socket = network_create_socket(network_socket_tcp);
	
	//Connect to the relay server
	var _s = network_connect_raw(global.socket, "127.0.0.1", port);
	
	if (_s >= 0)
	{
		debug_log.append("Connected to Server. Requesting Lobby Information.");
		lobby_search(0);
	}
	else
	{
		debug_log.append("Failed to connect to server!");
	}
}

function send_data(data_map)
{
	var json_map = json_encode(data_map);
	var buff = buffer_create(128, buffer_grow, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	var _b = buffer_write(buff, buffer_string, json_map);
	
	if (_b == -1) then show_debug_message("buffer_write failed.");
	
	show_debug_message(json_map);
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
	
	if (setting_show_incoming_packets)
	{
		try
		{
			debug_log.append("Input: "+string(data));
		}
	}
	
	if (parsed_data != -1)
	{
		switch parsed_data[? "cmd"]
		{	
			case "lobby_connect_success":
			{
				global.lobby_id = parsed_data[? "l_id"];
				debug_log.append("Lobby Created Successfully!\n\nShare this ID with your friends to play together: " + string(global.lobby_id));
			}
			break;
			
			case "player_connected":
			{
				var _id = real(parsed_data[? "p_id"]);
				var _p = instance_create_layer(100, 100, "instances", entity_player);
				_p.p_id =_id;
				debug_log.append("A player connected: " + string(_id));
				
				//Bounce to clients
				send_data(parsed_data);
			}
			break;
			
			case "player_move":
			{
				var pl_id = parsed_data[? "p_id"];
				
				with (entity_player)
				{
					if (pl_id == p_id)
					{
						var _sprinting = parsed_data[? "s"];
						var _x_dir = parsed_data[? "h"];
						var _y_dir = parsed_data[? "v"];
						
						x += _x_dir + (_x_dir*_sprinting*2);
						y += _y_dir + (_y_dir*_sprinting*2);
						image_xscale = parsed_data[? "h"];
					
						moved = true;
					
						break;
					}
				}
			}
			break;
			
			case "chat":
			{
				//bounce the chat to all clients
				debug_log.append(parsed_data[? "n"] + ": " + parsed_data[? "t"]);
				
				send_data(parsed_data);
			}
			break;
			
			case "player_disconnected":
			{
				var pl_id = parsed_data[? "p_id"];
				
				debug_log.append(string(pl_id) + " has disconnected.");
				
				with (entity_player)
				{
					if (pl_id == p_id)
					{
						instance_destroy();
						break;
					}
				}
			}
			break;
		}
	}
}