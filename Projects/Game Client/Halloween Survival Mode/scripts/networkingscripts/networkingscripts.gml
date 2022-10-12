// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function joinLobby(lobby_id)
{
	//server_status = "Connecting to server...";
	global.socket = network_create_socket(network_socket_tcp);
	
	//Try to connect to the main server.
	var _s = network_connect_raw(global.socket, "26.198.169.147", 55555);
	
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
	var _header = buffer_write(buff, buffer_text, string(string_byte_length(json_map)) + "|");
	var _b = buffer_write(buff, buffer_text, json_map);
	
	if (_header == -1) then show_debug_message("header write failed.");
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

function send_data_raw(data_map)
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
			case "lobby_connect_success": { global.lobby_id = parsed_data[? "l_id"]; global.player_id = parsed_data[? "plr_id"]; } break;
			case "player_pos":
			{
				var pl_id =  parsed_data[? "p_id"];
				var _x = parsed_data[? "x"];
				var _y = parsed_data[? "y"];
				var _xscale = parsed_data[? "xscale"];
				
				//update current client's position
				if (global.player_id == pl_id)
				{
					obj_player.x = _x;
					obj_player.y = _y;
					
					if (_xscale != 0)
						obj_player.image_xscale = _xscale;
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
							
							if (_xscale != 0)
								image_xscale = _xscale;
							
							despawn_timer = despawn_timer_set;
							
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
			
			case "chat":
			{
				chat_overlay.append("[" + parsed_data[? "n"] + "]" + ": " + parsed_data[? "t"]);
			}
			break;
			
			case "player_disconnected":
			{
				var pl_id = parsed_data[? "p_id"];
				var _p_n = string(pl_id);
				
				with (obj_player_entity)
				{
					if (pl_id == p_id)
					{
						_p_n = p_n;
						instance_destroy();
						break;
					}
				}
				
				chat_overlay.append(_p_n + " has disconnected.");
			}
			break;
			
			case "player_connected":
			{
				var _id = real(parsed_data[? "p_id"]);
				var _pn = parsed_data[? "p_n"];
				
				if (_id != global.player_id)
				{
					var _p = instance_create_layer(100, 100, "instances", obj_player_entity);
					_p.p_id =_id;
					_p.p_n = _pn;
				}
				
				chat_overlay.append(_pn + " joined the game.");
			}
			break;
			
			case "player_name_recieved":
			{
				var pl_id = parsed_data[? "p_id"];
				
				with (obj_player_entity)
				{
					if (pl_id == p_id)
					{
						p_n = parsed_data[? "p_n"];
						break;
					}
				}
			}
			break;
			
			case "enemy_pos":
			{
				var e_id = parsed_data[? "e_id"];
				var instance_updated = false;
				
				with (obj_enemy_entity)
				{
					if (e_id == enemy_id)
					{
						x = parsed_data[? "x"];
						y = parsed_data[? "y"];
							
						/*if (_xscale != 0)
							image_xscale = _xscale;*/
							
						despawn_timer = despawn_timer_set;
							
						instance_updated = true;
						break;
					}
				}
				
				//if we didn't update an instance: ask the server for the instance
				if (!instance_updated)
				{
					var _d = ds_map_create();
					_d[? "cmd"] = "request_enemy_entity";
					_d[? "e_id"] = e_id;
					send_data(_d);
				}
			}
			break;
			
			case "create_enemy":
			{
				var _e = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", asset_get_index(parsed_data[? "o_i"]))
				_e.max_hp = parsed_data[? "mhp"];
				_e.hp = parsed_data[? "hp"];
				_e.enemy_id = parsed_data[? "e_id"];
			}
			break;
			
			case "create_item":
			{
				var _e = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", obj_item_entity);
				_e.item_id = parsed_data[? "i_id"];
				_e.image_index = parsed_data[? "index"];
			}
			break;
			
			case "item_pos":
			{
				var i_id = parsed_data[? "i_id"];
				var instance_updated = false;
				
				with (obj_item_entity)
				{
					if (i_id == item_id)
					{
						x = parsed_data[? "x"];
						y = parsed_data[? "y"];
							
						despawn_timer = despawn_timer_set;
							
						instance_updated = true;
						break;
					}
				}
				
				//if we didn't update an instance: ask the server for the instance
				if (!instance_updated)
				{
					var _d = ds_map_create();
					_d[? "cmd"] = "request_item_entity";
					_d[? "i_id"] = i_id;
					send_data(_d);
				}
			}
			break;
			
			//add one item
			case "item_pickup":
			{
				var pl_id = parsed_data[? "p_id"];
				
				if (pl_id == global.player_id)
					if (!client_inventory.is_full())
						client_inventory.add(parsed_data[? "index"]);
			}
			break;
	
			
			//During CSCI 211:
			//remove one item
			case "item_remove":
			{
				var pl_id = parsed_data[? "p_id"];
				
				if (pl_id == global.player_id)
					client_inventory.remove(parsed_data[? "slot"]);
			}
			
			
			case "inventory_update":
			{
				//resyncs the entire inventory
				var pl_id = parsed_data[? "p_id"];
				
				if (pl_id == global.player_id)
					array_copy(client_inventory.inven, 0, parsed_data[? "inv"], 0, global.inventory_size);
			}
			break;
		}
	}
}