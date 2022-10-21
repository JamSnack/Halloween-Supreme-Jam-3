// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createLobby(port)
{
	//Creates a lobby on the relay server
	global.socket = network_create_socket(network_socket_tcp);
	
	//Connect to the relay server
	var _s = network_connect_raw(global.socket, "26.198.169.147", port);
	
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
	var _header = buffer_write(buff, buffer_text, string(string_byte_length(json_map)) + "|");
	var _b = buffer_write(buff, buffer_text, json_map);
	
	if (_header == -1) then show_debug_message("header write failed.");
	if (_b == -1) then show_debug_message("buffer_write failed.");
	
	//show_debug_message(string(string_length(json_map)) + "|" + json_map);
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
	//Send the data without a header
	var json_map = json_encode(data_map);
	var buff = buffer_create(128, buffer_grow, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	var _b = buffer_write(buff, buffer_text, json_map);
	
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
	
	if (setting_show_incoming_packets)
	{
		try
		{
			debug_log.append("Data: "+string(data));
			//debug_log.append("PData: "+string(parsed_data));
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
				var _pn = parsed_data[? "p_n"];
				//var _pi = parsed_data[? "p_i"];
				
				var _p = instance_create_layer(CENTER_X - 100, CENTER_Y, "instances", entity_player);
				_p.p_id =_id;
				_p.p_n = _pn;
				
				debug_log.append(_pn + " connected: " + string(_id));
				
				//Bounce to clients
				send_data(parsed_data);
			}
			break;
			
			case "player_move":
			{
				var pl_id = parsed_data[? "p_id"];
				var blocks_exist = instance_exists(entity_block);
				
				with (entity_player)
				{
					if (pl_id == p_id)
					{
						//take data from packet -> init vars
						var _sprinting = parsed_data[? "s"];
						var _x_dir = parsed_data[? "h"];
						var _y_dir = parsed_data[? "v"];
						
						//init potential movement speed this step:
						var x_speed = _x_dir*1.5 + (_x_dir*_sprinting*1.5);
						var y_speed = _y_dir*1.5 + (_y_dir*_sprinting*1.5);
						
						//check for collision, setting speed to 0 if colliding
						if (blocks_exist)
						{
							//find collisions -> init vars
							var h_collision = collision_rectangle(bbox_left + x_speed, bbox_top, bbox_right + x_speed, bbox_bottom, entity_block, false, true);
							var v_collision = collision_rectangle(bbox_left, bbox_top + y_speed, bbox_right, bbox_bottom + y_speed, entity_block, false, true);
							
							//horizontal collision
							if (h_collision != noone && h_collision.object_index != entity_block_door)
								x_speed = 0;
							
							//vertical collision
							if (v_collision != noone && v_collision.object_index != entity_block_door)
								y_speed = 0;
						}
						
						
						//apply speed to movement
						x += x_speed;
						y += y_speed;
						
						//set image_xscale
						image_xscale = parsed_data[? "h"];
						
						//flag this object as moved, sending new position to clients.
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
				
				//bounce disconnect to clients
				send_data(parsed_data);
			}
			break;
			
			case "player_name_request":
			{
				var pl_id = parsed_data[? "p_id"];
				
				with (entity_player)
				{
					if (pl_id == p_id)
					{
						//reused parsed_data map to bounce back a name:
						parsed_data[? "p_n"] = p_n;
						parsed_data[? "cmd"] = "player_name_recieved";
						send_data(parsed_data);
						break;
					}
				}
			}
			break;
			
			case "request_enemy_entity":
			{
				//The client has requested an enemy
				var e_id = parsed_data[? "e_id"];
				var instance_updated = false;
				
				if (instance_exists(entity_enemy))
				{
					with (entity_enemy)
					{
						if (e_id == enemy_id)
						{
							send_enemy_to_client();
							instance_updated = true;
							break;
						}
					}
				}
				
				if (!instance_updated)
				{
					parsed_data[? "cmd"] = "enemy_destroy";
					send_data(parsed_data);
				}
			}
			break;
			
			case "request_item_entity":
			{
				//The client has requested an enemy
				var i_id = parsed_data[? "i_id"];
				
				if (instance_exists(entity_item))
				{
					with (entity_item)
					{
						if (i_id == item_id)
						{
							send_item_to_client();
							break;
						}
					}
				}	
			}
			break;
			
			case "request_remove_item":
			{
				//The player wants to remove this item from their inventory. Is it legal?
				//drop_item, slot
				var pl_id = parsed_data[? "pl_id"];
				
				//check inventory
				with (entity_player)
				{
					if (pl_id == p_id)
					{
						var slot = parsed_data[? "slot"];
						var drop_item = parsed_data[? "d_i"];
						
						//player inventory -> check for item at slot -> remove it -> send result to player
						player_inventory[slot] = 0;
						
						if (drop_item)
							//create item that has been dropped
					
						break;
					}
				}
				
			}
			break;
			
			case "request_shoot":
			{
				var _s = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", entity_player_projectile);
				_s.direction = parsed_data[? "dir"];
				_s.speed = 4;
				
				parsed_data[? "cmd"] = "player_shoot";
				send_data(parsed_data);
			}
			break;
			
			case "request_tile_place":
			{
				var _x = parsed_data[? "x"];
				var _y = parsed_data[? "y"];
				var _index = parsed_data[? "type"];
				_type = entity_block;
				
				if (instance_exists(entity_core) && entity_core.candies_stored[_index] > 0)
				{					
					//select correct object
					switch (_index)
					{
						case 1: { _type = entity_block_door; } break;
						case 2: { _type = entity_block_glass; } break;
					}
					
					//create instance
					if (instance_exists(entity_block) && collision_point(_x, _y, entity_block, false,true) == noone || !instance_exists(entity_block) )
					{
						instance_create_layer(_x, _y, "Instances", _type);
						
						//remove a build from core
						entity_core.candies_stored[_index] -= 1;
					
						//update players
						networking_update_core_candies_at_index(_index);
					}
					
				}
				else
				{
					instance_create_layer(_x, _y, "Instances", entity_false_block);
				}
			}
			break;
			
			case "request_world_update":
			{				
				//This will probe each entity_player and cause them to send position packets, forcing them to exist in the new client's game.
				with (entity_player)
					moved = true;
					
				//send the tile data to the new player
				if (instance_exists(entity_block))
				{
					with(entity_block)
					{
						send_new_block_to_player();	
					}
				}
				
				//send enemy data to the new player
				if (instance_exists(entity_enemy))
				{
					with(entity_enemy)
					{
						send_enemy_to_client();	
					}
				}
				
				//Send core information
				if (instance_exists(entity_core))
				{
					for (var _i = 0; _i < array_length(entity_core.candies_stored); _i++)
						networking_update_core_candies_at_index(_i);
				}
			}
			break;
			
			case "request_tile_destroy":
			{
				if (instance_exists(entity_block))
				{
					var _c = collision_point(parsed_data[? "x"], parsed_data[? "y"], entity_block, false, true);
					
					if (_c != noone)
						with (_c) { instance_destroy(); }
				}
			}
			break;
			
			case "request_tile_update":
			{
				var instance_updated = false;
				
				if (instance_exists(entity_block))
				{
					var t_id = parsed_data[? "t_id"];
					with(entity_block)
					{
						if (t_id == tile_id)
						{
							update_block();
							instance_updated = true;
							break;
						}
					}
				}
				
				//destroy requested tile
				if (instance_updated = false)
				{
					parsed_data[? "cmd"] = "tile_destroy";	
					send_data(parsed_data);
				}
			}
			break;
		}
	}
}